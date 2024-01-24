-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy.
-- - Movie data includes the movie title, year released, MPAA rating,
--   and studio.
-- - There are many studios, and each studio produces many movies, but
--   a movie belongs to a single studio.
-- - An actor can be in multiple movies.
-- - Everything you need to do in this assignment is marked with TODO!

-- User stories
--
-- - As a guest, I want to see a list of movies with the title, year released,
--   MPAA rating, and studio information.
-- - As a guest, I want to see the movies which a single studio has produced.
-- - As a guest, I want to see each movie's cast including each actor's
--   name and the name of the character they portray.
-- - As a guest, I want to see the movies which a single actor has acted in.
-- * Note: The "guest" user role represents the experience prior to logging-in
--   to an app and typically does not have a corresponding database table.


-- Deliverables
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.
-- - Insertion of "Batman" sample data into tables.
-- - Selection of data, so that something similar to the sample "report"
--   below can be achieved.

-- Rubric
--
-- 1. Domain model - 6 points
-- - Think about how the domain model needs to reflect the
--   "real world" entities and the relationships with each other. 
--   Hint #1: It's not just a single table that contains everything in the 
--   expected output. There are multiple real world entities and
--   relationships including at least one many-to-many relationship.
--   Hint #2: Do NOT name one of your models/tables “cast” or “casts”; this 
--   is a reserved word in sqlite and will break your database! Instead, 
--   think of a better word to describe this concept; i.e. the relationship 
--   between an actor and the movie in which they play a part.
-- 2. Execution of the domain model (CREATE TABLE) - 4 points
-- - Follow best practices for table and column names
-- - Use correct data column types (i.e. TEXT/INTEGER)
-- - Use of the `model_id` naming convention for foreign key columns
-- 3. Insertion of data (INSERT statements) - 4 points
-- - Insert data into all the tables you've created
-- - It actually works, i.e. proper INSERT syntax
-- 4. "The report" (SELECT statements) - 6 points
-- - Write 2 `SELECT` statements to produce something similar to the
--   sample output below - 1 for movies and 1 for cast. You will need
--   to read data from multiple tables in each `SELECT` statement.
--   Formatting does not matter.

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Warner Bros.
-- The Dark Knight        2008           PG-13  Warner Bros.
-- The Dark Knight Rises  2012           PG-13  Warner Bros.

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne D
-- Batman Begins          Michael Caine         Alfred D
-- Batman Begins          Liam Neeson           Ra's Al Ghul D
-- Batman Begins          Katie Holmes          Rachel Dawes D
-- Batman Begins          Gary Oldman           Commissioner Gordon D
-- The Dark Knight        Christian Bale        Bruce Wayne D
-- The Dark Knight        Heath Ledger          Joker D
-- The Dark Knight        Aaron Eckhart         Harvey Dent D
-- The Dark Knight        Michael Caine         Alfred D
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes D
-- The Dark Knight Rises  Christian Bale        Bruce Wayne D
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon D
-- The Dark Knight Rises  Tom Hardy             Bane D
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake D
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle D

-- Turns column mode on but headers off
.mode column
.headers off

-- Drop existing tables, so you'll start fresh each time this script is run.
DROP TABLE Movies;
DROP TABLE Performers;
DROP TABLE characters;
DROP TABLE Studios;
DROP TABLE character_movie;

-- Create new tables, according to your domain model
CREATE TABLE Movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_name TEXT,
    year_released INTEGER,
    MPAA_rating TEXT,
    studios_id INTEGER,
  FOREIGN KEY (studios_id) REFERENCES studios(id)
);

CREATE TABLE Studios (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  Studios_name TEXT
);

CREATE TABLE Performers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    performer_name TEXT
);

CREATE TABLE characters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    character_name TEXT
);

CREATE TABLE character_movie (
  Movies_id INTEGER,
  Performers_id INTEGER,
  characters_id INTEGER,
  FOREIGN KEY (Movies_id) REFERENCES Movies(id),
  FOREIGN KEY (Performers_id) REFERENCES Performers(id),
  FOREIGN KEY (characters_id) REFERENCES characters(id)
);

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
INSERT INTO Movies (movie_name, year_released, MPAA_rating, Studios_id) 
VALUES ("Batman Begins", 2005, "PG-13", 1),
 ("The Dark Knight", 2008, "PG-13", 1),
("The Dark Knight Rises", 2012, "PG-13", 1);

INSERT INTO Performers (performer_name) 
VALUES ("Christian Bale"),
("Michael Caine"),
("Liam Neeson"),
("Katie Holmes"),
("Gary Oldman"),
("Heath Ledger"),
("Aaron Eckhart"),
("Maggie Gyllenhaal"),
("Tom Hardy"),
("Joseph Gordon-Levitt"),
("Anne Hathaway");

INSERT INTO characters (character_name) 
VALUES ("Bruce Wayne"),
("Alfred"),
("Ra's Al Ghul"),
("Rachel Dawes"),
("Comissioner Gordon"),
("Heath Ledger"),
("Harvey Dent"),
("Bane"),
("John Blake"),
("Selina Kyle");

INSERT INTO Studios (Studios_name) 
VALUES ("Warner Bros.");

INSERT INTO character_movie (Movies_id, Performers_id, characters_id) VALUES
(1, 1, 1),  -- Batman Begins, Christian Bale, Bruce Wayne
(1, 2, 2),  -- Batman Begins, Michael Caine, Alfred
(1, 3, 3),  -- Batman Begins, Liam Neeson, Ra's Al Ghul
(1, 4, 4),  -- Batman Begins, Katie Holmes, Rachel Dawes
(1, 5, 5),  -- Batman Begins, Gary Oldman, Commissioner Gordon
(2, 1, 1),  -- The Dark Knight, Christian Bale, Bruce Wayne
(2, 6, 6),  -- The Dark Knight, Heath Ledger, Joker
(2, 7, 7),  -- The Dark Knight, Aaron Eckhart, Harvey Dent
(2, 2, 2),  -- The Dark Knight, Michael Caine, Alfred
(2, 8, 4),  -- The Dark Knight, Maggie Gyllenhaal, Rachel Dawes
(3, 1, 1),  -- The Dark Knight Rises, Christian Bale, Bruce Wayne
(3, 5, 5),  -- The Dark Knight Rises, Gary Oldman, Commissioner Gordon
(3, 9, 8),  -- The Dark Knight Rises, Tom Hardy, Bane
(3, 10, 9), -- The Dark Knight Rises, Joseph Gordon-Levitt, John Blake
(3, 11, 10); -- The Dark Knight Rises, Anne Hathaway, Selina Kyle

-- Prints a header for the movies output
.print "Movies"
.print ""
.print ""
 
-- The SQL statement for the movies output
SELECT Movies.movie_name, Movies.year_released, Movies.MPAA_rating, Studios.Studios_name as Studio_name
FROM Movies
INNER JOIN Studios ON Movies.Studios_id = Studios.id;


-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""


-- The SQL statement for the cast output
SELECT Movies.movie_name AS MovieTitle, Performers.performer_name AS PerformerName , characters.character_name as CharacterName
FROM character_movie
INNER JOIN Movies ON character_movie.Movies_id = Movies.id
INNER JOIN Performers ON character_movie.Performers_id = Performers.id
INNER JOIN characters ON character_movie.characters_id = characters.id;
