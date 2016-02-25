CREATE SEQUENCE id_customer_seq;
CREATE TABLE Customer (
  id_customer INT PRIMARY KEY,
  email_address Varchar(50),
  customer_password Varchar(50),
  fname Varchar(50),
  lname Varchar(50),
  contact_number Varchar(50),
  address Varchar(50),
  postal_code Varchar(50),
  gender INT,
  birthdate Varchar(50),
  is_active BOOLEAN
);
ALTER SEQUENCE id_customer_seq OWNED BY Customer.id_customer;

CREATE SEQUENCE id_hotel_seq;
CREATE TABLE Hotel (
  hotel_id INT PRIMARY KEY,
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
ALTER SEQUENCE id_hotel_seq OWNED BY Hotel.hotel_id;

CREATE SEQUENCE id_personnel_seq;
CREATE TABLE Hotel_Personnel (
 id_personnel INT PRIMARY KEY,
 fname Varchar(50),
 mname Varchar(50),
 lname Varchar(50),
 personnel_password Varchar(50),
 is_active BOOLEAN,
 hotel_id INT REFERENCES Hotel(hotel_id)
);
ALTER SEQUENCE id_personnel_seq OWNED BY Hotel_Personnel.id_personnel;

CREATE SEQUENCE id_recipient_seq;
CREATE TABLE Message_recipient (
 id_msg_recipient INT PRIMARY KEY,
 is_read BOOLEAN,
 customer_id INT REFERENCES Customer (id_customer)
 id_hotel INT REFERENCES Customer (hotel_id)
);
ALTER SEQUENCE id_recipient_seq OWNED BY Message_recipient.id_msg_recipient;

CREATE SEQUENCE id_message_seq;
CREATE TABLE Message(
 id_message INT PRIMARY KEY,
 msg TEXT,
 timesent TIMESTAMP,
 msg_recipient_id INT REFERENCES Message_recipient (id_msg_recipient)
);
ALTER SEQUENCE id_message_seq OWNED BY Message.id_message;

CREATE SEQUENCE id_transaction_seq;
CREATE TABLE Online_Transaction (
 id_transaction INT PRIMARY KEY,
 transaction_number INT,
 date_of_transaction TIMESTAMP,
 downpayment INT,
 is_done BOOLEAN,
 hotel_id INT REFERENCES Hotel(hotel_id),
 customer_id INT REFERENCES Customer (id_customer)
);
ALTER SEQUENCE id_transaction_seq OWNED BY Online_Transaction.id_transaction;

CREATE SEQUENCE id_room_seq;
CREATE TABLE Room (
  id_room INT PRIMARY KEY,
  room_number Varchar(50),
  cost INT,
  available_room INT,
  hotel_id INT references Hotel(hotel_id)
);
ALTER SEQUENCE id_room_seq OWNED BY Room.id_room;

CREATE SEQUENCE id_type_seq;
CREATE TABLE Type (
  id_room_type INT PRIMARY KEY,
  room_type TEXT,
  room_id INT references Room(id_room)
);
ALTER SEQUENCE id_type_seq OWNED BY Type.id_room_type;

CREATE SEQUENCE id_feedback_seq;
CREATE TABLE Feedback (
  feedback_id INT PRIMARY KEY,
  comment TEXT,
  created_date TIMESTAMP,
  is_active BOOLEAN,
  hotel_id INT REFERENCES Hotel(hotel_id)
);
ALTER SEQUENCE id_feedback_seq OWNED BY Feedback.feedback_id;

CREATE SEQUENCE id_feature_seq;
CREATE TABLE Hotel_Features (
  hotel_features_id INT PRIMARY KEY,
  name Varchar(250),
  hotel_id INT REFERENCES Hotel(hotel_id)
);
ALTER SEQUENCE id_feature_seq OWNED BY Hotel_Features.hotel_features_id;

CREATE SEQUENCE id_list_seq;
CREATE TABLE Features_list (
  features_id INT PRIMARY KEY,
  name Varchar(250),
  hotel_features_id INT REFERENCES Hotel_Features(hotel_features_id)
);
ALTER SEQUENCE id_list_seq OWNED BY Features_list.features_id;

CREATE SEQUENCE id_rate_seq;
CREATE TABLE Rating (
  rating_id INT PRIMARY KEY,
  rate INT,
  Feedback_id INT REFERENCES Feedback(feedback_id)
);
ALTER SEQUENCE id_rate_seq OWNED BY Rating.rating_id;

CREATE SEQUENCE id_image_seq;
CREATE TABLE Image (
  image_id INT PRIMARY KEY,
  img Varchar(250),
  id_customer INT REFERENCES Customer(id_customer),
  hotel_id INT REFERENCES Hotel(hotel_id)
);
ALTER SEQUENCE id_rate_seq OWNED BY Image.image_id;

create or replace function newcustomer(par_email TEXT, par_password TEXT, par_fname TEXT, par_lname TEXT,
                                      par_contact TEXT, par_address TEXT, par_postal TEXT, par_gender INT,
                                      par_birthdate TEXT, par_is_active BOOLEAN) returns TEXT as
$$
  DECLARE
    loc_id INT;
    loc_res TEXT;
  BEGIN
    SELECT INTO loc_id id_customer FROM Customer WHERE email_address = par_email;
    if loc_id isnull THEN

      INSERT INTO Customer (email_address, customer_password, fname, lname, contact_number, address,
      postal_code, gender, birthdate, is_active) VALUES (par_id, par_email, par_password, par_fname, par_lname,
                                                  par_contact, par_address, par_postal, par_gender, par_birthdate, TRUE);
      loc_res = 'OK';

      ELSE
        loc_res = 'ID EXISTED';
      end if;
      return loc_res;
  END;
$$
  LANGUAGE 'plpgsql';

--select newcustomer (1, 'koneb2013@gmail.com', 'asdasd', 'Neiell Care', 'Paradiang', '09263555557', 'Iligan City', '9200', 1, 'AUGUST-20-1995', TRUE);

create or replace function getcustomer(OUT INT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT,
                                        OUT TEXT, OUT INT, OUT TEXT, OUT BOOLEAN) RETURNS SETOF RECORD AS
$$

  SELECT id_customer, email_address, customer_password, fname, lname, contact_number, address,
      postal_code, gender, birthdate, is_active FROM Customer;

$$
  LANGUAGE 'sql';

--select * from getcustomer();

create or replace function getcustomer_id(IN par_id INT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT,
                                        OUT TEXT, OUT INT, OUT TEXT, OUT BOOLEAN) RETURNS SETOF RECORD AS
$$

  SELECT email_address, customer_password, fname, lname, contact_number, address,
      postal_code, gender, birthdate, is_active FROM Customer WHERE id_customer = par_id;

$$
  LANGUAGE 'sql';

--select * from getcustomer_id(1);
