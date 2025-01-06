# 1. Create a table called employees with the following structure?
# : emp_id (integer, should not be NULL and should be a primary key)
# : emp_name (text, should not be NULL)
# : age (integer, should have a check constraint to ensure the age is at least 18)
# : email (text, should be unique for each employee)
# : salary (decimal, with a default value of 30,000).
# Write the SQL query to create the above table with all constraints.

# Ans 1:
create database A;
use A;
CREATE TABLE employees (
    emp_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    age INT NOT NULL CHECK (age >= 18),
    email VARCHAR(255) NOT NULL UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000.00 NOT NULL
);
DESCRIBE employees;

# 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
# Ans 2 : 
#  Constraints are rules enforced on the data in a database to ensure its accuracy, consistency, and reliability. They help maintain data integrity by preventing invalid data entry and ensuring that relationships between tables remain consistent.
# Common types of constraints are :
# NOT NULL: Ensures that a column cannot have a NULL value. Example: An employee must always have a name.
# UNIQUE: Ensures all values in a column are distinct. Example: No two employees can have the same email.
# PRIMARY KEY: Combines NOT NULL and UNIQUE. Uniquely identifies each row in a table. Example: emp_id is the primary key for the employees table.
# FOREIGN KEY: Establishes a relationship between two tables. Example: Each employee belongs to a department, defined in a separate table.
# CHECK: Ensures that a column satisfies a specific condition. Example: Employee age must be at least 18.
# DEFAULT: Provides a default value for a column if no value is specified. Example: The default salary for an employee is 30,000.

# 3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
# Ans: The NOT NULL constraint ensures that a column must always have a value, preventing NULL entries. This is useful for mandatory fields like names or IDs, where missing data would compromise the database's accuracy or functionality.
# No, a primary key cannot contain NULL values. A primary key must uniquely identify each row, and NULL represents unknown or missing data, which cannot ensure uniqueness or be reliably used to identify records.

# 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
# Ans: In SQL, you can modify constraints on an existing table using the ALTER TABLE command.
# Adding a Constraint: 
# Identify the table: Specify the table to which the constraint will be added.
# Define the constraint: Use ADD CONSTRAINT followed by the constraint type and details.

# Removing a Constraint
# Identify the table: Specify the table from which the constraint will be removed.
# Specify the constraint: Use DROP CONSTRAINT followed by the constraint name.

-- Step 1: Create the students table
CREATE TABLE students (
    student_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    age INT,
    course_id INT
);

-- Step 2: Create the courses table
CREATE TABLE courses (
    course_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL
);

-- Step 3: Add a Foreign Key Constraint
ALTER TABLE students
ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(course_id);

-- Step 4: Add a CHECK Constraint to ensure age >= 18
ALTER TABLE students
ADD CONSTRAINT check_age_valid CHECK (age >= 18);

-- Step 5: Remove the CHECK Constraint
ALTER TABLE students
DROP CHECK check_age_valid;

-- Step 6: Remove the Foreign Key Constraint
ALTER TABLE students
DROP FOREIGN KEY fk_course;

# 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.
# Ans 5 : Consequences of Violating Constraints:
# Insertion Failures: If you insert data that violates a constraint (e.g., inserting NULL into a NOT NULL column or duplicate values in a UNIQUE column), the insertion will fail.
# Update Failures: Violating constraints during an update (e.g., updating a PRIMARY KEY to a duplicate value or modifying a FOREIGN KEY to a non-existent value) results in an error.
# Deletion Failures: Deleting a record that is referenced by a FOREIGN KEY will fail unless cascading rules are set.

INSERT INTO students (student_name, age)
VALUES ('John Doe', 25);
-- Attempting duplicate entry:
INSERT INTO students (student_name, age)
VALUES ('John Doe', 28);
ERROR 1062 (23000): Duplicate entry 'John Doe' for key 'unique_student_name'

