/* This class allow the managment of the trackpad zones. It creates different
modes such as drums, melody and harmony with differnt zone distribuitions. */

public class ZoneMap {
    0 => int drumMapping;
    1 => int melMapping;
    2 => int harmMapping;
    0 => int mapping;

    fun int getZone(float x, float y) {
		0 => int zone;
		if (drumMapping == mapping) {
			getDrumZone(x, y) => zone;
		} else if (mapping == melMapping) {
			getMelZone(x, y) => zone;
		} else {
			getHarmZone(x, y) => zone;
		}
		return zone;
    }

    // ==================================================== //
    // ==================== Drum Zones ==================== //
    // ==================================================== //

    fun int getDrumZone(float x, float y) {
        if ( isDrumZone1(x, y) )
            return 1;
        if ( isDrumZone2(x, y) )
            return 2;
        if ( isDrumZone3(x, y) )
            return 3;
        if ( isDrumZone4(x, y) )
            return 4;
        if ( isDrumZone5(x, y) )
            return 5;
        if ( isDrumZone6(x, y) )
            return 6;
        return -1;
    }

    fun int isDrumZone1(float x, float y) {
        if ( x < - Math.fabs(y - 0.5) + 0.5 )
        return 1;
        return 0;
    }

    fun int isDrumZone2(float x, float y) {
        if ( y < - Math.fabs(x - 0.5) + 0.5 )
        return 1;
        return 0;
    }

    fun int isDrumZone3(float x, float y) {
        if ( y < -x + 1.5 && x < 0.5)
        return 1;
        return 0;
    }

    fun int isDrumZone4(float x, float y) {
        if ( y < -x + 1.5 && x > 0.5 && y > 0.5 )
        return 1;
        return 0;
    }

    fun int isDrumZone5(float x, float y) {
        if ( y < -x + 1.5 && y < 0.5)
        return 1;
        return 0;
    }

    fun int isDrumZone6(float x, float y) {
        if ( y > -x + 1.5 )
        return 1;
        return 0;
    }

    // ==================================================== //
    // ================== Melodic Zones =================== //
    // ==================================================== //

    fun int getMelZone(float x, float y) {
        8 => int numZones;
        (x * numZones + 1) $ int => int numZone;
        if (numZone == 1) return -5;
        if (numZone == 2) return 0;
        if (numZone == 3) return 3;
        if (numZone == 4) return 5;
        if (numZone == 5) return 7;
        if (numZone == 6) return 10;
        if (numZone == 7) return 12;
        if (numZone == 8) return 15;
        return 0;
    }

    // ==================================================== //
    // ================== Harmonic Zones ================== //
    // ==================================================== //

    fun int getHarmZone(float x, float y) {
        4 => int numXZones;
        2 => int numYZones;

        (x * numXZones) $ int => int xZn;
        (y * numYZones) $ int => int yZn;

        2 * xZn + yZn => int zn;

        if (zn == 0) return 0;
        if (zn == 1) return 2;
        if (zn == 2) return 7;
        if (zn == 3) return 10;
        if (zn == 4) return 15;
        if (zn == 5) return 17;
        if (zn == 6) return 11;
        if (zn == 7) return 12;
        return 0;
    }
}
