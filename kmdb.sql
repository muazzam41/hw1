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

-- Create new tables, according to your domain model
CREATE TABLE Movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_name TEXT,
    year_released INTEGER,
    MPAA_rating TEXT,
    studio TEXT
);

CREATE TABLE Performers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    performer_name TEXT
);

CREATE TABLE characters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    character_name TEXT,
    movie_id INTEGER,
    performers_id INTEGER
);

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
INSERT INTO Movies (movie_name,
 year_released,
  MPAA_rating,
  studio
  ) VALUES ("Batman Begins", 2005, "PG-13", "Warner Bros.");
  -- 1
INSERT INTO Movies (movie_name,
 year_released,
  MPAA_rating,
  studio
  ) VALUES ("The Dark Knight", 2008, "PG-13", "Warner Bros.");
  -- 2
INSERT INTO Movies (movie_name,
 year_released,
  MPAA_rating,
  studio
  ) VALUES ("The Dark Knight Rises", 2012, "PG-13", "Warner Bros.");
  -- 3
  -- Done with Movies additions

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

INSERT INTO characters (character_name, movie_id, performers_id) 
VALUES ("Bruce Wayne", 1, 1),
("Bruce Wayne", 2, 1),
("Bruce Wayne", 3, 1),
("Alfred", 1, 2),
("Alfred", 2, 2),
("Ra's Al Ghul", 1, 3),
("Rachel Dawes", 1, 4),
("Rachel Dawes", 2, 8),
("Comissioner Gordon", 1, 5),
("Comissioner Gordon", 3, 5),
("Heath Ledger", 2, 6),
("Harvey Dent", 2, 7),
("Bane", 3, 9),
("John Blake", 3, 10),
("Selina Kyle", 3, 11);

-- Prints a header for the movies output
.print "Movies"
.print ""
.print ""

-- The SQL statement for the movies output
-- TODO!

-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""


-- The SQL statement for the cast output
-- TODO!
