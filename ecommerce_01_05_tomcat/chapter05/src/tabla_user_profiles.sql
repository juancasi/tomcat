CREATE TABLE public.user_profiles
(
    id bigserial NOT NULL,
    user_id bigint,
    profile_id bigint,
    CONSTRAINT user_profiles_pkey PRIMARY KEY (id),
    CONSTRAINT user_profiles_profile_fkey FOREIGN KEY (profile_id)
    REFERENCES public.profiles (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT user_profiles_user_fkey FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
 OIDS=FALSE
);
ALTER TABLE public.user_profiles OWNER TO ecommerce;
GRANT ALL ON TABLE public.user_profiles TO ecommerce;