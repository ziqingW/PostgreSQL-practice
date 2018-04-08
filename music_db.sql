CREATE TABLE artist (
id SERIAL PRIMARY KEY,
name VARCHAR);

CREATE TABLE song_writer (
id SERIAL PRIMARY KEY,
name VARCHAR);

CREATE TABLE song (
id SERIAL PRIMARY KEY,
song_writer_id INTEGER REFERENCES song_writer (id)
);

CREATE TABLE album (
id SERIAL PRIMARY KEY,
name VARCHAR,
release_date date,
leading_artist_id INTEGER REFERENCES artist (id)
);

ALTER TABLE song
ADD COLUMN name VARCHAR;

CREATE TABLE track (
id SERIAL PRIMARY KEY,
song_id INTEGER REFERENCES song (id),
album_id INTEGER REFERENCES album (id),
duration TIME
);

INSERT INTO artist VALUES (
DEFAULT, 'Michael Jackson'),
(DEFAULT, 'Jay Chou'),
(DEFAULT, 'Sarah Brightman'
);

INSERT INTO song_writer VALUES
(DEFAULT, 'Michael Jackson'),
(DEFAULT, 'Jay Chou'),
(DEFAULT, 'Sarah Brightman'
);

INSERT INTO album VALUES
(DEFAULT, 'Jay', '2000-11-07', 2),
(DEFAULT, 'Fantasy', '2001-09-01', 2),
(DEFAULT, 'The Eight Dimensions', '2002-07-19', 2),
(DEFAULT, 'Thriller', '1982-09-30', 1),
(DEFAULT, 'Bad', '1987-08-31', 1),
(DEFAULT, 'Dangerous', '1991-11-26', 1),
(DEFAULT, 'History', '1995-06-20', 1),
(DEFAULT, 'Eden', '1998-11-09', 3),
(DEFAULT, 'La Luna', '2000-04-25', 3);

INSERT INTO song VALUES
(DEFAULT, 1, 'Billie Jean'),
(DEFAULT, 1, 'Black or White'),
(DEFAULT, 1, 'Bad'),
(DEFAULT, 1, 'Thriller'),
(DEFAULT, 1, 'Earth Song'),
(DEFAULT, 1, 'Dangerous'),
(DEFAULT, 2, 'Wife'),
(DEFAULT, 2, 'Starry Mood'),
(DEFAULT, 2, 'Black Humor'),
(DEFAULT, 2, 'Istanbul'),
(DEFAULT, 2, 'Tornado'),
(DEFAULT, 3, 'In Paradisum'),
(DEFAULT, 3, 'Eden'),
(DEFAULT, 3, 'Anytime, Anywhere'),
(DEFAULT, 3, 'La Luna');

INSERT INTO track VALUES
(DEFAULT, 1, 7, '00:05:10'),
(DEFAULT, 2, 6, '00:04:23'),
(DEFAULT, 3, 9, '00:02:11'),
(DEFAULT, 4, 7, '00:03:47'),
(DEFAULT, 5, 4, '00:04:22'),
(DEFAULT, 6, 1, '00:06:23'),
(DEFAULT, 7, 6, '00:03:27'),
(DEFAULT, 8, 8, '00:05:01'),
(DEFAULT, 9, 7, '00:04:18'),
(DEFAULT, 10, 4, '00:04:34'),
(DEFAULT, 11, 1, '00:06:23'),
(DEFAULT, 12, 8, '00:05:09'),
(DEFAULT, 13, 9, '00:04:34'),
(DEFAULT, 14, 2, '00:03:13'),
(DEFAULT, 15, 5, '00:03:11');

--What are tracks for a given album?
SELECT album.name AS album_name, song.name AS song_name FROM
album
INNER JOIN
track ON album.id = track.album_id
JOIN song on track.song_id = song.id WHERE album.id=1;

--What are the albums produced by a given artist?
SELECT album.name AS album_name, artist.name AS artist_name FROM
album
INNER JOIN
artist ON leading_artist_id = artist.id WHERE artist.id=2;

-- What is the track with the longest duration?
SELECT song.name, duration FROM
track
INNER JOIN
song ON track.song_id = song.id WHERE duration=(SELECT MAX(duration) FROM track);

