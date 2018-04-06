UPDATE restaurant
SET
address=
CASE id
WHEN 1 THEN '3004 Canal St'
WHEN 2 THEN '2704 Navigation Blvd'
WHEN 3 THEN '218 Travis St'
WHEN 4 THEN '2704 Polk St'
WHEN 5 THEN '1001 Avenida De Las Americas'
WHEN 6 THEN '7001 Harrisburg Blvd'
WHEN 7 THEN '1616 W Main St'
WHEN 8 THEN 'Second Ward'
WHEN 9 THEN '3519 Clinton Dr'
WHEN 10 THEN '1611 Lamar St'
WHEN 11 THEN '903 Hutchins St'
WHEN 12 THEN '610 Main St'
END

CREATE TABLE reviewer (
id SERIAL PRIMARY KEY,
name VARCHAR,
email VARCHAR,
karma INTEGER CHECK (karma >= 0 AND karma <= 7)
)

CREATE TABLE review (
id SERIAL PRIMARY KEY,
reviewer_id INTEGER REFERENCES reviewer (id),
stars INTEGER CHECK (stars >=1 AND stars <=5),
title VARCHAR,
review VARCHAR,
restaurant_id INTEGER REFERENCES restaurant (id)
);

INSERT INTO reviewer VALUES (
DEFAULT, 'Ziqing', 'redtaq@hotmail.com',5),
(DEFAULT, 'Linda', 'linda@aol.com', 3),
(DEFAULT, 'Goku', 'goku@4star.com', 7),
(DEFAULT, 'Rachel', 'rachel@google.com', 2),
(DEFAULT, 'Jacky', 'jacky@hotmail.com',4),
(DEFAULT, 'Tommy', 'tommy@stake.com', 1),
(DEFAULT, 'Jerry', 'jerry@usa.com', 6),
(DEFAULT, 'Stark', 'stark@wintercomes.org', 7);

INSERT INTO review VALUES 
(DEFAULT, 2, 3, 'It''s just so so.', 'I went to this restaurant last Sunday. I was so disappointed that they even don''t supply chicken!', 5),
(DEFAULT, 1, 4, 'Nice place!', 'Hey, the food here is great! You should come to taste by yourself!', 2),
(DEFAULT, 7, 5, 'Alright guys, here comes the king.', 'You have to agree the burger here is something you never tried before', 9),
(DEFAULT, 4, 2, 'Nah, not this.', 'Don''t come to this place, it''s broken.', 1),
(DEFAULT, 6, 4, 'Not bad.', 'I like it. At least the chicken tastes great!', 10),
(DEFAULT, 3, 3, 'Another OK place', 'You can find OK food here if you are used to eat trash food like me.', 7),
(DEFAULT, 8, 1, 'No no, it''s just wrong.', 'Terrible service! I can''t believe the servant was so lousy!', 6),
(DEFAULT, 5, 4, 'Cheap and good', 'Like the title, good.', 3),
(DEFAULT, 4, 3, 'Meh', 'What I can say, this is the only open one at 10''o clock I can find here.', 4),
(DEFAULT, 2, 4, 'I like the burger', 'Beautiful menu and great service, with the trumendous burger.', 8),
(DEFAULT, 1, 5, 'They don''t accept tips!', 'No tips! That''s good enough for me!', 11),
(DEFAULT, 7, 2, 'So regretful.', 'I should be here, that'' all I want to let you know.', 7),
(DEFAULT, 5, 4, 'You should come too.', 'Lovely cozy place with fireplace on all the year!', 6),
(DEFAULT, 4, 1, 'Leave me alone!', 'I got ambulanced after eating the salads here.', 4),
(DEFAULT, 2, 5, 'If you are a man like me...', 'They have all kinds of sauces for you to try, free!', 8);

--List all the reviews for a given restaurant given a specific restaurant ID
SELECT name, review.stars AS review_star, title AS review_title, review FROM restaurant
INNER JOIN review
ON restaurant.id = review.restaurant_id WHERE restaurant.id = 7;

--List all the reviews for a given restaurant, given a specific restaurant name.
SELECT name, review.stars AS review_star, title AS review_title, review FROM restaurant
INNER JOIN review
ON restaurant.id = review.restaurant_id WHERE restaurant.name = 'The Grove';

-- List all the reviews for a given reviewer, given a specific author name.
SELECT name, review.stars AS review_star, title AS review_title, review FROM reviewer
INNER JOIN review
ON reviewer.id = review.reviewer_id WHERE name = 'Jacky';

-- List all the reviews along with the restaurant they were written for. In the query result, select the restaurant name and the review text.
SELECT name, review FROM restaurant
INNER JOIN
review ON restaurant.id = review.restaurant_id ORDER BY name ASC;

-- Get the average stars by restaurant. The result should have the restaurant name and its average star rating
SELECT name, ROUND(AVG(review.stars),1) AS avg_review_stars FROM restaurant
LEFT OUTER JOIN
review ON restaurant.id = review.restaurant_id GROUP BY restaurant.id ORDER BY avg_review_stars DESC;

-- Get the number of reviews written for each restaurant. The result should have the restaurant name and its review count.
SELECT name, COUNT(review.review) FROM restaurant
LEFT OUTER JOIN
review ON restaurant.id = review.restaurant_id GROUP BY restaurant.id ORDER BY name ASC;

-- List all the reviews along with the restaurant, and the reviewer's name. The result should have the restaurant name, the review text, and the reviewer name. Hint: you will need to do a three-way join - i.e. joining all three tables together.
SELECT restaurant.name AS restaurant_name, review.review, reviewer.name AS reviewer_name
FROM restaurant
LEFT OUTER JOIN
review ON restaurant.id = review.restaurant_id
JOIN reviewer ON review.reviewer_id = reviewer.id ORDER by restaurant_name ASC;

-- Get the average stars given by each reviewer. (reviewer name, average star rating)
SELECT name, ROUND(AVG(stars),1) FROM reviewer
INNER JOIN
review ON reviewer.id = review.reviewer_id GROUP BY name;

-- Get the lowest star rating given by each reviewer. (reviewer name, lowest star rating)
SELECT name, MIN(stars) FROM reviewer
INNER JOIN
review ON reviewer.id = review.reviewer_id GROUP BY name;

-- Get the number of restaurants in each category. (category name, restaurant count)
SELECT category, COUNT(name) FROM restaurant GROUP BY category;

-- Get number of 5 star reviews given by restaurant. (restaurant name, 5-star count)
SELECT restaurant.name, COUNT(review.stars) FROM restaurant
LEFT OUTER JOIN
review ON restaurant.id = review.restaurant_id WHERE review.stars=5 GROUP BY restaurant.name;

-- Get the average star rating for a food category. (category name, average star rating)
SELECT category, ROUND(AVG(review.stars),1) FROM restaurant
LEFT OUTER JOIN
review ON restaurant.id = review.restaurant_id GROUP BY category;