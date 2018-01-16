import socket

HOST = 'localhost'
PORT = 6449
socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

prefix = "/MTT/notes"
prefix += "\x00\x00,ff\x00"


def sendOscMsg(msg):
    bndl = prefix.encode() + msg
    socket.sendto(bndl, (HOST, PORT))
    # print(bndl)
