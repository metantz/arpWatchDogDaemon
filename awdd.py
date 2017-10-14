#!/usr/bin/python
from scapy.all import sniff, ARP
import sys
from signal import SIGINT, signal
import gi
gi.require_version('Notify', '0.7')
from gi.repository import Notify

machines = dict()

def paranoid(pckt):
	if( pckt[ARP].hwsrc in machines ):
		if(	machines[pckt[ARP].hwsrc] == pckt[ARP].psrc	):
			return "I know it"
		else:
			return "Same MAC, different IP"
	elif( pckt[ARP].psrc in machines.values() ):
		return "Same IP, different MAC"
	else:
		return "Nice to meet you"
 
def pckt_hndlr(pckt):
	source_ip = pckt[ARP].psrc
	source_MAC = pckt[ARP].hwsrc
#if op == 'is-at'
	if(pckt[ARP].op == 2):
		res = paranoid(pckt)
		if(res == "Nice to meet you"):
			machines[pckt[ARP].hwsrc] = pckt[ARP].psrc
		elif(res == "I know it"):
			pass
		elif(res == "Same MAC, different IP"):
			if(pckt_hndlr.counter1 == 0 or not pckt_hndlr.counter1 % 100):
				Notify.Notification.new("Arp Spoofers Detected!",'IP: ' + str(source_ip) + '\nMAC: ' + str(source_MAC)+ '\nMAC known with different IP !!',"./img/Skull.jpg").show()
				pckt_hndlr.counter1 +=1
				if(pckt_hndlr.counter1 == 10000):
					pckt_hndlr.counter1 = 1
		elif( res == "Same IP, different MAC"):
			if(pckt_hndlr.counter2 == 0 or not pckt_hndlr.counter2 % 100):
				Notify.Notification.new("Arp Spoofers Detected!",'IP: ' + str(source_ip) + '\nMAC: ' + str(source_MAC)+ '\nIP known with different MAC !!',"/img/Skull.jpg").show()
				pckt_hndlr.counter2 +=1
				if(pckt_hndlr.counter2 == 10000):
					pckt_hndlr.counter2 = 1

def sig_handler(signal_number, interrupted_stack_frame):
	print "\nSIGINT received....."
	sys.exit(0)
					
if(len(sys.argv) < 2):
	my_iface = "wlp3s0"			 
else:
	my_iface = sys.argv[1]

Notify.init("arpWatchDog")
pckt_hndlr.counter1 = 0
pckt_hndlr.counter2 = 0


signal(SIGINT, sig_handler) 
#count: number of packets to capture. 0 means infinity
#store: wether to store sniffed packets or discard them
#prn: function to apply to each packet
sniff(filter = 'arp', count = 0, store = 0, iface = my_iface, prn = pckt_hndlr)
