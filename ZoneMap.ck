public class ZoneMap {

    0 => int drumMapping
    1 => int melMapping
    2 => int harmMapping

    drumMapping => int mapping

    fun int getZone(float x, float y) {
        if mapping == drumMapping {
            return getDrumZone(float x, float y);
        } else if (mapping == melMapping) {
            return getMelZone(float x, float y);
        } else {
            return getHarmZone(float x, float y);
        }
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
        x * numZones + 1 => int numZone;
        return numZone;
    }

    // ==================================================== //
    // ================== Harmonic Zones ================== //
    // ==================================================== //

    fun int getHarmZone(float x, float y) {
        4 => int numPairZones;
        (x * numPairZones + 1) + (y * 2 + 1) => int numZone;
    }
}
