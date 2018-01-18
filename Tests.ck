Kick kc;
Snare snr;
HH hh;
Crash crash;

kc.output => dac;
snr.output => dac;
hh.output => dac;
crash.output => dac;

while(true) {
	crash.keyOn();
	kc.keyOn();
	hh.keyOn();
	200::ms => now;
	hh.keyOn();
	200::ms => now;
	snr.keyOn();
	200::ms => now;
	hh.keyOn();
	200::ms => now;
	kc.keyOn();
	200::ms => now;
	hh.keyOn();
	200::ms => now;
	snr.keyOn();
	200::ms => now;
	hh.keyOn();
	200::ms => now;
}

/* 
fun void processLeadEvent(OscEvent event) {
    event.getInt() => int ID;
    event.getInt() => int state;
    if (DEBUG) <<< state >>>;
    if (state == 1) {
        event.getFloat() => float x;
        event.getFloat() => float y;
        event.getFloat() => float s;
        map.getZone(x, y) + 60 => int note;
        computeVelocity(s) => float vel;
        moog.freq(Std.mtof(note));
        moog.noteOn(vel);
    } else if (state == 4) {
        event.getFloat() => float x;
        event.getFloat() => float y;
        event.getFloat() => float s;
        map.getZone(x, y) + 60 => int note;
        computeVelocity(s) => float vel;
        moog.freq(Std.mtof(note));
    } else if (state == 7) {
        moog.noteOff(0.0);
    }
} */
