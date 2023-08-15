-- Table: prod.businessentitycontact

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- DROP TABLE IF EXISTS prod.businessentitycontact;

CREATE TABLE IF NOT EXISTS prod.businessentitycontact
(
    businessentityid integer NOT NULL,
    personid integer NOT NULL,
    contacttypeid integer NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI" PRIMARY KEY (businessentityid, personid, contacttypeid),
    CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.businessentity (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" FOREIGN KEY (contacttypeid)
        REFERENCES prod.contacttype (contacttypeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" FOREIGN KEY (personid)
        REFERENCES prod.person (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.businessentitycontact
    OWNER to postgres;

COMMENT ON TABLE prod.businessentitycontact
    IS 'Cross-reference table mapping stores, vendors, and employees to people';

COMMENT ON COLUMN prod.businessentitycontact.businessentityid
    IS 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';

COMMENT ON COLUMN prod.businessentitycontact.personid
    IS 'Primary key. Foreign key to Person.BusinessEntityID.';

COMMENT ON COLUMN prod.businessentitycontact.contacttypeid
    IS 'Primary key.  Foreign key to ContactType.ContactTypeID.';