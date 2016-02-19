CREATE TABLE Customer (
  id_customer INT,
  email_address VARCHAR,
  fname VARCHAR,
  lname VARCHAR,
  contact_number VARCHAR,
  address VARCHAR,
  postal_code VARCHAR,
  gender INT,
  birthdate VARCHAR,
  is_active BOOLEAN,

  PRIMARY KEY(id_customer)
);

CREATE TABLE Hotel (
  hotel_id INT,
  hotel_name VARCHAR,
  description TEXT,
  email_address VARCHAR,
  address VARCHAR,
  contact_number VARCHAR,
  google_map VARCHAR,
  no_of_restaurant INT,
  no_of_rooms INT,
  extra TEXT,
  is_active BOOLEAN,
);