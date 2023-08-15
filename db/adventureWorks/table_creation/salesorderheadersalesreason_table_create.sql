-- Table: prod.salesorderheadersalesreason

-- DROP TABLE IF EXISTS prod.salesorderheadersalesreason;

CREATE TABLE IF NOT EXISTS prod.salesorderheadersalesreason
(
    salesorderid integer NOT NULL,
    salesreasonid integer NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY (salesorderid, salesreasonid),
    CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID" FOREIGN KEY (salesorderid)
        REFERENCES prod.salesorderheader (salesorderid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" FOREIGN KEY (salesreasonid)
        REFERENCES prod.salesreason (salesreasonid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.salesorderheadersalesreason
    OWNER to postgres;

COMMENT ON TABLE prod.salesorderheadersalesreason
    IS 'Cross-reference table mapping sales orders to sales reason codes.';

COMMENT ON COLUMN prod.salesorderheadersalesreason.salesorderid
    IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';

COMMENT ON COLUMN prod.salesorderheadersalesreason.salesreasonid
    IS 'Primary key. Foreign key to SalesReason.SalesReasonID.';