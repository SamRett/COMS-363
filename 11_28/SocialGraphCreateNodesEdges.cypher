// social graph
// Add nodes with name and born attributes for 20 people.
// Select the first line with CREATE statement, copy and paste them to Neo4j query window.
// Run the query
// In this file, you can select one line or multiple lines at once, it does not matter.
CREATE (:Person {name:'Keanu Reeves', born:1984})
CREATE (:Person {name:'Carrie-Anne Moss', born:1987})
CREATE (:Person {name:'Laurence Fishburne', born:1981})
CREATE (:Person {name:'Hugo Weaving', born:1980})
CREATE (:Person {name:'Andy Wachowski', born:1987})
CREATE (:Person {name:'Lana Wachowski', born:1985})
CREATE (:Person {name:'Joel Silver', born:1982})
CREATE (:Person {name:'James', born:1982})
CREATE (:Person {name:'Liam', born:1982})
CREATE (:Person {name:'Sam Reeves', born:1984})
CREATE (:Person {name:'Joe Moss', born:1987})
CREATE (:Person {name:'Nick Fishburne', born:1981})
CREATE (:Person {name:'Jackie Weaving', born:1980})
CREATE (:Person {name:'Rachel Wachowski', born:1987})
CREATE (:Person {name:'Gabi Wachowski', born:1985})
CREATE (:Person {name:'Julie Silver', born:1982})
CREATE (:Person {name:'Kate Reeves', born:1984})
CREATE (:Person {name:'Darek Moss', born:1987})
CREATE (:Person {name:'Randy Fishburne', born:1981})
CREATE (:Person {name:'Jasmine Weaving', born:1980});

// Add nodes for the locations.
//USE socialgraphs 
CREATE (:Location {state:'Iowa'})
CREATE (:Location {state:'California'})
CREATE (:Location {state:'Florida'})
CREATE (:Location {state:'New York'});

// Add nodes for the games of interest.
CREATE (:Interest {game:'Football'})
CREATE (:Interest {game:'Cricket'})
CREATE (:Interest {game:'Tennis'})
CREATE (:Interest {game:'Golf'})
CREATE (:Interest {game:'Soccer'});

