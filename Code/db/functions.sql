

-- CUSTOMER

create or replace function newcustomer(par_email varchar, par_password varchar, par_fname varchar, par_lname varchar,
                                      par_gender INT, par_contact varchar, par_birthdate varchar, par_address varchar, par_postal varchar
                                      ) returns TEXT as
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

--select newcustomer ('koneb2013@gmail.com', 'asdasd', 'Neiell Care', 'Paradiang', '09263555557', 'Iligan City', '9200', 1, 'AUGUST-20-1995');

create or replace function getcustomer(OUT INT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT,
                                        OUT TEXT, OUT INT, OUT TEXT, OUT BOOLEAN) RETURNS SETOF RECORD AS\
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




--HOTEL


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



--IMAGE


create or replace function newimage(par_img Varchar, par_customerid Int, par_hotelid Int) returns Text as
  $$
    DECLARE
      loc_img Varchar;
      loc_res Text;

    BEGIN
      SELECT INTO loc_img img FROM Image WHERE img = par_img;
    if loc_img isnull THEN

      INSERT INTO Image (img, id_customer, hotel_id) 
        VALUES (par_img, par_customerid, par_hotelid)
                                                  
      loc_res = 'OK';

      ELSE
        loc_res = 'ID EXISTED';
      end if;
      return loc_res;
  END;
$$
  LANGUAGE 'plpgsql';

      

create or replace function getimage(OUT INT, OUT VARCHAR, OUT INT, OUT INT) RETURNS SETOF RECORD AS
$$

  SELECT image_id, img, id_customer, hotel_id FROM Image;

$$
  LANGUAGE 'sql';


create or replace function getimage_id(IN par_id INT, OUT VARCHAR, OUT INT, OUT INT) RETURNS SETOF RECORD AS
$$

  SELECT img, id_customer, hotel_id FROM Image WHERE image_id = par_id;

$$
  LANGUAGE 'sql';


--Hotel Features


create or replace function newhotelfeature(par_name Varchar, par_hotelid Int) returns Text as
  $$
    DECLARE
      loc_name Varchar;
      loc_res Text;

    BEGIN
      SELECT INTO loc_name name FROM Hotel_Features WHERE name = par_name;
    if loc_name isnull THEN

      INSERT INTO Hotel_Features (name, hotel_id) 
        VALUES (par_name,par_hotelid)
                                                  
      loc_res = 'OK';

      ELSE
        loc_res = 'ID EXISTED';
      end if;
      return loc_res;
  END;
$$
  LANGUAGE 'plpgsql';


create or replace function getfeature(OUT INT, OUT VARCHAR, OUT INT) RETURNS SETOF RECORD AS
  $$
    SELECT hotel_features_id, name, hotel_id FROM Hotel_Features AND Hotel;

$$
  LANGUAGE 'sql';


create or replace function getfeature_id(IN par_id INT, OUT VARCHAR, OUT INT) RETURNS SETOF RECORD AS
$$

  SELECT name, hotel_id FROM Image WHERE hotel_features_id = par_id;

$$
  LANGUAGE 'sql';

--Feature List


create or replace function newsubfeature(par_name Varchar, par_hotelfeaturesid Int) returns Text as
  $$
    DECLARE
      loc_name Varchar;
      loc_res Text;

    BEGIN
      SELECT INTO loc_name name FROM Feature_list WHERE name = par_name;
    if loc_name isnull THEN

      INSERT INTO Feature_list (name, hotel_features_id) 
        VALUES (par_name, par_hotelfeaturessid)
                                                  
      loc_res = 'OK';

      ELSE
        loc_res = 'ID EXISTED';
      end if;
      return loc_res;
  END;
$$
  LANGUAGE 'plpgsql';


create or replace function getsubfeature(OUT INT, OUT VARCHAR, OUT INT) RETURNS SETOF RECORD AS
  $$
    SELECT features_id, name, hotel_features_id from Feature_list AND Hotel_features;
  $$
    LANGUAGE 'sql';

create or replace function getsubfeature_id(IN par_id INT, OUT VARCHAR, OUT INT) RETURNS SETOF RECORD AS
$$

  SELECT name, hotel_features_id FROM Features_list WHERE features_id = par_id;

