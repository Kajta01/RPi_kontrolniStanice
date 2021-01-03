SELECT Ucastnik.ID, 
Ucastnik.Prezdivka, 
TIMEDIFF(V_000_Vysledky.Cil,V_000_Vysledky.Start) as CasNaTrase

from Ucastnik
LEFT JOIN V_000_Vysledky on Ucastnik.ID = V_000_Vysledky.ID