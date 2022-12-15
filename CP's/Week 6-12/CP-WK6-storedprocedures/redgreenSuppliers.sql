/*
Author: Samuel Rettig
*/

drop procedure if exists redgreenSuppliers;

delimiter //
create procedure redgreenSuppliers()
begin
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
end;//
delimiter ;

call redgreenSuppliers();