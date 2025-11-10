-- Задание 2

-- Название и продолжительность самого длительного трека.

SELECT name, duration FROM track
WHERE duration = (SELECT MAX(duration) FROM track);

-- Название треков, продолжительность которых не менее 3,5 минут.

SELECT name, duration FROM track
WHERE duration >= 210;

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно.

SELECT name, year_of_release FROM collection
WHERE year_of_release BETWEEN '2018-01-01' AND '2020-12-31';

-- Исполнители, чьё имя состоит из одного слова.

SELECT name FROM artist
WHERE name NOT LIKE '% %';

-- Название треков, которые содержат слово «мой» или «my».

SELECT name FROM track
WHERE name LIKE '%my%' OR name LIKE '%My%';

-- Задание 3

-- Количество исполнителей в каждом жанре.

SELECT name, COUNT(*) FROM genre
JOIN genre_artist ON genre_artist.genre_id = genre.id
GROUP BY name;

-- Количество треков, вошедших в альбомы 2019–2020 годов.

SELECT album.name, COUNT(track.name) FROM album
JOIN track ON track.album_id = album.id
WHERE year_of_release BETWEEN '2019-01-01' AND '2020-12-31'
GROUP BY album.name;

-- Средняя продолжительность треков по каждому альбому.

SELECT album.name, AVG(duration) FROM album
JOIN track ON track.album_id = album.id
GROUP BY album.name;

-- Все исполнители, которые не выпустили альбомы в 2020 году.

SELECT artist.name FROM artist
JOIN artist_album ON artist_album.artist_id = artist.id
JOIN album ON artist_album.album_id = album.id
WHERE year_of_release NOT BETWEEN '2019-12-31' AND '2021-01-01'
GROUP BY artist.name;

-- Названия сборников, в которых присутствует исполнитель Bob Dylan.

SELECT collection.name FROM  collection
JOIN collection_track ON collection_track.collection_id = collection.id
JOIN track ON collection_track.track_id = track.id
JOIN album ON track.album_id = album.id
JOIN artist_album ON artist_album.artist_id = album.id
JOIN artist ON artist_album.artist_id = artist.id
WHERE artist.id = 3
GROUP BY collection.name;

-- Задание 4

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.

SELECT album.name, COUNT(genre_id) FROM genre_artist
JOIN artist ON genre_artist.artist_id = artist.id
JOIN artist_album ON artist.id = artist_album.artist_id
JOIN album ON artist_album.album_id = album.id
GROUP BY album.name, genre_artist.artist_id
HAVING COUNT(genre_id) > 1;

-- Наименования треков, которые не входят в сборники.

SELECT track.name, collection_track.collection_id FROM track
LEFT JOIN collection_track ON collection_track.track_id = track.id
WHERE collection_track.collection_id IS NULL;

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек.

SELECT artist.name, duration FROM artist
JOIN artist_album ON artist.id = artist_album.artist_id
JOIN album ON artist_album.album_id = album.id
JOIN track ON album.id = track.album_id
WHERE duration = (SELECT MIN(duration) FROM track);

-- Названия альбомов, содержащих наименьшее количество треков.

SELECT album.name, COUNT(track.name) FROM album
JOIN track ON album.id = track.album_id
GROUP BY album.name
HAVING COUNT(track.name) = (
	SELECT MIN(count) FROM (
		SELECT album.name, COUNT(track.name) AS count FROM album
		JOIN track ON track.album_id = album.id
		GROUP BY album.name) AS foo);