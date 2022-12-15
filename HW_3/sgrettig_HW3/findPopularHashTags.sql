-- Author: Samuel Rettig
-- NetID: sgrettig

use practice;

drop procedure if exists findPopularHashTags;

delimiter // 
-- fix later
create procedure findPopularHashTags(in k int, in year_num int)
begin

select COUNT(distinct u.state, h.name) as statenum, group_concat(distinct u.state) as state, h.name
from practice.hashtags h
inner join practice.users u on u.state != 'na' 
inner join practice.tweets t on t.post_year = year_num and h.tid = t.tid and u.screen_name = t.posting_user
group by h.name
order by COUNT(distinct u.state, h.name) desc
limit k;

end

//

delimiter ;

call findPopularHashTags(5, 2016)

