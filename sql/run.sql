SELECT Ucastnik.ID as ID_Ucastnik, 
Zavod.ID_Cip, 
Zavod.Cas,
COUNT(Zavod.ID) as Pocet,
0_Pravidla.ProbihaciStanoviste as Body,
Zavod.ID_Stanoviste
 

from  0_Pravidla, Ucastnik
INNER JOIN Zavod on Ucastnik.ID_Cip = Zavod.ID_Cip
INNER JOIN Stanoviste on Zavod.ID_Stanoviste = Stanoviste.ID

where Stanoviste.ID_Skupina=1
GROUP by Ucastnik.ID
