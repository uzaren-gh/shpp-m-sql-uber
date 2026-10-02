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
    number    VARCHAR(30) NOT NULL CHECK (number <> ''),
    street_id INT UNSIGNED NOT NULL,
    approachable BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE KEY uniq_street_house (street_id, number),
    FOREIGN KEY (street_id) REFERENCES street (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS passenger
(
    id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    phone VARCHAR(20) NOT NULL CHECK (phone <> '') UNIQUE,
    phone_verified_at TIMESTAMP NULL,
    email_verified_at TIMESTAMP NULL,
    default_payment_method_id INT UNSIGNED NULL,
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255) NOT NULL CHECK (password_hash <> ''),
    rating DECIMAL(3,2) NOT NULL DEFAULT 5.00,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('active','blocked','deleted') NOT NULL DEFAULT 'active',
    name VARCHAR(50) NOT NULL CHECK (name <> ''),
    KEY idx_passenger_status (status),
    KEY idx_passenger_created_at (created_at)
    );

CREATE TABLE ride
(
    id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT UNSIGNED NOT NULL,
    driver_id    INT UNSIGNED NULL,
    status       ENUM('requested','accepted','in_progress','completed','cancelled_by_passenger','cancelled_by_driver') NOT NULL,
    requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    cancelled_at TIMESTAMP NULL,
    price        DECIMAL(10, 2) NULL,
    FOREIGN KEY (passenger_id) REFERENCES passenger (id),
    KEY idx_ride_passenger_status (passenger_id, status),
    KEY idx_ride_driver_status    (driver_id, status),
    KEY idx_ride_requested_at     (requested_at)
);