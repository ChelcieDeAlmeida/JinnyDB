-- Table: prod.productproductphoto

-- DROP TABLE IF EXISTS prod.productproductphoto;

CREATE TABLE IF NOT EXISTS prod.productproductphoto
(
    productid integer NOT NULL,
    productphotoid integer NOT NULL,
    "primary" boolean NOT NULL DEFAULT false,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductProductPhoto_ProductID_ProductPhotoID" PRIMARY KEY (productid, productphotoid),
    CONSTRAINT "FK_ProductProductPhoto_ProductPhoto_ProductPhotoID" FOREIGN KEY (productphotoid)
        REFERENCES prod.productphoto (productphotoid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_ProductProductPhoto_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productproductphoto
    OWNER to postgres;

COMMENT ON TABLE prod.productproductphoto
    IS 'Cross-reference table mapping products and product photos.';

COMMENT ON COLUMN prod.productproductphoto.productid
    IS 'Product identification number. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.productproductphoto.productphotoid
    IS 'Product photo identification number. Foreign key to ProductPhoto.ProductPhotoID.';

COMMENT ON COLUMN prod.productproductphoto."primary"
    IS '0 = Photo is not the principal image. 1 = Photo is the principal image.';