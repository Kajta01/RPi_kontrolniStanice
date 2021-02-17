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
__________________________________________________-

CREATE VIEW `V_RUN_04` AS 
SELECT Ucastnik.ID as ID_Ucastnik, 
Zavod.ID_Cip, 
Zavod.Cas,
COUNT(Zavod.ID) as Pocet,
0_Pravidla.ProbihaciStanoviste as Body,
Zavod.ID_Stanoviste
 

from  0_Pravidla, Ucastnik
INNER JOIN Zavod on Ucastnik.ID_Cip = Zavod.ID_Cip
INNER JOIN Stanoviste on Zavod.ID_Stanoviste = Stanoviste.ID

where Stanoviste.ID_Skupina=4
GROUP by Ucastnik.ID;

CREATE VIEW `V_RUN_05` AS 
SELECT Ucastnik.ID as ID_Ucastnik, 
Zavod.ID_Cip, 
Zavod.Cas,
COUNT(Zavod.ID) as Pocet,
0_Pravidla.ProbihaciStanoviste as Body,
Zavod.ID_Stanoviste
 

from  0_Pravidla, Ucastnik
INNER JOIN Zavod on Ucastnik.ID_Cip = Zavod.ID_Cip
INNER JOIN Stanoviste on Zavod.ID_Stanoviste = Stanoviste.ID

where Stanoviste.ID_Skupina=5
GROUP by Ucastnik.ID;

CREATE VIEW `V_RUN_06` AS 
SELECT Ucastnik.ID as ID_Ucastnik, 
Zavod.ID_Cip, 
Zavod.Cas,
COUNT(Zavod.ID) as Pocet,
0_Pravidla.ProbihaciStanoviste as Body,
Zavod.ID_Stanoviste
 

from  0_Pravidla, Ucastnik
INNER JOIN Zavod on Ucastnik.ID_Cip = Zavod.ID_Cip
INNER JOIN Stanoviste on Zavod.ID_Stanoviste = Stanoviste.ID

where Stanoviste.ID_Skupina=6
GROUP by Ucastnik.ID;

CREATE VIEW `V_RUN_07` AS 
SELECT Ucastnik.ID as ID_Ucastnik, 
Zavod.ID_Cip, 
Zavod.Cas,
COUNT(Zavod.ID) as Pocet,
0_Pravidla.ProbihaciStanoviste as Body,
Zavod.ID_Stanoviste
 

from  0_Pravidla, Ucastnik
INNER JOIN Zavod on Ucastnik.ID_Cip = Zavod.ID_Cip
INNER JOIN Stanoviste on Zavod.ID_Stanoviste = Stanoviste.ID

where Stanoviste.ID_Skupina=7
GROUP by Ucastnik.ID;