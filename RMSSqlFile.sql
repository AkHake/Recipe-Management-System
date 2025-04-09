create database recipe_db;

use recipe_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    status ENUM('active', 'inactive') DEFAULT 'active'
);

select * from users;

insert into users values (0, 'admin@gmail.com', 'admin', 'admin', 'active', 'Admin');

CREATE TABLE recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category ENUM('veg', 'non-veg') NOT NULL,
    ingredients TEXT NOT NULL,
    method TEXT NOT NULL,
    submitted_by VARCHAR(100),
    status ENUM('pending', 'approved','rejected') DEFAULT 'pending'
);

select * from recipes;

ALTER TABLE recipes ADD COLUMN image VARCHAR(255);

ALTER TABLE users ADD COLUMN name VARCHAR(100);

ALTER TABLE recipes
ADD COLUMN rejection_comment TEXT,
ADD COLUMN is_notified BOOLEAN DEFAULT FALSE;

truncate table recipes;

truncate table users;

ALTER TABLE recipes ADD COLUMN is_public BOOLEAN DEFAULT FALSE;

SET SQL_SAFE_UPDATES = 0;

UPDATE recipes SET is_public = FALSE WHERE is_public IS NULL;

ALTER TABLE recipes ADD COLUMN comment TEXT;

ALTER TABLE recipes ADD COLUMN admin_comment TEXT;

SHOW COLUMNS FROM recipes LIKE 'status';

ALTER TABLE recipes MODIFY COLUMN status ENUM('pending', 'approved', 'rejected');

SHOW COLUMNS FROM recipes LIKE 'is_public';
