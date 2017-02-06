PRAGMA foreign_keys=OFF;

DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Reservations;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Listings;
DROP TABLE IF EXISTS Theaters;

PRAGMA foreign_keys=ON;

-- Create the tables.
CREATE TABLE Users (
	username		VARCHAR(32),
	name			VARCHAR(32) NOT NULL,
	address 		VARCHAR(32),
	telephone 		VARCHAR(32) NOT NULL,
	PRIMARY KEY		(username)
);

CREATE TABLE Reservations (
	res_nbr			INT,
	username		VARCHAR(32),
	movie_name		VARCHAR(32),
	date			DATE NOT NULL,
	theater_name	VARCHAR(32),
	PRIMARY KEY 	(res_nbr),
	FOREIGN KEY 	(username) REFERENCES Users(username),
	FOREIGN KEY 	(movie_name) REFERENCES Movies(name)
	FOREIGN KEY 	(theater_name) REFERENCES Theaters(name),
	FOREIGN KEY		(movie_name, date) REFERENCES Listings(movie_name, date)
);

CREATE TABLE Movies (
	name			VARCHAR(32),
	PRIMARY KEY		(name)
);

CREATE TABLE Listings (
	movie_name 		VARCHAR(32), 
	date			DATE NOT NULL,
	free_seats		INT check (free_seats >= 0),
	theater_name	VARCHAR(32),
	PRIMARY KEY		(movie_name, date),
	FOREIGN KEY 	(movie_name) REFERENCES Movies(name),
	FOREIGN KEY		(theater_name) REFERENCES Theaters(name)
);

CREATE TABLE Theaters (
	name			VARCHAR(32),
	seats			INT,
	PRIMARY KEY		(name)
);

-- Insert data into the tables.

-- Users
INSERT INTO Users(username, name, telephone) VALUES ('dat13njo', 'Niklas Jönsson', '0732619989');
INSERT INTO Users(username, name, telephone) VALUES ('dat13mro', 'Marcus Rodan', '0700000000');
-- Theaters 
INSERT INTO Theaters(name, seats) VALUES('SF Lund', 100);
INSERT INTO Theaters(name, seats) VALUES('Royal Malmö', 204);
-- Movies 
INSERT INTO Movies(name) VALUES('Hacksaw Ridge');
INSERT INTO Movies(name) VALUES('Allied');
INSERT INTO Movies(name) VALUES('Live by Night');
-- Listings
INSERT INTO Listings(movie_name, date, free_seats, theater_name) VALUES('Hacksaw Ridge', '2017-02-06', 100, 'SF Lund');
INSERT INTO Listings(movie_name, date, free_seats, theater_name) VALUES('Allied', '2017-02-07', 100, 'Royal Malmö');
INSERT INTO Listings(movie_name, date, free_seats, theater_name) VALUES('Live by Night', '2017-02-08', 100, 'SF Lund');