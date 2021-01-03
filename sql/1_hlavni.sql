SELECT
Ucastnik.ID,
Ucastnik.Prezdivka,
IfNull(ZtraceneZivoty.Pocet * 0_Pravidla.Zivoty,0)  as Zivoty,
Time(V_001_Start.Cas) as Start,
Time(V_002_Cil.Cas) AS Cil,
IfNull(V_01_RUN.Body, 0) as RUN1,
IfNull(CP1.Body,0) as CP1,
IfNull(V_01_CP.Rozdil,0) as RUN1_T

from 0_Pravidla, Ucastnik
LEFT JOIN V_001_Start on Ucastnik.ID = V_001_Start.ID_Ucastnik
LEFT JOIN V_002_Cil on Ucastnik.ID = V_002_Cil.ID_Ucastnik
LEFT JOIN V_01_RUN on Ucastnik.ID = V_01_RUN.ID_Ucastnik
LEFT JOIN CP1 on Ucastnik.ID = CP1.ID_Ucastnik
LEFT JOIN ZtraceneZivoty on Ucastnik.ID = ZtraceneZivoty.ID_Ucastnik
LEFT JOIN V_01_CP on Ucastnik.ID = V_01_CP.ID_Ucastnik