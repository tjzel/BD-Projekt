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

## Tabele (10)
* Osoby,
* Stanowiska,
* Pracownicy,
* Kierowcy,
* Kontrolerzy,
* Strefy,
* Bilety,
* Progresja kar,
* Przewinienia,
* Nałożone kary

## Funkcje (2)
* Kwota kary,
* Pracownicy na stanoiwsku

## Widoki (3)
* Przedawnione kary,
* Kierowcy do wysłania na badania,
* Miesięczny ranking kontrolerów

## Procedury (4)
* Opłacenie mandatu,
* Wystawienie mandatu,
* Aktualizacja mandatów,
* Zmiana kwot kar

## Wyzwalacze (3)
* Osoby INSERT,
* Osoby UPDATE,
* NałożoneKary ALL
