-- Author: Samuel Rettig
-- NetID: sgrettig

use practice;

drop procedure if exists deleteUser;

delimiter //

create procedure deleteUser(in sc_name varchar(100), out errorcode int)
begin
declare screen_name_t varchar(100);
set screen_name_t = (select screen_name from practice.users where screen_name = sc_name);
-- set back to users if breaks!!!!
set errorcode = 1;
-- failed deletion by default
-- change to -1 or 0 

delete from practice.mentions 
where mentioned_user_scr = sc_name;

delete from practice.mentions
 where tid in 
 (select tid from practice.tweets where posting_user = sc_name);
 
delete from practice.hashtags
 where tid in 
 (select tid from practice.tweets where posting_user = sc_name);
 
delete from practice.urls 
where tid in 
(select tid from practice.tweets where posting_user = sc_name);

delete from practice.tweets
where posting_user = sc_name;

delete from practice.users t
where t.screen_name = sc_name;

-- if user does not exist
if screen_name_t != sc_name then
set errorcode= -1;
end if;

-- if successful
if screen_name_t = sc_name then
set errorcode= 0;
end if;

end

// 

delimiter ;

set @errorcode = -2;
call deleteUser("paka300", @errorcode);
select @errorcode;


