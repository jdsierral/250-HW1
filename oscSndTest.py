import argparse
import time
from pythonosc import osc_message_builder
from pythonosc import udp_client

parser = argparse.ArgumentParser()

parser.add_argument("--ip", default = "127.0.0.1")
parser.add_argument("--port", type=int, default = 6449)
args = parser.parse_args()

client = udp_client.SimpleUDPClient(args.ip, args.port)

while(True):
    client.send_message("/MTT", 10.0)
    time.sleep(0.1)
