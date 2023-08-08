-- Table: prod.salesterritoryhistory

SET search_path TO prod;

-- DROP TABLE IF EXISTS prod.salesterritoryhistory;

CREATE TABLE IF NOT EXISTS prod.salesterritoryhistory
(
    businessentityid integer NOT NULL,
    territoryid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID" PRIMARY KEY (businessentityid, startdate, territoryid),
    CONSTRAINT "FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.salesperson (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_SalesTerritoryHistory_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid)
        REFERENCES prod.salesterritory (territoryid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_SalesTerritoryHistory_EndDate" CHECK (enddate >= startdate OR enddate IS NULL)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.salesterritoryhistory
    OWNER to postgres;

COMMENT ON TABLE prod.salesterritoryhistory
    IS 'Sales representative transfers to other sales territories.';

COMMENT ON COLUMN prod.salesterritoryhistory.businessentityid
    IS 'Primary key. The sales rep.  Foreign key to SalesPerson.BusinessEntityID.';

COMMENT ON COLUMN prod.salesterritoryhistory.territoryid
    IS 'Primary key. Territory identification number. Foreign key to SalesTerritory.SalesTerritoryID.';

COMMENT ON COLUMN prod.salesterritoryhistory.startdate
    IS 'Primary key. Date the sales representive started work in the territory.';

COMMENT ON COLUMN prod.salesterritoryhistory.enddate
    IS 'Date the sales representative left work in the territory.';