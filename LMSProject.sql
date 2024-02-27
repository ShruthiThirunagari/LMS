create schema lms;

create table library_member ( member_id integer primary key,
first_name varchar(25),
last_name varchar(25),
email_address varchar(35),
phone_number bigint,
membership_level varchar(10));

create table address ( address_id integer primary key,
line1 varchar(30),
line2 varchar(30),
city varchar(20),
state char(2),
zipcode integer);

create table checkout ( id integer primary key,
checkout_date datetime,
due_date datetime,
is_returned boolean);


create table book ( book_id integer primary key,
title varchar(45),
author_name varchar(50),
year_published integer,
quantity integer);

CREATE TABLE book_isbn (
    isbn bigint PRIMARY KEY,
    book_id integer,
    CONSTRAINT fk_book_id FOREIGN KEY (book_id) REFERENCES book(book_id)
);


ALTER TABLE library_member
ADD COLUMN address_id integer,
ADD CONSTRAINT address_id FOREIGN KEY (address_id) REFERENCES address(address_id);

ALTER TABLE checkout
ADD COLUMN isbn bigint,
ADD COLUMN member_id integer,
ADD CONSTRAINT isbn FOREIGN KEY (isbn) REFERENCES book_isbn(isbn),
ADD CONSTRAINT member_id FOREIGN KEY (member_id) REFERENCES library_member(member_id);

INSERT INTO address (address_id, line1, line2, city, state, zipcode)
VALUES
(1, '123 Main St', 'Apt 101', 'Anytown', 'NY', 12345),
(2, '456 Elm St', '', 'Sometown', 'CA', 54321),
(3, '789 Oak St', 'Unit B', 'Othertown', 'TX', 67890),
(4, '101 Pine St', 'Suite 200', 'Anothertown', 'FL', 98765),
(5, '202 Maple St', '', 'Lasttown', 'WA', 54321),
(6, '303 Cedar St', '', 'Newtown', 'MA', 13579);

INSERT INTO library_member (member_id, first_name, last_name, email_address, phone_number, membership_level, address_id)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 1234567890, 'Gold', 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 9876543210, 'Silver', 2),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', 5551234567, 'Bronze', 3),
(4, 'Emily', 'Brown', 'emily.brown@example.com', 9998887776, 'Gold', 4),
(5, 'David', 'Davis', 'david.davis@example.com', 1112223334, 'Silver', 5),
(6, 'Emma', 'Wilson', 'emma.wilson@example.com', 4445556668, 'Bronze', 6),
(7, 'Olivia', 'Martinez', 'olivia.martinez@example.com', 7778889991, 'Gold', 1),
(8, 'Daniel', 'Anderson', 'daniel.anderson@example.com', 2223334445, 'Silver', 2),
(9, 'Sophia', 'Taylor', 'sophia.taylor@example.com', 6667778882, 'Bronze', 3),
(10, 'William', 'White', 'william.white@example.com', 8889990003, 'Gold', 4);


INSERT INTO book (book_id, title, author_name, year_published, quantity)
VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 1960, 10),
(2, '1984', 'George Orwell', 1949, 15),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 12),
(4, 'Pride and Prejudice', 'Jane Austen', 1813, 8),
(5, 'The Catcher in the Rye', 'J.D. Salinger', 1951, 11),
(6, 'Harry Potter and the Philosopher\'s Stone', 'J.K. Rowling', 1997, 20);

INSERT INTO book_isbn (isbn, book_id)
VALUES
(9780061120084, 1),
(9780451524935, 2),
(9780743273565, 3),
(9780140434261, 4),
(9780316769488, 5),
(9780590353427, 6),
(9780061120085, 1),
(9780451524936, 2),
(9780743273566, 3),
(9780140434262, 4),
(9780316769489, 5),
(9780590353428, 6),
(9780061120086, 1),
(9780451524937, 2),
(9780743273567, 3),
(9780140434263, 4),
(9780316769490, 5),
(9780590353429, 6),
(9780061120087, 1),
(9780451524938, 2);

select * from library_member;

INSERT INTO checkout (id, checkout_date, due_date, is_returned, isbn, member_id)
VALUES
(1, '2024-02-26 10:00:00', '2024-03-25 10:00:00', false, 9780061120084, 1),
(2, '2024-02-26 11:30:00', '2024-03-26 11:30:00', false, 9780451524935, 2),
(3, '2024-02-27 09:45:00', '2024-03-27 09:45:00', false, 9780743273565, 3),
(4, '2024-02-28 14:20:00', '2024-03-28 14:20:00', false, 9780140434261, 4),
(5, '2024-02-28 16:50:00', '2024-03-29 16:50:00', false, 9780316769488, 5),
(6, '2024-02-29 10:15:00', '2024-03-30 10:15:00', false, 9780590353427, 6);

INSERT INTO library_member (member_id, first_name, last_name, email_address, phone_number, membership_level, address_id)
VALUES
(11, 'Grace', 'Lee', 'grace.lee@example.com', 1234567890, 'Gold', 2);


-- Finding Member by Name and Mobile Number
SELECT * FROM library_member WHERE first_name = 'John' AND phone_number = 1234567890;

SELECT * FROM library_member;

-- List All the Books a Member Has Checked Out
SELECT l.first_name, l.last_name, b.title
FROM library_member l
JOIN checkout c ON l.member_id = c.member_id
JOIN book_isbn bi ON c.isbn = bi.isbn
JOIN book b ON bi.book_id = b.book_id
WHERE l.member_id = 1; -- Change the member_id as needed

UPDATE checkout
SET checkout_date = NOW(),
    due_date = DATE_ADD(NOW(), INTERVAL 14 DAY),
    is_returned = false
WHERE isbn = 9780451524935 -- ISBN of the book being checked out
AND member_id = 2; -- Member ID of the member checking out the book

SELECT *,
       CASE 
           WHEN is_returned = 1 THEN 'true'
           ELSE 'false'
       END AS is_returned_status
FROM lms.checkout
WHERE isbn = 9780451524935
  AND member_id = 2;
  
  -- List Available Books and Quantity That Can Be Checked Out:
  SELECT b.title, b.quantity - IFNULL(COUNT(bi.isbn), 0) AS available_quantity
FROM book b
LEFT JOIN book_isbn bi ON b.book_id = bi.book_id
GROUP BY b.title, b.quantity;

INSERT INTO checkout (id, checkout_date, due_date, is_returned, isbn, member_id)
VALUES
(7, '2024-03-01 12:00:00', '2024-03-31 12:00:00', false, 9780061120085, 7),
(8, '2024-03-02 10:30:00', '2024-04-01 10:30:00', false, 9780451524936, 8),
(9, '2024-03-03 08:45:00', '2024-04-02 08:45:00', false, 9780743273566, 9),
(10, '2024-03-04 14:20:00', '2024-04-03 14:20:00', false, 9780140434262, 10);



SELECT *
FROM checkout
WHERE DATE(due_date) = DATE_ADD(CURDATE(), INTERVAL 2 DAY);

SELECT *
FROM checkout
WHERE due_date < CURDATE() AND is_returned = false;

SELECT *
FROM checkout
WHERE DATE(checkout_date) = CURDATE();

INSERT INTO book (book_id, title, author_name, year_published, quantity)
VALUES
(7, 'The Hobbit', 'J.R.R. Tolkien', 1937, 5);

SELECT b.*, bi.isbn, c.checkout_date, c.due_date, c.is_returned
FROM book b
JOIN book_isbn bi ON b.book_id = bi.book_id
LEFT JOIN checkout c ON bi.isbn = c.isbn;




