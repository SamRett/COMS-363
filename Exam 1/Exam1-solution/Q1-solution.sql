-- for errors out of the common errors, 
-- see individual comments in the graded paper.
-- total points for Q1: 68
-- total points for Q2: 31
-- Free point for showing up: 1

-- solution and grading rubrics and comments for q1.
use fooddb_ex;

-- 1.a (5 pts)
-- a1 2pt for count(*)
-- a2 1pt for "as numFoods"
-- a3 2pt. for the correct table

select count(*) as numFoods from food;

-- 1.b (10 pts)
-- b1: 1pt for the correct select clause (0.5 pt for each attribute)
-- b2: 3pt. for three correct tables; 1 pt for each table
-- b3: 3pt. for the correct join conditions f.fid=r.fid (1.5pt) and r.iid=i.iid or inner join
-- b4: 1pt for the condition i.iname='Chicken';
-- b5: 1pt for order by r.amount (0.5pt) and correct order (0.5 pts)
-- b6: 1 free point for writing something.

select f.*
from food f, ingredient i, recipe r
where f.fid=r.fid and r.iid=i.iid and 
i.iname='Chicken'
order by r.amount desc;

-- c. (11 points)
-- c1: 1 pt for the select f.fid, f.fname
-- c2: 1 pt for count(*) as numIngredients (0.5pt)
-- c3: 3 pts for correct tables; 1pt for each table
-- c4: 3 pts. for the correct join conditions; 1.5 for each join condition.
-- c5: 1 pt for category='Meat'
-- c6: 2 pt. for the correct use of group by two attributes f.fid, f.fname

select f.fid, f.fname, count(*) as numMeatIngredients
from recipe r, food f, ingredient i 
where r.fid = f.fid and r.iid = i.iid 
and i.category='Meat'
group by f.fid, f.fname;

-- 1.d (8 points)
-- d1: 1 pt for the correct attribute in the select clause
-- d2: 2 pts for the correct tables
-- d3: 2 pts for the correct join condition
-- d4: 1 pt. for the correct use of group by i.iname
-- d5: 2 pt. for correct having clause condition >=2

select i.iname
from ingredient i, recipe r 
where i.iid = r.iid 
group by i.iname
having count(r.iid) >=2; 

-- 1.e (10 points)
-- e1: 1 pt. for the correct attribute in the select clause
-- e3: 2 pst. for using the correct tables

-- e4: 5 pt. for correct use of left join (2 pt) where r.iid is null (3 pt)
--   or correct use of not exists (2 pt) with the correct nested sub-query where i.iid = r.iid (3 pt).
--   or correct use of not in with the correct sub-query (3pt)

-- e5: 1 pt. for the correct order by descending i.iname
-- e6: 1 free pt.
-- other queries that give correct answers to all instances of these relations are fine

select i.iname 
from ingredient i left join recipe r on i.iid=r.iid
where r.iid is null
order by i.iname desc;

-- exists
select i.iname
from ingredient i
where not exists (
   select * 
   from recipe r
   where i.iid = r.iid
)
order by i.iname desc;


-- in 
select i.iname
from ingredient i
where i.iid not in (
   select r.iid
   from recipe r
)
order by i.iname desc;


-- 1.f (6 points)
-- f1: 2pt for fid of 27
-- f2: 2pt for fname "Fried Noodle"
-- f3: 2pt for no extra rows
-- Answer: 
-- fid, fname
-- 27, Fried Noodle

-- 1.g (8 points)
-- g1: 4 pt for the correct outer query
--    g1.1: 1 pt for the select clause
--    g1.2: 2 pts for the correct tables and join conditions
--    g1.3: 1 pt for the correct condition on the iname
-- g2: 4 pt for the correct inner query with exists
--     g2.1: 2 pt for the join of two tables on the join condition
--     g2.2: 1 pt for correct condition on the iname
--     g2.3: 1 pt for the correct correlation f.fid=r2.fid
--     4pt deduction for an artificial use of the exists operator

select f.* 
from food f, recipe r, ingredient i 
where f.fid = r.fid and r.iid = i.iid and i.iname='Green Onion' 
and exists
(select * 
 from recipe r2, ingredient i2 
 where r2.iid = i2.iid and i2.iname='Chicken' and f.fid=r2.fid); 


-- 1.h (8 points)
-- h1: 4 pt for the correct outer query
--    h1.1: 1 pt for the select clause
--    h1.2: 2 pts for the correct tables and join conditions
--    h1.3: 1 pt for the correct condition on the iname
-- h2: 4 pt for the correct inner query with an in operator.
--     h2.1: 2 pt for the join of two tables on the join condition
--     h2.2: 1 pt for correct condition on the iname
--     h2.3: 1 pt for the correct correlation f.fid=r2.fid
--     h2.4: 1 pt if the select clause does not select the right attribute

select f.* 
from food f, recipe r, ingredient i 
where f.fid = r.fid and r.iid = i.iid and i.iname='Green Onion' 
and f.fid in
(select r2.fid
 from recipe r2, ingredient i2 
 where r2.iid = i2.iid and i2.iname='Chicken'); 