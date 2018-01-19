/* Execution files to add each shred to the machine so that public classes
are available for main. Notice that Adding the first shreds doesnt actually
execute anything. Its just a hack to do a C style include. */

Machine.add("Drums/Kick.ck") => int kcShred;
Machine.add("Drums/Snare.ck") => int snrShred;
Machine.add("Drums/HH.ck") => int hhShred;
Machine.add("Drums/Crash.ck") => int crashShred;
Machine.add("ZoneMap.ck") => int zmShred;
Machine.add("NoteTracker.ck") => int ntShred;

Machine.add("Main.ck") => int mainShred;
