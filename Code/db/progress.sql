CREATE TABLE Customer (
  id_customer INT PRIMARY KEY,
  email_address TEXT,
  customer_password TEXT,
  fname TEXT,
  lname TEXT,
  contact_number TEXT,
  address TEXT,
  postal_code TEXT,
  gender INT,
  birthdate TEXT,
  is_active BOOLEAN
);

CREATE TABLE Hotel (
  hotel_id INT PRIMARY KEY,
  hotel_name TEXT,
  description TEXT,
  email_address TEXT,
  address TEXT,
  contact_number TEXT,
  google_map TEXT,
  no_of_restaurant INT,
  no_of_rooms INT,
  extra TEXT,
  is_active BOOLEAN
);

CREATE TABLE Hotel_Personnel (
 id_personnel INT PRIMARY KEY,
 fname TEXT,
 mname TEXT,
 lname TEXT,
 personnel_password TEXT,
 is_active BOOLEAN,
 hotel_id INT REFERENCES Hotel(hotel_id)
);

CREATE TABLE Message_recipient (
 id_msg_recipient INT PRIMARY KEY,
 is_read BOOLEAN,
 customer_id INT REFERENCES Customer (id_customer)
);

CREATE TABLE Message(
 id_message INT PRIMARY KEY,
 msg TEXT,
 timesent TIMESTAMP,
 msg_recipient_id INT REFERENCES Message_recipient (id_msg_recipient)
);

CREATE TABLE Online_Transaction (
 id_transaction INT PRIMARY KEY,
 transaction_number INT,
 date_of_transaction TIMESTAMP,
 downpayment TEXT,
 is_done BOOLEAN,
 hotel_id INT REFERENCES Hotel(hotel_id),
 customer_id INT REFERENCES Customer (id_customer)
);


CREATE TABLE Room (
  id_room INT PRIMARY KEY,
  room_number TEXT,
  cost INT,
  available_room INT,
  hotel_id INT references Hotel(hotel_id)
);

CREATE TABLE Type (
  id_room_type INT PRIMARY KEY,
  room_type TEXT,
  room_id INT references Room(id_room)
);

CREATE TABLE Feedback (
  feedback_id INT PRIMARY KEY,
  comment TEXT,
  created_date TIMESTAMP,
  is_active BOOLEAN,
  hotel_id INT REFERENCES Hotel(hotel_id)
);

CREATE TABLE Hotel_Features (
  hotel_features_id INT PRIMARY KEY,
  name TEXT,
  hotel_id INT REFERENCES Hotel(hotel_id)
);

CREATE TABLE Features_list (
  features_id INT PRIMARY KEY,
  name TEXT,
  hotel_features_id INT REFERENCES Hotel_Features(hotel_features_id)
);

CREATE TABLE Rating (
  rating_id INT PRIMARY KEY,
  rate INT,
  Feedback_id INT REFERENCES Feedback(feedback_id)
);

CREATE TABLE Image (
  image_id INT PRIMARY KEY,
  img TEXT,
  id_customer INT REFERENCES Customer(id_customer),
  hotel_id INT REFERENCES Hotel(hotel_id)
);

create or replace function newcustomer(par_id INT, par_email TEXT, par_password TEXT, par_fname TEXT, par_lname TEXT,
                                      par_contact TEXT, par_address TEXT, par_postal TEXT, par_gender INT,
                                      par_birthdate TEXT, par_is_active BOOLEAN) returns TEXT as
$$
  DECLARE
    loc_id INT;
    loc_res TEXT;
  BEGIN
    SELECT INTO loc_id id_customer FROM Customer WHERE id_customer = par_id;
    if loc_id isnull THEN

      INSERT INTO Customer (id_customer, email_address, customer_password, fname, lname, contact_number, address,
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

