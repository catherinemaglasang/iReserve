CREATE TABLE Customer (
  id_customer SERIAL PRIMARY KEY,
  email_address Varchar(50) UNIQUE ,
  customer_password Varchar(50),
  fname Varchar(50),
  lname Varchar(50),
  contact_number Varchar(50),
  address Varchar(50),
  postal_code Varchar(50),
  gender INT,
  birthdate Varchar(50),
  is_active BOOLEAN DEFAULT FALSE
);


CREATE TABLE Hotel (
  id_hotel SERIAL PRIMARY KEY,
  hotel_name Varchar(50),
  description TEXT,
  email_address Varchar(50),
  address Varchar(250),
  contact_number Varchar(50),
  google_map Varchar(255),
  no_of_restaurant INT,
  no_of_rooms INT,
  extra TEXT,
  is_active BOOLEAN
);


CREATE TABLE Hotel_Personnel (
 id_personnel SERIAL PRIMARY KEY,
 fname Varchar(50),
 mname Varchar(50),
 lname Varchar(50),
 personnel_password Varchar(50),
 is_active BOOLEAN,
 hotel_id INT REFERENCES Hotel(id_hotel)
);

CREATE TABLE Message_recipient (
 id_msg_recipient SERIAL PRIMARY KEY,
 is_read BOOLEAN,
 customer_id INT REFERENCES Customer (id_customer),
 id_hotel INT REFERENCES Hotel (id_hotel)
);

CREATE TABLE Message(
 id_message SERIAL PRIMARY KEY,
 msg TEXT,
 timesent TIMESTAMP,
 msg_recipient_id INT REFERENCES Message_recipient (id_msg_recipient)
);

CREATE TABLE Online_Transaction (
 id_transaction SERIAL PRIMARY KEY,
 transaction_number INT,
 date_of_transaction TIMESTAMP,
 downpayment INT,
 is_done BOOLEAN,
 hotel_id INT REFERENCES Hotel(id_hotel),
 customer_id INT REFERENCES Customer (id_customer)
);

CREATE TABLE Room (
  id_room SERIAL PRIMARY KEY,
  room_number Varchar(50),
  cost INT,
  available_room INT,
  hotel_id INT references Hotel(id_hotel)
);

CREATE TABLE Type (
  id_room_type SERIAL PRIMARY KEY,
  room_type TEXT,
  room_id INT references Room(id_room)
);

CREATE TABLE Feedback (
  feedback_id SERIAL PRIMARY KEY,
  comment TEXT,
  created_date TIMESTAMP,
  is_active BOOLEAN,
  hotel_id INT REFERENCES Hotel(id_hotel)
);

CREATE TABLE Hotel_Features (
  hotel_features_id SERIAL PRIMARY KEY,
  name Varchar(250),
  hotel_id INT REFERENCES Hotel(id_hotel)
);

CREATE TABLE Features_list (
  features_id SERIAL PRIMARY KEY,
  name Varchar(250),
  hotel_features_id INT REFERENCES Hotel_Features(hotel_features_id)
);

CREATE TABLE Rating (
  rating_id SERIAL PRIMARY KEY,
  rate INT,
  Feedback_id INT REFERENCES Feedback(feedback_id)
);

CREATE TABLE Image (
  image_id SERIAL PRIMARY KEY,
  img Varchar(250),
  id_customer INT REFERENCES Customer(id_customer),
  hotel_id INT REFERENCES Hotel(id_hotel)
);
