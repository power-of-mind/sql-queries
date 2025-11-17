-- Создаем базу данных music_website

CREATE DATABASE music_website;

-- Создаем таблицу с жанрами

CREATE TABLE IF NOT EXISTS Genre (
id SERIAL PRIMARY KEY,
name VARCHAR(255) UNIQUE NOT NULL
);

-- Создаем таблицу с исполнителями

CREATE TABLE IF NOT EXISTS Artist (
id SERIAL PRIMARY KEY,
name VARCHAR(255) UNIQUE NOT NULL
);

-- Создаем промежуточную таблицу с жанрами и исполнителями

CREATE TABLE IF NOT EXISTS Genre_Artist (
genre_id INTEGER REFERENCES Genre(id),
artist_id INTEGER REFERENCES Artist(id),
CONSTRAINT pk PRIMARY KEY (genre_id, artist_id)
);

-- Создаем таблицу с альбомами

CREATE TABLE IF NOT EXISTS Album(
id SERIAL PRIMARY KEY,
name VARCHAR(255) UNIQUE NOT NULL,
year_of_release DATE NOT NULL CHECK (year_of_release > '2000-12-31')
);

-- Создаем промежуточную таблицу с исполнителями и альбомами

CREATE TABLE IF NOT EXISTS Artist_Album (
artist_id INTEGER REFERENCES Artist(id),
album_id INTEGER REFERENCES Album(id),
CONSTRAINT pk_1 PRIMARY KEY (artist_id, album_id)
);

-- Создаем таблицу со сборниками

CREATE TABLE IF NOT EXISTS Collection (
id SERIAL PRIMARY KEY,
name VARCHAR(255) UNIQUE NOT NULL,
year_of_release DATE NOT NULL CHECK (year_of_release > '2000-12-31')
);

-- Создаем таблицу с треками

CREATE TABLE IF NOT EXISTS Track (
id SERIAL PRIMARY KEY,
name VARCHAR(255) UNIQUE NOT NULL,
duration INTEGER NOT NULL CHECK (duration > 150),
album_id INTEGER NOT NULL REFERENCES Album(id)
);

-- Создаем промежуточную таблицу со сборниками и треками

CREATE TABLE IF NOT EXISTS Collection_Track (
collection_id INTEGER REFERENCES Collection(id),
track_id INTEGER REFERENCES Track(id),
CONSTRAINT pk_2 PRIMARY KEY (collection_id, track_id)
);
