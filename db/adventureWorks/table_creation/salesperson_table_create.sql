-- Table: prod.salesperson

SET search_path TO prod;

-- DROP TABLE IF EXISTS prod.salesperson;

CREATE TABLE IF NOT EXISTS prod.salesperson
(
    businessentityid integer NOT NULL,
    territoryid integer,
    salesquota numeric,
    bonus numeric NOT NULL DEFAULT 0.00,
    commissionpct numeric NOT NULL DEFAULT 0.00,
    salesytd numeric NOT NULL DEFAULT 0.00,
    saleslastyear numeric NOT NULL DEFAULT 0.00,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY (businessentityid),
    CONSTRAINT "FK_SalesPerson_Employee_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.employee (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_SalesPerson_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid)
        REFERENCES prod.salesterritory (territoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_SalesPerson_SalesQuota" CHECK (salesquota > 0.00),
    CONSTRAINT "CK_SalesPerson_Bonus" CHECK (bonus >= 0.00),
    CONSTRAINT "CK_SalesPerson_CommissionPct" CHECK (commissionpct >= 0.00),
    CONSTRAINT "CK_SalesPerson_SalesYTD" CHECK (salesytd >= 0.00),
    CONSTRAINT "CK_SalesPerson_SalesLastYear" CHECK (saleslastyear >= 0.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.salesperson
    OWNER to postgres;

COMMENT ON TABLE prod.salesperson
    IS 'Sales representative current information.';

COMMENT ON COLUMN prod.salesperson.businessentityid
    IS 'Primary key for SalesPerson records. Foreign key to Employee.BusinessEntityID';

COMMENT ON COLUMN prod.salesperson.territoryid
    IS 'Territory currently assigned to. Foreign key to SalesTerritory.SalesTerritoryID.';

COMMENT ON COLUMN prod.salesperson.salesquota
    IS 'Projected yearly sales.';

COMMENT ON COLUMN prod.salesperson.bonus
    IS 'Bonus due if quota is met.';

COMMENT ON COLUMN prod.salesperson.commissionpct
    IS 'Commision percent received per sale.';

COMMENT ON COLUMN prod.salesperson.salesytd
    IS 'Sales total year to date.';

COMMENT ON COLUMN prod.salesperson.saleslastyear
    IS 'Sales total of previous year.';