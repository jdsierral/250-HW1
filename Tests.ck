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