MATCH (James:Person{name:'James'})
MATCH (Liam: Person{name:'Liam'})
MATCH (LanaW: Person{name: 'Lana Wachowski'})
MATCH (JoelS: Person{name:'Joel Silver'})
MATCH (Randy: Person{name:'Randy Fishburne'})
MATCH (Jasmine: Person{name: 'Jasmine Weaving'})
MATCH (AndyW: Person{name: 'Andy Wachowski'})
MATCH (Darek: Person{name: 'Darek Moss'})
MATCH (Kate: Person{name: 'Kate Reeves'})
MATCH (Gabi: Person{name: 'Gabi Wachowski'})
MATCH (Laurence: Person{name: 'Laurence Fishburne'})
MATCH (Nick:Person {name:'Nick Fishburne'})
MATCH (Sam: Person{name: 'Sam Reeves'})
MATCH (Julie: Person{name: 'Julie Silver'})
MATCH (Rachel: Person{name: 'Rachel Wachowski'})
MATCH (Carrie: Person{name: 'Carrie-Anne Moss'})
MATCH (Hugo: Person{name: 'Hugo Weaving'})
MATCH (Darek:Person {name:'Darek Moss'})
MATCH (Jackie:Person {name:'Jackie Weaving'})
MATCH (Iowa:Location {state:'Iowa'})
MATCH (California:Location {state:'California'})
MATCH (Florida:Location {state:'Florida'})
MATCH (NY:Location {state:'New York'})
MATCH (Football:Interest {game:'Football'})
MATCH (Cricket:Interest {game:'Cricket'})
MATCH (Tennis:Interest {game:'Tennis'})
MATCH (Golf:Interest {game:'Golf'})
MATCH (Soccer:Interest {game:'Soccer'})
CREATE
  (James)-[:FRIENDSHIP {since:['2014']}]->(Liam),
  (James)-[:FRIENDSHIP {since:['2003']}]->(Hugo),
  (James)-[:FRIENDSHIP {since:['2001']}]->(AndyW),
  (Liam)-[:FRIENDSHIP {since:['2001']}]->(LanaW),
  (Liam)-[:FRIENDSHIP {since:['2013']}]->(AndyW),
  (LanaW)-[:FRIENDSHIP {since:['2015']}]->(James),
  (JoelS)-[:FRIENDSHIP {since:['2011']}]->(James),
  (James)-[:FRIENDSHIP {since:['2012']}]->(Jasmine),
  (James)-[:FRIENDSHIP {since:['2010']}]->(Randy),
  (Randy)-[:FRIENDSHIP {since:['2005']}]->(AndyW),
  (Jasmine)-[:FRIENDSHIP {since:['2010']}]->(LanaW),
  (Liam)-[:FRIENDSHIP {since:['2011']}]->(Carrie),
  (AndyW)-[:FRIENDSHIP {since:['2012']}]->(Darek),
  (Darek)-[:FRIENDSHIP {since:['2013']}]->(Kate),
  (Gabi)-[:FRIENDSHIP {since:['2011']}]->(Hugo),
  (Gabi)-[:FRIENDSHIP {since:['2006']}]->(AndyW),
  (Liam)-[:FRIENDSHIP {since:['2002']}]->(Randy),
  (Liam)-[:FRIENDSHIP {since:['2003']}]->(Rachel),
  (LanaW)-[:FRIENDSHIP {since:['2001']}]->(Sam),
  (James)-[:FRIENDSHIP {since:['2005']}]->(Sam),
  (Laurence)-[:FRIENDSHIP {since:['2006']}]->(Julie)
CREATE 
(Liam)-[:POSTED {message: 'Happy Birthday'}]->(James),
(JoelS)-[:POSTED {message: 'Happy New Year!'}]->(Rachel),
(James)-[:POSTED {message: 'I am working'}]->(Randy),
(Randy)-[:POSTED {message: 'When are you free?'}]->(Sam),
(Sam)-[:POSTED {message: 'I have exam tomorrow'}]->(Darek),
(Darek)-[:POSTED {message: 'Happy Birthday'}]->(Liam),
(Gabi)-[:POSTED {message: 'Can I call you later?'}]->(Laurence),
(Laurence)-[:POSTED {message: 'When are you returning?'}]->(Gabi),
(Hugo)-[:POSTED {message: 'I am going for dinner'}]->(JoelS),
(Jackie)-[:POSTED {message: 'Bye!'}]->(Liam),
(Nick)-[:POSTED {message: 'How are you?'}]->(Sam),
(Carrie)-[:POSTED {message: 'see you later!'}]->(Nick),
(Sam)-[:POSTED {message: 'Happy Birthday'}]->(Liam),
(James)-[:POSTED {message: 'Happy Birthday'}]->(Liam),
(Rachel)-[:POSTED {message: 'Happy Birthday'}]->(Liam)
CREATE 
(Liam)-[:PLAYS]->(Soccer),
(JoelS)-[:PLAYS]->(Tennis),
(James)-[:PLAYS]->(Cricket),
(Randy)-[:PLAYS]->(Golf),
(Sam)-[:PLAYS]->(Soccer),
(Julie)-[:PLAYS]->(Soccer)
CREATE 
(Liam)-[:LIVES]->(Iowa),
(JoelS)-[:LIVES]->(Iowa),
(James)-[:LIVES]->(NY),
(Randy)-[:LIVES]->(Iowa),
(Sam)-[:LIVES]->(Iowa),
(Darek)-[:LIVES]->(NY),
(Gabi)-[:LIVES]->(Florida),
(Laurence)-[:LIVES]->(California);

create index PersonIdx for (p:Person) on (p.name); 