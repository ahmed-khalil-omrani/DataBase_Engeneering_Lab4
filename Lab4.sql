---1:
create table Vol (Novol varchar2(10) primary key,
Vildep Varchar2(10),
Vilar Varchar2(10),
 Deph Number(*), Depmn Number(*), Arrivh Number(*), Arrivm Number(*));
create table Pilote (Nopilote varchar2(10) primary key, Nom varchar2(10), 
Adresse varchar2(10), salaire number(*), Commission number(*), DateEmbauche Date);

create table Appareil (Code_Type Varchar2(10)Primary key, Nbplace Number(*), Desig varchar2(10));
create table Avion (Noavion Number (*) primary key, Code_Type varchar2(10) constraint fk1_av references appareil(Code_Type) , Annéeachat Number(*)
, Nom varchar2(10), Nbhvol Number(*));
create table Affectation (Novol varchar2(10) constraint fk1_aff references Vol(novol), Date_vol Date , 
Nopilote varchar2(10) constraint fk2_aff references pilote(Nopilote) , Noavion Number(*) constraint fk3_aff references Avion(Noavion),
constraint pk_aff primary key (Novol , Date_vol)
);
---2:
insert into pilote values('NP058','figue', 'cannes',2800,3000,'15/01/06');
insert into pilote values('NP115','lavande', 'USA',4000,0,'18/09/04');
insert into appareil values('A400',250 ,'600-200');
insert into appareil values('B200',400 ,'555-111');


insert into Avion values(13,'A400',2009,'boeing',120);
insert into Avion values(345,'B200',2012,'airbus',500);
insert into Avion values(250,'A400',2013,'martin',50);

insert into Vol Values ('AV118','paris','espagne', 10 , 45,12,25);
insert into Vol Values ('AV212','Italie','portugal', 7 , 15,10,0);

insert into affectation Values ('AV118','30/08/06','NP058',13);
insert into affectation Values ('AV212','30/11/06','NP115',345);

---3:
set SERVEROutPut On;
declare 
x int;
begin 
select count(*) into x
from Pilote;
dbms_output.put_line('the number is:'||x); 

end;


/
---4:
set SERVEROutPut On;
declare 
x Number ;
d date;
begin 

select DATEEMBAUCHE,commission into d,x from Pilote
where salaire =(select max(salaire) from pilote);

DBMS_OUTPUT.PUT_LINE('The commission and the hiring date of the pilot with the greatest salary are ' || x || ', ' || TO_CHAR(d, 'DD-MON-YYYY'));
end;
/
---5:
set SERVEROutPut On;
declare 
name varchar(20);
s Number;
begin
select Nom,salaire into name,s from PILOTE
where Nopilote='NP115';
DBMS_OUTPUT.PUT_LINE('the name of pilote with no= NP115 '||name||' and his salary = '||s);
end;
---6:
Declare 
name varchar(20);
s Number;
mindate pilote.DATEEMBAUCHE%type;
begin
select MIN(DATEEMBAUCHE) into mindate from pilote;
select nom , salaire into name,s from Pilote
where mindate=DATEEMBAUCHE;
DBMS_OUTPUT.PUT_LINE('the name of pilote with '||name||' and his salary = '||s);
end;


set SERVEROutPut On;
declare 
Type Rpilote is record(nom varchar(20), salaire Number);
pr Rpilote;
begin 
select nom , salaire into pr.nom , pr.salaire from pilote
where DATEEMBAUCHE=(select Min(DATEEMBAUCHE) from pilote);
dbms_OutPut.PUT_LINE('the name of pilote with '||pr.nom||' and his salary = '||pr.salaire);
end;*/

---7:
set SERVEROutPut On;
declare 
type aviontype is Record(nb_avion number , cdtype varchar(20));
typeavion avionType;
begin 
select count(av.NoAvion) , av.code_type into typeavion.nb_avion , typeavion.cdtype 
from avion av, appareil ap
where av.code_type='A400' and av.code_type=ap.code_type
group by av.code_type;
dbms_OutPut.PUT_LINE(typeavion.nb_Avion||' '||typeavion.cdtype);
end;

---8:
declare 
codeType CONSTANT Appareil.code_type%type :='A735';
nbPlace Appareil.nbplace%type := 450;
des Appareil.DESIG%type :='737-400';
begin
insert into appareil values(codeType,nbPlace,des);
end;
---9:
declare
codeType Appareil.code_type%type;
begin
select code_type into codeType from appareil
where code_type='A735';
dbms_OutPut.PUT_LINE(codeType||' is will inserted');
end;
---10:
declare
avge Int;
begin 
select avg(NBHVOL) Into avge from AVION;
dbms_OutPut.PUT_LINE('the avarage='||avge);
end;
