DROP TABLE if exists MusicVideo;

--Query1
CREATE TABLE MusicVideo (
    TrackID INTEGER PRIMARY KEY,
    VideoDirector TEXT NOT NULL,
    FOREIGN KEY (TrackID) REFERENCES tracks(TrackID)
);

--Query2
INSERT INTO MusicVideo (TrackID, VideoDirector) VALUES (1, 'Joe Biden');
INSERT INTO MusicVideo (TrackID, VideoDirector) VALUES (2, 'Barack Obama');
INSERT INTO MusicVideo (TrackID, VideoDirector) VALUES (3, 'JFK');
INSERT INTO MusicVideo (TrackID, VideoDirector) VALUES (4, 'Lincoln');
INSERT INTO MusicVideo (TrackID, VideoDirector) VALUES (5, 'Big Washington');
INSERT INTO MusicVideo (TrackID, VideoDirector) VALUES (6, 'Charles De Gaulle');
INSERT INTO MusicVideo (TrackID, VideoDirector) VALUES (7, 'Bush Sr');
INSERT INTO MusicVideo (TrackID, VideoDirector) VALUES (8, 'Bush Jr');
INSERT INTO MusicVideo (TrackID, VideoDirector) VALUES (9, 'Teddy');
INSERT INTO MusicVideo (TrackID, VideoDirector) VALUES (10, 'BAH');

--Query3
INSERT INTO MusicVideo (TrackID, VideoDirector)
SELECT TrackID, 'Joe Biden'
FROM tracks
WHERE Name = 'Voodoo'
LIMIT 1;

--Query4
SELECT Name
FROM tracks
WHERE Name LIKE '%á%'
   OR Name LIKE '%é%'
   OR Name LIKE '%í%'
   OR Name LIKE '%ó%'
   OR Name LIKE '%ú%';

--Query5
SELECT tracks.Name AS TrackName,
       albums.Title AS AlbumTitle,
       artists.Name AS ArtistName
FROM tracks
JOIN albums ON tracks.AlbumID = albums.AlbumID
JOIN artists ON albums.ArtistID = artists.ArtistID;

--Query6
SELECT genres.Name AS GenreName,
       COUNT(tracks.TrackID) AS NumberOfTracks
FROM tracks
JOIN genres ON tracks.GenreId = genres.GenreId
GROUP BY genres.Name
ORDER BY NumberOfTracks DESC;

-- Query 7:
SELECT DISTINCT c.CustomerId, c.FirstName, c.LastName
FROM customers c
JOIN invoices i ON c.CustomerId = i.CustomerId
JOIN invoice_items ii ON i.InvoiceId = ii.InvoiceId
JOIN tracks t ON ii.TrackId = t.TrackId
WHERE t.Milliseconds > (
    SELECT AVG(Milliseconds)
    FROM tracks
    WHERE Milliseconds <= 900000
)
AND t.Milliseconds <= 900000;

-- Query 8:
SELECT t.TrackId, t.Name, g.Name AS GenreName
FROM tracks t
JOIN genres g ON t.GenreId = g.GenreId
WHERE t.GenreId NOT IN (
    SELECT GenreId
    FROM tracks
    GROUP BY GenreId
    ORDER BY SUM(Milliseconds) DESC
    LIMIT 5
);

