-- Table: prod.productmodelillustration

-- DROP TABLE IF EXISTS prod.productmodelillustration;

CREATE TABLE IF NOT EXISTS prod.productmodelillustration
(
    productmodelid integer NOT NULL,
    illustrationid integer NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID" PRIMARY KEY (productmodelid, illustrationid),
    CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID" FOREIGN KEY (illustrationid)
        REFERENCES prod.illustration (illustrationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID" FOREIGN KEY (productmodelid)
        REFERENCES prod.productmodel (productmodelid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productmodelillustration
    OWNER to postgres;

COMMENT ON TABLE prod.productmodelillustration
    IS 'Cross-reference table mapping product models and illustrations.';

COMMENT ON COLUMN prod.productmodelillustration.productmodelid
    IS 'Primary key. Foreign key to ProductModel.ProductModelID.';

COMMENT ON COLUMN prod.productmodelillustration.illustrationid
    IS 'Primary key. Foreign key to Illustration.IllustrationID.';