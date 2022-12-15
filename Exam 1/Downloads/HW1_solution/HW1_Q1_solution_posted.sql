use hw1_q1;

-- teaching staff coms 363 F2022
-- terms of use: for students of coms 363 Fall 2022.
-- the content of this file is not to be shared to anyone else without 
-- the instructor's written consent.

-- For each question, one solution is provided.
-- there are other correct ways to write the query.
-- However, when you join relations, the conditions for 
-- joining in all these questions must be on the foreign key 
-- of the referencing table and the primary key of 
-- the referenced table. Otherwise, the semantic of the query 
-- is incorrect.

-- Unless the question asks to order rows based on attribute values,
-- DBMS may return the rows in different order than what you see in 
-- the example.

-- Queries that give the same answer for this database instance could 
-- be wrong for other instances.

-- a.
select count(*) as num_events from events;


-- b. 

SELECT vid, sched_date 
FROM events 
where location !='ISU Campus';

-- c 

select e.vid, e.sched_date, e.location  
from `events` e, participates pp, persons p 
where e.vid= pp.vid and e.sched_date=pp.sched_date and pp.pid=p.pid and p.pname='Pak';

-- d 

select e.*
from participates pp, events e, persons p
where pp.pid=p.pid and pp.vid=e.vid and e.sched_date = pp.sched_date 
and (p.pname="Pak" or p.pname="John") 
order by e.sched_date desc;

-- e 
-- you can also use exists or in, but the query looks different 
-- than what is given here. See CP-WK2 for an example of using 
-- the in and exists operators instead of a join.

select pp1.vid
from participates pp1, participates pp2, participates pp3,
persons p1, persons p2, persons p3
where p1.pname='Mary' and p1.pid=pp1.pid
and p2.pname='Jane' and p2.pid = pp2.pid
and p3.pname = 'John' and p3.pid = pp3.pid 
and pp1.vid = pp2.vid and pp2.vid = pp3.vid;

-- f

select p.pname
from participates pp right join persons p on p.pid=pp.pid 
where pp.pid is null 
order by p.pid desc;


-- g 

select p.pid, p.pname
from participates pp, persons p
where pp.pid=p.pid 
group by p.pid, p.pname
having count(distinct pp.vid, pp.sched_date) >= 2;

-- h 

select v.venue_id, v.name
from venues v
where not exists 
(select *
from events e
where e.vid=v.venue_id);

-- i

select v.venue_id, v.name
from venues v
where  v.venue_id not in 
(select e.vid
from events e);
