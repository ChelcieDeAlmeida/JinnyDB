-- Table: prod.salesorderdetail

SET search_path TO prod;

CREATE SEQUENCE IF NOT EXISTS prod.salesorderdetail_salesorderdetailid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.salesorderdetail;

CREATE TABLE IF NOT EXISTS prod.salesorderdetail
(
    salesorderid integer NOT NULL,
    salesorderdetailid integer NOT NULL DEFAULT nextval('prod.salesorderdetail_salesorderdetailid_seq'::regclass),
    carriertrackingnumber character varying(25) COLLATE pg_catalog."default",
    orderqty smallint NOT NULL,
    productid integer NOT NULL,
    specialofferid integer NOT NULL,
    unitprice numeric NOT NULL,
    unitpricediscount numeric NOT NULL DEFAULT 0.0,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY (salesorderid, salesorderdetailid),
    CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID" FOREIGN KEY (salesorderid)
        REFERENCES prod.salesorderheader (salesorderid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID" FOREIGN KEY (specialofferid, productid)
        REFERENCES prod.specialofferproduct (specialofferid, productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_SalesOrderDetail_OrderQty" CHECK (orderqty > 0),
    CONSTRAINT "CK_SalesOrderDetail_UnitPrice" CHECK (unitprice >= 0.00),
    CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" CHECK (unitpricediscount >= 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.salesorderdetail
    OWNER to postgres;

COMMENT ON TABLE prod.salesorderdetail
    IS 'Individual products associated with a specific sales order. See SalesOrderHeader.';

COMMENT ON COLUMN prod.salesorderdetail.salesorderid
    IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';

COMMENT ON COLUMN prod.salesorderdetail.salesorderdetailid
    IS 'Primary key. One incremental unique number per product sold.';

COMMENT ON COLUMN prod.salesorderdetail.carriertrackingnumber
    IS 'Shipment tracking number supplied by the shipper.';

COMMENT ON COLUMN prod.salesorderdetail.orderqty
    IS 'Quantity ordered per product.';

COMMENT ON COLUMN prod.salesorderdetail.productid
    IS 'Product sold to customer. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.salesorderdetail.specialofferid
    IS 'Promotional code. Foreign key to SpecialOffer.SpecialOfferID.';

COMMENT ON COLUMN prod.salesorderdetail.unitprice
    IS 'Selling price of a single product.';

COMMENT ON COLUMN prod.salesorderdetail.unitpricediscount
    IS 'Discount amount.';