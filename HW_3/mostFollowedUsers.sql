-- Author: Samuel Rettig
-- NetID: sgrettig

use practice;

drop procedure if exists mostFollowedUsers;

delimiter // 

create procedure mostFollowedUsers(in k int, in party_name varchar(100))
begin

select screen_name, subcategory, numFollowers
from practice.users
where party_name = subcategory
order by numFollowers desc
limit k;

end

//

delimiter ;

call mostFollowedUsers(5,'GOP');

