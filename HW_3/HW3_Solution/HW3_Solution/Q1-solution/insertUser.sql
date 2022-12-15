drop procedure if exists insertUser;
-- change the default statement delimiter from ; to //
delimiter //
create procedure insertUser(in scrname varchar(80), in user_name varchar(80), in category varchar(80), in subcategory varchar(80), in state varchar(80), in numFollowers int, in numFollowing integer, out success integer)
/*
  insert the food name with one plus the highest fid value in the table fooddb_ex.food
*/
begin
    DECLARE mycount INTEGER;
	DECLARE newcount INTEGER;
	-- not success
    
	set success = 0;
    select count(*) into mycount
    from practice.users where screen_name = scrname;
    
    if mycount = 0 then
		begin
			insert into practice.users values (scrname, user_name, category, subcategory, state, numFollowers, numFollowing);
            
			select count(*) into newcount
			from practice.users where screen_name = scrname;
            
			if newcount > 0 then 
				set success = 1;
			end if;
            
        end;
    end if;
    
    
end;//
-- change the default delimiter back
delimiter ;

