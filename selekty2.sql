select rok, count(rok) as pocet_zapisov from zapis group by rok;

select 
  zapis.id_predmet, 
  (select predmet.NAZOV from predmet where predmet.id_predmet = zapis.id_predmet) as nazov, 
  zapis.rok, 
  count(zapis.rok) as pocet_zapisov 
from zapis 
group by zapis.id_predmet, zapis.rok; 

select max(kredity), min(kredity), avg(kredity) from Predmet;

