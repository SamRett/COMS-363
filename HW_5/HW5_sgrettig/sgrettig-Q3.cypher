//Author: Samuel Rettig
// ID: sgrettig

drop database hw5 if exists;
create database hw5;
start database hw5;
:use hw5;

//Note: this use line errors for some weird reason. I dont know. i've tried. 
//Database stuff

//match (a) -[r] -> () delete a, r
//run seperately 
//match(a) delete a

drop index suppliers1 if exists;
drop index parts1 if exists;
drop index projects1 if exists;
drop index suppliers2 if exists;
drop index parts2 if exists;
drop index projects2 if exists;
drop index suppliers3 if exists;
drop index parts3 if exists;
drop index projects3 if exists;


create (:Suppliers {Sname:'Aldi', SID:1});
create (:Parts {Pname:'Cheese', PID:2});
create (:Projects {Jname:'Pizza', JID:3});
create (:SPJ1 {Qty:300});

match (Aldi:Suppliers{Sname:'Aldi'})
match (Cheese:Parts {Pname:'Cheese'})
match (Pizza:Projects {Jname:'Pizza'})
create ((Aldi)-[:Supplies]->(:SPJ1)<-[:Part]-(Cheese)),
((Aldi)-[:Supplies]->(:SPJ1)-[:Project]->(Pizza));

create index suppliers1 for (s:Suppliers) on (s.SID); 
create index parts1 for (p:Parts) on (p.PID); 
create index projects1 for (j:Projects) on (j.JID); 

//Node 1 above

create (:Suppliers2 {Sname:'Xbox', SID:4});
create (:Parts2 {Pname:'Halo', PID:5});
create (:Projects2 {Jname:'Gamepass', JID:6});
create (:SPJ2 {Qty:35});

match (Xbox:Suppliers2{Sname:'Xbox'})
match (Halo:Parts2 {Pname:'Halo'})
match (Gamepass:Projects2 {Jname:'Gamepass'})
create ((Xbox)-[:Supplies2]->(:SPJ2)<-[:Part2]-(Halo)),
((Xbox)-[:Supplies2]->(:SPJ2)-[:Project2]->(Gamepass));

create index suppliers2 for (s:Suppliers2) on (s.SID); 
create index parts2 for (p:Parts2) on (p.PID); 
create index projects2 for (j:Projects2) on (j.JID); 

//Node 2 above

create (:Suppliers3 {Sname:'Playstation', SID:7});
create (:Parts3 {Pname:'Gumba', PID:8});
create (:Projects3 {Jname:'burning', JID:9});
create (:SPJ3 {Qty:666});

match (Playstation:Suppliers3{Sname:'Playstation'})
match (Gumba:Parts3 {Pname:'Gumba'})
match (burning:Projects3 {Jname:'burning'})
create ((Playstation)-[:Supplies3]->(:SPJ3)<-[:Part3]-(Gumba)),
((Playstation)-[:Supplies3]->(:SPJ3)-[:Project3]->(burning));

create index suppliers3 for (s:Suppliers3) on (s.SID); 
create index parts3 for (p:Parts3) on (p.PID); 
create index projects3 for (j:Projects3) on (j.JID);

//Node 3 above


