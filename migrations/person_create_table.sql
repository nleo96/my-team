DROP TABLE public.person;

CREATE TABLE IF NOT EXISTS public.person
(
    id bigserial NOT NULL,
    first_name character varying(20)[] NOT NULL,
    middle_name character varying(20)[],
    last_name character varying(20)[] NOT NULL,
    birth date NOT NULL,
    email character varying(50)[] NOT NULL,
    nickname character varying(16)[],
	is_active boolean NOT NULL DEFAULT True,
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_person_id PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.person OWNER TO postgres;