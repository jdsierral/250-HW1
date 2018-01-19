# This File is in charge of managing trackpad data.
# registering the callback for the api and deciding what to broadcast via OSC
# It is also the main execution file as it will call the subprocess chuck!!
# Finally it reaches to system settings to disable temporarily the trackpad to
# avoid moving everything with the cursor. To rever this last thing
# at anExit function is registered to revert the process.

import Trackpad
import OscSender
import os
import subprocess
import struct
import threading
import time
import atexit


def printData(MTEvent):
    print(chr(27) + "[2J")
    print("//=======================================//")
    print("//=======================================//")
    print("Frame: " + str(MTEvent.frame))
    print("TimeStamp: " + str(MTEvent.timestamp))
    print("ID: " + str(MTEvent.ID))
    print("state: " + str(MTEvent.state))
    print("unused1: " + str(MTEvent.unused1))
    print("Indirect: " + str(MTEvent.indirect))
    print("Pos: " + str(MTEvent.normVec.pos.x) + ", " + str(MTEvent.normVec.pos.y))
    print("Vel: " + str(MTEvent.normVec.vel.x) + ", " + str(MTEvent.normVec.vel.y))
    print("size: " + str(MTEvent.size))
    print("unused2: " + str(MTEvent.unused2))
    # The following three define the ellipsoid of a finger.
    print("angle: " + str(MTEvent.angle))
    print("majorAxis: " + str(MTEvent.majorAxis))
    print("minorAxis: " + str(MTEvent.minorAxis))
    print("Pos: " + str(MTEvent.normVec.pos.x) + ", " + str(MTEvent.normVec.pos.y))
    print("Vel: " + str(MTEvent.normVec.vel.x) + ", " + str(MTEvent.normVec.vel.y))
    print("unused3: " + str(MTEvent.unused3))
    print("unused4: " + str(MTEvent.unused4))
    print("Area: " + str(MTEvent.area))

def broadcastData(data):
    ID = data.ID
    s = data.state
    x = data.normVec.pos.x
    y = data.normVec.pos.y
    z = data.size
    OscSender.sendOscMsg(ID, s, x, y, z)

@Trackpad.MTContactCallbackFunction
def callback(device, data_ptr, n_fingers, timestamp, frame):
    for i in range(n_fingers):
        data = data_ptr[i]
        # printData(data)
        broadcastData(data)
    return 0



Trackpad.initialize(callback)
Trackpad.disableTrackpad()
atexit.register(Trackpad.enableTrackpad)
subprocess.call(["ChucK", "Execute.ck"])

while(True):
    time.sleep(0.01)
