
SELECT 
    ID, 
    Prezdivka,  
    Zivoty,
    CasNaTrase,
    CekaciCas,
    RUN,
    CP, 
    SEC_TO_TIME(TIME_TO_SEC( CasNaTrase )- TIME_TO_SEC( CekaciCas ) - ((Zivoty+RUN+CP)*60) ) as VyslednyCas



FROM (
  SELECT 
    V.ID, 
    V.Prezdivka,
    V.Zivoty,
    TIMEDIFF(V.Cil,V.Start) as CasNaTrase,
    (V.RUN01 + V.RUN02 + V.RUN03 + V.RUN02 + V.RUN05 + V.RUN06 + V.RUN07) as RUN,
    (V.CP1 + V.CP2 + V.CP3 + V.CP4 + V.CP5) as CP,
    Time(TIME_FORMAT(SEC_TO_TIME(  TIME_TO_SEC( V.CP1_T )+TIME_TO_SEC( V.CP2_T ) +TIME_TO_SEC( V.CP3_T ) 
    +TIME_TO_SEC( V.CP4_T )+TIME_TO_SEC( V.CP5_T )) , "%H:%i:%s")) AS CekaciCas

  FROM V_000_Vysledky as V
    where V.Vyloucen = 0
) AS x
order by VyslednyCas
