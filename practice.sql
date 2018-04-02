CREATE TABLE restaurant (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR UNIQUE,
  distance FLOAT,
  stars FLOAT,
  category VARCHAR,
  favourite_dish VARCHAR,
  takeout BOOLEAN,
  last_time_visit DATE
  );

INSERT INTO restaurant VALUES (DEFAULT, 'Moon Tower Inn', 0.2, 4, 'Bars', 'Hot dogs', TRUE, '2018-02-24'),
(DEFAULT, 'The Original Ninfa''s on Navigation', 0.3, 4, 'Tex-Mex', 'Fajitas', TRUE, '2018-03-25'),
(DEFAULT, 'Hearsay Gastro Lounge', 1.5, 4, 'American(New)', 'Byrd burger', TRUE, '2018-03-10'),
(DEFAULT, 'Nancy''s Hustle', 0.9, 4.5, 'American(New)', 'Brussel sprouts', False, '2018-03-27'),
(DEFAULT, 'Grotto Downtown', 1.1, 4, 'Italian', 'Tomato basil soup', TRUE, '2018-03-27'),
(DEFAULT, 'Chicken Station', 2.5, 5, 'Latin American', 'Chicken', TRUE, '2018-04-01'),
(DEFAULT, 'Night Heron', 3.8, 4, 'Bars', 'Burger', False, '2018-03-20'),
(DEFAULT, 'House of Hoopz BBQ & Crawfish', 0.3, 4.5, 'Barbeque', 'BBQ', TRUE, '2018-03-03'),
(DEFAULT, 'The New Potato', 0.9, 5, 'American(New)', 'Cocktails', TRUE, '2018-01-18'),
(DEFAULT, 'The Grove', 1.3, 3.5, 'American(New)', 'Roasted cauliflower koshary', TRUE, '2018-03-12'),
(DEFAULT, 'King''s Court Bar And Kitchen', 0.9, 3.5, 'Bars', 'Curry fries', TRUE, '2018-03-01'),
(DEFAULT, 'The District', 1.5, 3.5, 'American(New)', 'Burgers', TRUE, '2018-01-27');

SELECT name FROM restaurant WHERE stars=5;
SELECT name, favourite_dish FROM restaurant WHERE stars=5;
SELECT id FROM restaurant WHERE name LIKE '%Moon Tower%';
SELECT name FROM restaurant WHERE category='Barbeque';
SELECT name FROM restaurant WHERE takeout=TRUE;
SELECT name FROM restaurant WHERE takeout=TRUE AND category='Barbeque';
SELECT name FROM restaurant WHERE distance <= 2;
SELECT name FROM restaurant WHERE last_time_visit>'2018-03-25';
SELECT name FROM restaurant WHERE last_time_visit<'2018-03-25' AND stars=5;
SELECT name, distance FROM restaurant ORDER BY distance ASC;
SELECT name, distance FROM restaurant ORDER BY distance ASC LIMIT 2;
SELECT name, stars FROM restaurant ORDER BY stars DESC LIMIT 2;
SELECT name, stars, distance FROM restaurant WHERE distance < 2 ORDER BY stars DESC LIMIT 2;
SELECT COUNT(*) FROM restaurant;
SELECT COUNT(*), category FROM restaurant GROUP BY category;
SELECT AVG(stars), category FROM restaurant GROUP BY category;
SELECT MAX(stars) AS max_star, COUNT(*) AS restaurant_numbers,category FROM restaurant GROUP BY category; 