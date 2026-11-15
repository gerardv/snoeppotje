// Snoeppotje voor Meike
// Een potje voor onder het oude bamboe dekseltje.
// Alle maten in millimeters. Pas de waarden hieronder aan en exporteer
// opnieuw naar STL (F6, daarna F7) als iets niet past.

/* [Dekseltje (gemeten)] */
// Breedte van het onderste houten deel dat in het potje zakt
plug_breedte = 49;
// Diagonaal van dat deel (gemeten: 60 mm)
plug_diagonaal = 60;
// Buitenmaat van de siliconen ring
ring_buitenmaat = 57;

/* [Potje] */
// Totale hoogte van het potje (zonder deksel)
hoogte = 80;
// Wanddikte (1,6 mm = 4 lijnen met een 0,4 mm nozzle)
wand = 1.6;
// Dikte van de bodem
bodem = 1.6;
// Speling rondom tussen hout en opening (per kant)
speling = 0.3;
// Hoogte van de kraag bovenin die het dekseltje recht houdt
kraag_hoogte = 4;
// Kleine afschuining onderaan tegen "olifantenvoet"
voet_afschuining = 0.6;

/* [Verborgen] */
$fn = 96;

// Hoekstraal uit zijde en diagonaal:
// diagonaal = z*sqrt(2) - 2r*(sqrt(2)-1)  =>  r = (z*sqrt(2) - d) / (2*(sqrt(2)-1))
plug_straal = (plug_breedte * sqrt(2) - plug_diagonaal) / (2 * (sqrt(2) - 1));
echo(str("Hoekstraal dekseltje: ", plug_straal, " mm"));

// Afgerond vierkant, gecentreerd, met zijde z en hoekstraal r
module afgerond_vierkant(z, r) {
    offset(r = r) square(z - 2 * r, center = true);
}

// Alle vormen zijn concentrisch met het dekseltje, zodat de hoeken
// overal netjes evenwijdig lopen.
function straal_bij(z) = plug_straal + (z - plug_breedte) / 2;

buiten  = ring_buitenmaat;              // buitenkant potje = buitenkant ring
binnen  = buiten - 2 * wand;            // binnenkant van de wand
opening = plug_breedte + 2 * speling;   // opening bovenin
kraag_afschuining = (binnen - opening) / 2; // 45 graden: print zonder support

module laag(z, h, maat) {
    translate([0, 0, z]) linear_extrude(h) afgerond_vierkant(maat, straal_bij(maat));
}

module potje() {
    top_wand = hoogte - kraag_hoogte - kraag_afschuining;
    difference() {
        // Buitenkant, met kleine afschuining onderaan
        hull() {
            laag(0, 0.01, buiten - 2 * voet_afschuining);
            laag(voet_afschuining, hoogte - voet_afschuining, buiten);
        }
        // Binnenruimte
        laag(bodem, top_wand - bodem + 0.01, binnen);
        hull() {
            laag(top_wand, 0.01, binnen);
            laag(hoogte - kraag_hoogte, 0.01, opening);
        }
        laag(hoogte - kraag_hoogte, kraag_hoogte + 1, opening);
    }
}

potje();
