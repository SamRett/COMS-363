-- Author: Samuel George Rettig

-- SELECT * FROM hw1_q1.events;

SELECT count(*) as num_events
 FROM hw1_q1.events;
 -- Question 1a Answer
 
SELECT vid, sched_date 
 from hw1_q1.events 
 where location != 'ISU Campus';
 -- Question 1b Answer 
 
 SELECT vid, sched_date, location
 from hw1_q1.events 
 where vid= '4';
 -- Question 1c Answer 
 
SELECT vid, sched_date, location
 from hw1_q1.events 
 where vid= '4' or vid = '6'
 order by sched_date DESC;
 -- Question 1d Answer 
 
 SELECT vid
 FROM hw1_q1.participates p
 where p.vid = '6'
 LIMIT 1;
 -- Question 1e Answer 
 -- Source for limit command:
 -- https://www.mysqltutorial.org/mysql-limit.aspx
 
SELECT p.pid, p.pname
 FROM hw1_q1.participates b
 RIGHT JOIN persons p ON b.pid = p.pid;
 -- Question 1f Answer 
 
 
 
 SELECT b.pid, b.pname
 FROM hw1_q1.persons b
 group by pid
 having 2<=(
 select count(pid)
 from hw1_q1.participates p
 where p.pid = b.pid )
 order by pid asc;
 -- Question 1g Answer 
 
 SELECT v.venue_id, v.name
 FROM hw1_q1.venues v
 where not exists
 (
 select p.vid
 from hw1_q1.participates p
 where p.vid = v.venue_id);
 -- Question 1h Answer 
 
 SELECT v.venue_id, v.name
 FROM hw1_q1.venues v
 where v.venue_id not in 
 (
 select p.vid
 from hw1_q1.participates p
 where p.vid = v.venue_id);
 -- Question 1i Answer 
 