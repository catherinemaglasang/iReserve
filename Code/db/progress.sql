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

CREATE TABLE Room (
  id_room INT,
  room_number VARCHAR,
  cost INT,
  available_room INT,
  hotel_id INT references Hotel(hotel_id),
)

CREATE TABLE Type (
  id_room_type INT,
  room_type VARCHAR,
  room_id INT references Room(id_room),
)