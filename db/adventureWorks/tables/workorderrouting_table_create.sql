-- Table: prod.workorderrouting

-- DROP TABLE IF EXISTS prod.workorderrouting;

CREATE TABLE IF NOT EXISTS prod.workorderrouting
(
    workorderid integer NOT NULL,
    productid integer NOT NULL,
    operationsequence smallint NOT NULL,
    locationid smallint NOT NULL,
    scheduledstartdate timestamp without time zone NOT NULL,
    scheduledenddate timestamp without time zone NOT NULL,
    actualstartdate timestamp without time zone,
    actualenddate timestamp without time zone,
    actualresourcehrs numeric(9,4),
    plannedcost numeric NOT NULL,
    actualcost numeric,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence" PRIMARY KEY (workorderid, productid, operationsequence),
    CONSTRAINT "FK_WorkOrderRouting_Location_LocationID" FOREIGN KEY (locationid)
        REFERENCES prod.location (locationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_WorkOrderRouting_WorkOrder_WorkOrderID" FOREIGN KEY (workorderid)
        REFERENCES prod.workorder (workorderid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_WorkOrderRouting_ScheduledEndDate" CHECK (scheduledenddate >= scheduledstartdate),
    CONSTRAINT "CK_WorkOrderRouting_ActualEndDate" CHECK (actualenddate >= actualstartdate OR actualenddate IS NULL OR actualstartdate IS NULL),
    CONSTRAINT "CK_WorkOrderRouting_ActualResourceHrs" CHECK (actualresourcehrs >= 0.0000),
    CONSTRAINT "CK_WorkOrderRouting_PlannedCost" CHECK (plannedcost > 0.00),
    CONSTRAINT "CK_WorkOrderRouting_ActualCost" CHECK (actualcost > 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.workorderrouting
    OWNER to postgres;

COMMENT ON TABLE prod.workorderrouting
    IS 'Work order details.';

COMMENT ON COLUMN prod.workorderrouting.workorderid
    IS 'Primary key. Foreign key to WorkOrder.WorkOrderID.';

COMMENT ON COLUMN prod.workorderrouting.productid
    IS 'Primary key. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.workorderrouting.operationsequence
    IS 'Primary key. Indicates the manufacturing process sequence.';

COMMENT ON COLUMN prod.workorderrouting.locationid
    IS 'Manufacturing location where the part is processed. Foreign key to Location.LocationID.';

COMMENT ON COLUMN prod.workorderrouting.scheduledstartdate
    IS 'Planned manufacturing start date.';

COMMENT ON COLUMN prod.workorderrouting.scheduledenddate
    IS 'Planned manufacturing end date.';

COMMENT ON COLUMN prod.workorderrouting.actualstartdate
    IS 'Actual start date.';

COMMENT ON COLUMN prod.workorderrouting.actualenddate
    IS 'Actual end date.';

COMMENT ON COLUMN prod.workorderrouting.actualresourcehrs
    IS 'Number of manufacturing hours used.';

COMMENT ON COLUMN prod.workorderrouting.plannedcost
    IS 'Estimated manufacturing cost.';

COMMENT ON COLUMN prod.workorderrouting.actualcost
    IS 'Actual manufacturing cost.';