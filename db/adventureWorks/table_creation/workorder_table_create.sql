-- Table: prod.workorder

CREATE SEQUENCE IF NOT EXISTS prod.workorder_workorderid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.workorder;

CREATE TABLE IF NOT EXISTS prod.workorder
(
    workorderid integer NOT NULL DEFAULT nextval('prod.workorder_workorderid_seq'::regclass),
    productid integer NOT NULL,
    orderqty integer NOT NULL,
    scrappedqty smallint NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    duedate timestamp without time zone NOT NULL,
    scrapreasonid smallint,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY (workorderid),
    CONSTRAINT "FK_WorkOrder_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" FOREIGN KEY (scrapreasonid)
        REFERENCES prod.scrapreason (scrapreasonid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_WorkOrder_OrderQty" CHECK (orderqty > 0),
    CONSTRAINT "CK_WorkOrder_ScrappedQty" CHECK (scrappedqty >= 0),
    CONSTRAINT "CK_WorkOrder_EndDate" CHECK (enddate >= startdate OR enddate IS NULL)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.workorder
    OWNER to postgres;

COMMENT ON TABLE prod.workorder
    IS 'Manufacturing work orders.';

COMMENT ON COLUMN prod.workorder.workorderid
    IS 'Primary key for WorkOrder records.';

COMMENT ON COLUMN prod.workorder.productid
    IS 'Product identification number. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.workorder.orderqty
    IS 'Product quantity to build.';

COMMENT ON COLUMN prod.workorder.scrappedqty
    IS 'Quantity that failed inspection.';

COMMENT ON COLUMN prod.workorder.startdate
    IS 'Work order start date.';

COMMENT ON COLUMN prod.workorder.enddate
    IS 'Work order end date.';

COMMENT ON COLUMN prod.workorder.duedate
    IS 'Work order due date.';

COMMENT ON COLUMN prod.workorder.scrapreasonid
    IS 'Reason for inspection failure.';