INSERT INTO students (student_name, age)
VALUES (NULL, 22);  -- student_name cannot be NULL

INSERT INTO students (student_name, age, course_id)
VALUES ('Jane Doe', 20, 999);  -- course_id 999 does not exist

# 6. You created a products table without constraints as follows:
# CREATE TABLE products (
# product_id INT,
# product_name VARCHAR(50),
# price DECIMAL(10, 2));
# Now, you realise that The product_id should be a primary key. The price should have a default value of 50.00

# Ans 6: 

-- Step 1: Add the PRIMARY KEY constraint to product_id
ALTER TABLE products
ADD PRIMARY KEY (product_id);
-- Step 2: Set the default value of 50.00 for the price column
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2) DEFAULT 50.00
);

# 7. You have two tables: Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
# Ans 7 : 

-- Create the students Table
CREATE TABLE students (
    student_id INT NOT NULL PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    class_id INT
);
-- Create the classes Table
CREATE TABLE classes (
    class_id INT NOT NULL PRIMARY KEY,
    class_name VARCHAR(255) NOT NULL
);
-- Insert Data into the students Table
INSERT INTO students (student_id, student_name, class_id) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);

-- Insert Data into the classes Table
INSERT INTO classes (class_id, class_name) VALUES
(101, 'math'),
(102, 'science'),
(103, 'history');

-- Write and Run the INNER JOIN Query
SELECT 
    students.student_name, 
    classes.class_name
FROM 
    students
INNER JOIN 
    classes
ON 
    students.class_id = classes.class_id;
    
# 8. Consider the following three tables: Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order. Hint: (use INNER JOIN and LEFT JOIN)
# Ans 8 : 

-- Step 1: Create the orders Table

CREATE TABLE orders (
    order_id INT NOT NULL PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT
);

-- Step 2: Create the customers Table

CREATE TABLE customers (
    customer_id INT NOT NULL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL
);

-- Step 3: Create the products Table

CREATE TABLE products (
    product_id INT NOT NULL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    order_id INT
);

-- Step 4: Insert Data into the orders Table

INSERT INTO orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-01', 101),
(2, '2024-01-03', 102);

-- Step 5: Insert Data into the customers Table

INSERT INTO customers (customer_id, customer_name) VALUES
(101, 'Alice'),
(102, 'Bob');

-- Step 6: Insert Data into the products Table

INSERT INTO products (product_id, product_name, order_id) VALUES
(1, 'Laptop', 1),
(2, 'Phone', NULL);

-- Step 7: Query to Fetch All order_id, customer_name, and product_name

SELECT 
    orders.order_id,
    customers.customer_name,
    products.product_name
FROM 
    products
LEFT JOIN 
    orders ON products.order_id = orders.order_id
LEFT JOIN 
    customers ON orders.customer_id = customers.customer_id;

# 9. Given the following tables: Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
# Ans 9:

SELECT 
    p.product_name,
    SUM(s.amount) AS total_sales
FROM 
    Sales s
INNER JOIN 
    Products p
ON 
    s.product_id = p.product_id
GROUP BY 
    p.product_name;

# 10.You are given three tables: Write a query to display the order_id, customer_name, and the quantity of products ordered by each ustomer using an INNER JOIN between all three tables.
# Ans 10: 

-- Step 1: Create the 'orders' table
CREATE TABLE orders (
    order_id INT NOT NULL PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT
);

-- Step 2: Create the 'customers' table
CREATE TABLE customers (
    customer_id INT NOT NULL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL
);

-- Step 3: Create the 'order_details' table
CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Step 4: Insert data into the 'orders' table
INSERT INTO orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-02', 1),
(2, '2024-01-05', 2);

-- Step 5: Insert data into the 'customers' table
INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob');

-- Step 6: Insert data into the 'order_details' table
INSERT INTO order_details (order_id, product_id, quantity) VALUES
(1, 101, 2),
(1, 102, 1),
(2, 101, 3);

