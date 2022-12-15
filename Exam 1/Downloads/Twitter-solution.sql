
-- 
use practice; 

-- a
select count(*) as numTweets from tweets;

-- b
select count(distinct tid) as numTweetsWithMention from mentions;

-- c
select count(distinct name) as numHashtagName from HashTags;

-- d
select distinct state  
from users
where state<>'na' and state<>''
order by state
limit 3;

-- e
select count(tid) as numTweetsByIowan
from tweets t, users u
where t.posting_user=u.screen_name and u.state='Iowa';

-- f.1 left join
select u.screen_name 
from users u left join tweets t on t.posting_user=u.screen_name
where t.posting_user is null 
order by u.screen_name
limit 3;

-- f.2 exists
select u.screen_name
from users u 
where not exists (
   select * 
   from tweets t
   where t.posting_user=u.screen_name
)
order by u.screen_name
limit 3;

-- f.3 in 
select u.screen_name
from users u 
where u.screen_name not in (
   select t.posting_user
   from tweets t
)
order by u.screen_name
limit 3;

-- g
select u.screen_name, u.state, count(t.tid) as numTweets
from users u join tweets t on t.posting_user=u.screen_name
group by u.screen_name, u.state
having numTweets >=100
order by numTweets desc
limit 3;


-- h)
select distinct m1.mentioned_user_scr
from mentions m1, users u1, tweets t1
where m1.tid = t1.tid and t1.posting_user = u1.screen_name and u1.state='Iowa'
and m1.mentioned_user_scr in (
select m2.mentioned_user_scr
from mentions m2, users u2, tweets t2
where m2.tid = t2.tid and t2.posting_user = u2.screen_name and u2.state='Minnesota');

-- option 2
select distinct m1.mentioned_user_scr
from mentions m1, users u1, tweets t1
where m1.tid = t1.tid and t1.posting_user = u1.screen_name and u1.state='Iowa'
and exists (
select *
from mentions m2, users u2, tweets t2
where m2.tid = t2.tid and t2.posting_user = u2.screen_name 
and u2.state='Minnesota' and m1.mentioned_user_scr=m2.mentioned_user_scr);

-- option 3
select distinct m1.mentioned_user_scr
from mentions m1, users u1, tweets t1, mentions m2, users u2, tweets t2
where m1.tid = t1.tid and t1.posting_user = u1.screen_name and u1.state='Iowa'
and m2.tid = t2.tid and t2.posting_user = u2.screen_name 
and u2.state='Minnesota' and m1.mentioned_user_scr=m2.mentioned_user_scr;
