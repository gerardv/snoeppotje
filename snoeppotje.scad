// Snoeppotje voor Meike
// Een potje voor onder het oude bamboe dekseltje.
// Alle maten in millimeters. Pas de waarden hieronder aan en exporteer
// opnieuw naar STL (F6, daarna F7) als iets niet past.
//
// Afdichting: de siliconen ring steekt rondom 4 mm buiten het hout uit.
// Bij het sluiten vouwt dat randje naar beneden, de opening in, en wordt
// het tussen het hout en de binnenwand van de kraag geklemd.

/* [Dekseltje (gemeten)] */
// Breedte van het onderste houten deel dat in het potje zakt
plug_breedte = 49;
// Diagonaal van dat deel (gemeten: 60 mm)
plug_diagonaal = 60;
// Buitenmaat van de siliconen ring
ring_buitenmaat = 57;
// Dikte van de siliconen ring
ring_dikte = 1;

/* [Afdichting] */
// Hoeveel de ring wordt samengedrukt tussen hout en wand (per kant).
// Groter = strakker en beter dicht, kleiner = makkelijker open.
ring_klem = 0.2;
// Diepte van de kraag waarin de ring afdicht
kraag_hoogte = 10;
// Afschuining bovenaan de opening, zodat de ring netjes naar binnen vouwt
inloop = 1;

/* [Potje] */
// Totale hoogte van het potje (zonder deksel)
hoogte = 80;
// Buitenmaat van het potje
buiten = 57;
// Wanddikte onder de kraag (1,6 mm = 4 lijnen met een 0,4 mm nozzle, perimeters 2 in PrusaSlicer)
wand = 1.6;
// Dikte van de bodem
bodem = 1.6;
// Kleine afschuining onderaan tegen "olifantenvoet"
voet_afschuining = 0.6;

/* [Naam] */
// Naam die in de zijkant wordt uitgespaard (leeg laten = geen naam)
naam = "MEIKE";
// Lettertype
lettertype = "Inter Display:style=SemiBold";
// Extra ruimte tussen de letters (1 = normaal)
letterafstand = 1.15;
// Lengte van de naam; hij staat gedraaid en loopt van onder naar boven
naam_lengte = 70;
// Hoe diep de letters in de wand gaan (laat minstens 1 mm wand over)
naam_diepte = 0.6;

/* [Verborgen] */
$fn = 96;

// Hoekstraal uit zijde en diagonaal:
// diagonaal = z*sqrt(2) - 2r*(sqrt(2)-1)  =>  r = (z*sqrt(2) - d) / (2*(sqrt(2)-1))
plug_straal = (plug_breedte * sqrt(2) - plug_diagonaal) / (2 * (sqrt(2) - 1));

// Opening = hout + aan elke kant de (iets samengedrukte) ring
opening = plug_breedte + 2 * (ring_dikte - ring_klem);
binnen  = buiten - 2 * wand;
kraag_afschuining = (binnen - opening) / 2; // 45 graden: print zonder support

echo(str("Hoekstraal dekseltje: ", plug_straal, " mm"));
echo(str("Opening bovenin: ", opening, " mm"));

// Afgerond vierkant, gecentreerd, met zijde z en hoekstraal r
module afgerond_vierkant(z, r) {
    offset(r = r) square(z - 2 * r, center = true);
}

// Alle vormen zijn concentrisch met het dekseltje.
function straal_bij(z) = plug_straal + (z - plug_breedte) / 2;

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
        // Inloop bovenaan
        hull() {
            laag(hoogte - inloop, 0.01, opening);
            laag(hoogte, 0.01, opening + 2 * inloop);
        }
        // Naam in de voorkant, 90 graden gedraaid, leest van onder naar boven
        if (naam != "")
            translate([0, -buiten / 2 + naam_diepte, hoogte / 2])
                rotate([90, 0, 0])
                    linear_extrude(naam_diepte + 1)
                        rotate(90)
                            resize([naam_lengte, 0], auto = true)
                                text(naam, font = lettertype, spacing = letterafstand,
                                     halign = "center", valign = "center");
    }
}

potje();
