-- Table: prod.productdescription

SET search_path TO prod;


CREATE SEQUENCE IF NOT EXISTS prod.productdescription_productdescriptionid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.productdescription;

CREATE TABLE IF NOT EXISTS prod.productdescription
(
    productdescriptionid integer NOT NULL DEFAULT nextval('prod.productdescription_productdescriptionid_seq'::regclass),
    description character varying(400) COLLATE pg_catalog."default" NOT NULL,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY (productdescriptionid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productdescription
    OWNER to postgres;

COMMENT ON TABLE prod.productdescription
    IS 'Product descriptions in several languages.';

COMMENT ON COLUMN prod.productdescription.productdescriptionid
    IS 'Primary key for ProductDescription records.';

COMMENT ON COLUMN prod.productdescription.description
    IS 'Description of the product.';