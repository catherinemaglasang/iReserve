CREATE TABLE Customer (
  id_customer INT,
  email_address VARCHAR,
  fname VARCHAR,
  lname VARCHAR,
  contact_number VARCHAR,
  address VARCHAR,
  postal_code VARCHAR,
  gender BOOLEAN,
  birthdate VARCHAR,
  is_active BOOLEAN,

  PRIMARY KEY(id_customer)
);