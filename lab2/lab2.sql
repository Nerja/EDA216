-- disable foreigin key check
PRAGMA foreign_keys = OFF;

-- drop the tables if the exists
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Reservations;
DROP TABLE IF EXISTS Performances;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Theaters;

-- enable foreigin key check
PRAGMA foreign_keys = OFF;

CREATE TABLE Users (
	username	VARCHAR(32),
	name		VARCHAR(32) NOT NULL,
	address		VARCHAR(32),
	telephone	VARCHAR(32) NOT NULL,
	PRIMARY KEY	(username)
);

CREATE TABLE Reservations (
	nbr		INT,
	username	VARCHAR(32),
	movie_name	VARCHAR(32),
	date		DATE NOT NULL,
	theater_name	VARCHAR(32),
	PRIMARY KEY 	(nbr),
	FOREIGN KEY 	(username) REFERENCES Users(username),
	FOREIGN KEY 	(movie_name) REFERENCES Movies(name),
	FOREIGN KEY 	(theater_name) REFERENCES Theaters(name),
	FOREIGN KEY	(movie_name, date) REFERENCES Performances(movie_name, date)
);

CREATE TABLE Performances ( 
	movie_name	VARCHAR(32),
	date		DATE NOT NULL,
	free_seat	INT check (free_seat >= 0),
	theater_name	VARCHAR(32),
	PRIMARY KEY	(movie_name, date),
	FOREIGN KEY	(movie_name) REFERENCES Movies(name),
	FOREIGN KEY	(theater_name) REFERENCES Theaters(name)
);

CREATE TABLE Movies (
	name		VARCHAR(32),
	PRIMARY KEY	(name)
);

CREATE TABLE Theaters (
	name		VARCHAR(32),
	seats		INT,
	PRIMARY KEY	(name)
);

-- Add some users
INSERT INTO Users(username, name, address, telephone) VALUES ('dat13mro', 'Marcus Rodan', 'Tappers väg 6', '11111111');
INSERT INTO Users(username, name, telephone) VALUES ('dat13njo', 'Niklas Jönsson', '123123123');
INSERT INTO Users(username, name, telephone) VALUES ('dat13asi', 'Aleks Hallick', '123123123');
INSERT INTO Users(username, name, telephone, telephone) VALUES ('dat13at1', 'Andy Troung', 'Malmö', '123123123');

-- Add some movies
INSERT INTO Movies(name) VALUES ('Assassins Creed');
INSERT INTO Movies(name) VALUES ('Live by night');
INSERT INTO Movies(name) VALUES ('Hundraettåringen');
INSERT INTO Movies(name) VALUES ('Best of kalle anka');

-- Add some theaters
INSERT INTO Theaters(name, seats) VALUES ('Sal 1', 123);
INSERT INTO Theaters(name, seats) VALUES ('Sal 2', 95);
INSERT INTO Theaters(name, seats) VALUES ('Sal 3', 45);

-- Add some performances
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Assassins Creed', '2017-02-17', 123, 'Sal 1'); 
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Assassins Creed', '2017-02-18', 95, 'Sal 2'); 
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Assassins Creed', '2017-02-20', 45, 'Sal 3'); 
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Assassins Creed', '2017-02-21', 45, 'Sal 3'); 
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Assassins Creed', '2017-02-22', 95, 'Sal 2'); 
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Assassins Creed', '2017-02-23', 123, 'Sal 1'); 

INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Live by night', '2017-02-22', 95, 'Sal 2'); 
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Live by night', '2017-02-23', 123, 'Sal 1'); 

INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Hundraettåringen', '2017-02-22', 95, 'Sal 2'); 
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Hundraettåringen', '2017-02-23', 123, 'Sal 1'); 
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Hundraettåringen', '2017-02-24', 95, 'Sal 2'); 
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Hundraettåringen', '2017-02-25', 123, 'Sal 1'); 

INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Best of kalle anka', '2017-02-22', 95, 'Sal 2'); 
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Best of kalle anka', '2017-02-24', 45, 'Sal 3');
INSERT INTO Performances(movie_name, date, free_seat, theater_name) VALUES ('Best of kalle anka', '2017-02-28', 45, 'Sal 3');
 
