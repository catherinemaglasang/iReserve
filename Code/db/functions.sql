
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





create or replace function newHotel_Personnel( par_id_personnel varchar, par_fname varchar, par_mname varchar, par_lname varchar, par_personnel_password varchar, par_is_active BOOLEAN,
                                                Hotel.hotel_id INT) returns TEXT as
$$
    DECLARE
        loc_id_personnel TEXT;
        loc_res TEXT;
    BEGIN
    SELECT INTO loc_id_personnel id_personnel FROM Hotel_Personnel WHERE id_personnel = par_id_personnel;
    if loc_id_personnel isnull THEN

      INSERT INTO Hotel_Personnel (id_personnel, fname, mname, lname, personnel_password, is_active, Hotel.hotel_id) VALUES (par_id_personnel, par_fname, par_mname,
                                    par_lname, par_personnel_password, TRUE, Hotel.hotel_id);
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

  SELECT id_personnel, fname, mname, lname, personnel_password, is_active, Hotel.hotel_id FROM Hotel_Personnel;

$$
  LANGUAGE 'sql';

--select * from getHotel_Personnel();

create or replace function getid_personnel(OUT par_id_personnel TEXT, OUT TEXT, OUT TEXT, OUT TEXT, OUT TEXT, OUT BOOLEAN,
                                        OUT INT ) RETURNS SETOF RECORD AS
$$

  SELECT fname, mname, lname, customer_password, is_active, Hotel.hotel_id
     FROM Hotel_Personnel WHERE id_personnel = par_id_personnel;

$$
  LANGUAGE 'sql';

--select * from getid_personnel(1);

create or replace function newroom(par_room_number varchar, par_cost INT, par_room_type Varchar, par_hotel_id INT) returns TEXT as
$$
    DECLARE 
        loc_room_number TEXT;
        loc_res TEXT;
    BEGIN
    SELECT INTO loc_room_number par_room_number FROM Room WHERE room_number = par_room_number;
    if loc_room_number isnull THEN

      INSERT INTO ROOM (room_number,cost, room_type, hotel_id) VALUES
      (par_room_number, par_cost, par_room_type, par_hotel_id);
      loc_res = 'OK';

      ELSE
        loc_res = 'ID EXISTED';
      end if;
      return loc_res;
  END;
$$
  LANGUAGE 'plpgsql';


--select newroom('200', 2000, 'twin-bed', 1);

create or replace function getroom(OUT Int,OUT Varchar, OUT Int, OUT varchar, OUT INT) RETURNS SETOF RECORD AS

$$

  SELECT id_room, room_number, cost, room_type, hotel_id FROM Room;

$$
  LANGUAGE 'sql';

--select * from getRoom();

create or replace function getid_room(IN par_id_room Int, OUT varchar, OUT INT, OUT VARCHAR, OUT INT) RETURNS SETOF RECORD AS
$$

  SELECT room_number, cost, room_type, hotel_id 
     FROM Room WHERE id_room = par_id_room;

$$
  LANGUAGE 'sql';

--select * from getid_room(102);




--Transaction

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