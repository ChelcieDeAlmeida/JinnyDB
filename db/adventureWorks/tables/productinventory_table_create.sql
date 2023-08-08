-- Table: prod.productinventory
SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- DROP TABLE IF EXISTS prod.productinventory;

CREATE TABLE IF NOT EXISTS prod.productinventory
(
    productid integer NOT NULL,
    locationid smallint NOT NULL,
    shelf character varying(10) COLLATE pg_catalog."default" NOT NULL,
    bin smallint NOT NULL,
    quantity smallint NOT NULL DEFAULT 0,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductInventory_ProductID_LocationID" PRIMARY KEY (productid, locationid),
    CONSTRAINT "FK_ProductInventory_Location_LocationID" FOREIGN KEY (locationid)
        REFERENCES prod.location (locationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_ProductInventory_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_ProductInventory_Bin" CHECK (bin >= 0 AND bin <= 100)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productinventory
    OWNER to postgres;

COMMENT ON TABLE prod.productinventory
    IS 'Product inventory information.';

COMMENT ON COLUMN prod.productinventory.productid
    IS 'Product identification number. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.productinventory.locationid
    IS 'Inventory location identification number. Foreign key to Location.LocationID.';

COMMENT ON COLUMN prod.productinventory.shelf
    IS 'Storage compartment within an inventory location.';

COMMENT ON COLUMN prod.productinventory.bin
    IS 'Storage container on a shelf in an inventory location.';

COMMENT ON COLUMN prod.productinventory.quantity
    IS 'Quantity of products in the inventory location.';