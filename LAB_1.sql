--Part – A 
--1. Retrieve a unique genre of songs. 
SELECT DISTINCT Genre
FROM Songs;

--2. Find top 2 albums released before 2010. 
SELECT TOP 2 Album_title
FROM Albums
WHERE Release_year < 2010


--3. Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005) 
INSERT INTO Songs (Song_id, Song_title, Duration, Genre, Album_id)
VALUES (1245, 'Zaroor', 2.55, 'Feel good', 1005);

--4. Change the Genre of the song ‘Zaroor’ to ‘Happy’ 
UPDATE Songs
SET Genre = 'Happy'
WHERE Song_title = 'Zaroor';

--5. Delete an Artist ‘Ed Sheeran’ 
DELETE FROM Artists
WHERE Artist_name = 'Ed Sheeran';

--6. Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)] 
ALTER TABLE Songs
ADD Rating DECIMAL(3, 2);

--7. Retrieve songs whose title starts with 'S'. 
SELECT Song_id, Song_title
FROM Songs
WHERE Song_title LIKE 'S%';

--8. Retrieve all songs whose title contains 'Everybody'. 
SELECT Song_id, Song_title
FROM Songs
WHERE Song_title LIKE '%Everybody%';

--9. Display Artist Name in Uppercase. 
SELECT UPPER(Artist_name) AS Artist_name
FROM Artists;

--10. Find the Square Root of the Duration of a Song ‘Good Luck’ 
SELECT SQRT(Duration) AS Square_Root_Duration
FROM Songs
WHERE Song_title = 'Good Luck';

--11. Find Current Date. 
SELECT GETDATE() ;

--12. Find the number of albums for each artist. 
SELECT Artist_id, COUNT(Album_id) AS Number_of_Albums
FROM Albums
GROUP BY Artist_id;

--13. Retrieve the Album_id which has more than 5 songs in it. 
SELECT Albums.Album_id
FROM Songs inner join Albums
on Songs.Album_id=Albums.Album_id
GROUP BY Albums.Album_id
HAVING COUNT(Song_id) > 5;

--14. Retrieve all songs from the album 'Album1'. (using Subquery) 
SELECT *
FROM Songs
WHERE Album_id = (SELECT Album_id FROM Albums WHERE Album_title = 'Album1');

--15. Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery) 
SELECT Album_title
FROM Albums
WHERE Artist_id = (SELECT Artist_id FROM Artists WHERE Artist_name = 'Aparshakti Khurana');

--16. Retrieve all the song titles with its album title. 
SELECT Songs.Song_title, Albums.Album_title
FROM Songs
JOIN Albums ON Songs.Album_id = Albums.Album_id;

--17. Find all the songs which are released in 2020. 
SELECT Songs.Song_title
FROM Songs
JOIN Albums ON Songs.Album_id = Albums.Album_id
WHERE Albums.Release_year = 2020;

--18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.  
CREATE VIEW Fav_Songs AS
SELECT * FROM Songs
WHERE Song_id BETWEEN 101 AND 105;

--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view. 
UPDATE Fav_Songs
SET Song_title = 'Jannat'
WHERE Song_id = 101;

--20. Find all artists who have released an album in 2020.  
SELECT DISTINCT Artists.Artist_name
FROM Artists
JOIN Albums ON Artists.Artist_id = Albums.Artist_id
WHERE Albums.Release_year = 2020;

--21. Retrieve all songs by Shreya Ghoshal and order them by duration.  
SELECT Songs.Song_title
FROM Songs
JOIN Albums ON Songs.Album_id = Albums.Album_id
JOIN Artists ON Albums.Artist_id = Artists.Artist_id
WHERE Artists.Artist_name = 'Shreya Ghoshal'
ORDER BY Songs.Duration;

--Part – B 
--22. Retrieve all song titles by artists who have more than one album.  
SELECT Song_title
FROM Songs
WHERE Album_id IN (
    SELECT Album_id
    FROM Albums
    GROUP BY Artist_id
    HAVING COUNT(Album_id) > 1
);

--23. Retrieve all albums along with the total number of songs.  
SELECT Albums.Album_title, COUNT(Songs.Song_id) AS Total_Songs
FROM Albums
LEFT JOIN Songs ON Albums.Album_id = Songs.Album_id
GROUP BY Albums.Album_title;

--24. Retrieve all songs and release year and sort them by release year.  
SELECT Songs.Song_title, Albums.Release_year
FROM Songs
JOIN Albums ON Songs.Album_id = Albums.Album_id
ORDER BY Albums.Release_year;

--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs.
SELECT Genre, COUNT(Song_id) AS Total_Songs
FROM Songs
GROUP BY Genre
HAVING COUNT(Song_id) > 2;

--26. List all artists who have albums that contain more than 3 songs. 
SELECT DISTINCT Artists.Artist_name
FROM Artists
JOIN Albums ON Artists.Artist_id = Albums.Artist_id
JOIN Songs ON Albums.Album_id = Songs.Album_id
GROUP BY Albums.Album_id
HAVING COUNT(Songs.Song_id) > 3;

--Part – C 
--27. Retrieve albums that have been released in the same year as 'Album4' 
--28. Find the longest song in each genre 
--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title. 
--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes. 