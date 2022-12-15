// Author: Samuel Rettig (sgrettig)

//A.

MATCH (t:Tweet)<-[:POSTED]-(u:User)
WHERE t.post_year = 2016 and t.post_month = 2
RETURN u.screen_name as screenname, u.sub_category as party, t.retweet_count as retweetcount
ORDER BY t.retweet_count desc
LIMIT 5;

//B.

MATCH (h:Hashtag)-[:TAGGED]->(t:Tweet)<-[:POSTED]-(u:User)
WHERE u.location = "Ohio"OR u.location = "Alaska"
RETURN DISTINCT h.name as hashtagname
ORDER BY h.name asc
LIMIT 5;

//C.

MATCH (u:User)
WHERE u.sub_category  = "democrat"
RETURN u.screen_name as screenname, u.sub_category as party, u.followers as numfollowers
ORDER BY u.followers desc
LIMIT 5;

//D.

MATCH (mention:User)<-[:MENTIONED]-(t:Tweet)<-[:POSTED]-(u:User)
WHERE u.sub_category  = "GOP" 
WITH mention, collect (u.screen_name) as listMentionUsers, collect (distinct u.screen_name) as listMentionUsers_2
RETURN mention.screen_name as mentionedUser, listMentionUsers_2
ORDER BY size(listMentionUsers) desc
LIMIT 5;

//E.


MATCH (h:Hashtag)-[t:TAGGED]->(:Tweet)<-[:POSTED]-(n:User)
where n.location <> "na" and n.location is not null
with h.name as hashtag, count (distinct n.location) as statenum, collect (distinct n.location) as statelist
RETURN hashtag,statenum, statelist
order by statenum desc
lIMIT 3
