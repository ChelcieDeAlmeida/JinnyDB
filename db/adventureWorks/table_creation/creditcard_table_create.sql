-- Table: prod.creditcard

CREATE SEQUENCE IF NOT EXISTS prod.creditcard_creditcardid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.creditcard;

CREATE TABLE IF NOT EXISTS prod.creditcard
(
    creditcardid integer NOT NULL DEFAULT nextval('prod.creditcard_creditcardid_seq'::regclass),
    cardtype character varying(50) COLLATE pg_catalog."default" NOT NULL,
    cardnumber character varying(25) COLLATE pg_catalog."default" NOT NULL,
    expmonth smallint NOT NULL,
    expyear smallint NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY (creditcardid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.creditcard
    OWNER to postgres;

COMMENT ON TABLE prod.creditcard
    IS 'Customer credit card information.';

COMMENT ON COLUMN prod.creditcard.creditcardid
    IS 'Primary key for CreditCard records.';

COMMENT ON COLUMN prod.creditcard.cardtype
    IS 'Credit card name.';

COMMENT ON COLUMN prod.creditcard.cardnumber
    IS 'Credit card number.';

COMMENT ON COLUMN prod.creditcard.expmonth
    IS 'Credit card expiration month.';

COMMENT ON COLUMN prod.creditcard.expyear
    IS 'Credit card expiration year.';