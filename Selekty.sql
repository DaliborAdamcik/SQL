select * from PREDMET;
select * from student WHERE priezvisko like 'A%';
select * from student where meno = 'Peter' and rocnik = '3';
select id_student, (priezvisko||' '||meno)as priezvisko_meno, rocnik from student;
select id_student, (substr(meno, 1,1)||'. '||priezvisko)as m_priezvisko, rocnik from student;
select zapis.*, predmet.nazov, predmet.kredity, student.meno, student.priezvisko, student.rocnik 
  from zapis join predmet on zapis.ID_PREDMET = predmet.ID_PREDMET join STUDENT on zapis.ID_STUDENT = STUDENT.ID_STUDENT;

select student.meno, student.priezvisko, predmet.nazov, zapis.ROK
  from zapis join predmet on zapis.ID_PREDMET = predmet.ID_PREDMET join STUDENT on zapis.ID_STUDENT = STUDENT.ID_STUDENT 
  where rok=2015;

select * from PREDMET where not exists(select 1 from ZAPIS where PREDMET.ID_PREDMET = ZAPIS.ID_PREDMET);

select * from STUDENT where not exists(select 1 from ZAPIS where STUDENT.ID_STUDENT = ZAPIS.ID_STUDENT);

select count(id_predmet) as predmet_cnt from PREDMET;
select count(id_student) as student_cnt from Student;
select count(rok) as zapis_cnt from zapis;

select id_predmet, nazov, (select count(rok) from zapis where zapis.id_predmet = predmet.id_predmet) as zapis_cnt from predmet;

select student.*, (select count(ZAPIS.ID_STUDENT) from ZAPIS where zapis.id_student = student.id_student) AS zapis_cnt from STUDENT ;

select predmet.*, (select count(ZAPIS.ID_PREDMET) from ZAPIS where zapis.id_predmet = predmet.id_predmet) AS zapis_cnt from predmet;

select student.* from student WHERE (SELECT count(zapis.ID_STUDENT) FROM zapis where student.ID_STUDENT = zapis.ID_STUDENT)<3;

select student.* from student WHERE (SELECT count(zapis.ID_STUDENT) FROM zapis where student.ID_STUDENT = zapis.ID_STUDENT) = (SELECT max(count(zapis.ID_STUDENT)) FROM zapis Group by zapis.ID_STUDENT);

select predmet.* from predmet where (SELECT count(zapis.ID_PREDMET) FROM zapis where predmet.ID_PREDMET = zapis.ID_PREDMET) = (SELECT max(count(zapis.ID_PREDMET)) FROM zapis Group by zapis.ID_PREDMET);

