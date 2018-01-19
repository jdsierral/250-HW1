# 250-HW1

This project is an attempt to use only the computer keyboard and trackpad (mainly the trackpad in this case) as a way
to control a musical instrument.

In this case I used one of Apples API to get semi-raw data from the trackpad.
A trackpad is fundamentally different from a Mouse as is not based in delta-values. On the contrary it is based on absolute
values which then are converted to delta values to interact with the computer. However, we can access data
based on finger gestures. This is how the OS recognizes gestures like swipe or pinch.

However, in this case Im tracking each finger independently to divide the trackpad in different zones
that allow the user to have an experience much more closer to that with a touch screen.

The following video demonstrates its use:

https://youtu.be/GTkJvO6koa8


# The TrackPad API
The api is originally intended for objective-C. However, it is also possible to call its functions from pure C.
Due to this, it is possible to call it from python with a library that allows calling c functions.
The information is collected in packets of structs containing all the information about each gesture. From there
a python script takes this information, takes whatever is needed for the control (mainly position, size of finger,
and ID of finger). Then this information is fed to chuck through OSC with python-OSC.

I could trace back the creator of this python wrapper to use the apple API library to this website.
I didn't develop that part although my version was rewritten to organize a little bit some things.

http://blog.sendapatch.se/2009/november/macbook-multitouch-in-python.html

# Chuck scripts

The chuck scripts for the drums were totally developed from 0 just with additive synthesis and subtractive synthesis.
The other sounds are the Moog object and the Wurley piano that are based on fm synthesis algorithms.

# Conclusions

This was a 1 week long project, but a very interesting one!
