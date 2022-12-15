-- Author: Samuel Rettig
-- NetID: sgrettig

use practice;

drop procedure if exists insertUser;

delimiter //

create procedure insertUser(in sc_name varchar(100), in us_name varchar(100), in cat varchar(100),
in s_cat varchar(100), in st varchar(100), in num_followers int, in num_following int, out succ int)
begin

declare new_user varchar(100);

-- initially 0 if unsuccesful
set succ = 0;

insert into practice.users(screen_name, user_name, category, subcategory, state, numfollowers, numfollowing)
values(sc_name, us_name, cat, s_cat, st, num_followers, num_following);

select screen_name into new_user
from practice.users
where screen_name = sc_name;

if sc_name = new_user then
set succ= 1;
end if;

end; 

//

delimiter ;

set @screen_name="paka300";
set @user_name="pak at ISU";
set @category = null;
set @subcategory = "Independent";
set @state = "Iowa";
set @numFollows=0;
set @numFollowing=0;
-- 0 means false;
set @success = 0;
call insertUser(@screen_name, @user_name, @category, @subcategory, @state, @numFollows, 
@numFollowing, @success);
select @success;