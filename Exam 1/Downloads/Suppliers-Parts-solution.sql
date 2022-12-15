use suppliersparts;
-- a.
select count(pid) as numParts from parts;
-- or 
select count(*) as numParts from parts;
-- b.
select s.sid, s.sname, p.pid, p.pname, c.cost
from Catalog as c
inner join Parts as p on p.pid = c.pid
inner join Suppliers as s on s.sid = c.sid
order by s.sname asc limit 5;
-- c.
select distinct s.sid, s.sname, s.address 
from Suppliers as s 
inner join Catalog as c on s.sid = c.sid;

-- d.
select distinct p.pid, p.pname 
from Parts as p 
inner join Catalog as c on p.pid = c.pid 
where p.color = 'black';

-- e.
select distinct s.sid, s.sname
from Catalog as c
inner join Suppliers as s on s.sid = c.sid
inner join Parts as p on p.pid = c.pid
where p.color = 'red' and s.sid in 
	(select distinct s.sid
		from Catalog as c
		inner join Suppliers as s on s.sid = c.sid
		inner join Parts as p on p.pid = c.pid
		where p.color = 'green');
        
-- f.
select sid
from catalog  
where pid in (select pid 
 from parts where color='green') 
group by sid
having count(pid) = (
select count(*) 
from parts
where color='green') 
order by sid;

-- using the exists operator
select c.sid
from catalog c
where exists (select * 
 from parts where color='green' and c.pid=pid) 
group by sid
having count(pid) = (
select count(*) 
from parts
where color='green') 
order by sid;

-- using the INNER JOIN operator
select c.sid
from catalog c inner join parts p on c.pid=p.pid
where p.color='green'
group by c.sid
having count(c.pid) = (
	select count(*) 
	from parts
	where color='green') 
order by c.sid;