-- Table: prod.password

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- DROP TABLE IF EXISTS prod.password;

CREATE TABLE IF NOT EXISTS prod.password
(
    businessentityid integer NOT NULL,
    passwordhash character varying(128) COLLATE pg_catalog."default" NOT NULL,
    passwordsalt character varying(10) COLLATE pg_catalog."default" NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Password_BusinessEntityID" PRIMARY KEY (businessentityid),
    CONSTRAINT "FK_Password_Person_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.person (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.password
    OWNER to postgres;

COMMENT ON TABLE prod.password
    IS 'One way hashed authentication information';

COMMENT ON COLUMN prod.password.passwordhash
    IS 'Password for the e-mail account.';

COMMENT ON COLUMN prod.password.passwordsalt
    IS 'Random value concatenated with the password string before the password is hashed.';