-- What are the albums released in the 60s? 70s? 80s? 90s?
SELECT name, release_date FROM
album WHERE release_date>= '1960-01-01' AND release_date <= '1969-12-31';
SELECT name, release_date FROM
album WHERE release_date>= '1970-01-01' AND release_date <= '1979-12-31';
SELECT name, release_date FROM
album WHERE release_date>= '1980-01-01' AND release_date <= '1989-12-31';
SELECT name, release_date FROM
album WHERE release_date>= '1990-01-01' AND release_date <= '1999-12-31';

-- How many albums did a given artist produce in the 90s?
SELECT artist.name, album.name FROM
artist
INNER JOIN
album ON artist.id=album.leading_artist_id WHERE artist.id=1 AND release_date>= '1990-01-01' AND release_date <= '1999-12-31';

-- What is each artist's latest album?
SELECT artist.name AS artist_name, album.name AS album_name, release_date FROM
artist
INNER JOIN
album ON artist.id=album.leading_artist_id WHERE release_date IN (SELECT MAX(release_date) FROM album GROUP BY leading_artist_id);

-- List all albums along with its total duration based on summing the duration of its tracks.
SELECT album.name, SUM(track.duration) AS album_total_length FROM
album
INNER JOIN
track ON album.id = track.album_id GROUP BY album.name;

-- What is the album with the longest duration?
SELECT MAX(sum_duration) AS max_duration
FROM(
SELECT SUM(duration) AS sum_duration
FROM track GROUP BY album_id) AS sum_table;

-- Who are the 5 most prolific artists based on the number of albums they have recorded?
SELECT artist.name, COUNT(album.id) AS album_num FROM
artist
INNER JOIN
album ON artist.id=album.leading_artist_id GROUP BY artist.id ORDER BY album_num DESC LIMIT 5;

-- What are all the tracks a given artist has recorded?
SELECT artist.name AS artist_name, song.name AS song_name FROM
artist
INNER JOIN
album ON artist.id=album.leading_artist_id
JOIN track
ON track.album_id=album.id
JOIN song
ON track.song_id = song.id WHERE artist.id=1;

-- What are the top 5 most often recorded songs?
SELECT song.name, COUNT(*) AS count_track FROM song
INNER JOIN
track ON song.id=track.song_id GROUP BY song.id ORDER BY count_track DESC LIMIT 5;

-- Who are the top 5 song writers whose songs have been most often recorded?
SELECT song_writer.name AS song_writer_name, COUNT(track.id) AS track_count FROM
song_writer
INNER JOIN song ON song.song_writer_id=song_writer.id
JOIN track ON track.song_id=song.id GROUP BY song_writer.id ORDER BY track_count DESC LIMIT 5;

-- Who is the most prolific song writer based on the number of songs he has written?
SELECT song_writer.name AS song_writer_name, COUNT(song.id) AS song_num FROM
song_writer
INNER JOIN song ON song.song_writer_id=song_writer.id
GROUP BY song_writer.id ORDER BY song_num DESC LIMIT 1;

-- What songs has a given artist recorded?
SELECT artist.name AS artist_name, song.name AS song_name FROM
artist
INNER JOIN album ON artist.id=album.leading_artist_id
JOIN track ON album.id=track.album_id
JOIN song ON track.song_id=song.id WHERE artist.id=3;

-- Who are the song writers whose songs a given artist has recorded?
SELECT artist.name AS artist_name, song.name AS song_name, song_writer.name AS song_writer_name FROM
artist
INNER JOIN album ON artist.id=album.leading_artist_id
JOIN track ON album.id=track.album_id
JOIN song ON track.song_id=song.id 
JOIN song_writer ON song.song_writer_id=song_writer.id WHERE artist.id=3;

-- Who are the artists who have recorded a given song writer's songs?
SELECT artist.name AS artist_name, song.name AS song_name, song_writer.name AS song_writer_name FROM
artist
INNER JOIN album ON artist.id=album.leading_artist_id
JOIN track ON album.id=track.album_id
JOIN song ON track.song_id=song.id 
JOIN song_writer ON song.song_writer_id=song_writer.id WHERE song_writer.id=1;

