import argparse
import time

from pythonosc import osc_message_builder
from pythonosc import udp_client

HOST = 'localhost'
PORT = 6449
PREFIX = "/MT"
client = udp_client.UDPClient(HOST, PORT)

def sendOscMsg(ID, s, x, y, z):
    msg = osc_message_builder.OscMessageBuilder(address = PREFIX)
    msg.add_arg(ID)
    msg.add_arg(s)
    msg.add_arg(x)
    msg.add_arg(y)
    msg.add_arg(z)
    msg = msg.build()
    client.send(msg)
