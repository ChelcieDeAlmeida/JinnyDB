-- Table: prod.transactionhistoryarchive

-- DROP TABLE IF EXISTS prod.transactionhistoryarchive;

CREATE TABLE IF NOT EXISTS prod.transactionhistoryarchive
(
    transactionid integer NOT NULL,
    productid integer NOT NULL,
    referenceorderid integer NOT NULL,
    referenceorderlineid integer NOT NULL DEFAULT 0,
    transactiondate timestamp without time zone NOT NULL DEFAULT now(),
    transactiontype character(1) COLLATE pg_catalog."default" NOT NULL,
    quantity integer NOT NULL,
    actualcost numeric NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_TransactionHistoryArchive_TransactionID" PRIMARY KEY (transactionid),
    CONSTRAINT "CK_TransactionHistoryArchive_TransactionType" CHECK (upper(transactiontype::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.transactionhistoryarchive
    OWNER to postgres;

COMMENT ON TABLE prod.transactionhistoryarchive
    IS 'Transactions for previous years.';

COMMENT ON COLUMN prod.transactionhistoryarchive.transactionid
    IS 'Primary key for TransactionHistoryArchive records.';

COMMENT ON COLUMN prod.transactionhistoryarchive.productid
    IS 'Product identification number. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.transactionhistoryarchive.referenceorderid
    IS 'Purchase order, sales order, or work order identification number.';

COMMENT ON COLUMN prod.transactionhistoryarchive.referenceorderlineid
    IS 'Line number associated with the purchase order, sales order, or work order.';

COMMENT ON COLUMN prod.transactionhistoryarchive.transactiondate
    IS 'Date and time of the transaction.';

COMMENT ON COLUMN prod.transactionhistoryarchive.transactiontype
    IS 'W = Work Order, S = Sales Order, P = Purchase Order';

COMMENT ON COLUMN prod.transactionhistoryarchive.quantity
    IS 'Product quantity.';

COMMENT ON COLUMN prod.transactionhistoryarchive.actualcost
    IS 'Product cost.';