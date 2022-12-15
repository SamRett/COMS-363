set autocommit=1; -- default
use suppliersparts;
select cost
from catalog
where sid=1 and pid=102;
-- add 5 to the cost and update the catalog table
update catalog
set cost = cost+5
where sid=1 and pid=102;
rollback; -- cancelation of the change
select cost
from catalog
where sid=1 and pid=102;