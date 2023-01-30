# BD_Projekt
Tutaj jeszcze nic nie ma, ale coś powstanie.
[Arkusz google](https://docs.google.com/spreadsheets/d/1Jg0HyKWWY96D-6gPyGL3LQ-5d9hi8gJcSzA8RWQKls8/edit#gid=0).

Temat projektu: *Baza danych przedsiębiorstwa komunikacji miejskiej. Baza powinna przechowywać informacje o kierowcach, liniach (jakie są przystanki), autobusach oraz rozkładzie jazdy.*

## Wymagania dotyczące bazy
* Min. 16 zaprojektowanych tabel,
* zawieranie danych dotyczących atrybutów zmieniających się w czasie,
* zawieranie tabel realizujących jeden ze schematów dziedziczenia,
* min. 10 widoków lub funkcji,
* oprogramowanie z wykorzystaniem procedur składowanych i wyzwalaczy (min. po 5 procedur i po 5 wyzwalaczy),
* projekt strategii pielęgnacji bazy danych (kopie zapasowe),
* opcjonalne utworzenie dwóch programów klienckich - jeden dla administratora i drugi dla pozostałych użytkowników.

## Wymagania dotyczące opisu
* Podstawowe założenia projektu (cel, główne założenia, możliwości, ograniczenia przyjęte przy projektowaniu),
* diagram ER,
* schemat bazy danych (diagram relacji) [*chyba to samo co wyżej??*],
* dodatkowe więzy integralności danych (nie zapisane w schemacie),
* utworzone indeksy,
* opis stworzonych widoków,
* opis procedur składowanych,
* opis wyzwalaczy,
* skrypt tworzący bazę danych,
* typowe zapytania.

--------------------------------------

## Tabele (20)
* Osoby,
* Stanowiska,
* Pracownicy,
* Kierowcy,
* Kontrolerzy,
* Strefy,
* Bilety,
* Progresja kar,
* Przewinienia,
* Nałożone kary,
* Autobusy,
* Czasy przejazdu,
* Koszty eksploatacji,
* Kursy,
* Linie,
* Modele autobusów,
* Przystanki,
* Trasy,
* Usługi,
* Wykonane kursy

## Funkcje (7)
* Kwota kary,
* Pracownicy na stanowisku,
* Addtime
    dodaje dwie wartości formatu TIME do siebie (na potrzeby obliczania czasów dojazdu do poszczególnych przystanków),
* Harmonogram jazdy autobusu
    prezentuje harmonogram jazdy autobusu dla danego dnia tygodnia, tzn. w jakich godzinach wykonywane są nim poszczególne kursy
    i na jakich przystankach się one zaczynają i kończą
* Harmonogram pracy kierowcy
    prezentuje harmonogram pracy kierowcy dla danego dnia tygodnia, tzn. w jakich godzinach wykonuje poszczególne kursy
    i na jakich przystankach się one zaczynają i kończą,
* Rozkład jazdy dla kursu
    dla danego kursu prezentuje czasy dojazdu do poszczególnych przystanków na jego trasie,
* Rozkład jazdy dla przystanku
    dla danego przystanku i dnia tygodnia wypisuje godziny w jakich zatrzymują się na nim autobusy wszystkich linii przez niego przejeżdżających 


## Widoki (4)
* Przedawnione kary,
* Kierowcy do wysłania na badania,
* Miesięczny ranking kontrolerów,
* Czasy trwania kursów
    dla każdego kursu podaje godzinę rozpoczęcia i zakończenia wraz z końcowymi przystankami

## Procedury (6)
* Opłacenie mandatu,
* Wystawienie mandatu,
* Aktualizacja mandatów,
* Zmiana kwot kar
* Zastąp autobus
    zastępuje jeden autobus innym we wszystkich kursach w tabeli Kursy,
* Zastąp kierowcę
    przypisuje wszystkie kursy jednego kierowcy innemu


## Wyzwalacze (5)
* Osoby INSERT,
* Osoby UPDATE,
* NałożoneKary ALL
* Kursy INSERT 
    sprawdza czy wstawione kursy mogą być wykonywane przez danego kierowcę danym autobusem,
    kontroluje by każdy kurs był przypisany do nie więcej niż jednego z dni,
* Kursy UPDATE
    uniemożliwia zmianę godziny rozpoczęcia kursu ze względu na konieczność zachowania integralności tabeli wykonane kursy,
    sprawdza czy wstawione kursy mogą być wykonywane przez danego kierowcę danym autobusem,
    kontroluje by każdy kurs był przypisany do nie więcej niż jednego z dni,

## Dodatkowe więzy integralności
W tabeli Kursy przy wstawianiu lub aktualizacji danych przez wyzwalacze realizowane jest sprawdzanie czy dany kurs może być wykonany przez danego kierowcę danym autobusem tzn. czy w tym samym czasie kierowca lub autobus nie wykonują jakiegoś innego kursu.
