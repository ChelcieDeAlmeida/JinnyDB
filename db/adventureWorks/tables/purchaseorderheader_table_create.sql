-- Table: prod.purchaseorderheader


CREATE SEQUENCE IF NOT EXISTS prod.purchaseorderheader_purchaseorderid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.purchaseorderheader;

CREATE TABLE IF NOT EXISTS prod.purchaseorderheader
(
    purchaseorderid integer NOT NULL DEFAULT nextval('prod.purchaseorderheader_purchaseorderid_seq'::regclass),
    revisionnumber smallint NOT NULL DEFAULT 0,
    status smallint NOT NULL DEFAULT 1,
    employeeid integer NOT NULL,
    vendorid integer NOT NULL,
    shipmethodid integer NOT NULL,
    orderdate timestamp without time zone NOT NULL DEFAULT now(),
    shipdate timestamp without time zone,
    subtotal numeric NOT NULL DEFAULT 0.00,
    taxamt numeric NOT NULL DEFAULT 0.00,
    freight numeric NOT NULL DEFAULT 0.00,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_PurchaseOrderHeader_PurchaseOrderID" PRIMARY KEY (purchaseorderid),
    CONSTRAINT "FK_PurchaseOrderHeader_Employee_EmployeeID" FOREIGN KEY (employeeid)
        REFERENCES prod.employee (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_PurchaseOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (shipmethodid)
        REFERENCES prod.shipmethod (shipmethodid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_PurchaseOrderHeader_Vendor_VendorID" FOREIGN KEY (vendorid)
        REFERENCES prod.vendor (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_PurchaseOrderHeader_Status" CHECK (status >= 1 AND status <= 4),
    CONSTRAINT "CK_PurchaseOrderHeader_ShipDate" CHECK (shipdate >= orderdate OR shipdate IS NULL),
    CONSTRAINT "CK_PurchaseOrderHeader_SubTotal" CHECK (subtotal >= 0.00),
    CONSTRAINT "CK_PurchaseOrderHeader_TaxAmt" CHECK (taxamt >= 0.00),
    CONSTRAINT "CK_PurchaseOrderHeader_Freight" CHECK (freight >= 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.purchaseorderheader
    OWNER to postgres;

COMMENT ON TABLE prod.purchaseorderheader
    IS 'General purchase order information. See PurchaseOrderDetail.';

COMMENT ON COLUMN prod.purchaseorderheader.purchaseorderid
    IS 'Primary key.';

COMMENT ON COLUMN prod.purchaseorderheader.revisionnumber
    IS 'Incremental number to track changes to the purchase order over time.';

COMMENT ON COLUMN prod.purchaseorderheader.status
    IS 'Order current status. 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete';

COMMENT ON COLUMN prod.purchaseorderheader.employeeid
    IS 'Employee who created the purchase order. Foreign key to Employee.BusinessEntityID.';

COMMENT ON COLUMN prod.purchaseorderheader.vendorid
    IS 'Vendor with whom the purchase order is placed. Foreign key to Vendor.BusinessEntityID.';

COMMENT ON COLUMN prod.purchaseorderheader.shipmethodid
    IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';

COMMENT ON COLUMN prod.purchaseorderheader.orderdate
    IS 'Purchase order creation date.';

COMMENT ON COLUMN prod.purchaseorderheader.shipdate
    IS 'Estimated shipment date from the vendor.';

COMMENT ON COLUMN prod.purchaseorderheader.subtotal
    IS 'Purchase order subtotal. Computed as SUM(PurchaseOrderDetail.LineTotal)for the appropriate PurchaseOrderID.';

COMMENT ON COLUMN prod.purchaseorderheader.taxamt
    IS 'Tax amount.';

COMMENT ON COLUMN prod.purchaseorderheader.freight
    IS 'Shipping cost.';