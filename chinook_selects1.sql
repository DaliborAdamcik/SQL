--------------------------------------------------------
--  DDL for View BP01
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."BP01" ("NAME", "CNT") AS 
  select mediatype.name, count(*) as cnt from track
left join mediatype on mediatype.MEDIATYPEID = track.MEDIATYPEID
group by mediatype.name;
--------------------------------------------------------
--  DDL for View BP02
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."BP02" ("COUNTRY", "ALBUM", "INCOME") AS 
  select country, album, sum(unitprice*quantity) as income
from bp02p
group by country, album
order by country, album;
--------------------------------------------------------
--  DDL for View BP02P
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."BP02P" ("ALBUM", "ARTISTID", "ALBUMID", "TRACKID", "UNITPRICE", "QUANTITY", "COUNTRY") AS 
  select album.title as album, album.artistid, album.albumid, track.trackid, track.unitprice, invoiceline.quantity, invoice.billingcountry as country
from album 
join track on track.albumid = album.albumid
join invoiceline on invoiceline.trackid= track.trackid
join invoice on invoice.INVOICEID = invoiceline.INVOICEID
where album.artistid = (select artistid from artist where name like '%Audioslave%');
--------------------------------------------------------
--  DDL for View DA01_ARTISTALBUM
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."DA01_ARTISTALBUM" ("NAME", "TITLE") AS 
  select artist.name, album.title from artist right join album on artist.artistid = album.artistid order by artist.name, album.title;
--------------------------------------------------------
--  DDL for View DA02_ARTALBCNT
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."DA02_ARTALBCNT" ("NAME", "ALBUMCOUNT") AS 
  select artist.name, (SELECT count(*) FROM album WHERE artist.artistid = album.artistid) as albumcount FROM ARTIST order by artist.name DESC;
--------------------------------------------------------
--  DDL for View JK01
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."JK01" ("USAALBUM", "USATRACK") AS 
  select count(distinct albumid) as usaalbum, count(trackid) as usatrack from jk01p;
--------------------------------------------------------
--  DDL for View JK01P
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."JK01P" ("TRACKID", "ALBUMID") AS 
  select invoiceline.trackid, track.albumid 
from invoice 
join invoiceline on invoiceline.invoiceid = invoice.invoiceid
join track on invoiceline.TRACKID = track.TRACKID
where invoicedate = '20.7.11' and BILLINGCOUNTRY='USA';
--------------------------------------------------------
--  DDL for View JK02
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."JK02" ("METALICAALBUMS") AS 
  select count(*) as metalicaalbums from album where album.artistid = (select artistid from artist where name like 'Metallica%');
--------------------------------------------------------
--  DDL for View JL01
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."JL01" ("TRACKID", "NAME", "SECS") AS 
  select trackid, name, milliseconds / 1000 as secs from track where milliseconds > 600000;
--------------------------------------------------------
--  DDL for View JL02
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."JL02" ("TRACKID", "NAME", "GENRENAME") AS 
  select track.trackid, track.name, genre.name as genrename from track 
join genre on genre.genreid = track.genreid
where track.genreid = (select genre.genreid from genre where genre.name = 'Pop') and track.name like 'D%';
--------------------------------------------------------
--  DDL for View JU01
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."JU01" ("MPEG4", "ALBUMID", "TITLE") AS 
  select count(*) as mpeg4, track.ALBUMID, album.title from track 
join album on track.albumid = album.albumid
where track.mediatypeid = 3 
group by track.albumid, album.title order by album.title asc;
--------------------------------------------------------
--  DDL for View JU02
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."JU02" ("BILLINGCOUNTRY", "TATALFOFCOUNTRY") AS 
  select billingcountry, sum(total) as tatalfofcountry from invoice group by billingcountry;
--------------------------------------------------------
--  DDL for View KK01
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."KK01" ("SECS", "TRACKNAME", "TITLE", "ARTISTNAME") AS 
  select milliseconds / 1000 as secs, track.name as trackname, album.title, artist.name as artistname from track 
join album on album.ALBUMID = track.ALBUMID
join artist on album.ARTISTID = artist.ARTISTID
where milliseconds = (select max(milliseconds) from track);
--------------------------------------------------------
--  DDL for View KK02
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."KK02" ("TRACKID", "TRACKNAME", "GENRENAME") AS 
  select track.trackid, track.name as trackname, genre.name as genrename from track 
join genre on genre.genreid = track.genreid
where track.name like 'K%' order by track.name;
--------------------------------------------------------
--  DDL for View LS01
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."LS01" ("TRACKID", "TRACKNAME", "ALBUMTITLE", "ARTISTNAME") AS 
  select track.trackid, track.name as trackname, album.title as albumtitle, artist.name as artistname from playlisttrack

  join track on track.trackid = playlisttrack.trackid 
  join album on track.albumid = album.albumid 
  join artist on artist.artistid = album.artistid;
--------------------------------------------------------
--  DDL for View LS02
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."LS02" ("GENREID", "TIMES", "NAME") AS 
  select "GENREID","TIMES","NAME" from LS02P where times = (select max(times) from ls02p);
