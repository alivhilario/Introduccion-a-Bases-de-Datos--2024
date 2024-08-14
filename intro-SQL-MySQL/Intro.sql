-- Main commands
--Get mySQL
sudo apt - get
update sudo apt - get install mysql - server
--Start it
sudo service mysql start
--In order to get access
sudo mysql - u root - p
-- Make sure is working.
sudo service mysql status
--Access as ROOT
sudo mysql - u root - p
--Better visualization 
--G\
SHOW full columns
FROM
    tableName;

`year` ---pretty helpful to use reserved words
--Access to databases
SHOW DATABASES;

USE tienda;

SHOW tables;

SELECT
    *
FROM
    tableName;

DESC;

----Which data is selected by
SELECT
    DATABASE ();

--Create a new database
CREATE DATABASE my_database;

--Delete a database
DROP database platzi_operation;

CREATE DATABASE IF NOT EXISTS platzi_operation;

--Show warnings
SHOW warnings;

---Create Tables
CREATE TABLE
    IF NOT EXISTS books (
        --AUTO_INCREMENT:it will store the last added no matter which was deleted before.
        --The last number is not the CARDINALITY!!!
        --UNSIGNED: just positive numbers.
        book_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        --AUTHOR: we'll link other table with this one (This is Relational Database) 
        author_id INT UNSIGNED,
        title VARCHAR(100) NOT NULL,
        --DEFAULT: If info is not added by default the info will be the same as I added.
        publication_year INT UNSIGNED NOT NULL DEFAULT 1900,
        publication_language VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Languge',
        cover_url VARCHAR(500),
        --DOUBLE: store the number and the decimals.
        price DOUBLE NOT NULL DEFAULT 10.0,
        --TINYINT: Bolean 1 o 0 (True o False)
        sellable TINYINT (1) DEFAULT 1,
        copies INT NOT NULL DEFAULT 1,
        --TEXT: Text
        description_book TEXT
    );

CREATE TABLE
    IF NOT EXISTS authors (
        author_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(100) NOT NULL,
        nationality VARCHAR(3) NOT NULL
    );

CREATE TABLE
    IF NOT EXISTS clients (
        client_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        `name` VARCHAR(50) NOT NULL,
        email VARCHAR(100) NOT NULL UNIQUE,
        birthdate DATETIME,
        gender ENUM ('male', 'female', 'ns') NOT NULL,
        active TINYINT (1) NOT NULL default 1, --IF SOMETHING IS DELETED JUST SHOW AS INACTIVE HIDE IT
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

--INSERT
INSERT INTO
    authors (name, nationality)
values
    ('Gabriel Garcia Marquez', 'COL');

INSERT INTO
    authors (id, name, nationality)
values
    ('Gabriel Garcia Marquez', 'COL');

INSERT INTO
    `clients` (name, email, birthdate, gender, active)
VALUES
    (
        'Maria Luisa Marin',
        'Maria Luisa.83726282A@random.names',
        '1957-07-30',
        'F',
        1
    ),
    (
        'Pedro Sanchez',
        'Pedro.78522059J@random.names',
        '1992-01-31',
        'M',
        1
    );

--Juts keep in mind the usage of ON DUPLICATE KEY UPDATE
INSERT INTO
    `clients` (name, email, birthdate, gender, active)
values
    (
        'Pedro Sanchez',
        'pedro@random.names',
        '1992-01-01',
        0
    ) ON DUPLICATE KEY
UPDATE
SET
    active =
VALUES
    (active);

INSERT INTO
    usuarios (id, nombre, email)
VALUES
    (2, 'Ana Gomez', 'ana.gomez@example.com') ON DUPLICATE KEY
UPDATE nombre =
VALUES
    (nombre),
    email =
VALUES
    (email);

---CHATGP explanation 'ON DUPLICATE KEY UPDATE'
CREATE TABLE
    usuarios (
        id INT PRIMARY KEY,
        nombre VARCHAR(100),
        email VARCHAR(100) UNIQUE,
        ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

---Queries inside the query --------------------------------
--Adding authors---
INSERT INTO
    books (title, author_id)
VALUES
    ('El Laberinto de la Soledad', 23);

-------Being aware of the "Alias"
INSERT INTO
    authors (author_id, name, nationality)
VALUES
    (23, 'Octavio Paz', 'MEX') AS new_author ON DUPLICATE KEY
UPDATE author_id = new_author.author_id,
name = new_author.name;

--DELETE--
DELETE FROM books
WHERE
    author_id = 2;

--Queries inside
INSERT INTO
    books (title, author_id, 'year')
VALUES
    (
        'Vuelta al Laberinto de la Soledad',
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                name = 'Octavio Paz'
        ),
        1960
    );