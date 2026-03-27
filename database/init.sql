CREATE DATABASE IF NOT EXISTS thehub;
CREATE USER IF NOT EXISTS 'thehubuser'@'%' IDENTIFIED BY 'password1';
GRANT ALL PRIVILEGES ON thehub.* TO 'thehubuser'@'%';
FLUSH PRIVILEGES;

USE thehub;

CREATE TABLE IF NOT EXISTS games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(255) NOT NULL,
    image_link VARCHAR(1024),
    release_date DATE
);

CREATE TABLE IF NOT EXISTS weekly_recaps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    week_number INT NOT NULL,
    year INT NOT NULL,
    recap TEXT NOT NULL,
    generated_at DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS games (
         id INT AUTO_INCREMENT PRIMARY KEY,
         title VARCHAR(255) NOT NULL,
         genre VARCHAR(255) NOT NULL,
         image_link VARCHAR(1024),
         release_date DATE
     );

     CREATE TABLE IF NOT EXISTS weekly_recaps (
         id INT AUTO_INCREMENT PRIMARY KEY,
         week_number INT NOT NULL,
         year INT NOT NULL,
         recap TEXT NOT NULL,
         generated_at DATETIME NOT NULL
     );
