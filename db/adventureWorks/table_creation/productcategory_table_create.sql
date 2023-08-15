-- Table: prod.productcategory

SET search_path TO prod;

CREATE SEQUENCE IF NOT EXISTS prod.productcategory_productcategoryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.productcategory;

CREATE TABLE IF NOT EXISTS prod.productcategory
(
    productcategoryid integer NOT NULL DEFAULT nextval('prod.productcategory_productcategoryid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY (productcategoryid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productcategory
    OWNER to postgres;

COMMENT ON TABLE prod.productcategory
    IS 'High-level product categorization.';

COMMENT ON COLUMN prod.productcategory.productcategoryid
    IS 'Primary key for ProductCategory records.';

COMMENT ON COLUMN prod.productcategory.name
    IS 'Category description.';