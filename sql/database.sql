CREATE DATABASE TEST_OVA;

INSERT INTO App.Akce (Nazev, Heslo)
values ("TEST_OVA", "grafana")


--------------

CREATE TABLE TEST_OVA.0_Pravidla LIKE CJTZV_19.0_Pravidla;

CREATE TABLE TEST_OVA.Cip LIKE CJTZV_19.Cip;
CREATE TABLE TEST_OVA.CP_01 LIKE CJTZV_19.CP_01;
CREATE TABLE TEST_OVA.CP_02 LIKE CJTZV_19.CP_02;
CREATE TABLE TEST_OVA.CP_03 LIKE CJTZV_19.CP_03;
CREATE TABLE TEST_OVA.CP_04 LIKE CJTZV_19.CP_04;
CREATE TABLE TEST_OVA.CP_05 LIKE CJTZV_19.CP_05;
CREATE TABLE TEST_OVA.Skupina LIKE CJTZV_19.Skupina;
CREATE TABLE TEST_OVA.Stanoviste LIKE CJTZV_19.Stanoviste;
CREATE TABLE TEST_OVA.Ucastnik LIKE CJTZV_19.Ucastnik;
CREATE TABLE TEST_OVA.Zavod LIKE CJTZV_19.Zavod;
CREATE TABLE TEST_OVA.ZtraceneZivoty LIKE CJTZV_19.ZtraceneZivoty;
--------------
ALTER TABLE `Ucastnik` ADD FOREIGN KEY (`ID_Cip`) 
REFERENCES `Cip`(`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;



--------------
INSERT INTO `Cip` (`ID`) VALUES ('101');
INSERT INTO `Cip` (`ID`) VALUES ('102');
INSERT INTO `Cip` (`ID`) VALUES ('103');
INSERT INTO `Cip` (`ID`) VALUES ('104');
INSERT INTO `Cip` (`ID`) VALUES ('105');
INSERT INTO `Ucastnik` (`ID`, `ID_Cip`, `Jmeno`, `Prijmeni`, `Prezdivka`, `Vyloucen`) 
VALUES ('1', '101', 'Karel', 'Mohyla', 'Kulička', '0');
INSERT INTO `Ucastnik` (`ID`, `ID_Cip`, `Jmeno`, `Prijmeni`, `Prezdivka`, `Vyloucen`) 
VALUES ('2', '102', 'Radan', 'Vališ', 'Lev', '0');
INSERT INTO `Ucastnik` (`ID`, `ID_Cip`, `Jmeno`, `Prijmeni`, `Prezdivka`, `Vyloucen`) 
VALUES ('3', '103', 'Pavla', 'Ludvíková', 'Nika', '0');
INSERT INTO `Ucastnik` (`ID`, `ID_Cip`, `Jmeno`, `Prijmeni`, `Prezdivka`, `Vyloucen`) 
VALUES ('4', '104', 'Kristián', 'Váša', 'Tulák', '0');
INSERT INTO `Ucastnik` (`ID`, `ID_Cip`, `Jmeno`, `Prijmeni`, `Prezdivka`, `Vyloucen`) 
VALUES ('5', '105', 'Iva', 'Kutílková', 'Skřítek', '0');

INSERT INTO `Stanoviste` (`ID`, `Nazev`, `Ukolove`, `ID_Skupina`, `Aktivni`, `GPSN`, `GPSE`, `Popis`, `Poradi`) 
VALUES ('10', 'Start', '2', NULL, '1', '49.83567640', '18.15579440', '', '1');

