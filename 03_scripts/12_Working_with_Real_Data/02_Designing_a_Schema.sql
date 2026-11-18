-- SQL for Everyone: From Zero to Confident
-- Chapter 12: Working with Real Data
-- Lesson 12.2: Designing a Schema
-- Database: brewhouse (setup: 00_setup/brewhouse-setup)
-- Run it in your browser, nothing to install: https://www.codepion.com/exercises/udemy-sql-course/playground/designing-a-schema/
-- This lesson changes data. To start over: docker compose down -v, then docker compose up -d --wait

-- Instructors, with a unique email
CREATE TABLE instructors (
  instructor_id serial PRIMARY KEY,
  name text NOT NULL,
  email text UNIQUE NOT NULL);

-- Workshops, each with one instructor
CREATE TABLE workshops (
  workshop_id serial PRIMARY KEY,
  title text NOT NULL,
  instructor_id int NOT NULL REFERENCES instructors (instructor_id),
  starts_at timestamp NOT NULL,
  seats int NOT NULL CHECK (seats > 0),
  price numeric(6, 2) NOT NULL CHECK (price >= 0));

-- Attendees, and a link table for bookings
CREATE TABLE attendees (
  attendee_id serial PRIMARY KEY,
  name text NOT NULL,
  email text UNIQUE NOT NULL);
CREATE TABLE bookings (
  attendee_id int NOT NULL REFERENCES attendees (attendee_id),
  workshop_id int NOT NULL REFERENCES workshops (workshop_id),
  booked_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (attendee_id, workshop_id));

-- Insert some sample data
INSERT INTO instructors (name, email) VALUES ('Grace Hall', 'grace@brewhouse.test'), ('Marco Silva', 'marco@brewhouse.test');
INSERT INTO workshops (title, instructor_id, starts_at, seats, price)
VALUES ('Latte Art', 1, '2026-03-14 10:00', 8, 45), ('Home Roasting', 2, '2026-03-21 14:00', 6, 60);
INSERT INTO attendees (name, email)
VALUES ('Ava Moreau', 'ava@example.test'), ('Oscar Walker', 'oscar@example.test'), ('Zara Haddad', 'zara@example.test');
INSERT INTO bookings (attendee_id, workshop_id) VALUES (1, 1), (2, 1), (2, 2), (3, 2);

-- Free seats for each workshop: a join and a count
SELECT w.title, i.name AS instructor, COUNT(b.attendee_id) AS booked,
       w.seats - COUNT(b.attendee_id) AS free
FROM workshops w
JOIN instructors i ON i.instructor_id = w.instructor_id
LEFT JOIN bookings b ON b.workshop_id = w.workshop_id
GROUP BY w.workshop_id, i.name
ORDER BY w.workshop_id;

-- A booking for a workshop that does not exist: refused by the foreign key
INSERT INTO bookings (attendee_id, workshop_id) VALUES (1, 99);

-- A workshop with 0 seats: refused by the CHECK
INSERT INTO workshops (title, instructor_id, starts_at, seats, price)
VALUES ('Empty Room', 1, '2026-04-01 10:00', 0, 10);

-- A duplicate email: refused by UNIQUE
INSERT INTO attendees (name, email) VALUES ('Duplicate Ava', 'ava@example.test');

-- Deleting a workshop that has bookings: refused by the foreign key
DELETE FROM workshops WHERE workshop_id = 1;
