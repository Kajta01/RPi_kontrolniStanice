SELECT 
Ucastnik.ID as ID_Ucastnik,
Zavod.ID_Cip, 
MIN(Zavod.Cas) as Prichod,
MAX(Zavod.Cas) as Odchod,
TIMEDIFF(MAX(Zavod.Cas),MIN(Zavod.Cas)) as Rozdil,
COUNT(Zavod.ID) as Pocet,
IF(COUNT(Zavod.ID)=1,0_Pravidla.ProbihaciStanoviste , 0) as Body

from 0_Pravidla, Zavod
INNER JOIN Ucastnik on Ucastnik.ID_Cip = Zavod.ID_Cip
where Zavod.ID_Stanoviste = 10
group by Ucastnik.id


