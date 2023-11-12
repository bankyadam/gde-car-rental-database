# Autókölcsönzö Adatbázis Rendszer Kialakitása

## Cél
Egy autókölcsönző cég adatbázis rendszerének kialakítása, megvalósítása és elemzése. Az adatbázisnak képesnek kell lennie kezelni a járművek, ügyfelek, kölcsönzések és számlák adatait, valamint automatizálnia kell bizonyos kölcsönzési műveleteket tárolt eljárások segítségével.
A járművek, ügyfelek, kölcsönzések tábláknak 3NF-ben kell lenniük

## Feladatok
### Adatbázis Tervezés
- Tervezd meg az autókölcsönző adatbázist! Vedd figyelembe a szükséges táblákat: Járművek, Ügyfelek, Kölcsönzések, Számlák.
- Tervezd meg az indexeket a hatékony lekérdezés érdekében.
### Adatok Beszúrása
Készíts SQL INSERT utasításokat az adatok táblákba történő beszúrásához.
### Lekérdezések Megírása
Készíts lekérdezéseket, amelyek információt nyújtanak a különféle járművek elérhetőségéről, ügyfelek kölcsönzési előzményeiről.
### Triggerek Megírása
- Hozz létre egy triggert, ami automatikusan frissíti a jármű állapotát (elérhető/nem elérhető), amikor egy kölcsönzés történik.
### Tárolt Eljárások Megírása
- Számla generálása tárolt eljárással.
- Különféle statisztikák és riportok generálása tárolt eljárással.
### Ügyfelek Tábla Particionálása
- Particionáld az Ügyfelek táblát megye alapján.
### Adatbázis Teljesítmény Analízis
- Elemezd, hogyan teljesít az adatbázis a lekérdezések és műveletek során, és tegyél javaslatokat a teljesítmény optimalizálására.

## Beadandók
- Az adatbázis tervezését bemutató dokumentáció.
- SQL scriptek (táblák létrehozása, adatok beszúrása, lekérdezések, triggerek, tárolt eljárások).
- Teljesítményanalízis jelentés.

## Értékelési Szempontok
- A tervezés logikai felépítése és megvalósíthatósága.
- Az SQL scriptek helyessége és hatékonysága.
- A teljesítményanalízis alapossága és a benne foglalt javaslatok relevanciája.