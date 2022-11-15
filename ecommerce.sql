CREATE ROLE ecommerce WITH LOGIN ENCRYPTED PASSWORD 'ecommerce';
CREATE ROLE ecommerce_admin WITH LOGIN ENCRYPTED PASSWORD '234567';
CREATE ROLE ecommerce_client WITH LOGIN ENCRYPTED PASSWORD '345678';
CREATE ROLE ecommerce_guest WITH LOGIN ENCRYPTED PASSWORD '456789';


CREATE DATABASE ecommerce
WITH
OWNER = ecommerce
ENCODING = 'UTF8'
TABLESPACE = pg_default
CONNECTION LIMIT = -1;


CREATE TABLE categories (
id bigserial NOT NULL,
published integer NOT NULL DEFAULT '0',
name varchar (255) NOT NULL,
icon varchar (255) NOT NULL,
created_at timestamp without time zone DEFAULT now(),
updated_at timestamp without time zone DEFAULT now(),
CONSTRAINT categories_pkey PRIMARY KEY (id)
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.categories OWNER TO ecommerce;



CREATE TABLE products (
id bigserial NOT NULL,
published integer NOT NULL DEFAULT '0',
rating_cache double precision NOT NULL DEFAULT '3.0',
rating_count integer NOT NULL DEFAULT '0',
category_id bigint NOT NULL,
name varchar (255) NOT NULL,
pricing double precision NOT NULL DEFAULT '0.00',
short_description varchar (255) NOT NULL,
long_description text NOT NULL,
icon varchar (255) NOT NULL,
created_at timestamp without time zone DEFAULT now (),
updated_at timestamp without time zone DEFAULT now (),
CONSTRAINT products_pkey PRIMARY KEY (id),
CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id)
REFERENCES public.categories (id) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.products OWNER TO ecommerce;


CREATE TABLE users (
id bigserial NOT NULL,
user_type integer NOT NULL DEFAULT '0',
username varchar (128) NOT NULL,
email varchar (128) NOT NULL,
password varchar (128) NOT NULL,
created_at timestamp without time zone DEFAULT now(),
updated_at timestamp without time zone DEFAULT now(),
CONSTRAINT users_pkey PRIMARY KEY (id)
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.users OWNER TO ecommerce;


CREATE TABLE reviews (
id bigserial NOT NULL,
product_id bigint NOT NULL,
user_id bigint NOT NULL,
rating double precision NOT NULL,
comment text NOT NULL,
approved integer NOT NULL DEFAULT '1',
spam integer NOT NULL DEFAULT '0',
created_at timestamp without time zone DEFAULT now (),
updated_at timestamp without time zone DEFAULT now (),
CONSTRAINT reviews_pkey PRIMARY KEY (id)
)
WITH (
OIDS=FALSE
);
ALTER TABLE public.reviews OWNER TO ecommerce;


INSERT INTO categories ("published", "name", "icon") VALUES
(1, 'Category One', 'category01.jpg'),
(1, 'Category Two', 'category02.jpg'),
(1, 'Category Three', 'category03.jpg'),
(1, 'Category Four', 'category04.jpg'),
(1, 'Category Five', 'category05.jpg');


INSERT INTO products ("published", "rating_cache", "rating_count", "category_id",
"name", "pricing", "short_description", "long_description", "icon") VALUES
(1, 3.0, 0, 1, 'First product', 20.99, 'Short description', 'Lorem ips ...',
'product01.jpg'),
(1, 3.0, 0, 1, 'Second product', 55.00, 'Short description', 'Lorem ips ...',
'product02.jpg'),
(1, 3.0, 0, 1, 'Third product', 65.00, 'Short description', 'Lorem ips ...',
'product03.jpg'),
(1, 3.0, 0, 1, 'Fourth product', 85.00, 'Short description', 'Lorem ips ...',
'product04.jpg'),
(1, 3.0, 0, 1, 'Fifth product', 95.00, 'Short description', 'Lorem ips ...',
'product05.jpg'),
(1, 3.0, 0, 2, 'Product 06', 35.00, 'Short description', 'Lorem ips ...',
'product06.jpg'),
(1, 3.0, 0, 2, 'Product 07', 45.00, 'Short description', 'Lorem ips ...',
'product07.jpg'),
(1, 3.0, 0, 3, 'Product 08', 52.00, 'Short description', 'Lorem ips ...',
'product08.jpg'),
(1, 3.0, 0, 3, 'Product 09', 62.00, 'Short description', 'Lorem ips ...',
'product09.jpg'),
(1, 3.0, 0, 4, 'Product 10', 14.00, 'Short description', 'Lorem ips ...',
'product10.jpg'),
(1, 3.0, 0, 4, 'Product 11', 18.00, 'Short description', 'Lorem ips ...',
'product11.jpg'),
(1, 3.0, 0, 5, 'Product 12', 40.00, 'Short description', 'Lorem ips ...',
'product12.jpg'),
(1, 3.0, 0, 5, 'Product 13', 44.00, 'Short description', 'Lorem ips ...',
'product13.jpg');




UPDATE products SET long_description = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit,
, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
, irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
, Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim
, id est laborum';



INSERT INTO users ("username", "email", "password") VALUES
('jose', 'jose.lopez@gmail.com', 'jlopez2018'),
('maria', 'maria.quintero@gmail.com', 'mquintero2018'),
('pedro', 'pedro.gutierrez@gmail.com', 'pgutierrez2018');





INSERT INTO reviews ("product_id", "user_id", "rating", "comment") VALUES
(1,1,4.5,'Comment 001'),
(1,2,3.5,'Comment 002'),
(1,3,4.0,'Comment 003'),
(2,1,2.5,'Comment 004'),
(2,2,3.5,'Comment 005'),
(2,3,3.0,'Comment 006'),
(3,1,4.0,'Comment 007'),
(3,2,3.5,'Comment 008'),
(3,3,2.0,'Comment 009'),
(4,1,5.0,'Comment 010'),
(4,2,3.0,'Comment 011'),
(4,3,3.5,'Comment 012'),
(5,1,3.0,'Comment 013'),
(5,2,4.5,'Comment 014'),
(5,3,4.0,'Comment 015');



grant select, insert, update, delete on categories to ecommerce_admin;
grant select, insert, update, delete on products to ecommerce_admin;
grant usage, select on all sequences in schema public to ecommerce_admin;



grant select on categories to ecommerce_client;
grant select on products to ecommerce_client;
grant select on all sequences in schema public to ecommerce_client;



grant select on categories to ecommerce_guest;
grant select on products to ecommerce_guest;
grant select on all sequences in schema public to ecommerce_guest;





























