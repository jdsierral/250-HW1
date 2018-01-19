/* Main Chuck file. It loads and manages the whole synth */

Kick kc;
Snare snr;
HH hh;
Crash crash;
ZoneMap map;
NoteTracker tracker;
Moog moog;
Wurley wurley;

Gain kcLevel;
Gain snrLevel;
Gain hhLevel;
Gain crashLevel;

0 => int DEBUG;

// ============= SOME IDs as Enums ============== //

1 => int kcID;
2 => int snrID;
6 => int hhID;
5 => int crashID;

0 => int drumsID;
1 => int leadID;
2 => int padID;



// =========== GENERAL SETTINGS ================= //
int currID;
drumsID => int currInstr;
6449 => int PORT;
1 => int keyboard;

hhLevel.gain(0.25);
snrLevel.gain(0.7);
crashLevel.gain(0.5);

// ============= CONECTIONS ===================== //

kc.output => kcLevel => dac;
snr.output => snrLevel => dac;
hh.output => hhLevel => dac;
crash.output => crashLevel => dac;
moog => dac;
wurley => dac;
spork ~ initOsc();
spork ~ initKeyboard();

// ============= OSC Receiver =================== //

fun void initOsc() {
    OscRecv rcv;
    PORT => rcv.port;
    rcv.listen();
    rcv.event("/MT, i i f f f") @=> OscEvent @ event;
    while(true) {
        event => now;
        while (event.nextMsg()) {
            if (currInstr == drumsID) {
                processDrumEvent(event);
            } else if (currInstr == leadID){
                processLeadEvent(event);
            } else if (currInstr == padID) {
                processPadEvent(event);
            }
        }
    }
}

// =============== HID Receiver =================== //
fun void initKeyboard() {
    Hid hi;
    HidMsg keyMsg;
    hi.openKeyboard( keyboard );
    while(true){
        hi => now;
        while(hi.recv(keyMsg)) {
            if ( keyMsg.isButtonDown() ) {
                <<< keyMsg.ascii >>>;
                if (88 == keyMsg.ascii) {
                    <<< "Drums Enabled">>>;
                    drumsID => currInstr;
                    map.drumMapping => map.mapping;
                } else if (67 == keyMsg.ascii) {
                    <<< "Lead Enabled">>>;
                    leadID => currInstr;
                    map.melMapping => map.mapping;
                } else if (86 == keyMsg.ascii) {
                    <<< "Pad Enabled">>>;
                    padID => currInstr;
                    map.harmMapping => map.mapping;
                }
            }
        }
    }
}


// =============== DRUM Managment ================= //

fun void processDrumEvent(OscEvent event) {
    event.getInt() => int ID;
    event.getInt() => int state;
    if (state == 1) {
        event.getFloat() => float x;
        event.getFloat() => float y;
        event.getFloat() => float s;
        map.getZone(x, y) => int drum;
        if (DEBUG) {
            <<< drum >>>;
            <<< x, y, s >>>;
        }
        computeVelocity(s) => float vel;
        triggerDrum(drum, vel);
    }
}

fun void triggerDrum(int drum, float vel) {
    if (drum == kcID) {
        kc.keyOn(vel);
    } else if (drum == snrID) {
        snr.keyOn(vel);
    } else if (drum == hhID) {
        hh.keyOn(vel);
    } else if (drum == crashID) {
        crash.keyOn(vel);
    }
}


// =============== LEAD Managment ================= //



fun void processLeadEvent(OscEvent event) {
    event.getInt() => int ID;
    event.getInt() => int state;
    event.getFloat() => float x;
    event.getFloat() => float y;
    event.getFloat() => float s;
    map.getZone(x, y) + 60 => int note;
    computeVelocity(s) => float vel;
    if (state == 1) {
        ID => currID;
        moog.freq(Std.mtof(note));
        moog.vibratoGain(y/15.0);
        moog.noteOn(vel);
    } else if (state == 4) {
        if (ID == currID) {
            moog.vibratoGain(y/15.0);
            moog.freq(Std.mtof(note));
        }
    } else if (state == 7) {
        moog.noteOff(0.0);
    }
}

// ================ PAD Managment ================= //
fun void processPadEvent(OscEvent event) {
    event.getInt() => int ID;
    event.getInt() => int state;
    event.getFloat() => float x;
    event.getFloat() => float y;
    event.getFloat() => float s;
    map.getZone(x, y) + 48 => int note;
    computeVelocity(s) => float vel;
    if (state == 1) {
        ID => currID;
        wurley.freq(Std.mtof(note));
        wurley.noteOn(vel);
    } else if (state == 4) {
        if (ID == currID) {
            wurley.freq(Std.mtof(note));
        }
    } else if (state == 7) {
        wurley.noteOff(0.0);
    }
}

// =================== MISC ======================= //

fun float computeVelocity(float size) {
    return Math.pow(Math.fabs(size/2.4 - 0.2), 0.25);
}

while (true) {
    10::ms => now;
}
