-- 1a
select count(*) as num_foods from food;

-- 1b
select f.fid, f.fname
from food f , ingredient i, recipe r
where f.fid = r.fid and r.iid = i.iid and i.iname = 'chicken'
order by r.amount desc;

-- 1c 
select f.fid, f.fname, count(*) as numMeatIngredients
from recipe r, food f, ingredient i 
where r.fid = f.fid and r.iid = i.iid 
and i.category='Meat'
group by f.fid, f.fname;

-- 1d
select i.iname
from ingredient i, recipe r 
where i.iid = r.iid 
group by i.iname
having count(r.iid) >=2; 

-- 1e

/*
Original:

select e.iname
from ingredient e
where not exists
(select p.iid
from recipe p
where e.iid = p.iid)

*/
-- fix added was the order by. original solution was in the wrong order (e5)
select e.iname
from ingredient e
where not exists
(select p.iid
from recipe p
where e.iid = p.iid)
order by e.iname desc;

-- 1g
 -- below is original
 /*
select f.*
from food f, recipe r, ingredient i
where  exists
(select r2.*, f2.*, i2.*
from recipe r2, food f2, ingredient i2
where f.fid = r.fid and r.iid = i.iid and i.iname = 'Green Onion' and f2.fid = 5s.fid
 and r2.iid= i2.iid and i2.iname = 'chicken' and f.fid = f2.fid);
 */
 
 -- I have all of the core elements. the above version is what it was. If you feel
 -- like the changes are small enough to give back points, then it would be appreciated
 -- if I could get the points back
 -- missed the point 1.3
 select f.*
from food f, recipe r, ingredient i
where f.fid = r.fid and r.iid = i.iid and i.iname = 'Green Onion' and exists
(select r2.*, f2.*, i2.*
from recipe r2, food f2, ingredient i2
where r2.iid= i2.iid and i2.iname = 'chicken' and f.fid = f2.fid);

-- 1h
/*
original below

select f.*
from food f, recipe r, ingredients i
where f.fid in
(select r2.*, f2.*, i2.*
from recipe r2, food f2, ingredient i2
where f.fid = r.fid and r.iid = i.iid and i.iname = 'Green Onion' and f2.fid = 5s.fid
 and r2.iid= i2.iid and i2.iname = 'chicken' and f.fid = f2.fid);
 
 */
 
 
 -- in original I missed the following points: 1.3, 2.4
 select f.*
from food f, recipe r, ingredient i
where f.fid = r.fid and r.iid = i.iid and i.iname = 'Green Onion' and f.fid in
(select r2.fid
from recipe r2, food f2, ingredient i2
 where r2.iid= i2.iid and i2.iname = 'chicken' and f.fid = f2.fid);
 