-- Step 7: Query to fetch order_id, customer_name, and quantity for each customer
SELECT 
    orders.order_id,
    customers.customer_name,
    order_details.quantity
FROM 
    orders
INNER JOIN 
    customers ON orders.customer_id = customers.customer_id
INNER JOIN 
    order_details ON orders.order_id = order_details.order_id;


use mavenmovies;
select * from mavenmovies.actor;

# SQL Commands
# 1. Identify the primary keys and foreign keys in maven movies DB. Discuss the differences.

# Ans: Primary Key: A column or set of columns that uniquely identifies each record in a table. For example, in a table like customers, the customer_id might be the primary key.
# Foreign Key: A column or set of columns in one table that refers to the primary key in another table, establishing a relationship between the two tables. For example, actor_id in the films table could be a foreign key referencing actor_id in the actors table.

# 2. List all details of actors.

SELECT * FROM actor;

# 3. List all customer information from DB.

SELECT * FROM customer;

# 4. List different countries.

SELECT DISTINCT country FROM customer;

# 5. Display all active customers.

SELECT * FROM customer WHERE active = 1;

# 6. List of all rental IDs for customer with ID 1.

SELECT rental_id FROM rental WHERE customer_id = 1;

# 7. Display all the films whose rental duration is greater than 5.

SELECT * FROM film WHERE rental_duration > 5;

# 8. List the total number of films whose replacement cost is greater than $15 and less than $20.

SELECT COUNT(*) FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;

# 9. Display the count of unique first names of actors.

SELECT COUNT(DISTINCT first_name) FROM actor;

# 10. Display the first 10 records from the customer table.

SELECT * FROM customer LIMIT 10;

# 11. Display the first 3 records from the customer table whose first name starts with ‘b’.

SELECT * FROM customer WHERE first_name LIKE 'B%' LIMIT 3;

# 12. Display the names of the first 5 movies which are rated as ‘G’.

SELECT title FROM film WHERE rating = 'G' LIMIT 5;

# 13. Find all customers whose first name starts with "a".

SELECT * FROM customer WHERE first_name LIKE 'A%';

# 14. Find all customers whose first name ends with "a".

SELECT * FROM customer WHERE first_name LIKE '%a';

# 15. Display the list of the first 4 cities which start and end with ‘a’.

SELECT DISTINCT city FROM customer WHERE city LIKE 'A%' AND city LIKE '%A' LIMIT 4;

# 16. Find all customers whose first name has "NI" in any position.

SELECT * FROM customer WHERE first_name LIKE '%NI%';

# 17. Find all customers whose first name has "r" in the second position.

SELECT * FROM customer WHERE first_name LIKE '_r%';

# 18. Find all customers whose first name starts with "a" and is at least 5 characters in length.

SELECT * FROM customer WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

# 19. Find all customers whose first name starts with "a" and ends with "o".

SELECT * FROM customer WHERE first_name LIKE 'A%o';

# 20. Get the films with PG and PG-13 rating using the IN operator.

SELECT * FROM film WHERE rating IN ('PG', 'PG-13');

# 21. Get the films with length between 50 to 100 using the BETWEEN operator.

SELECT * FROM film WHERE length BETWEEN 50 AND 100;

# 22. Get the top 50 actors using the LIMIT operator.

SELECT * FROM actor LIMIT 50;

# 23. Get the distinct film ids from the inventory table.

SELECT DISTINCT film_id FROM inventory;


# Functions: Basic Aggregate Functions:

# Question 1: Retrieve the total number of rentals made in the Sakila database.

SELECT COUNT(*) AS total_rental
FROM rental;

# Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.

SELECT AVG(rental_duration) AS avg_rental_duration
FROM film;

# Question 3: Display the first name and last name of customers in uppercase.

SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper
FROM customer;

# Question 4: Extract the month from the rental date and display it alongside the rental ID.

SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

# Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).

SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

# Question 6: Find the total revenue generated by each store.

SELECT store_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

# Question 7: Determine the total number of rentals for each category of movies.

SELECT c.name AS category, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

# Question 8: Find the average rental rate of movies in each language.

SELECT l.name AS language, AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;

# Question 9: Display the title of the movie, customer’s first name, and last name who rented it.

SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

# Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."

SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

# Question 11: Retrieve the customer names along with the total amount they've spent on rentals.

SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

# Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London').

SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London';


# Advanced Joins and GROUP BY:

# Question 13: Display the top 5 rented movies along with the number of times they've been rented.

SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 5;

# Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;


# Windows Function:

# 1. Rank the customers based on the total amount they've spent on rentals.

SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS customer_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY customer_rank;

# 2. Calculate the cumulative revenue generated by each film over time.

SELECT f.title, 
       r.rental_date, 
       SUM(p.amount) AS revenue,
       SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id, r.rental_date
ORDER BY f.film_id, r.rental_date;

# 3. Determine the average rental duration for each film, considering films with similar lengths.

SELECT f.title, f.length, AVG(f.rental_duration) OVER (PARTITION BY f.length) AS avg_rental_duration
FROM film f;

# 4. Identify the top 3 films in each category based on their rental counts.

WITH FilmRentalCounts AS (
    SELECT f.title, c.name AS category, COUNT(r.rental_id) AS rental_count
    FROM film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY f.film_id, c.category_id
)
SELECT title, category, rental_count,
       RANK() OVER (PARTITION BY category ORDER BY rental_count DESC) AS film_rank
FROM FilmRentalCounts
WHERE film_rank <= 3;

# 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.

WITH CustomerRentalCounts AS (
    SELECT customer_id, COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY customer_id
),
AvgRentals AS (
    SELECT AVG(total_rentals) AS avg_rentals FROM CustomerRentalCounts
)
SELECT crc.customer_id, crc.total_rentals, 
       crc.total_rentals - (SELECT avg_rentals FROM AvgRentals) AS rental_diff
FROM CustomerRentalCounts crc;

# 6. Find the monthly revenue trend for the entire rental store over time.

SELECT DATE_FORMAT(r.rental_date, '%Y-%m') AS rental_month, 
       SUM(p.amount) AS monthly_revenue
FROM rental r
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY rental_month
ORDER BY rental_month;

# 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

WITH CustomerSpending AS (
    SELECT c.customer_id, SUM(p.amount) AS total_spent
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
),
Percentile AS (
    SELECT PERCENT_RANK() OVER (ORDER BY total_spent DESC) AS percentile_rank, customer_id
    FROM CustomerSpending
)
SELECT cs.customer_id, cs.total_spent
FROM CustomerSpending cs
JOIN Percentile p ON cs.customer_id = p.customer_id
WHERE p.percentile_rank >= 0.8
ORDER BY cs.total_spent DESC;

# 8. Calculate the running total of rentals per category, ordered by rental count.

WITH CategoryRentalCounts AS (
    SELECT c.name AS category, COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.category_id
)
SELECT category, rental_count,
       SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM CategoryRentalCounts
ORDER BY rental_count DESC;

# 9. Find the films that have been rented less than the average rental count for their respective categories.

WITH CategoryRentalCounts AS (
    SELECT c.name AS category, f.title, COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY f.film_id, c.category_id
),
AvgCategoryRentalCount AS (
    SELECT category, AVG(rental_count) AS avg_rental_count
    FROM CategoryRentalCounts
    GROUP BY category
)
SELECT crc.title, crc.category, crc.rental_count
FROM CategoryRentalCounts crc
JOIN AvgCategoryRentalCount acrc ON crc.category = acrc.category
WHERE crc.rental_count < acrc.avg_rental_count;

# 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

