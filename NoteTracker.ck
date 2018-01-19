/* This Note tracker is used to manage a polyphonic synth
Nevertheless it was not used. It allow for 10 voices  */

public class NoteTracker {
    10 => int numVoices;
    int notes[10];
    -1 => int idx;

    fun int getLastOnNote() {
        for (9 => int i; i >= 0; i--) {
            if (notes[i] != 0) {
                return notes[i];
            }
        }
        return 0;
    }

    fun void noteOn(int note) {
        idx++;
        note => notes[idx];
    }

    fun int noteOff(int note) {
        for (0 => int i; i < 10; i++) {
            if(notes[i] == note) {
                0 => notes[i];
            }
        }

        for (9 => int i; i >= 0; i--) {
            if(notes[i] != 0) {
                i - 1 => idx;
                <<< idx >>>;
                printNotes();
                if (idx != -1) return notes[i];
                else return 0;
            }
        }
    }

    fun void printNotes() {
        for (0 => int i; i < 10; i++) {
            <<< notes[i] >>>;
        }
    }
}
