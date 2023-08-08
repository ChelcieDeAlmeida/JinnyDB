-- Table: prod.productmodelproductdescriptionculture

-- DROP TABLE IF EXISTS prod.productmodelproductdescriptionculture;

CREATE TABLE IF NOT EXISTS prod.productmodelproductdescriptionculture
(
    productmodelid integer NOT NULL,
    productdescriptionid integer NOT NULL,
    cultureid character(6) COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_Product" PRIMARY KEY (productmodelid, productdescriptionid, cultureid),
    CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID" FOREIGN KEY (cultureid)
        REFERENCES prod.culture (cultureid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_Pro" FOREIGN KEY (productdescriptionid)
        REFERENCES prod.productdescription (productdescriptionid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo" FOREIGN KEY (productmodelid)
        REFERENCES prod.productmodel (productmodelid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productmodelproductdescriptionculture
    OWNER to postgres;

COMMENT ON TABLE prod.productmodelproductdescriptionculture
    IS 'Cross-reference table mapping product descriptions and the language the description is written in.';

COMMENT ON COLUMN prod.productmodelproductdescriptionculture.productmodelid
    IS 'Primary key. Foreign key to ProductModel.ProductModelID.';

COMMENT ON COLUMN prod.productmodelproductdescriptionculture.productdescriptionid
    IS 'Primary key. Foreign key to ProductDescription.ProductDescriptionID.';

COMMENT ON COLUMN prod.productmodelproductdescriptionculture.cultureid
    IS 'Culture identification number. Foreign key to Culture.CultureID.';