SELECT Zavod.ID_Ucastnik, 
MIN(Zavod.Cas) as Prichod,
MAX(Zavod.Cas) as Odchod,
TIMEDIFF(MAX(Zavod.Cas),MIN(Zavod.Cas)) as Rozdil

from Zavod
where Zavod.ID_Stanoviste = 10
group by Zavod.ID_Ucastnik


