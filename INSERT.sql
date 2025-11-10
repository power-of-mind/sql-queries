-- Заполняем таблицу с жанрами

INSERT INTO genre (name)
VALUES ('Alternative');

INSERT INTO genre (name)
VALUES ('Rock');

INSERT INTO genre (name)
VALUES ('Punk');

INSERT INTO genre (name)
VALUES ('Metall');

-- Заполняем таблицу с исполнителями

INSERT INTO artist (name)
VALUES ('Stone Sour');

INSERT INTO artist (name)
VALUES ('Linkin Park');

INSERT INTO artist (name)
VALUES ('Bob Dylan');

INSERT INTO artist (name)
VALUES ('Queen');

INSERT INTO artist (name)
VALUES ('Sum 41');

INSERT INTO artist (name)
VALUES ('Blink 182');

INSERT INTO artist (name)
VALUES ('Metallica');

INSERT INTO artist (name)
VALUES ('Slipknot');

-- Заполняем промежуточную таблицу с жанрами и исполнителями

INSERT INTO genre_artist (genre_id, artist_id)
VALUES (1, 1);

INSERT INTO genre_artist (genre_id, artist_id)
VALUES (1, 2);

INSERT INTO genre_artist (genre_id, artist_id)
VALUES (2, 3);

INSERT INTO genre_artist (genre_id, artist_id)
VALUES (2, 4);

INSERT INTO genre_artist (genre_id, artist_id)
VALUES (3, 5);

INSERT INTO genre_artist (genre_id, artist_id)
VALUES (3, 6);

INSERT INTO genre_artist (genre_id, artist_id)
VALUES (4, 7);

INSERT INTO genre_artist (genre_id, artist_id)
VALUES (4, 8);

INSERT INTO genre_artist (genre_id, artist_id)
VALUES (1, 7);

INSERT INTO genre_artist (genre_id, artist_id)
VALUES (1, 8);

-- Заполняем таблицу с альбомами

INSERT INTO album (name, year_of_release)
VALUES ('Reload', '2005-03-10');

INSERT INTO album (name, year_of_release)
VALUES ('Ride The Lightning', '2010-11-02');

INSERT INTO album (name, year_of_release)
VALUES ('Master Of Puppets', '2019-06-12');

INSERT INTO album (name, year_of_release)
VALUES ('Load', '2022-09-21');

-- Заполняем промежуточную таблицу с исполнителями и альбомами

INSERT INTO artist_album (artist_id, album_id)
VALUES (1, 1);

INSERT INTO artist_album (artist_id, album_id)
VALUES (1, 2);

INSERT INTO artist_album (artist_id, album_id)
VALUES (2, 1);

INSERT INTO artist_album (artist_id, album_id)
VALUES (2, 3);

INSERT INTO artist_album (artist_id, album_id)
VALUES (3, 3);

INSERT INTO artist_album (artist_id, album_id)
VALUES (3, 4);

INSERT INTO artist_album (artist_id, album_id)
VALUES (4, 1);

INSERT INTO artist_album (artist_id, album_id)
VALUES (4, 3);

INSERT INTO artist_album (artist_id, album_id)
VALUES (5, 2);

INSERT INTO artist_album (artist_id, album_id)
VALUES (5, 4);

INSERT INTO artist_album (artist_id, album_id)
VALUES (6, 3);

INSERT INTO artist_album (artist_id, album_id)
VALUES (7, 1);

INSERT INTO artist_album (artist_id, album_id)
VALUES (8, 4);

-- Заполняем таблицу с треками

INSERT INTO track (name, duration, album_id)
VALUES ('Master Of Puppets', 175, 1);

INSERT INTO track (name, duration, album_id)
VALUES ('It is my Darling', 198, 1);

INSERT INTO track (name, duration, album_id)
VALUES ('The Unforgiven', 203, 2);

INSERT INTO track (name, duration, album_id)
VALUES ('Nothing Else', 225, 2);

INSERT INTO track (name, duration, album_id)
VALUES ('The Memory Remains', 184, 3);

INSERT INTO track (name, duration, album_id)
VALUES ('Better Than You', 219, 3);

INSERT INTO track (name, duration, album_id)
VALUES ('Drying Out', 202, 4);

INSERT INTO track (name, duration, album_id)
VALUES ('You Came Back', 192, 4);

-- Заполняем таблицу со сборниками

INSERT INTO collection (name, year_of_release)
VALUES ('This Is Your Life', '2002-08-11');

INSERT INTO collection (name, year_of_release)
VALUES ('Broadcast Archives', '2007-03-10');

INSERT INTO collection (name, year_of_release)
VALUES ('The Bridge School', '2018-05-20');

INSERT INTO collection (name, year_of_release)
VALUES ('Anniversary Edition', '2020-02-15');

-- Заполняем промежуточную таблицу со сборниками и треками

INSERT INTO collection_track (collection_id, track_id)
VALUES (1, 1);

INSERT INTO collection_track (collection_id, track_id)
VALUES (1, 2);

INSERT INTO collection_track (collection_id, track_id)
VALUES (2, 3);

INSERT INTO collection_track (collection_id, track_id)
VALUES (2, 4);

INSERT INTO collection_track (collection_id, track_id)
VALUES (3, 5);

INSERT INTO collection_track (collection_id, track_id)
VALUES (3, 6);

INSERT INTO collection_track (collection_id, track_id)
VALUES (4, 5);

INSERT INTO collection_track (collection_id, track_id)
VALUES (4, 6);