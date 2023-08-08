-- Table: prod.salespersonquotahistory

SET search_path TO prod;

-- DROP TABLE IF EXISTS prod.salespersonquotahistory;

CREATE TABLE IF NOT EXISTS prod.salespersonquotahistory
(
    businessentityid integer NOT NULL,
    quotadate timestamp without time zone NOT NULL,
    salesquota numeric NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate" PRIMARY KEY (businessentityid, quotadate),
    CONSTRAINT "FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.salesperson (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_SalesPersonQuotaHistory_SalesQuota" CHECK (salesquota > 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.salespersonquotahistory
    OWNER to postgres;

COMMENT ON TABLE prod.salespersonquotahistory
    IS 'Sales performance tracking.';

COMMENT ON COLUMN prod.salespersonquotahistory.businessentityid
    IS 'Sales person identification number. Foreign key to SalesPerson.BusinessEntityID.';

COMMENT ON COLUMN prod.salespersonquotahistory.quotadate
    IS 'Sales quota date.';

COMMENT ON COLUMN prod.salespersonquotahistory.salesquota
    IS 'Sales quota amount.';