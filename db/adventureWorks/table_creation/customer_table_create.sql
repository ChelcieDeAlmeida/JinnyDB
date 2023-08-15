-- Table: prod.customer

SET search_path TO prod;

CREATE SEQUENCE IF NOT EXISTS prod.customer_customerid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.customer;

CREATE TABLE IF NOT EXISTS prod.customer
(
    customerid integer NOT NULL DEFAULT nextval('prod.customer_customerid_seq'::regclass),
    personid integer,
    storeid integer,
    territoryid integer,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Customer_CustomerID" PRIMARY KEY (customerid),
    CONSTRAINT "FK_Customer_Person_PersonID" FOREIGN KEY (personid)
        REFERENCES prod.person (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_Customer_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid)
        REFERENCES prod.salesterritory (territoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_Customer_Store_StoreID" FOREIGN KEY (storeid)
        REFERENCES prod.store (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.customer
    OWNER to postgres;

COMMENT ON TABLE prod.customer
    IS 'Current customer information. Also see the Person and Store tables.';

COMMENT ON COLUMN prod.customer.customerid
    IS 'Primary key.';

COMMENT ON COLUMN prod.customer.personid
    IS 'Foreign key to Person.BusinessEntityID';

COMMENT ON COLUMN prod.customer.storeid
    IS 'Foreign key to Store.BusinessEntityID';

COMMENT ON COLUMN prod.customer.territoryid
    IS 'ID of the territory in which the customer is located. Foreign key to SalesTerritory.SalesTerritoryID.';