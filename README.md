# Snoeppotje voor Meike

Een 3D-printbaar potje voor onder het oude bamboe dekseltje.

![Voorbeeld](voorbeeld.png)

## Printen

Open `snoeppotje.stl` in PrusaSlicer. Het potje staat al goed: opening naar boven.

- Materiaal: PLA
- Laaghoogte: 0,2 mm
- Perimeters: 4 (de wand is 1,6 mm, dan is hij helemaal massief)
- Geen support nodig
- Afmetingen: 57 x 57 x 80 mm, ongeveer 200 ml inhoud

## Hoe het past

- Het houten deel onderaan het dekseltje is 49 x 49 mm (hoekstraal ca. 11,2 mm).
  De platte siliconen ring (10 mm breed, 1 mm dik, buitenmaat 57 mm) steekt daar
  rondom 4 mm buiten uit.
- Bij het sluiten vouwt dat randje naar beneden de opening in, net als bij het
  oude glazen potje. Het wordt dan geklemd tussen het hout en de binnenwand.
- De opening is daarom 50,6 mm: 49 mm hout plus aan elke kant 0,8 mm voor de ring
  van 1 mm. De ring wordt dus 0,2 mm (20%) ingedrukt: dicht, maar nog soepel.
- De kraag waarin de ring afdicht is 10 mm diep, met bovenaan een schuine inloop
  van 1 mm zodat de ring netjes naar binnen vouwt.
- Onder de kraag wordt het potje binnenin wijder, met een schuine overgang van
  45 graden zodat het zonder support print.

## Aanpassen

`snoeppotje.scad` is het bronbestand voor [OpenSCAD](https://openscad.org) (gratis).
Bovenin staan alle maten, zoals `hoogte`, `wand` en `ring_klem`. Na aanpassen:
F6 (renderen), daarna F7 (STL exporteren), en die STL open je weer in PrusaSlicer.

Gaat het dekseltje te zwaar open of dicht, zet `ring_klem` dan op 0.1 of 0. Sluit het niet goed af, zet het op 0.3.
