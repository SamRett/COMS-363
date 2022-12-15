// Create the Twitter database
// 1. Create the constraints make the importing of the data much faster.
//    Neo4j automatically creates label indexes for these constraints.
//    Without these indexes, Pak was not able to load the database using this method.
//    Unlike load data infile for MySQL, the load csv command in Neo4j is not a bulk loading method.
// 2. Be sure to put the csv file in the import folder for the database you are creating.

// remove all nodes and edges
MATCH (n) OPTIONAL MATCH (n)-[r]-()
DELETE n, r;

// remove Tweet node label
MATCH (n:Tweet)
REMOVE n:Tweet;

// remove User node label
MATCH (n:User)
REMOVE n:User;

// remove Hashtag node label
MATCH (n:Hashtag)
REMOVE n:Hashtag;

// remove URL node label
MATCH (n:Url)
REMOVE n:Url;

drop constraint tidIdx if exists;
drop constraint tidExists if exists;

// Unlike in relational DBMS, unique in Neo4j allows for multiple null values 

create constraint tidIdx FOR (t:Tweet) REQUIRE t.id IS UNIQUE;

// depreciated
//create constraint tidExists on (t:Tweet) ASSERT exists(t.id);
// Version Neo4j database server 4.4.3
create constraint tidExists for (t:Tweet) require t.id is not null;

LOAD CSV WITH HEADERS FROM 'file:///tweets_notext-new.csv' AS line FIELDTERMINATOR ';'
CREATE (:Tweet {id:line.tid, post_day:toInteger(line.post_day), post_month:toInteger(line.post_month), post_year:toInteger(line.post_year), retweet_count:toInteger(line.retweetCt), created_at: line.posted});

// load users

drop constraint userIdx if exists;
drop constraint userExists if exists;

// create the constraints; indexes are created when these constraints are defined.

create constraint userIdx for (u:User) REQUIRE u.screen_name IS UNIQUE;
create constraint userExists for (u:User) require u.screen_name is not null;

// load the data. Notice the function, toInteger, to make sure that the number of followers are 
// integer.

LOAD CSV WITH HEADERS FROM 'file:///user.csv' AS line FIELDTERMINATOR ';'
CREATE (:User {screen_name:line.screen_name, name: line.name, sub_category:line.sub_category, category: line.category, location:line.ofstate, followers: toInteger(line.numFollowers), following: toInteger(line.numFollowing)});

// create edges from nodes of the label User to nodes of the label Tweet.
// if not creating the index, it will be really slow. The statement may not get done.


// :auto using periodic commit 200 // previous version

LOAD CSV WITH HEADERS FROM "file:///tweets_notext-new.csv" AS line FIELDTERMINATOR ';'
MATCH (t:Tweet{id:line.tid})
MERGE (u:User{screen_name:line.posting_user})
CREATE (u)-[:POSTED]->(t);

drop constraint hUnique if exists;
drop constraint hExists if exists;

create constraint hUnique for (h:Hashtag) REQUIRE h.name IS UNIQUE;
create constraint hExists for (h:Hashtag)require h.name is not null;

// notice that we use match for tweet, but merge for hashtag nodes, which creates 
// a Hashtag node if it does not exist or use the existing Hashtag node to 
// create an edge. Notice the use of toUpper(). 
// On Twitter, Hashtag names are not case sensitive. But Neo4j string values are 
// case sensitive. Therefore, we make the Hahstag names as case insensitive here.


// :auto using periodic commit 200
LOAD CSV WITH HEADERS FROM "file:///tagged.csv" AS line FIELDTERMINATOR ';'
MATCH (t:Tweet{id:line.tid})
MERGE (h:Hashtag{name:toUpper(line.hastagname)})
CREATE (h)-[:TAGGED]->(t);

drop constraint urlUnique if exists;
drop constraint urlExists if exists;

create constraint urlUnique for (url:Url) require url.url IS UNIQUE;
create constraint urlExists for (url:Url) require url.url is not null;

// load url used
// note that toLower() is used to ensure that the count of distinct url is same as in relational DBMS

// :auto using periodic commit 200
LOAD CSV WITH HEADERS FROM "file:///urlused.csv" AS line FIELDTERMINATOR ';'
MATCH (t:Tweet{id:line.tid})
MERGE (l:Url{url:toLower(line.url)})
CREATE (l)-[:URL_USED]->(t);

// :auto using periodic commit 200
LOAD CSV WITH HEADERS FROM "file:///mentioned.csv" AS line FIELDTERMINATOR ';'
MATCH (t:Tweet{id:line.tid})
MERGE (u:User{screen_name:line.screen_name})
CREATE (t)-[:MENTIONED]->(u);

// Make sure that state names are written in the same way
match (u:User) where u.location='SD' set u.location='South Dakota';
match (u:User) where u.location='AZ' set u.location='Arizona';
match (u:User) where u.location='IL' set u.location='Illinois';
match (u:User) where u.location='IA' set u.location='Iowa';
match (u:User) where u.location='WI' set u.location='Wisconsin';
match (u:User) where u.location='FL' set u.location='Florida';
match (u:User) where u.location='NE' set u.location='Nebraska';