$$
  LANGUAGE 'sql';


  
-- Feedback


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

create or replace function getfeedback_id(IN par_feedback_id INT, OUT TEXT, OUT TIMESTAMP, OUT BOOLEAN, OUT INT) RETURNS SETOF RECORD AS
$$
  SELECT comment, created_date, is_active, hotel_id FROM Feedback WHERE feedback_id = par_feedback_id;
$$
  LANGUAGE 'sql';

create or replace function deletefeedback(par_feedback_id INT, par_comment TEXT, par_created_date TIMESTAMP, par_is_active BOOLEAN, par_hotel_id INT) returns TEXT AS
$$
  DELETE FROM Feedback WHERE feedback_id IN (SELECT feedback_id FROM Feedback WHERE feedback_id = par_feedback_id);
$$
  LANGUAGE 'sql';



--Rating

create or replace function newrating(par_rating_id INT, rate INT, feedback_id INT) returns TEXT AS
$$
  DECLARE
    loc_id INT;
    loc_res TEXT;
  BEGIN
    SELECT INTO loc_id rating_id FROM Rating WHERE rating_id = par_rating_id;
    if loc_id isnull THEN

      INSERT INTO Rating(rating_id, rate, feedback_id) VALUES (par_rating_id, par_rate, par_feedback_id);
      loc_res = 'OK';

      ELSE
      loc_res = 'ID EXISTED';
      end if;
      return loc_res;

  END;
$$
  LANGUAGE 'plpgsql';

create or replace function getrating(OUT INT, OUT INT, OUT INT) RETURNS SETOF RECORD AS
$$
  SELECT rating_id, rate, Feedback_id FROM Rating;
$$
  LANGUAGE 'sql';


--Hotel Personnel

create or replace function newHotel_Personnel( par_fname varchar, par_mname varchar, par_lname varchar, par_personnel_password varchar, par_is_active BOOLEAN,
                                                par_hotel_id INT) returns TEXT as
$$
    DECLARE
        loc_fname TEXT;
        loc_mname TEXT;
        loc_lname TEXT;
        loc_res TEXT;

    BEGIN
    SELECT INTO loc_fname fname, loc_mname fname, loc_lname lname FROM Hotel_Personnel WHERE fname = par_fname, mname = par_mname, lname = par_fname;
    if loc_fname, loc_mname, loc_lname isnull THEN

      INSERT INTO Hotel_Personnel (fname, mname, lname, personnel_password, is_active, par_hotel_id) VALUES (par_fname, par_mname,
                                    par_lname, par_personnel_password, TRUE, par_hotel_id);
      loc_res = 'OK';

      ELSE
        loc_res = 'Personnel ID EXISTED';
      end if;
      return loc_res;
  END;
$$
  LANGUAGE 'plpgsql';

--select newHotel_Personnel (1, 'Marjorie', 'Galabin', 'Buctolan', 'gwapa', 'TRUE', 1);

create or replace function getHotel_Personnel(OUT INT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT, OUT BOOLEAN, OUT INT) RETURNS SETOF RECORD AS

$$

  SELECT id_personnel, fname, mname, lname, personnel_password, is_active, hotel_id FROM Hotel_Personnel;

$$
  LANGUAGE 'sql';

--select * from getHotel_Personnel();

create or replace function getid_personnel( IN par_id INT, OUT fname TEXT, OUT mname TEXT, OUT lname TEXT, OUT TEXT, OUT BOOLEAN,
                                        OUT INT ) RETURNS SETOF RECORD AS
$$

  SELECT fname, mname, lname, personnel_password, is_active, hotel_id
     FROM Hotel_Personnel WHERE id_personnel = par_id;

$$
  LANGUAGE 'sql';

--select * from getid_personnel(1);


-- Room

