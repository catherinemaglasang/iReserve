CREATE TABLE Customer (
  id_customer INT PRIMARY KEY,
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

CREATE TABLE Hotel_Personnel (
 id_personnel INT PRIMARY KEY,
 fname VARCHAR,
 mname VARCHAR,
 lname VARCHAR,
 password VARCHAR,
 is_active BOOLEAN,
 hotel_id INT REFERENCES Hotel(hotel_id),

);


CREATE TABLE Message_recipient (
 id_msg_recipient INT PRIMARY KEY,
 is_read BOOLEAN,
 customer_id INT REFERENCES Customer (id_customer)

);



