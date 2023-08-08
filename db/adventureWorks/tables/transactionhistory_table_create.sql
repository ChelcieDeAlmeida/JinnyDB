-- Table: prod.transactionhistory

CREATE SEQUENCE IF NOT EXISTS prod.transactionhistory_transactionid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.transactionhistory;

CREATE TABLE IF NOT EXISTS prod.transactionhistory
(
    transactionid integer NOT NULL DEFAULT nextval('prod.transactionhistory_transactionid_seq'::regclass),
    productid integer NOT NULL,
    referenceorderid integer NOT NULL,
    referenceorderlineid integer NOT NULL DEFAULT 0,
    transactiondate timestamp without time zone NOT NULL DEFAULT now(),
    transactiontype character(1) COLLATE pg_catalog."default" NOT NULL,
    quantity integer NOT NULL,
    actualcost numeric NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY (transactionid),
    CONSTRAINT "FK_TransactionHistory_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_TransactionHistory_TransactionType" CHECK (upper(transactiontype::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.transactionhistory
    OWNER to postgres;

COMMENT ON TABLE prod.transactionhistory
    IS 'Record of each purchase order, sales order, or work order transaction year to date.';

COMMENT ON COLUMN prod.transactionhistory.transactionid
    IS 'Primary key for TransactionHistory records.';

COMMENT ON COLUMN prod.transactionhistory.productid
    IS 'Product identification number. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.transactionhistory.referenceorderid
    IS 'Purchase order, sales order, or work order identification number.';

COMMENT ON COLUMN prod.transactionhistory.referenceorderlineid
    IS 'Line number associated with the purchase order, sales order, or work order.';

COMMENT ON COLUMN prod.transactionhistory.transactiondate
    IS 'Date and time of the transaction.';

COMMENT ON COLUMN prod.transactionhistory.transactiontype
    IS 'W = WorkOrder, S = SalesOrder, P = PurchaseOrder';

COMMENT ON COLUMN prod.transactionhistory.quantity
    IS 'Product quantity.';

COMMENT ON COLUMN prod.transactionhistory.actualcost
    IS 'Product cost.';