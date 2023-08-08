-- Table: prod.vendor

-- DROP TABLE IF EXISTS prod.vendor;

CREATE TABLE IF NOT EXISTS prod.vendor
(
    businessentityid integer NOT NULL,
    accountnumber character varying COLLATE pg_catalog."default" NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    creditrating smallint NOT NULL,
    preferredvendorstatus boolean NOT NULL DEFAULT true,
    activeflag boolean NOT NULL DEFAULT true,
    purchasingwebserviceurl character varying(1024) COLLATE pg_catalog."default",
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY (businessentityid),
    CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.businessentity (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_Vendor_CreditRating" CHECK (creditrating >= 1 AND creditrating <= 5)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.vendor
    OWNER to postgres;

COMMENT ON TABLE prod.vendor
    IS 'Companies from whom Adventure Works Cycles purchases parts or other goods.';

COMMENT ON COLUMN prod.vendor.businessentityid
    IS 'Primary key for Vendor records.  Foreign key to BusinessEntity.BusinessEntityID';

COMMENT ON COLUMN prod.vendor.accountnumber
    IS 'Vendor account (identification) number.';

COMMENT ON COLUMN prod.vendor.name
    IS 'Company name.';

COMMENT ON COLUMN prod.vendor.creditrating
    IS '1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average';

COMMENT ON COLUMN prod.vendor.preferredvendorstatus
    IS '0 = Do not use if another vendor is available. 1 = Preferred over other vendors supplying the same product.';

COMMENT ON COLUMN prod.vendor.activeflag
    IS '0 = Vendor no longer used. 1 = Vendor is actively used.';

COMMENT ON COLUMN prod.vendor.purchasingwebserviceurl
    IS 'Vendor URL.';