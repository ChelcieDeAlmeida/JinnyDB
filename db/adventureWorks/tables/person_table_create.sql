-- Table: prod.person

-- DROP TABLE IF EXISTS prod.person;

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS prod.person
(
    businessentityid integer NOT NULL,
    persontype character(2) COLLATE pg_catalog."default" NOT NULL,
    namestyle boolean NOT NULL DEFAULT false,
    title character varying(8) COLLATE pg_catalog."default",
    firstname character varying COLLATE pg_catalog."default" NOT NULL,
    middlename character varying COLLATE pg_catalog."default",
    lastname character varying COLLATE pg_catalog."default" NOT NULL,
    suffix character varying(10) COLLATE pg_catalog."default",
    emailpromotion integer NOT NULL DEFAULT 0,
    additionalcontactinfo xml,
    demographics xml,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Person_BusinessEntityID" PRIMARY KEY (businessentityid),
    CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.businessentity (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_Person_EmailPromotion" CHECK (emailpromotion >= 0 AND emailpromotion <= 2),
    CONSTRAINT "CK_Person_PersonType" CHECK (persontype IS NULL OR (upper(persontype::text) = ANY (ARRAY['SC'::text, 'VC'::text, 'IN'::text, 'EM'::text, 'SP'::text, 'GC'::text])))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.person
    OWNER to postgres;

COMMENT ON TABLE prod.person
    IS 'Human beings involved with AdventureWorks: employees, customer contacts, and vendor contacts.';

COMMENT ON COLUMN prod.person.businessentityid
    IS 'Primary key for Person records.';

COMMENT ON COLUMN prod.person.persontype
    IS 'Primary type of person: SC = Store Contact, IN = Individual (retail) customer, SP = Sales person, EM = Employee (non-sales), VC = Vendor contact, GC = General contact';

COMMENT ON COLUMN prod.person.namestyle
    IS '0 = The data in FirstName and LastName are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.';

COMMENT ON COLUMN prod.person.title
    IS 'A courtesy title. For example, Mr. or Ms.';

COMMENT ON COLUMN prod.person.firstname
    IS 'First name of the person.';

COMMENT ON COLUMN prod.person.middlename
    IS 'Middle name or middle initial of the person.';

COMMENT ON COLUMN prod.person.lastname
    IS 'Last name of the person.';

COMMENT ON COLUMN prod.person.suffix
    IS 'Surname suffix. For example, Sr. or Jr.';

COMMENT ON COLUMN prod.person.emailpromotion
    IS '0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners.';

COMMENT ON COLUMN prod.person.additionalcontactinfo
    IS 'Additional contact information about the person stored in xml format.';

COMMENT ON COLUMN prod.person.demographics
    IS 'Personal information such as hobbies, and income collected from online shoppers. Used for sales analysis.';