
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
  is_active BOOLEAN
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
 hotel_id INT REFERENCES Hotel(hotel_id)
);

CREATE TABLE Message_recipient (
 id_msg_recipient SERIAL PRIMARY KEY,
 is_read BOOLEAN,
 customer_id INT REFERENCES Customer (id_customer),
 id_hotel INT REFERENCES Hotel (hotel_id)
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
 hotel_id INT REFERENCES Hotel(hotel_id),
 customer_id INT REFERENCES Customer (id_customer)
);

CREATE TABLE Room (
  id_room SERIAL PRIMARY KEY,
  room_number Varchar(50),
  cost INT,
  available_room INT,
  hotel_id INT references Hotel(hotel_id)
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
  hotel_id INT REFERENCES Hotel(hotel_id)
);

CREATE TABLE Hotel_Features (
  hotel_features_id SERIAL PRIMARY KEY,
  name Varchar(250),
  hotel_id INT REFERENCES Hotel(hotel_id)
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
  hotel_id INT REFERENCES Hotel(hotel_id)
);

create or replace function newcustomer(par_email varchar, par_password varchar, par_fname varchar, par_lname varchar,
                                      par_contact varchar, par_address varchar, par_postal varchar, par_gender INT,
                                      par_birthdate varchar) returns TEXT as
$$
  DECLARE
    loc_email VARCHAR;
    loc_res TEXT;
  BEGIN
    SELECT INTO loc_email email_address FROM Customer WHERE email_address = par_email;
    if loc_email isnull THEN

      INSERT INTO Customer (email_address, customer_password, fname, lname, contact_number, address,
      postal_code, gender, birthdate, is_active) VALUES (par_email, par_password, par_fname, par_lname,
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



create or replace function newhotel(par_hotelname varchar, par_description TEXT, par_email varchar, par_address varchar,
                                      par_contact varchar, par_googlemap varchar, par_no_ofrestaurant INT, par_no_ofrooms INT,
                                      par_extra TEXT) returns TEXT as
$$
  DECLARE
    loc_email VARCHAR;
    loc_res TEXT;
  BEGIN
    SELECT INTO loc_email email_address FROM Hotel WHERE email_address = par_email;
    if loc_email isnull THEN

      INSERT INTO Hotel (hotel_name, description, email_address, address, contact_number, google_map,
      no_of_restaurant, no_of_rooms, extra, is_active) VALUES (par_hotelname, par_description, par_email, par_address,
                                                  par_contact, par_googlemap, par_no_ofrestaurant, par_no_ofrooms, par_extra, TRUE);
      loc_res = 'OK';

      ELSE
        loc_res = 'ID EXISTED';
      end if;
      return loc_res;
  END;
$$
  LANGUAGE 'plpgsql';



create or replace function gethotel(OUT INT, OUT VARCHAR, OUT TEXT, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR,
                                        OUT INT, OUT INT, OUT TEXT, OUT BOOLEAN) RETURNS SETOF RECORD AS
$$

  SELECT id_hotel, hotel_name, description, email_address, address, contact_number, google_map,
      no_of_restaurant, no_of_rooms, extra, is_active FROM Hotel;

$$
  LANGUAGE 'sql';


create or replace function gethotel_id(IN par_id INT, OUT VARCHAR, OUT TEXT, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR,
                                        OUT INT, OUT INT, OUT TEXT, OUT BOOLEAN) RETURNS SETOF RECORD AS
$$

  SELECT hotel_name, description, email_address, address, contact_number, no_of_restaurant,
      no_of_rooms, extra, is_active FROM Hotel WHERE id_hotel = par_id;

$$
  LANGUAGE 'sql';


create or replace function newfeedback(par_feedback_id INT, par_comment TEXT, par_created_date TIMESTAMP, par_is_active BOOLEAN, par_hotel_id INT) returns TEXT AS
$$
  DECLARE
    loc_id INT;
    loc_res TEXT;
  BEGIN
    SELECT INTO loc_id feedback_id FROM Feedback WHERE feedback_id = par_feedback_id;
    if loc_id isnull THEN

      INSERT INTO Feedback(feedback_id, comment, created_date, is_active, hotel_id) VALUES (par_feedback_id, par_comment, par_created_date, TRUE, par_hotel_id);

      loc_res = 'OK';

      ELSE
        loc_res = 'ID EXISTED';
      end if;
      return loc_res;
  END;
$$
  LANGUAGE 'plpgsql';

create or replace function getfeedback(OUT INT, OUT TEXT, OUT TIMESTAMP, OUT BOOLEAN, OUT INT) RETURNS SETOF RECORD AS
$$
  SELECT feedback_id, comment, created_date, is_active, hotel_id FROM Feedback;
$$
  LANGUAGE 'sql';