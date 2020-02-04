DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE customers;
DROP TABLE films;
-- DROP TABLE screens;

CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255)
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  funds DECIMAL(2)
);

-- CREATE TABLE screens (
--   id SERIAL PRIMARY KEY,
--   capacity INT,
--   2d_standard BOOLEAN,
--   2d_imax BOOLEAN,
--   3d_standard BOOLEAN,
--   3d_imax BOOLEAN,
-- );

CREATE TABLE screenings (
  id SERIAL PRIMARY KEY,
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
  -- screen INT REFERENCES screens(id) ON DELETE CASCADE,
  -- type
  tickets_available INT,
  showing VARCHAR,
  day VARCHAR,
  type VARCHAR,
  price DECIMAL(2)
);

-- film_id changed to screening_id
CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
-- do I actually need ON DELETE CASCADE?
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  screening_id INT REFERENCES screenings(id) ON DELETE CASCADE
);
