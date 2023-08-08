-- Table: prod.specialofferproduct

SET search_path TO prod;

-- DROP TABLE IF EXISTS prod.specialofferproduct;

CREATE TABLE IF NOT EXISTS prod.specialofferproduct
(
    specialofferid integer NOT NULL,
    productid integer NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID" PRIMARY KEY (specialofferid, productid),
    CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID" FOREIGN KEY (specialofferid)
        REFERENCES prod.specialoffer (specialofferid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.specialofferproduct
    OWNER to postgres;

COMMENT ON TABLE prod.specialofferproduct
    IS 'Cross-reference table mapping products to special offer discounts.';

COMMENT ON COLUMN prod.specialofferproduct.specialofferid
    IS 'Primary key for SpecialOfferProduct records.';

COMMENT ON COLUMN prod.specialofferproduct.productid
    IS 'Product identification number. Foreign key to Product.ProductID.';