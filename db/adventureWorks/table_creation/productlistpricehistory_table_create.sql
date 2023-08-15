-- Table: prod.productlistpricehistory

-- DROP TABLE IF EXISTS prod.productlistpricehistory;

CREATE TABLE IF NOT EXISTS prod.productlistpricehistory
(
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    listprice numeric NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductListPriceHistory_ProductID_StartDate" PRIMARY KEY (productid, startdate),
    CONSTRAINT "FK_ProductListPriceHistory_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_ProductListPriceHistory_EndDate" CHECK (enddate >= startdate OR enddate IS NULL),
    CONSTRAINT "CK_ProductListPriceHistory_ListPrice" CHECK (listprice > 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productlistpricehistory
    OWNER to postgres;

COMMENT ON TABLE prod.productlistpricehistory
    IS 'Changes in the list price of a product over time.';

COMMENT ON COLUMN prod.productlistpricehistory.productid
    IS 'Product identification number. Foreign key to Product.ProductID';

COMMENT ON COLUMN prod.productlistpricehistory.startdate
    IS 'List price start date.';

COMMENT ON COLUMN prod.productlistpricehistory.enddate
    IS 'List price end date';

COMMENT ON COLUMN prod.productlistpricehistory.listprice
    IS 'Product list price.';