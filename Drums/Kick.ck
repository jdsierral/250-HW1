public class Kick {
    Gain output;
    Gain gen;
    SqrOsc sqr => gen;
    TriOsc sin => gen;
    gen => LPF lpf => ADSR env => output;
    0.09 => gen.gain;
    60.0 => sqr.freq;
    60.0 => sin.freq;
    55.0 => lpf.freq;
    10.0 => lpf.Q;

    env.set(1.5::ms, 180::ms, 0.0001, 1::samp);

    fun void keyOn() {
        spork ~ trigger();
    }

	fun void keyOn(float vel) {
        computeVelocity(vel);
		spork ~ trigger();
	}

    fun void computeVelocity(float vel) {
        vel => output.gain;
    }


    fun void trigger() {
		env.keyOn();
		while(true) {
			1::samp => now;
			if (env.state() == 2) {
				env.keyOff();
			}
			if (env.state() == 4) {
				break;
			}
		}
    }
}
