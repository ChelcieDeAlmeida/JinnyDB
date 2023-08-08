-- Table: prod.billofmaterials


CREATE SEQUENCE IF NOT EXISTS prod.billofmaterials_billofmaterialsid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.billofmaterials;

CREATE TABLE IF NOT EXISTS prod.billofmaterials
(
    billofmaterialsid integer NOT NULL DEFAULT nextval('prod.billofmaterials_billofmaterialsid_seq'::regclass),
    productassemblyid integer,
    componentid integer NOT NULL,
    startdate timestamp without time zone NOT NULL DEFAULT now(),
    enddate timestamp without time zone,
    unitmeasurecode character(3) COLLATE pg_catalog."default" NOT NULL,
    bomlevel smallint NOT NULL,
    perassemblyqty numeric(8,2) NOT NULL DEFAULT 1.00,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID" PRIMARY KEY (billofmaterialsid),
    CONSTRAINT "FK_BillOfMaterials_Product_ComponentID" FOREIGN KEY (componentid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID" FOREIGN KEY (productassemblyid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unitmeasurecode)
        REFERENCES prod.unitmeasure (unitmeasurecode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_BillOfMaterials_EndDate" CHECK (enddate > startdate OR enddate IS NULL),
    CONSTRAINT "CK_BillOfMaterials_ProductAssemblyID" CHECK (productassemblyid <> componentid),
    CONSTRAINT "CK_BillOfMaterials_BOMLevel" CHECK (productassemblyid IS NULL AND bomlevel = 0 AND perassemblyqty = 1.00 OR productassemblyid IS NOT NULL AND bomlevel >= 1),
    CONSTRAINT "CK_BillOfMaterials_PerAssemblyQty" CHECK (perassemblyqty >= 1.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.billofmaterials
    OWNER to postgres;

COMMENT ON TABLE prod.billofmaterials
    IS 'Items required to make bicycles and bicycle subassemblies. It identifies the heirarchical relationship between a parent product and its components.';

COMMENT ON COLUMN prod.billofmaterials.billofmaterialsid
    IS 'Primary key for BillOfMaterials records.';

COMMENT ON COLUMN prod.billofmaterials.productassemblyid
    IS 'Parent product identification number. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.billofmaterials.componentid
    IS 'Component identification number. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.billofmaterials.startdate
    IS 'Date the component started being used in the assembly item.';

COMMENT ON COLUMN prod.billofmaterials.enddate
    IS 'Date the component stopped being used in the assembly item.';

COMMENT ON COLUMN prod.billofmaterials.unitmeasurecode
    IS 'Standard code identifying the unit of measure for the quantity.';

COMMENT ON COLUMN prod.billofmaterials.bomlevel
    IS 'Indicates the depth the component is from its parent (AssemblyID).';

COMMENT ON COLUMN prod.billofmaterials.perassemblyqty
    IS 'Quantity of the component needed to create the assembly.';