SELECT Ucastnik.ID,
Zavod.ID_Cip,
Zavod.Cas

from Ucastnik
INNER JOIN Zavod on Zavod.ID_Cip = Ucastnik.ID_Cip
WHERE Zavod.ID_Stanoviste = 100
