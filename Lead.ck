public class Lead {
    Gain output;
    Gain gen;

    gen.gain(1);

    SinOsc sinOsc => gen;
    TriOsc triOsc => gen;
    SinOsc lfo => blackhole;
    0.3 => float tremDepth;

    gen => LPF lpf => ADSR env => Gain trem => output;

    lpf.freq(10000.0);
    lpf.Q(2.0);
    trem.gain(1.0);
    output.gain(1.0);
    sinOsc.freq(440);
    triOsc.freq(440);
    lfo.gain(1.0);
    lfo.freq(4.0);



    env.set(50::ms, 50::ms, 0.3, 200::ms);

    fun void keyOn(float vel) {
        output.gain(vel);
        spork ~ trigger();
    }

    fun void keyOff() {
        env.keyOff();
    }

    fun void note(float note) {
        Std.mtof(note) => sinOsc.freq;
        Std.mtof(note) => triOsc.freq;
    }

    fun void trigger() {
        env.keyOn();
        while(true) {
            1::samp => now;
            trem.gain((lfo.last() - 1.0)*tremDepth*0.5 + 1.0);
            if (env.state() == 4) {
                break;
            }
        }
    }
}