create or replace function newRoom( par_room_number varchar, par_cost INT, par_available_room INT, par_hotel_id INT) returns TEXT as
$$
    DECLARE 
        loc_room_number TEXT;
        loc_res TEXT;
    BEGIN
    SELECT INTO loc_room_number room_number FROM Room WHERE room_number = par_room_number;
    if loc_room_number isnull THEN

      INSERT INTO ROOM (room_number,cost, available_room, hotel_id); VALUES (par_room_number, par_cost,
                                    par_available_room, par_hotel_id);
      loc_res = 'OK';

      ELSE
        loc_res = 'ROOM ID EXISTED';
      end if;
      return loc_res;
  END;
$$
  LANGUAGE 'plpgsql';

--select newRoom ('102', '102A', 1000, 5, 1);

create or replace function getRoom( OUT INT, OUT INT, OUT INT, OUT INT, OUT INT) RETURNS SETOF RECORD AS

$$

  SELECT id_room, room_number, cost, available_room, hotel_id FROM Room;

$$
  LANGUAGE 'sql';

--select * from getRoom();

create or replace function getid_room(IN par_id_room TEXT, OUT TEXT, OUT INT, OUT INT, OUT INT) RETURNS SETOF RECORD AS
$$

  SELECT room_number, cost, available_room, par_hotel_id
     FROM Room WHERE id_room = par_id_room;

$$
  LANGUAGE 'sql';

--select * from getid_room(102);

create or replace function newType(par_id_room_type varchar, par_room_type varchar, Room.id_room INT) return TEXT as
$$ 
    DECLARE
        loc_id_room_type TEXT;
        loc_res TEXT;
    BEGIN
    SELECT INTO loc_id_room_type id_room_type FROM Room WHERE id_room_type = par_id_room_type;
    if loc_id_room_tpye isnull THEN

      INSERT INTO Type (id_room_type, room_type, Room.id_room);
      loc_res = 'OK';

      ELSE
        loc_res = 'ROOM TYPE ID EXISTED';
      end if;
      return loc_res;
  END;
$$
  LANGUAGE 'plpgsql';

--select newType ('1A-1', 'single',102);

create or replace function getType(OUT TEXT, OUT TEXT, OUT INT) RETURNS SETOF RECORD AS

$$

  SELECT id_room_type, room_type, Room.id_room FROM Type;

$$
  LANGUAGE 'sql';

--select * from getType();

create or replace function getid_room_type(IN par_id_room_type TEXT, OUT TEXT, OUT INT) RETURNS SETOF RECORD AS
$$

  SELECT room_type, Room.id_room
     FROM Type WHERE id_room_type = par_id_room_type;

$$
  LANGUAGE 'sql';

--select * from getid_room_type(1A-1);


--Online Transaction

create or replace function newtransaction(par_transaction_number Int, par_date Timestamp, par_downpayment Int, 
                                          par_hotel_id Int, par_customer_id Int) returns Text as 
$$
  DECLARE
    loc_transaction_number Int;
    loc_res Text;

  BEGIN
  SELECT INTO loc_transaction_number transaction_number FROM Online_Transaction WHERE transaction_number = par_transaction_number;
  if loc_transaction_number isnull THEN

    INSERT INTO Online_Transaction(transaction_number, date_of_transaction, downpayment, is_done, hotel_id, customer_id)
        VALUES(par_transaction_number, par_date, par_downpayment, TRUE, par_hotel_id, par_customer_id );
        loc_res ='OK';

    ELSE
    loc_res = "Transaction exist";
    end if;
     return loc_res

  END;
  $$

  LANGUAGE 'plpgsql';




create or replace function gettransaction(OUT INT, OUT INT, OUT Timestamp,OUT INT, OUT BOOLEAN, OUT INT, OUT INT) RETURNS SETOF RECORD AS
  $$
    SELECT id_transaction, transaction_number, date_of_transaction, downpayment, is_done, hotel_id, customer_id FROM Online_transaction

  $$
    LANGUAGE 'sql';


create or replace function gettransaction_id(IN par_id INT, OUT INT, OUT Timestamp,OUT INT, OUT BOOLEAN, OUT INT, OUT INT) RETURNS SETOF RECORD AS
  $$
    SELECT  transaction_number, date_of_transaction, downpayment, is_done, hotel_id, customer_id FROM Online_transaction WHERE id_transaction = par_id

  $$
    LANGUAGE 'sql';