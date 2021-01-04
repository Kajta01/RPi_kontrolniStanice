SELECT
Ucastnik.ID,
Ucastnik.Prezdivka,
Ucastnik.Vyloucen,
IfNull(ZtraceneZivoty.Pocet * 0_Pravidla.Zivoty,0)  as Zivoty,
Time(V_001_Start.Cas) as Start,
Time(V_002_Cil.Cas) AS Cil,

IfNull(V_RUN_01.Body, 0) as RUN01,
IfNull(V_RUN_02.Body, 0) as RUN02,
IfNull(V_RUN_03.Body, 0) as RUN03,
IfNull(V_RUN_04.Body, 0) as RUN04,
IfNull(V_RUN_05.Body, 0) as RUN05,
IfNull(V_RUN_06.Body, 0) as RUN06,
IfNull(V_RUN_07.Body, 0) as RUN07,

IfNull(CP1.Body,0) as CP1,
IfNull(V_CP_01.Rozdil,0) as CP1_T,
IfNull(V_CP_01.Body,0) as CP1_RUN,

IfNull(CP2.Body,0) as CP2,
IfNull(V_CP_02.Rozdil,0) as CP2_T,
IfNull(V_CP_02.Body,0) as CP2_RUN,

IfNull(CP3.Body,0) as CP3,
IfNull(V_CP_03.Rozdil,0) as CP3_T,
IfNull(V_CP_03.Body,0) as CP3_RUN,

IfNull(CP4.Body,0) as CP4,
IfNull(V_CP_04.Rozdil,0) as CP4_T,
IfNull(V_CP_04.Body,0) as CP4_RUN,

IfNull(CP5.Body,0) as CP5,
IfNull(V_CP_05.Rozdil,0) as CP5_T,
IfNull(V_CP_05.Body,0) as CP5_RUN

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

LEFT JOIN CP1 on Ucastnik.ID = CP1.ID_Ucastnik
LEFT JOIN CP2 on Ucastnik.ID = CP2.ID_Ucastnik
LEFT JOIN CP3 on Ucastnik.ID = CP3.ID_Ucastnik
LEFT JOIN CP4 on Ucastnik.ID = CP4.ID_Ucastnik
LEFT JOIN CP5 on Ucastnik.ID = CP5.ID_Ucastnik

LEFT JOIN V_CP_01 on Ucastnik.ID = V_CP_01.ID_Ucastnik
LEFT JOIN V_CP_02 on Ucastnik.ID = V_CP_02.ID_Ucastnik
LEFT JOIN V_CP_03 on Ucastnik.ID = V_CP_03.ID_Ucastnik
LEFT JOIN V_CP_04 on Ucastnik.ID = V_CP_04.ID_Ucastnik
LEFT JOIN V_CP_05 on Ucastnik.ID = V_CP_05.ID_Ucastnik

LEFT JOIN ZtraceneZivoty on Ucastnik.ID = ZtraceneZivoty.ID_Ucastnik


