SinOsc sine => Gain gain => dac;
float x;
float y;

<<< " Hola " >>>;

spork ~ initOSC();

fun void initOSC() {
    OscRecv recv;
    6449 => recv.port;
    recv.listen();
    <<< recv >>>;
    recv.event("/MTT/notes, f f") @=> OscEvent @ event;
    while(true) {
        event => now;
        while (event.nextMsg()){
            event.getFloat() => x;
            event.getFloat() => y;
            <<< x, y >>>;
        }
    }
}


while (true) {
	200::samp => now;
}
