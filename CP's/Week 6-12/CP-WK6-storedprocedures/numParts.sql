/*
Author: Samuel Rettig
*/

drop procedure if exists numParts;
-- change the default statement delimiter from ; to //
delimiter //
create procedure numParts()
begin
	select count(*)
	from suppliersparts.parts;

end;//
-- change the default delimiter back
delimiter ;


call numparts();
