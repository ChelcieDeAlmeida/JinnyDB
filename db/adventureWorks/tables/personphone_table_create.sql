-- Table: prod.personphone

-- DROP TABLE IF EXISTS prod.personphone;

CREATE TABLE IF NOT EXISTS prod.personphone
(
    businessentityid integer NOT NULL,
    phonenumber character varying COLLATE pg_catalog."default" NOT NULL,
    phonenumbertypeid integer NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID" PRIMARY KEY (businessentityid, phonenumber, phonenumbertypeid),
    CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.person (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" FOREIGN KEY (phonenumbertypeid)
        REFERENCES prod.phonenumbertype (phonenumbertypeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.personphone
    OWNER to postgres;

COMMENT ON TABLE prod.personphone
    IS 'Telephone number and type of a person.';

COMMENT ON COLUMN prod.personphone.businessentityid
    IS 'Business entity identification number. Foreign key to Person.BusinessEntityID.';

COMMENT ON COLUMN prod.personphone.phonenumber
    IS 'Telephone number identification number.';

COMMENT ON COLUMN prod.personphone.phonenumbertypeid
    IS 'Kind of phone number. Foreign key to PhoneNumberType.PhoneNumberTypeID.';