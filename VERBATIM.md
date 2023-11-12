# JEGYZŐKÖNYV

## Környezet

### Futtatás

`docker compose start postgres`

Az adatbázis elérhető kintről a `5632` porton. 

### Automatikus környezet létrehozás
Az adatbázis inicializálásakor automatikusan lefutnak az adatbázis táblákat, a példa adatokat és a triggerek/tárolt
eljárásokat létrehozó SQL file-ok, amiket a `docker/postgres/init_db` könyvtárban lehet megtalálni. A file-ok név
alapján sorbarendezve futnak le. Nevezéktan:
- 001-049: táblák
- 050-100: triggerek
- 101-200: adatok generálása
- 201-: tárolt ejárások

### Riportok
Egyszerű riportok futtatására a `reports` könyvtárban vannak példa SQL query-k:
- `available_cars.sql`: kilistázza azokat az autókat, amik ebben a pillanatban elérhetőek
- `customer_history.sql`: kilistázza az eddigi bérléseit az ügyfeleknek

## Táblák kialakítása

### Autók — `cars`

Az alapvető adatok mellett (gyártó, típus, évjárat, szín) fontosnak tartottam még a műszaki érvényesség dátumát is
feltüntetni, így erre a későbbiekben lehet akár trigger-t is írni, hogy a dátum előtt X nappal már ne engedje az adott
autót kikölcsönözni. Ezen felül az autó napi bérleti díját is felvezettem.

Fontos volt a kulcs kiválasztásánál, hogy olyan egyedi azonosítót válasszak, ami garantálja, hogy nem lesz ütközés és
tökéletesen azonosítja a fizikai autót is. Mivel a rendszám maga nem azonosítja az autót tökéletesen egyedileg — a
vásárolt egyedi rendszámok nem az autóhoz, hanem a tulajdonoshoz tartoznak, így az átkerülhet egy másik autóra eladás
után — az autók egyedi alvázszámát (VIN - Vehicle Identification Number) tettem meg elsődleges kulcsnak.

### Ügyfelek — `customers`

A bérlő adatain felül lehetőség van cégnév megadásra is, illetve egy eltérő számlázási cím tárolására is.

### Bérlések és eseményeik — `rentals` és `rental_events`

Úgy gondoltam, hogy egy egyszerű `rentals` tábla, amiben egy start és end date van meghatározva, nem lenne elégséges az
esetleges jövőbeni fejlesztésekre, illetve az autó aktuális állapotának nyomonkövetésére sem, hogy mikortól bérelhető
újra. Emiatt döntöttem úgy, hogy a bérléshez tartozó eseményeket (kibélés, visszahozás, takarítás, szervíz) külön
rekordokban legyen letárolva.

### Számlák — `invoices` és `invoice_items`

A számlák mivel tartalmazhatnak több elemet is — akár a takarítást, mint általános összeget —, emiatt azokat külön
táblába szerveztem.

A számlák generálása a `generate_invoices()` tárolt eljárással történik.

