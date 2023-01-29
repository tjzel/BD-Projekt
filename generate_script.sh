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
cat src/function_kwota_kary.sql >> start_database.sql
cat src/view_kierowcy_badania.sql >> start_database.sql
cat src/view_przedawnione_kary.sql >> start_database.sql
cat src/view_ranking_kontrolerow.sql >> start_database.sql
cat src/procedure_wystaw_mandat.sql >> start_database.sql
cat src/procedure_oplacenie_mandatu.sql >> start_database.sql
cat src/trigger_table_osoby_insert.sql >> start_database.sql
cat src/trigger_table_osoby_update.sql >> start_database.sql