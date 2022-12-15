use fooddb_ex;
drop procedure if exists insertFood;
-- change the default statement delimiter from ; to //
delimiter //
create procedure insertFood(in foodname varchar(45), out success int)
/*
  insert the food name with one plus the highest fid value in the table fooddb_ex.food
*/
begin
	DECLARE fidToinsert INTEGER;
    DECLARE newfid INTEGER;
 
	-- not success
	set success = 0;
    
    -- find the maximum fid value + 1
    select max(fid)+1 into fidToinsert
    from fooddb_ex.food;

	-- assign this new fid value to the new food name
    insert into fooddb_ex.food values (fidToinsert, foodname);
    
    select max(fid) into newfid
    from fooddb_ex.food;
 
	-- check whether the insertion is successful
    if newfid = fidToinsert then 
       set success = 1;
    end if;
    
end;//
-- change the default delimiter back
delimiter ;

