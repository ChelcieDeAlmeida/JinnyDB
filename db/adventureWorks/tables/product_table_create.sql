-- Table: prod.product

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE SEQUENCE IF NOT EXISTS prod.product_productid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.product;

CREATE TABLE IF NOT EXISTS prod.product
(
    productid integer NOT NULL DEFAULT nextval('prod.product_productid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    productnumber character varying(25) COLLATE pg_catalog."default" NOT NULL,
    makeflag boolean NOT NULL DEFAULT true,
    finishedgoodsflag boolean NOT NULL DEFAULT true,
    color character varying(15) COLLATE pg_catalog."default",
    safetystocklevel smallint NOT NULL,
    reorderpoint smallint NOT NULL,
    standardcost numeric NOT NULL,
    listprice numeric NOT NULL,
    size character varying(5) COLLATE pg_catalog."default",
    sizeunitmeasurecode character(3) COLLATE pg_catalog."default",
    weightunitmeasurecode character(3) COLLATE pg_catalog."default",
    weight numeric(8,2),
    daystomanufacture integer NOT NULL,
    productline character(2) COLLATE pg_catalog."default",
    class character(2) COLLATE pg_catalog."default",
    style character(2) COLLATE pg_catalog."default",
    productsubcategoryid integer,
    productmodelid integer,
    sellstartdate timestamp without time zone NOT NULL,
    sellenddate timestamp without time zone,
    discontinueddate timestamp without time zone,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Product_ProductID" PRIMARY KEY (productid),
    CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY (productmodelid)
        REFERENCES prod.productmodel (productmodelid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" FOREIGN KEY (productsubcategoryid)
        REFERENCES prod.productsubcategory (productsubcategoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY (sizeunitmeasurecode)
        REFERENCES prod.unitmeasure (unitmeasurecode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY (weightunitmeasurecode)
        REFERENCES prod.unitmeasure (unitmeasurecode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_Product_Weight" CHECK (weight > 0.00),
    CONSTRAINT "CK_Product_SafetyStockLevel" CHECK (safetystocklevel > 0),
    CONSTRAINT "CK_Product_ReorderPoint" CHECK (reorderpoint > 0),
    CONSTRAINT "CK_Product_StandardCost" CHECK (standardcost >= 0.00),
    CONSTRAINT "CK_Product_ListPrice" CHECK (listprice >= 0.00),
    CONSTRAINT "CK_Product_DaysToManufacture" CHECK (daystomanufacture >= 0),
    CONSTRAINT "CK_Product_ProductLine" CHECK ((upper(productline::text) = ANY (ARRAY['S'::text, 'T'::text, 'M'::text, 'R'::text])) OR productline IS NULL),
    CONSTRAINT "CK_Product_Class" CHECK ((upper(class::text) = ANY (ARRAY['L'::text, 'M'::text, 'H'::text])) OR class IS NULL),
    CONSTRAINT "CK_Product_Style" CHECK ((upper(style::text) = ANY (ARRAY['W'::text, 'M'::text, 'U'::text])) OR style IS NULL),
    CONSTRAINT "CK_Product_SellEndDate" CHECK (sellenddate >= sellstartdate OR sellenddate IS NULL)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.product
    OWNER to postgres;

COMMENT ON TABLE prod.product
    IS 'Products sold or used in the manfacturing of sold products.';

COMMENT ON COLUMN prod.product.productid
    IS 'Primary key for Product records.';

COMMENT ON COLUMN prod.product.name
    IS 'Name of the product.';

COMMENT ON COLUMN prod.product.productnumber
    IS 'Unique product identification number.';

COMMENT ON COLUMN prod.product.makeflag
    IS '0 = Product is purchased, 1 = Product is manufactured in-house.';

COMMENT ON COLUMN prod.product.finishedgoodsflag
    IS '0 = Product is not a salable item. 1 = Product is salable.';

COMMENT ON COLUMN prod.product.color
    IS 'Product color.';

COMMENT ON COLUMN prod.product.safetystocklevel
    IS 'Minimum inventory quantity.';

COMMENT ON COLUMN prod.product.reorderpoint
    IS 'Inventory level that triggers a purchase order or work order.';

COMMENT ON COLUMN prod.product.standardcost
    IS 'Standard cost of the product.';

COMMENT ON COLUMN prod.product.listprice
    IS 'Selling price.';

COMMENT ON COLUMN prod.product.size
    IS 'Product size.';

COMMENT ON COLUMN prod.product.sizeunitmeasurecode
    IS 'Unit of measure for Size column.';

COMMENT ON COLUMN prod.product.weightunitmeasurecode
    IS 'Unit of measure for Weight column.';

COMMENT ON COLUMN prod.product.weight
    IS 'Product weight.';

COMMENT ON COLUMN prod.product.daystomanufacture
    IS 'Number of days required to manufacture the product.';

COMMENT ON COLUMN prod.product.productline
    IS 'R = Road, M = Mountain, T = Touring, S = Standard';

COMMENT ON COLUMN prod.product.class
    IS 'H = High, M = Medium, L = Low';

COMMENT ON COLUMN prod.product.style
    IS 'W = Womens, M = Mens, U = Universal';

COMMENT ON COLUMN prod.product.productsubcategoryid
    IS 'Product is a member of this product subcategory. Foreign key to ProductSubCategory.ProductSubCategoryID.';

COMMENT ON COLUMN prod.product.productmodelid
    IS 'Product is a member of this product model. Foreign key to ProductModel.ProductModelID.';

COMMENT ON COLUMN prod.product.sellstartdate
    IS 'Date the product was available for sale.';

COMMENT ON COLUMN prod.product.sellenddate
    IS 'Date the product was no longer available for sale.';

COMMENT ON COLUMN prod.product.discontinueddate
    IS 'Date the product was discontinued.';