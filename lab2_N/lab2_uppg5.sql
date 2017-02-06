-- List all movies which are shown:
SELECT movie_name 
FROM Listings;
-- List dates when a movie is shown:
SELECT DISTINCT date 
FROM Listings;
-- List all data concerning a movie performance
SELECT *
FROM Listings;

-- And number of seats perhaps?

-- Create a reservation
INSERT INTO Reservations(username, movie_name, date, theater_name) 
VALUES('dat13kfr', 'Hacksaw Ridge', '2017-02-06', 'SF Lund');