SELECT DATE_FORMAT(r.rental_date, '%Y-%m') AS rental_month, 
       SUM(p.amount) AS monthly_revenue
FROM rental r
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY rental_month
ORDER BY monthly_revenue DESC
LIMIT 5;


# Normalisation & CTE

# 1. First Normal Form (1NF): Identify a table that violates 1NF:

# Ans 1 : The address table in the Sakila database violates 1NF if multiple phone numbers or secondary addresses are stored in a single field.
# Steps to Normalize to 1NF: Split the multi-valued fields like phone into separate rows or create a new table to handle such fields.
# Example of Normalized Design: Original address table (violating 1NF):

address_id | address       | phone
------------------------------------
1          | 123 Main St   | 555-1234, 555-5678
2          | 456 Elm St    | 555-4321


# 2. Second Normal Form (2NF): Determine if a table is in 2NF:

# Ans 2 : A table is in 2NF if it is in 1NF and all non-key attributes are fully dependent on the primary key.
# Example of a 2NF Violation: The film_category table:

film_id | category_id | category_name
--------------------------------------
1       | 1           | Action
2       | 1           | Action

# Steps to Normalize: Remove the partial dependency by separating category_name into a category table:

#film_category:

film_id | category_id
---------------------
1       | 1           
2       | 1

# category:

category_id | category_name
---------------------------
1           | Action


# 3. Third Normal Form (3NF): Identify a table that violates 3NF:

# Ans 3 : A table violates 3NF if it has transitive dependencies (non-key attributes depending on other non-key attributes).

# Example of a 3NF Violation: The customer table:

customer_id | address_id | city_name
-------------------------------------
1           | 101        | London
2           | 102        | Paris


# Steps to Normalize:

# 1. Move city_name to a city table: customer:

customer_id | address_id
------------------------
1           | 101        
2           | 102

# city:

address_id | city_name
----------------------
101        | London
102        | Paris


# 4. Normalization Process: Normalize a Table to 2NF: Take the film_actor table:

# Ans 4 : Original:

actor_id | film_id | actor_name | film_title
-------------------------------------------
1        | 1       | Tom Hanks | Forrest Gump
2        | 1       | Robin Wright | Forrest Gump


# Steps to Normalize:

# Split into two tables:

#actor:

actor_id | actor_name
---------------------
1        | Tom Hanks
2        | Robin Wright

# film_actor:

actor_id | film_id
------------------
1        | 1
2        | 1



# 5. CTE Basics: Retrieve the distinct list of actor names and the number of films they have acted in:

# Ans 5 :

WITH ActorFilms AS (
    SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
)
SELECT first_name, last_name, film_count
FROM ActorFilms;


# 6. CTE with Joins: Display film title, language name, and rental rate:

WITH FilmLanguage AS (
    SELECT f.title, l.name AS language_name, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT title, language_name, rental_rate
FROM FilmLanguage;


# 7. CTE for Aggregation: Find total revenue generated by each customer:

WITH CustomerRevenue AS (
    SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
)
SELECT customer_id, first_name, last_name, total_revenue
FROM CustomerRevenue
ORDER BY total_revenue DESC;


# 8. CTE with Window Functions: Rank films based on rental duration:

WITH FilmRanking AS (
    SELECT f.title, f.rental_duration,
           RANK() OVER (ORDER BY f.rental_duration DESC) AS rental_rank
    FROM film f
)
SELECT title, rental_duration, rental_rank
FROM FilmRanking;


# 9. CTE and Filtering: List customers who made more than two rentals and join with customer details:

WITH FrequentRenters AS (
    SELECT r.customer_id, COUNT(r.rental_id) AS rental_count
    FROM rental r
    GROUP BY r.customer_id
    HAVING rental_count > 2
)
SELECT c.customer_id, c.first_name, c.last_name, f.rental_count
FROM customer c
JOIN FrequentRenters f ON c.customer_id = f.customer_id;

























