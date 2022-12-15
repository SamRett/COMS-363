-- By teaching staff ComS 363
use practice;
drop procedure if exists mostFollowedUsers;
create procedure mostFollowedUsers(in k integer, in party varchar(80))
SELECT u.screen_name, u.subcategory, u.numFollowers 
FROM practice.users u 
WHERE u.subcategory = party
ORDER BY u.numFollowers DESC 
LIMIT k; 