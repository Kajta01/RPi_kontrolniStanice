CREATE VIEW V_0_FINAL AS 
SELECT 
    ID_Ucastnik, 
    Prezdivka,  
    Zivoty as ZtraceneZivoty,
    CasNaTrase,
    CekaciCas,
    RUN,
    CP,
    RUN_CP,
    Vyloucen,
    SEC_TO_TIME(TIME_TO_SEC( CasNaTrase )- TIME_TO_SEC( CekaciCas ) - ((ZivotyBody + RUN+CP + RUN_CP)*60) ) as VyslednyCas



FROM (
  SELECT 
    V.ID_Ucastnik, 
    V.Prezdivka,
    V.Vyloucen,
    V.Zivoty,
    V.ZivotyBody,
    TIMEDIFF(V.Cil,V.Start) as CasNaTrase,
    (V.RUN_01 + V.RUN_02 + V.RUN_03 + V.RUN_02 + V.RUN_05 + V.RUN_06 + V.RUN_07) as RUN,
    (V.CP_01 + V.CP_02 + V.CP_03 + V.CP_04 + V.CP_05) as CP,
    (V.CP_01_RUN + V.CP_02_RUN + V.CP_03_RUN + V.CP_04_RUN +V.CP_05_RUN)  as RUN_CP,
    Time(TIME_FORMAT(SEC_TO_TIME(  TIME_TO_SEC( V.CP_01_T )+TIME_TO_SEC( V.CP_02_T ) +TIME_TO_SEC( V.CP_03_T ) 
    +TIME_TO_SEC( V.CP_04_T )+TIME_TO_SEC( V.CP_05_T )) , "%H:%i:%s")) AS CekaciCas

  FROM V_000_Vysledky as V
) AS x
order by VyslednyCas
