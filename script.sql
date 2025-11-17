-- Clean up
DROP TABLE IF EXISTS theaters CASCADE;
DROP TABLE IF EXISTS halls CASCADE;
DROP TABLE IF EXISTS seat_types CASCADE;
DROP TABLE IF EXISTS seats CASCADE;
DROP TABLE IF EXISTS films CASCADE;
DROP TABLE IF EXISTS genres CASCADE;
DROP TABLE IF EXISTS film_genres CASCADE;
DROP TABLE IF EXISTS showtimes CASCADE;
DROP TABLE IF EXISTS visitors CASCADE;
DROP TABLE IF EXISTS tickets CASCADE;

-- Tables creation
CREATE TABLE theaters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE halls (
    id SERIAL PRIMARY KEY,
    theater_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0),
    UNIQUE (theater_id, name),
    FOREIGN KEY (theater_id) REFERENCES theaters(id) ON DELETE CASCADE
);

CREATE TABLE seat_types (
    id SERIAL PRIMARY KEY,
    seat_type_name VARCHAR(50) NOT NULL
);

CREATE TABLE seats (
    id SERIAL PRIMARY KEY,
    hall_id INT NOT NULL,
    seat_type INT NOT NULL,
    seat_ticket_name VARCHAR(100),
    FOREIGN KEY (hall_id) REFERENCES halls(id) ON DELETE CASCADE,
    FOREIGN KEY (seat_type) REFERENCES seat_types(id)
);

CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration_minutes INT CHECK (duration_minutes > 0)
);

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE film_genres (
    film_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (film_id, genre_id),
    FOREIGN KEY (film_id) REFERENCES films(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

CREATE TABLE showtimes (
    id SERIAL PRIMARY KEY,
    movie_id INT NOT NULL,
    hall_id INT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES films(id),
    FOREIGN KEY (hall_id) REFERENCES halls(id)
);

CREATE TABLE visitors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE
);

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    seat_id INT NOT NULL,
    price INT NOT NULL CHECK (price >= 0),
    transaction_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    showtime_id INT NOT NULL,
    visitor_id INT NOT NULL,
    FOREIGN KEY (seat_id) REFERENCES seats(id),
    FOREIGN KEY (showtime_id) REFERENCES showtimes(id),
    FOREIGN KEY (visitor_id) REFERENCES visitors(id)
);
