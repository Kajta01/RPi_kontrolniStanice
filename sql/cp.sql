CREATE VIEW `V_CP_01` AS
SELECT 
Ucastnik.ID as ID_Ucastnik,
Zavod.ID_Cip, 
MIN(Zavod.Cas) as Prichod,
MAX(Zavod.Cas) as Odchod,
TIMEDIFF(MAX(Zavod.Cas),MIN(Zavod.Cas)) as Rozdil,
COUNT(Zavod.ID) as Pocet,
IF(COUNT(Zavod.ID)=1,0_Pravidla.ProbihaciStanoviste , 0_Pravidla.UkoloveStanoviste) as Body

from 0_Pravidla, Zavod
INNER JOIN Ucastnik on Ucastnik.ID_Cip = Zavod.ID_Cip
where Zavod.ID_Stanoviste = "CP_01"
group by Ucastnik.id;

CREATE VIEW `V_CP_02` AS
SELECT 
Ucastnik.ID as ID_Ucastnik,
Zavod.ID_Cip, 
MIN(Zavod.Cas) as Prichod,
MAX(Zavod.Cas) as Odchod,
TIMEDIFF(MAX(Zavod.Cas),MIN(Zavod.Cas)) as Rozdil,
COUNT(Zavod.ID) as Pocet,
IF(COUNT(Zavod.ID)=1,0_Pravidla.ProbihaciStanoviste , 0_Pravidla.UkoloveStanoviste) as Body

from 0_Pravidla, Zavod
INNER JOIN Ucastnik on Ucastnik.ID_Cip = Zavod.ID_Cip
where Zavod.ID_Stanoviste = "CP_02"
group by Ucastnik.id;

CREATE VIEW `V_CP_03` AS
SELECT 
Ucastnik.ID as ID_Ucastnik,
Zavod.ID_Cip, 
MIN(Zavod.Cas) as Prichod,
MAX(Zavod.Cas) as Odchod,
TIMEDIFF(MAX(Zavod.Cas),MIN(Zavod.Cas)) as Rozdil,
COUNT(Zavod.ID) as Pocet,
IF(COUNT(Zavod.ID)=1,0_Pravidla.ProbihaciStanoviste , 0_Pravidla.UkoloveStanoviste) as Body

from 0_Pravidla, Zavod
INNER JOIN Ucastnik on Ucastnik.ID_Cip = Zavod.ID_Cip
where Zavod.ID_Stanoviste = "CP_03"
group by Ucastnik.id;

CREATE VIEW `V_CP_04` AS
SELECT 
Ucastnik.ID as ID_Ucastnik,
Zavod.ID_Cip, 
MIN(Zavod.Cas) as Prichod,
MAX(Zavod.Cas) as Odchod,
TIMEDIFF(MAX(Zavod.Cas),MIN(Zavod.Cas)) as Rozdil,
COUNT(Zavod.ID) as Pocet,
IF(COUNT(Zavod.ID)=1,0_Pravidla.ProbihaciStanoviste , 0_Pravidla.UkoloveStanoviste) as Body

from 0_Pravidla, Zavod
INNER JOIN Ucastnik on Ucastnik.ID_Cip = Zavod.ID_Cip
where Zavod.ID_Stanoviste = "CP_04"
group by Ucastnik.id;

CREATE VIEW `V_CP_05` AS
SELECT 
Ucastnik.ID as ID_Ucastnik,
Zavod.ID_Cip, 
MIN(Zavod.Cas) as Prichod,
MAX(Zavod.Cas) as Odchod,
TIMEDIFF(MAX(Zavod.Cas),MIN(Zavod.Cas)) as Rozdil,
COUNT(Zavod.ID) as Pocet,
IF(COUNT(Zavod.ID)=1,0_Pravidla.ProbihaciStanoviste , 0_Pravidla.UkoloveStanoviste) as Body

from 0_Pravidla, Zavod
INNER JOIN Ucastnik on Ucastnik.ID_Cip = Zavod.ID_Cip
where Zavod.ID_Stanoviste = "CP_05"
group by Ucastnik.id;
