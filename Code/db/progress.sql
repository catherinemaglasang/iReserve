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

CREATE TABLE Message(
 id_message INT PRIMARY KEY,
 msg TEXT,
 timesent DATETIME,
 msg_recipient_id INT REFERENCES Message_recipient (id_msg_recipient)

);

CREATE TABLE Transaction (
 id_transaction INT PRIMARY KEY,
 transaction_number INT,
 date_of_transaction DATETIME,
 downpayment VARCHAR,
 is_done BOOLEAN,
 hotel_id INT REFERENCES Hotel(hotel_id),
 customer_id INT REFERENCES Customer (id_customer),

);

