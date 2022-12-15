drop procedure if exists deleteUser;
-- change the default statement delimiter from ; to //
delimiter //
create procedure deleteUser(in scrname varchar(80), out errorcode integer)
/*
   Author: Teaching staff coms363
   Delete the rows referencing the user's screen name before deleting the user from the users relation
*/
begin
    declare mycount integer;
    set errorcode = -1;
    
	-- check whether the user exists
	select count(*) into mycount
    from practice.users
    where screen_name=scrname;
    
	if mycount = 1 then 
	begin
    
		-- begin deleting rows referencing this user
		-- delete the row(s) where the scrname-to-be-deleted is mentioned
		DELETE m FROM practice.mentions m WHERE m.mentioned_user_scr = scrname;
			
		-- delete the row(s) in the urls table of tweets posted by the to-be-deleted scrname
			
		DELETE ur FROM practice.urls ur INNER JOIN practice.tweets t on t.tid=ur.tid where t.posting_user=scrname;
			
		-- delete the row(s) in the hashtags table of tweets posted by the to-be-deleted scrname
			
		DELETE  h from practice.hashtags h inner join practice.tweets t on h.tid=t.tid where t.posting_user=scrname;
			
		-- delete the row(s) in the mentioned table of tweets posted by the to-be-deleted scrname
		DELETE mur FROM practice.mentions mur INNER JOIN practice.tweets t ON mur.tid = t.tid where t.posting_user = scrname; 

		-- delete the rows of the tweets posted by this to-be-deleted scrname
		DELETE t from practice.tweets t INNER JOIN practice.users u ON t.posting_user = u.screen_name where u.screen_name = scrname;
		
		-- delete the user from the users table
		DELETE u FROM practice.users u WHERE u.screen_name = scrname;
			
		select count(*) into mycount
        from practice.users
		where screen_name=scrname;
            
        -- success
		if mycount = 0 then 
			set errorcode = 0;
		else 
			-- fail to delete
			set errorcode = 1;
		end if;
	end;
    end if;

end; //
-- change the default delimiter back
delimiter ;