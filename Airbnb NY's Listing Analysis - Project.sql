/* 

## Key activities

 - Use of basic SQL to explore the database.
 - Filter, group by, and analyse datasets using SQL.
 - Answer key business questions with SQL.

 */



/* 

## The Dataset 

The dataset is a CSV file named `airbnb_data.csv`, which contains data on airbnb listings in the state of New York. It contains the following columns:


| Field Name           | Description                                  |
| -------------------- | -------------------------------------------- |
| `listing_id`         | The unique identifier for a listing          |
| `description`        | The description used on the listing          |
| `host_id`            | Unique identifier for a host                 |
| `neighbourhood_full` | Name of boroughs and neighbourhoods          |
| `coordinates`        | Coordinates of listing (latitude, longitude) |
| `listing_added`      | Date of added listing                        |
| `room_type`          | Type of room                                 |
| `rating`             | Rating from 0 to 5.                          |
| `price`              | Price per night for listing                  |
| `number_of_reviews`  | Amount of reviews received                   |
| `reviews_per_month`  | Number of reviews per month                  |
| `availability_365`   | Number of days available per year            |
| `number_of_stays`    | Total number of stays thus far               | 

*/

 
  
/*

## Questions to answer 

* Question 1: List the top 10 most reviewed private rooms
* Question 2: What are the cheapest 10 private rooms in New York?
* Question 3: What is the average availability of a private room in New York?
* Question 4: Which listings have an availability of fewer than 30 days a year but have fewer than 10 reviews?
* Question 5: What is the average number of reviews per room type, ordered by the average in descending order?
* Question 6: What is the number and average price of listings by room type where such listings are available for more than 250 days a year?
* Question 7: What is the most expensive listing by room type, for listings available more than 100 days a year?

*/



 -- ## Exploratory Data Analysis

-- SELECT the first 10 rows of all the columns from the airbnb dataset
SELECT *
FROM 'airbnb_data.csv'
LIMIT 10;


-- SELECT the first 10 rows of the listing_id, description, and neighbourhood_full columns
SELECT listing_id, description, neighbourhood_full
FROM 'airbnb_data.csv'
LIMIT 10;


-- Set an alias for listing_id, description and neighbourhood_full
SELECT listing_id AS Lists, description AS Description, neighbourhood_full AS Neighbourhood
FROM 'airbnb_data.csv'
LIMIT 10;


-- Sort the output by number of stays
SELECT *
FROM 'airbnb_data.csv'
ORDER BY number_of_stays DESC
LIMIT 10;


-- Filter room type by private room
SELECT *
FROM 'airbnb_data.csv'
WHERE room_type = 'Private Room';


-- Get the average price for all rooms
SELECT listing_id, description, AVG(price)
FROM 'airbnb_data.csv'
GROUP BY listing_id, description;


-- Get the average price per room type
SELECT room_type AS 'Type Of Room', AVG(price) AS 'Avarage Price per room type'
FROM 'airbnb_data.csv'
GROUP BY room_type;



 -- ## Answering the questions

 -- Question 1: List the top 10 most reviewed private rooms
SELECT listing_id, SUM(number_of_reviews) AS '# Of Rooms'
FROM 'airbnb_data.csv'
WHERE room_type = 'Private Room'
GROUP BY listing_id
ORDER BY SUM(number_of_reviews) DESC
LIMIT 10;


-- Question 2: List the top 10 cheapest private rooms in New York
SELECT *
FROM 'airbnb_data.csv'
WHERE room_type = 'Private Room'
ORDER BY price
LIMIT 10;


-- Question 3: What is the average availability of a private room in New York?
SELECT room_type, AVG(availability_365) AS 'Avg. Room Availability'
FROM 'airbnb_data.csv'
WHERE room_type = 'Private Room' 
GROUP BY room_type
LIMIT 10;


-- Question 4: Which listings have an availability of fewer than 30 days a year but have fewer than 10 reviews?
SELECT listing_id, availability_365 AS 'Avg. Room Availability', number_of_reviews AS 'Reviews'
FROM 'airbnb_data.csv'
WHERE availability_365 < 30
	AND number_of_reviews < 10
ORDER BY availability_365 DESC, number_of_reviews DESC;


-- Question 5: What is the average number of reviews per room type, ordered by the average in ascending order?
SELECT room_type AS 'Type Of Room', AVG(number_of_reviews) AS avg_reviews
FROM 'airbnb_data.csv'
GROUP BY room_type
ORDER BY avg_reviews DESC;


-- Question 6: What is the average price of listings by room type where such listings are available for more than 250 days a year?
SELECT room_type, COUNT(listing_id) AS number_of_lists, AVG(price) AS avg_price
FROM 'airbnb_data.csv'
WHERE availability_365 > 250
GROUP BY room_type,
ORDER BY avg_price DESC;


-- Question 7: What is the most expensive listing by room type, for listings available more than 100 days a year?
SELECT room_type, MAX(price) AS max_price
FROM 'airbnb_data.csv'
WHERE availability_365 > 100
GROUP BY room_type
ORDER BY max_price DESC;