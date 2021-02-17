CREATE VIEW `V_001_Start` AS 
SELECT Ucastnik.ID as ID_Ucastnik,
Zavod.ID_Cip,
Zavod.Cas

from Ucastnik
INNER JOIN Zavod on Zavod.ID_Cip = Ucastnik.ID_Cip
WHERE Zavod.ID_Stanoviste = 1;



CREATE VIEW `V_002_Cil` AS 
SELECT Ucastnik.ID as ID_Ucastnik,
Zavod.ID_Cip,
Zavod.Cas

from Ucastnik
INNER JOIN Zavod on Zavod.ID_Cip = Ucastnik.ID_Cip
WHERE Zavod.ID_Stanoviste = 100;