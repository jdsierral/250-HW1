Kick kc;
Snare snr;
HH hh;
Crash crash;
ZoneMap map;

1 => int kcId;
2 => int snrId;
6 => int hhId;
5 => int crashId;

6449 => int PORT;

kc.output => dac;
snr.output => dac;
hh.output => dac;
crash.output => dac;
spork ~ initOsc();


fun void initOsc() {
    OscRecv rcv;
    PORT => rcv.port;
    rcv.listen();
    rcv.event("/MT, i f f f") @=> OscEvent @ event;
    while(true) {
        event => now;
        while (event.nextMsg()) {
            processEvent(event);
        }
    }
}

fun void processEvent(OscEvent event) {
    event.getInt() => int state;
    if (state == 1) {
        event.getFloat() => float x;
        event.getFloat() => float y;
        event.getFloat() => float s;
        map.getZone(x, y) => int drum;
        <<< drum >>>;
        <<< x, y, s >>>;
        triggerDrum(drum, s);
    }
}

fun void triggerDrum(int drum, float vel) {
    if (drum == kcId) {
        kc.keyOn();
    } else if (drum == snrId) {
        snr.keyOn();
    } else if (drum == hhId) {
        hh.keyOn();
    } else if (drum == crashId) {
        crash.keyOn();
    }
}

while (true) {
    10::ms => now;
}
