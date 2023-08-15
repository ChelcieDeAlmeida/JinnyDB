SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
	
	-- Table: prod.businessentityaddress

-- DROP TABLE IF EXISTS prod.businessentityaddress;

CREATE TABLE IF NOT EXISTS prod.businessentityaddress
(
    businessentityid integer NOT NULL,
    addressid integer NOT NULL,
    addresstypeid integer NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType" PRIMARY KEY (businessentityid, addressid, addresstypeid),
    CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" FOREIGN KEY (addresstypeid)
        REFERENCES prod.addresstype (addresstypeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" FOREIGN KEY (addressid)
        REFERENCES prod.address (addressid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.businessentity (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.businessentityaddress
    OWNER to postgres;

COMMENT ON TABLE prod.businessentityaddress
    IS 'Cross-reference table mapping customers, vendors, and employees to their addresses.';

COMMENT ON COLUMN prod.businessentityaddress.businessentityid
    IS 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';

COMMENT ON COLUMN prod.businessentityaddress.addressid
    IS 'Primary key. Foreign key to Address.AddressID.';

COMMENT ON COLUMN prod.businessentityaddress.addresstypeid
    IS 'Primary key. Foreign key to AddressType.AddressTypeID.';