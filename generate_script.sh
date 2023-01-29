# !/bin/bash
rm start_database.sql
touch start_database.sql
cat src/database.sql >> start_database.sql
cat src/table_osoby.sql >> start_database.sql
cat src/table_stanowiska.sql >> start_database.sql
cat src/table_pracownicy.sql >> start_database.sql
cat src/table_kierowcy.sql >> start_database.sql
cat src/table_kontrolerzy.sql >> start_database.sql
cat src/table_strefy.sql >> start_database.sql
cat src/table_bilety.sql >> start_database.sql
cat src/table_przewinienia.sql >> start_database.sql
cat src/table_progresja_kar.sql >> start_database.sql
cat src/table_nalozone_kary.sql >> start_database.sql
###
cat src/view_kierowcy_badania.sql >> start_database.sql
cat src/view_przedawnione_kary.sql >> start_database.sql
cat src/view_ranking_kontrolerow.sql >> start_database.sql

cat src/table_linie.sql >> start_database.sql
cat src/table_modele_autobusow.sql >> start_database.sql
cat src/table_autobusy.sql >> start_database.sql
cat src/table_przystanki.sql >> start_database.sql
cat src/table_trasy.sql >> start_database.sql
cat src/table_kursy.sql >> start_database.sql
cat src/table_czasy_przejazdu.sql >> start_database.sql
cat src/table_uslugi.sql >> start_database.sql
cat src/table_koszty_eksploatacji.sql >> start_database.sql
cat src/table_wykonane_kursy.sql >> start_database.sql
cat src/function_addtime.sql >> start_database.sql
cat src/function_rozklad_jazdy_dla_przystanku.sql >> start_database.sql
cat src/function_rozklad_jazdy_dla_kursu.sql >> start_database.sql
cat src/view_czasy_trwania_kursow.sql >> start_database.sql
cat src/function_harmonogram_jazdy_autobusu.sql >> start_database.sql
cat src/function_harmonogram_pracy_kierowcy.sql >> start_database.sql
###
cat src/trigger_table_osoby_insert.sql >> start_database.sql
cat src/trigger_table_osoby_update.sql >> start_database.sql
cat src/trigger_table_nalozone_kary_all.sql >> start_database.sql
###
cat src/function_kwota_kary.sql >> start_database.sql
cat src/function_pracownicy_na_stanowisku.sql >> start_database.sql
###
cat src/procedure_wystaw_mandat.sql >> start_database.sql
cat src/procedure_oplacenie_mandatu.sql >> start_database.sql
cat src/procedure_aktualizacja_mandatow.sql >> start_database.sql
cat src/procedure_zmien_kary.sql >> start_database.sql