--------------------------------------------------------
--  DDL for View LS02P
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."LS02P" ("GENREID", "TIMES", "NAME") AS 
  select track.genreid, count(*) as times, genre.NAME from playlisttrack
  join track on track.trackid = playlisttrack.trackid 
  join genre on track.genreid = genre.genreid
  group by track.genreid, genre.name;
--------------------------------------------------------
--  DDL for View MH01
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."MH01" ("CUSTOMERID", "FIRSTNAME", "LASTNAME", "COMPANY", "ADDRESS", "CITY", "STATE", "COUNTRY", "POSTALCODE", "PHONE", "FAX", "EMAIL", "SUPPORTREPID") AS 
  select "CUSTOMERID","FIRSTNAME","LASTNAME","COMPANY","ADDRESS","CITY","STATE","COUNTRY","POSTALCODE","PHONE","FAX","EMAIL","SUPPORTREPID" from customer where state = 'NY';
--------------------------------------------------------
--  DDL for View MH02
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."MH02" ("INVOICEID", "BILLINGADDRESS", "BILLINGCITY", "BILLINGSTATE", "BILLINGCOUNTRY", "BILLINGPOSTALCODE") AS 
  select invoiceline.invoiceid, invoice.BILLINGADDRESS, invoice.BILLINGCITY, invoice.BILLINGSTATE, invoice.BILLINGCOUNTRY, invoice.BILLINGPOSTALCODE from invoiceline
join invoice on invoice.INVOICEID = invoiceline.INVOICEID

where invoiceline.TRACKID in 
(select track.trackid from track 
  join album on album.albumid = track.albumid
  where album.ARTISTID = (SELect artistid from artist where name = 'Marvin Gaye')
  );
--------------------------------------------------------
--  DDL for View SB01
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."SB01" ("TITLE", "NAME") AS 
  select album.title, track.name
from album 
join track on album.albumid = track.albumid
order by album.title ASC, track.name ASC;
--------------------------------------------------------
--  DDL for View SB02
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."SB02" ("ALBUMID", "TITLE", "ARTISTID") AS 
  select album."ALBUMID",album."TITLE",album."ARTISTID" from album 
where album.ALBUMID in (select SB02P.ALBUMID from SB02P where SB02P.CNT = (Select max(SB02P.CNT) FROM SB02P));
--------------------------------------------------------
--  DDL for View SB02P
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."SB02P" ("ALBUMID", "CNT") AS 
  select track.ALBUMID, count(*) as cnt from track group by track.ALBUMID;
--------------------------------------------------------
--  DDL for View TB00
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."TB00" ("SKLADBYNAA", "SKLADBYAEROSMITH") AS 
  select 
(select count(*) as skladbynaa from track where name like 'A%') as skladbynaa, 
(select count(*) as skladbyaerosmith from track where ALBUMID in (select albumid from artist where name like '%Aerosmith%') ) as skladbyaerosmith 
from dual;
--------------------------------------------------------
--  DDL for View TB11
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."TB11" ("METAL") AS 
  select count(*) as metal from track where track.genreid = (Select genreid from genre where name = 'Metal');
--------------------------------------------------------
--  DDL for View TB12
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."TB12" ("TRACKID", "NAME", "ALBUMID", "MEDIATYPEID", "GENREID", "COMPOSER", "MILLISECONDS", "BYTES", "UNITPRICE") AS 
  Select "TRACKID","NAME","ALBUMID","MEDIATYPEID","GENREID","COMPOSER","MILLISECONDS","BYTES","UNITPRICE" from track where track.BYTES =(select max(track.bytes) from track);
--------------------------------------------------------
--  DDL for View TP01
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."TP01" ("NAME", "GENRECNT") AS 
  select genre.name, count(*) as genrecnt from genre 
join track on track.genreid = genre.genreid
group by genre.name order by genre.name;
--------------------------------------------------------
--  DDL for View TP02
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."TP02" ("TRACKNAME", "ALBUMTITLE", "ARTISTNAME", "GENRENAME", "SECS") AS 
  select track.name as trackname, album.title as albumtitle, artist.name as artistname, genre.name as genrename, track.MILLISECONDS / 1000 as secs from track
join album on track.albumid = album.albumid 
join artist on artist.artistid = album.artistid
join genre on track.genreid = genre.genreid
where track.MILLISECONDS < 120000;
--------------------------------------------------------
--  DDL for View TS01
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."TS01" ("NAME", "CNT") AS 
  select playlist.name, count(playlist.name) as cnt
from playlist  
join playlisttrack on playlist.playlistid = playlisttrack.playlistid
where playlisttrack.TRACKID in (select trackid 
from track 
where albumid in (select albumid from album where artistid = (select artistid from artist where name like 'Incognito%')))
group by playlist.name;
--------------------------------------------------------
--  DDL for View TS02
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CHINOOK"."TS02" ("ARTISTNAME", "ALBUMTITLE") AS 
  select artist.name as artistname, album.title as albumtitle from artist 
join album on album.artistid = artist.artistid
where artist.name like '%ie%'
order by artist.name ASC, album.title ASC;

