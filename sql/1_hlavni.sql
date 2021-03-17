SELECT
Ucastnik.ID as ID_Ucastnik,
Ucastnik.ID_Cip as ID_Cip,
Ucastnik.Prezdivka,
Ucastnik.Vyloucen,
IfNull(ZtraceneZivoty.Pocet,0)  as Zivoty,
IfNull(ZtraceneZivoty.Pocet * 0_Pravidla.Zivoty,0)  as ZivotyBody,
Time(V_001_Start.Cas) as Start,
Time(V_002_Cil.Cas) AS Cil,

IfNull(V_RUN_01.Body, 0) as RUN_01,
IfNull(V_RUN_02.Body, 0) as RUN_02,
IfNull(V_RUN_03.Body, 0) as RUN_03,
IfNull(V_RUN_04.Body, 0) as RUN_04,
IfNull(V_RUN_05.Body, 0) as RUN_05,
IfNull(V_RUN_06.Body, 0) as RUN_06,
IfNull(V_RUN_07.Body, 0) as RUN_07,

IfNull(CP_01.Body,0) as CP_01,
IfNull(V_CP_01.Rozdil,0) as CP_01_T,
IfNull(V_CP_01.Body,0) as CP_01_RUN,

IfNull(CP_02.Body,0) as CP_02,
IfNull(V_CP_02.Rozdil,0) as CP_02_T,
IfNull(V_CP_02.Body,0) as CP_02_RUN,

IfNull(CP_03.Body,0) as CP_03,
IfNull(V_CP_03.Rozdil,0) as CP_03_T,
IfNull(V_CP_03.Body,0) as CP_03_RUN,

IfNull(CP_04.Body,0) as CP_04,
IfNull(V_CP_04.Rozdil,0) as CP_04_T,
IfNull(V_CP_04.Body,0) as CP_04_RUN,

IfNull(CP_05.Body,0) as CP_05,
IfNull(V_CP_05.Rozdil,0) as CP_05_T,
IfNull(V_CP_05.Body,0) as CP_05_RUN

from 0_Pravidla, Ucastnik
LEFT JOIN V_001_Start on Ucastnik.ID = V_001_Start.ID_Ucastnik
LEFT JOIN V_002_Cil on Ucastnik.ID = V_002_Cil.ID_Ucastnik

LEFT JOIN V_RUN_01 on Ucastnik.ID = V_RUN_01.ID_Ucastnik
LEFT JOIN V_RUN_02 on Ucastnik.ID = V_RUN_02.ID_Ucastnik
LEFT JOIN V_RUN_03 on Ucastnik.ID = V_RUN_03.ID_Ucastnik
LEFT JOIN V_RUN_04 on Ucastnik.ID = V_RUN_04.ID_Ucastnik
LEFT JOIN V_RUN_05 on Ucastnik.ID = V_RUN_05.ID_Ucastnik
LEFT JOIN V_RUN_06 on Ucastnik.ID = V_RUN_06.ID_Ucastnik
LEFT JOIN V_RUN_07 on Ucastnik.ID = V_RUN_07.ID_Ucastnik

LEFT JOIN CP_01 on Ucastnik.ID = CP_01.ID_Ucastnik
LEFT JOIN CP_02 on Ucastnik.ID = CP_02.ID_Ucastnik
LEFT JOIN CP_03 on Ucastnik.ID = CP_03.ID_Ucastnik
LEFT JOIN CP_04 on Ucastnik.ID = CP_04.ID_Ucastnik
LEFT JOIN CP_05 on Ucastnik.ID = CP_05.ID_Ucastnik

LEFT JOIN V_CP_01 on Ucastnik.ID = V_CP_01.ID_Ucastnik
LEFT JOIN V_CP_02 on Ucastnik.ID = V_CP_02.ID_Ucastnik
LEFT JOIN V_CP_03 on Ucastnik.ID = V_CP_03.ID_Ucastnik
LEFT JOIN V_CP_04 on Ucastnik.ID = V_CP_04.ID_Ucastnik
LEFT JOIN V_CP_05 on Ucastnik.ID = V_CP_05.ID_Ucastnik

LEFT JOIN ZtraceneZivoty on Ucastnik.ID = ZtraceneZivoty.ID_Ucastnik


