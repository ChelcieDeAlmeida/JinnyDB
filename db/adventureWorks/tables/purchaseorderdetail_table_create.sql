-- Table: prod.purchaseorderdetail


CREATE SEQUENCE IF NOT EXISTS prod.purchaseorderdetail_purchaseorderdetailid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.purchaseorderdetail;

CREATE TABLE IF NOT EXISTS prod.purchaseorderdetail
(
    purchaseorderid integer NOT NULL,
    purchaseorderdetailid integer NOT NULL DEFAULT nextval('prod.purchaseorderdetail_purchaseorderdetailid_seq'::regclass),
    duedate timestamp without time zone NOT NULL,
    orderqty smallint NOT NULL,
    productid integer NOT NULL,
    unitprice numeric NOT NULL,
    receivedqty numeric(8,2) NOT NULL,
    rejectedqty numeric(8,2) NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID" PRIMARY KEY (purchaseorderid, purchaseorderdetailid),
    CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID" FOREIGN KEY (purchaseorderid)
        REFERENCES prod.purchaseorderheader (purchaseorderid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_PurchaseOrderDetail_OrderQty" CHECK (orderqty > 0),
    CONSTRAINT "CK_PurchaseOrderDetail_UnitPrice" CHECK (unitprice >= 0.00),
    CONSTRAINT "CK_PurchaseOrderDetail_ReceivedQty" CHECK (receivedqty >= 0.00),
    CONSTRAINT "CK_PurchaseOrderDetail_RejectedQty" CHECK (rejectedqty >= 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.purchaseorderdetail
    OWNER to postgres;

COMMENT ON TABLE prod.purchaseorderdetail
    IS 'Individual products associated with a specific purchase order. See PurchaseOrderHeader.';

COMMENT ON COLUMN prod.purchaseorderdetail.purchaseorderid
    IS 'Primary key. Foreign key to PurchaseOrderHeader.PurchaseOrderID.';

COMMENT ON COLUMN prod.purchaseorderdetail.purchaseorderdetailid
    IS 'Primary key. One line number per purchased product.';

COMMENT ON COLUMN prod.purchaseorderdetail.duedate
    IS 'Date the product is expected to be received.';

COMMENT ON COLUMN prod.purchaseorderdetail.orderqty
    IS 'Quantity ordered.';

COMMENT ON COLUMN prod.purchaseorderdetail.productid
    IS 'Product identification number. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.purchaseorderdetail.unitprice
    IS 'Vendor''s selling price of a single product.';

COMMENT ON COLUMN prod.purchaseorderdetail.receivedqty
    IS 'Quantity actually received from the vendor.';

COMMENT ON COLUMN prod.purchaseorderdetail.rejectedqty
    IS 'Quantity rejected during inspection.';