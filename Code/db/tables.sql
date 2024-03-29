
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
 email_address varchar(50) UNIQUE,
 fname Varchar(50),
 mname Varchar(50),
 lname Varchar(50),
 personnel_password Varchar(50),
 is_active BOOLEAN,
 hotel_id INT REFERENCES Hotel(id_hotel)
);


CREATE TABLE Transaction (
  id_transaction      SERIAL PRIMARY KEY,
  transaction_number  INT,
  date_of_transaction TIMESTAMP,
  fee                 INT,
  is_done             BOOLEAN,
  hotel_id            INT REFERENCES Hotel (id_hotel),
  room_id             INT REFERENCES Room (id_room)
);
 

CREATE TABLE Room (
  id_room SERIAL PRIMARY KEY,
  room_number Varchar(50),
  cost INT,
  room_type Varchar(50),
  hotel_id INT references Hotel(id_hotel)
);

CREATE TABLE Feedback (
  feedback_id SERIAL PRIMARY KEY,
  name Varchar(50),
  comment TEXT,
  created_date TIMESTAMP,
  is_active BOOLEAN,
  hotel_id INT REFERENCES Hotel(id_hotel)
);

CREATE TABLE Image (
  id_image  SERIAL PRIMARY KEY,
  img VARCHAR(100),
  hotel_id  INT REFERENCES Hotel (id_hotel)
);

CREATE TABLE Hotel_features (
  id_hotel_features SERIAL PRIMARY KEY,
  name VARCHAR(100),
  hotel_id  INT REFERENCES Hotel (id_hotel)
);

CREATE TABLE Hotel_features_list (
  id_hotel_features_list SERIAL PRIMARY KEY,
  name VARCHAR(100),
  hotel_features INT REFERENCES Hotel_features (id_hotel_features)
);

CREATE TABLE Visited (
  id_visited  SERIAL PRIMARY KEY,
  count INT,
  hotel_id INT REFERENCES Hotel (id_hotel)
);
