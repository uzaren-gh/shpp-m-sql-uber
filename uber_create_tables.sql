CREATE DATABASE IF NOT EXISTS uber
CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE uber;

CREATE TABLE IF NOT EXISTS city
(
    id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL CHECK (name <> '')
);

CREATE TABLE IF NOT EXISTS street
(
    id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(50) NOT NULL CHECK (name <> ''),
    city_id INT UNSIGNED NOT NULL,
    drivable BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE KEY uniq_city_street (city_id, name),
    FOREIGN KEY (city_id) REFERENCES city (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS house
(
    id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    number    VARCHAR(30) NOT NULL CHECK (name <> ''),
    street_id INT UNSIGNED NOT NULL,
    approachable BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE KEY uniq_street_house (street_id, number),
    FOREIGN KEY (street_id) REFERENCES street (id) ON DELETE CASCADE
);

