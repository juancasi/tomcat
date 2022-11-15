CREATE TABLE public.profiles(
  id serial NOT NULL,
  name character varying(100),
  profile character varying(100),
  CONSTRAINT group_pkey PRIMARY KEY (id))
WITH (OIDS=FALSE);

ALTER TABLE public.profiles OWNER TO ecommerce;
GRANT ALL ON TABLE public.profiles TO ecommerce;

INSERT INTO profiles VALUES("Administrador", 
  "ADMINISTRATOR");

SELECT * from profiles;