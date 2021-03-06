/* Public Class for HiHat sound in Drums  */

public class HH {
    /* Each instrument has an output to control gain and connect to dac */
    Gain output;
    /* this generator works as node to connect different source waveforms */
    Gain gen;
    gen.gain(0.7);

    Noise noise => gen;
    gen => LPF lpf => HPF hpf => ADSR env => output;

    lpf.freq(15000.0);
    lpf.Q(2);
    hpf.freq(9000.0);
    hpf.Q(20.0);

    env.set(20::ms, 20::ms, 0.01, 1::samp);

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
                Math.random2f(8700, 9200) => hpf.freq;
				break;
			}
		}
    }


}