--BONUS 1: Given a lead artist, what collaborators has he worked with? Hint: you can give the same table 2 different aliases. For example, a query to find all people you follow would look like `select from "user" as follower, "user" as followee where ...
INSERT INTO artist VALUES
(DEFAULT, 'Joker Xue'),
(DEFAULT, 'Secret Garden'),
(DEFAULT, 'Tempetation Within'),
(DEFAULT, 'Night Wish'),
(DEFAULT, 'Adele');

ALTER TABLE album ADD COLUMN collaborators_id INTEGER [];
UPDATE album SET collaborators_id='{1,3,7,8}' WHERE album.id=1;
UPDATE album SET collaborators_id='{3,4,5,6,7}' WHERE album.id=2;
UPDATE album SET collaborators_id='{3,4,8}' WHERE album.id=3;
UPDATE album SET collaborators_id='{2,4,5,6}' WHERE album.id=4;
UPDATE album SET collaborators_id='{3,7,8}' WHERE album.id=5;
UPDATE album SET collaborators_id='{2,4}' WHERE album.id=6;
UPDATE album SET collaborators_id='{5,6,8}' WHERE album.id=7;
UPDATE album SET collaborators_id='{1,2,5}' WHERE album.id=8;
UPDATE album SET collaborators_id='{1,4,6}' WHERE album.id=9;

SELECT DISTINCT temp_table.leading_artist_name, artist.name AS collaborator_name FROM (
SELECT album.leading_artist_id, artist.name AS leading_artist_name, collaborators_id FROM
album INNER JOIN artist ON artist.id=album.leading_artist_id) AS temp_table, artist
WHERE artist.id=ANY (temp_table.collaborators_id) AND temp_table.leading_artist_id=1 ORDER BY collaborator_name;

--Super challenge: given an artist who has worked as a collaborator, who are the other collaborators he has worked with?
SELECT temp_co_collaborator.album_id, temp_co_collaborator.collaborator_name, artist.name AS other_collaborator_name FROM
(SELECT * FROM (
SELECT album.id AS album_id, collaborators_id, artist.id AS collaborator_id, artist.name AS collaborator_name FROM
album INNER JOIN artist ON artist.id=ANY(album.collaborators_id)) AS temp_table
WHERE temp_table.collaborator_id=1) AS temp_co_collaborator, artist
WHERE artist.id = ANY (temp_co_collaborator.collaborators_id) AND artist.id != temp_co_collaborator.collaborator_id;

--BONUS 2
--Get the list of tracks with a violin in it. (You can sub in your instrument of choice)
ALTER TABLE track ADD COLUMN instrument TEXT [];
UPDATE track SET instrument='{"violin", "piano"}' WHERE id BETWEEN 27 AND 30;
UPDATE track SET instrument='{"violin"}' WHERE id=16;
UPDATE track SET instrument='{"piano"}' WHERE id=19 OR id=20;
UPDATE track SET instrument='{"drum", "keyboard"}' WHERE id=22 OR id=24 OR id=18;
UPDATE track SET instrument='{"flutes"}' WHERE id=17 OR id=23;
UPDATE track SET instrument='{"gitar"}' WHERE id=21 OR id BETWEEN 25 AND 26;
UPDATE track SET instrument='{"vocal"}' WHERE id=18;
UPDATE track SET instrument='{"vocal"}' WHERE id=21;

SELECT song.name AS song_name FROM
track INNER JOIN
song ON track.song_id=song.id
WHERE 'violin'= ANY (track.instrument);

-- Get the list of tracks with both a harmonica and an accordion. (Again, sub in your instruments of choice)
SELECT song.name AS song_name FROM
track INNER JOIN
song ON track.song_id=song.id
WHERE 'violin'= ANY (track.instrument) AND 'piano'=ANY(track.instrument);

-- Get the list of vocal tracks.
SELECT song.name AS song_name FROM
track INNER JOIN
song ON track.song_id=song.id
WHERE 'vocal'= ANY (track.instrument);

-- Get the list of instrumental tracks (no vocal).
SELECT song.name AS song_name FROM
track INNER JOIN
song ON track.song_id=song.id
WHERE 'vocal' != ANY (track.instrument);

-- Get a list of piano solo tracks (piano and no other instrument).
SELECT song.name AS song_name FROM
track INNER JOIN
song ON track.song_id = song.id
WHERE 'piano'=ANY(track.instrument) AND array_length(instrument,1)=1;













