use practice;
drop procedure if exists findPopularHashtags;
create procedure findPopularHashtags(in k integer, in iyear integer)
	SELECT COUNT(DISTINCT state) AS statenum, group_concat(DISTINCT state) AS states, name as hashtagname
	FROM practice.users u, practice.Tweets t, practice.hashTags th 
	WHERE t.posting_user = u.screen_name AND t.post_year = iyear AND t.tid = th.tid AND u.state != "na" and u.state !='' 
	GROUP BY th.name 
	ORDER BY statenum DESC 
	LIMIT k;

