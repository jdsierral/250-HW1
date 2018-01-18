public class Snare {
    Gain output;
    Gain gen;
    gen.gain(0.7);

    Noise noise => gen;
    gen => LPF lpf => HPF hpf => ADSR env => ADSR td => output;

    lpf.freq(6000.0);
    lpf.Q(2);
    hpf.freq(200.0);
    hpf.Q(20.0);

    env.set(0.2::ms, 500::ms, 0.0, 1::samp);
    td.set(1::ms, 50::ms, 0.1, 1::samp);

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
        td.keyOn();
        while(true) {
            1::samp => now;
            if (env.state() == 2) {
                env.keyOff();
				td.keyOff();
            }
            if (env.state() == 4) {
                break;
            }
        }
    }
}
