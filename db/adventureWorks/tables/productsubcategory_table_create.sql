-- Table: prod.productsubcategory

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE SEQUENCE IF NOT EXISTS prod.productsubcategory_productsubcategoryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;


-- DROP TABLE IF EXISTS prod.productsubcategory;

CREATE TABLE IF NOT EXISTS prod.productsubcategory
(
    productsubcategoryid integer NOT NULL DEFAULT nextval('prod.productsubcategory_productsubcategoryid_seq'::regclass),
    productcategoryid integer NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID" PRIMARY KEY (productsubcategoryid),
    CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID" FOREIGN KEY (productcategoryid)
        REFERENCES prod.productcategory (productcategoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productsubcategory
    OWNER to postgres;

COMMENT ON TABLE prod.productsubcategory
    IS 'Product subcategories. See ProductCategory table.';

COMMENT ON COLUMN prod.productsubcategory.productsubcategoryid
    IS 'Primary key for ProductSubcategory records.';

COMMENT ON COLUMN prod.productsubcategory.productcategoryid
    IS 'Product category identification number. Foreign key to ProductCategory.ProductCategoryID.';

COMMENT ON COLUMN prod.productsubcategory.name
    IS 'Subcategory description.';