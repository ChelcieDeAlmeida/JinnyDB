-- Table: prod.salesorderheader

SET search_path TO prod;

CREATE SEQUENCE IF NOT EXISTS prod.salesorderheader_salesorderid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.salesorderheader;

CREATE TABLE IF NOT EXISTS prod.salesorderheader
(
    salesorderid integer NOT NULL DEFAULT nextval('prod.salesorderheader_salesorderid_seq'::regclass),
    revisionnumber smallint NOT NULL DEFAULT 0,
    orderdate timestamp without time zone NOT NULL DEFAULT now(),
    duedate timestamp without time zone NOT NULL,
    shipdate timestamp without time zone,
    status smallint NOT NULL DEFAULT 1,
    onlineorderflag boolean NOT NULL DEFAULT true,
    purchaseordernumber character varying COLLATE pg_catalog."default",
    accountnumber character varying COLLATE pg_catalog."default",
    customerid integer NOT NULL,
    salespersonid integer,
    territoryid integer,
    billtoaddressid integer NOT NULL,
    shiptoaddressid integer NOT NULL,
    shipmethodid integer NOT NULL,
    creditcardid integer,
    creditcardapprovalcode character varying(15) COLLATE pg_catalog."default",
    currencyrateid integer,
    subtotal numeric NOT NULL DEFAULT 0.00,
    taxamt numeric NOT NULL DEFAULT 0.00,
    freight numeric NOT NULL DEFAULT 0.00,
    totaldue numeric,
    comment character varying(128) COLLATE pg_catalog."default",
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" PRIMARY KEY (salesorderid),
    CONSTRAINT "FK_SalesOrderHeader_Address_BillToAddressID" FOREIGN KEY (billtoaddressid)
        REFERENCES prod.address (addressid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_SalesOrderHeader_Address_ShipToAddressID" FOREIGN KEY (shiptoaddressid)
        REFERENCES prod.address (addressid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_SalesOrderHeader_CreditCard_CreditCardID" FOREIGN KEY (creditcardid)
        REFERENCES prod.creditcard (creditcardid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_SalesOrderHeader_CurrencyRate_CurrencyRateID" FOREIGN KEY (currencyrateid)
        REFERENCES prod.currencyrate (currencyrateid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_SalesOrderHeader_Customer_CustomerID" FOREIGN KEY (customerid)
        REFERENCES prod.customer (customerid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_SalesOrderHeader_SalesPerson_SalesPersonID" FOREIGN KEY (salespersonid)
        REFERENCES prod.salesperson (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_SalesOrderHeader_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid)
        REFERENCES prod.salesterritory (territoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_SalesOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (shipmethodid)
        REFERENCES prod.shipmethod (shipmethodid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_SalesOrderHeader_Status" CHECK (status >= 0 AND status <= 8),
    CONSTRAINT "CK_SalesOrderHeader_DueDate" CHECK (duedate >= orderdate),
    CONSTRAINT "CK_SalesOrderHeader_ShipDate" CHECK (shipdate >= orderdate OR shipdate IS NULL),
    CONSTRAINT "CK_SalesOrderHeader_SubTotal" CHECK (subtotal >= 0.00),
    CONSTRAINT "CK_SalesOrderHeader_TaxAmt" CHECK (taxamt >= 0.00),
    CONSTRAINT "CK_SalesOrderHeader_Freight" CHECK (freight >= 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.salesorderheader
    OWNER to postgres;

COMMENT ON TABLE prod.salesorderheader
    IS 'General sales order information.';

COMMENT ON COLUMN prod.salesorderheader.salesorderid
    IS 'Primary key.';

COMMENT ON COLUMN prod.salesorderheader.revisionnumber
    IS 'Incremental number to track changes to the sales order over time.';

COMMENT ON COLUMN prod.salesorderheader.orderdate
    IS 'Dates the sales order was created.';

COMMENT ON COLUMN prod.salesorderheader.duedate
    IS 'Date the order is due to the customer.';

COMMENT ON COLUMN prod.salesorderheader.shipdate
    IS 'Date the order was shipped to the customer.';

COMMENT ON COLUMN prod.salesorderheader.status
    IS 'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled';

COMMENT ON COLUMN prod.salesorderheader.onlineorderflag
    IS '0 = Order placed by sales person. 1 = Order placed online by customer.';

COMMENT ON COLUMN prod.salesorderheader.purchaseordernumber
    IS 'Customer purchase order number reference.';

COMMENT ON COLUMN prod.salesorderheader.accountnumber
    IS 'Financial accounting number reference.';

COMMENT ON COLUMN prod.salesorderheader.customerid
    IS 'Customer identification number. Foreign key to Customer.BusinessEntityID.';

COMMENT ON COLUMN prod.salesorderheader.salespersonid
    IS 'Sales person who created the sales order. Foreign key to SalesPerson.BusinessEntityID.';

COMMENT ON COLUMN prod.salesorderheader.territoryid
    IS 'Territory in which the sale was made. Foreign key to SalesTerritory.SalesTerritoryID.';

COMMENT ON COLUMN prod.salesorderheader.billtoaddressid
    IS 'Customer billing address. Foreign key to Address.AddressID.';

COMMENT ON COLUMN prod.salesorderheader.shiptoaddressid
    IS 'Customer shipping address. Foreign key to Address.AddressID.';

COMMENT ON COLUMN prod.salesorderheader.shipmethodid
    IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';

COMMENT ON COLUMN prod.salesorderheader.creditcardid
    IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';

COMMENT ON COLUMN prod.salesorderheader.creditcardapprovalcode
    IS 'Approval code provided by the credit card company.';

COMMENT ON COLUMN prod.salesorderheader.currencyrateid
    IS 'Currency exchange rate used. Foreign key to CurrencyRate.CurrencyRateID.';

COMMENT ON COLUMN prod.salesorderheader.subtotal
    IS 'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.';

COMMENT ON COLUMN prod.salesorderheader.taxamt
    IS 'Tax amount.';

COMMENT ON COLUMN prod.salesorderheader.freight
    IS 'Shipping cost.';

COMMENT ON COLUMN prod.salesorderheader.totaldue
    IS 'Total due from customer. Computed as Subtotal + TaxAmt + Freight.';

COMMENT ON COLUMN prod.salesorderheader.comment
    IS 'Sales representative comments.';