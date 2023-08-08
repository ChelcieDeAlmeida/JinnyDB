-- Table: prod.productcosthistory

-- DROP TABLE IF EXISTS prod.productcosthistory;

CREATE TABLE IF NOT EXISTS prod.productcosthistory
(
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    standardcost numeric NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate" PRIMARY KEY (productid, startdate),
    CONSTRAINT "FK_ProductCostHistory_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_ProductCostHistory_EndDate" CHECK (enddate >= startdate OR enddate IS NULL),
    CONSTRAINT "CK_ProductCostHistory_StandardCost" CHECK (standardcost >= 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productcosthistory
    OWNER to postgres;

COMMENT ON TABLE prod.productcosthistory
    IS 'Changes in the cost of a product over time.';

COMMENT ON COLUMN prod.productcosthistory.productid
    IS 'Product identification number. Foreign key to Product.ProductID';

COMMENT ON COLUMN prod.productcosthistory.startdate
    IS 'Product cost start date.';

COMMENT ON COLUMN prod.productcosthistory.enddate
    IS 'Product cost end date.';

COMMENT ON COLUMN prod.productcosthistory.standardcost
    IS 'Standard cost of the product.';