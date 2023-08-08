-- Table: prod.productmodel

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE SEQUENCE IF NOT EXISTS prod.productmodel_productmodelid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.productmodel;

CREATE TABLE IF NOT EXISTS prod.productmodel
(
    productmodelid integer NOT NULL DEFAULT nextval('prod.productmodel_productmodelid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    catalogdescription xml,
    instructions xml,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY (productmodelid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productmodel
    OWNER to postgres;

COMMENT ON TABLE prod.productmodel
    IS 'Product model classification.';

COMMENT ON COLUMN prod.productmodel.productmodelid
    IS 'Primary key for ProductModel records.';

COMMENT ON COLUMN prod.productmodel.name
    IS 'Product model description.';

COMMENT ON COLUMN prod.productmodel.catalogdescription
    IS 'Detailed product catalog information in xml format.';

COMMENT ON COLUMN prod.productmodel.instructions
    IS 'Manufacturing instructions in xml format.';