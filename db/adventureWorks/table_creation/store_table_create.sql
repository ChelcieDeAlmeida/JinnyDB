-- Table: prod.store

SET search_path TO prod;

-- DROP TABLE IF EXISTS prod.store;

CREATE TABLE IF NOT EXISTS prod.store
(
    businessentityid integer NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    salespersonid integer,
    demographics xml,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY (businessentityid),
    CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.businessentity (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" FOREIGN KEY (salespersonid)
        REFERENCES prod.salesperson (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.store
    OWNER to postgres;

COMMENT ON TABLE prod.store
    IS 'Customers (resellers) of Adventure Works products.';

COMMENT ON COLUMN prod.store.businessentityid
    IS 'Primary key. Foreign key to Customer.BusinessEntityID.';

COMMENT ON COLUMN prod.store.name
    IS 'Name of the store.';

COMMENT ON COLUMN prod.store.salespersonid
    IS 'ID of the sales person assigned to the customer. Foreign key to SalesPerson.BusinessEntityID.';

COMMENT ON COLUMN prod.store.demographics
    IS 'Demographic informationg about the store such as the number of employees, annual sales and store type.';