-- Table: prod.productvendor

-- DROP TABLE IF EXISTS prod.productvendor;

CREATE TABLE IF NOT EXISTS prod.productvendor
(
    productid integer NOT NULL,
    businessentityid integer NOT NULL,
    averageleadtime integer NOT NULL,
    standardprice numeric NOT NULL,
    lastreceiptcost numeric,
    lastreceiptdate timestamp without time zone,
    minorderqty integer NOT NULL,
    maxorderqty integer NOT NULL,
    onorderqty integer,
    unitmeasurecode character(3) COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID" PRIMARY KEY (productid, businessentityid),
    CONSTRAINT "FK_ProductVendor_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unitmeasurecode)
        REFERENCES prod.unitmeasure (unitmeasurecode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.vendor (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_ProductVendor_AverageLeadTime" CHECK (averageleadtime >= 1),
    CONSTRAINT "CK_ProductVendor_StandardPrice" CHECK (standardprice > 0.00),
    CONSTRAINT "CK_ProductVendor_LastReceiptCost" CHECK (lastreceiptcost > 0.00),
    CONSTRAINT "CK_ProductVendor_MinOrderQty" CHECK (minorderqty >= 1),
    CONSTRAINT "CK_ProductVendor_MaxOrderQty" CHECK (maxorderqty >= 1),
    CONSTRAINT "CK_ProductVendor_OnOrderQty" CHECK (onorderqty >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productvendor
    OWNER to postgres;

COMMENT ON TABLE prod.productvendor
    IS 'Cross-reference table mapping vendors with the products they supply.';

COMMENT ON COLUMN prod.productvendor.productid
    IS 'Primary key. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.productvendor.businessentityid
    IS 'Primary key. Foreign key to Vendor.BusinessEntityID.';

COMMENT ON COLUMN prod.productvendor.averageleadtime
    IS 'The average span of time (in days) between placing an order with the vendor and receiving the purchased product.';

COMMENT ON COLUMN prod.productvendor.standardprice
    IS 'The vendor''s usual selling price.';

COMMENT ON COLUMN prod.productvendor.lastreceiptcost
    IS 'The selling price when last purchased.';

COMMENT ON COLUMN prod.productvendor.lastreceiptdate
    IS 'Date the product was last received by the vendor.';

COMMENT ON COLUMN prod.productvendor.minorderqty
    IS 'The maximum quantity that should be ordered.';

COMMENT ON COLUMN prod.productvendor.maxorderqty
    IS 'The minimum quantity that should be ordered.';

COMMENT ON COLUMN prod.productvendor.onorderqty
    IS 'The quantity currently on order.';

COMMENT ON COLUMN prod.productvendor.unitmeasurecode
    IS 'The product''s unit of measure.';