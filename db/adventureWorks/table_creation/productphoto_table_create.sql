-- Table: prod.productphoto

CREATE SEQUENCE IF NOT EXISTS prod.productphoto_productphotoid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.productphoto;

CREATE TABLE IF NOT EXISTS prod.productphoto
(
    productphotoid integer NOT NULL DEFAULT nextval('prod.productphoto_productphotoid_seq'::regclass),
    thumbnailphoto bytea,
    thumbnailphotofilename character varying(50) COLLATE pg_catalog."default",
    largephoto bytea,
    largephotofilename character varying(50) COLLATE pg_catalog."default",
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductPhoto_ProductPhotoID" PRIMARY KEY (productphotoid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productphoto
    OWNER to postgres;

COMMENT ON TABLE prod.productphoto
    IS 'Product images.';

COMMENT ON COLUMN prod.productphoto.productphotoid
    IS 'Primary key for ProductPhoto records.';

COMMENT ON COLUMN prod.productphoto.thumbnailphoto
    IS 'Small image of the product.';

COMMENT ON COLUMN prod.productphoto.thumbnailphotofilename
    IS 'Small image file name.';

COMMENT ON COLUMN prod.productphoto.largephoto
    IS 'Large image of the product.';

COMMENT ON COLUMN prod.productphoto.largephotofilename
    IS 'Large image file name.';