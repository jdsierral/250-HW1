# This file interconnects with the API to get the gestures from the trackpad
# currently is getting semi raw data which allows to track each finger gesture
# individually. It also allow to track the coordinates and the size of the
# finger pressing the trackpad which is later used as the velocity of the noteOn
# event

import ctypes
import io
from ctypes.util import find_library
import subprocess


CFArrayRef = ctypes.c_void_p
CFMutableArrayRef = ctypes.c_void_p
CFIndex = ctypes.c_long

MTSupport = ctypes.CDLL("/System/Library/PrivateFrameworks/MultitouchSupport.framework/MultitouchSupport")

CFArrayGetCount = MTSupport.CFArrayGetCount
CFArrayGetCount.argtypes = [CFArrayRef]
CFArrayGetCount.restype = CFIndex

CFArrayGetValueAtIndex = MTSupport.CFArrayGetValueAtIndex
CFArrayGetValueAtIndex.argtypes = [CFArrayRef, CFIndex]
CFArrayGetValueAtIndex.restype = ctypes.c_void_p

MTDeviceCreateList = MTSupport.MTDeviceCreateList
MTDeviceCreateList.argtypes = []
MTDeviceCreateList.restype = CFMutableArrayRef

class MTPoint(ctypes.Structure):
    _fields_ = [("x", ctypes.c_float), ("y", ctypes.c_float)]

class MTVector(ctypes.Structure):
    _fields_ = [("pos", MTPoint), ("vel", MTPoint)]

class MTData(ctypes.Structure):
    _fields_ = [
        ("frame", ctypes.c_int),
        ("timestamp", ctypes.c_double),
        ("ID", ctypes.c_int),
        ("state", ctypes.c_int),
        # 1 = Began
        # 2 = Moved
        # 4 = Stationary
        # 7 = Touching
        # 8 = Ended
        # 16 = Canceled
        # 7 = Any
        ("unused1", ctypes.c_int),
        ("indirect", ctypes.c_int),
        ("normVec", MTVector),
        ("size", ctypes.c_float),
        ("unused2", ctypes.c_int),
        ("angle", ctypes.c_float),
        ("majorAxis", ctypes.c_float),
        ("minorAxis", ctypes.c_float),
        ("vec", MTVector),
        ("unused3", ctypes.c_int),
        ("unused4", ctypes.c_int),
        ("area", ctypes.c_float),
    ]

MTDataRef = ctypes.POINTER(MTData)

MTContactCallbackFunction = ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_int, MTDataRef, ctypes.c_int, ctypes.c_double, ctypes.c_int)

MTDeviceRef = ctypes.c_void_p

MTRegisterContactFrameCallback = MTSupport.MTRegisterContactFrameCallback

MTRegisterContactFrameCallback.argtypes = [MTDeviceRef, MTContactCallbackFunction]
MTRegisterContactFrameCallback.restype = None

MTDeviceStart = MTSupport.MTDeviceStart
MTDeviceStart.argtypes = [MTDeviceRef, ctypes.c_int]
MTDeviceStart.restype = None

def initialize(callbackFunction):
    devices = MTSupport.MTDeviceCreateList()
    num_devices = CFArrayGetCount(devices)
    for i in range(num_devices):
        device = CFArrayGetValueAtIndex(devices, i)
        MTRegisterContactFrameCallback(device, callbackFunction)
        MTDeviceStart(device, 0) ## Initializetion of MT whats 0 for?

def disableTrackpad():
    subprocess.call(["defaults", "write", "com.apple.AppleMultitouchTrackpad", "USBMouseStopsTrackpad", "-int", "1"])
    subprocess.call(["defaults", "write", "com.apple.driver.AppleBluetoothMultitouch.trackpad", "USBMouseStopsTrackpad", "-int", "1"])
    print("Trackpad Disabled")

def enableTrackpad():
    subprocess.call(["defaults", "write", "com.apple.AppleMultitouchTrackpad", "USBMouseStopsTrackpad", "-int", "0"])
    subprocess.call(["defaults", "write", "com.apple.driver.AppleBluetoothMultitouch.trackpad", "USBMouseStopsTrackpad", "-int", "0"])
    print("Trackpad Enabled")
