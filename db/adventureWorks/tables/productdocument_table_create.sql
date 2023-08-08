-- Table: prod.productdocument

-- DROP TABLE IF EXISTS prod.productdocument;

CREATE TABLE IF NOT EXISTS prod.productdocument
(
    productid integer NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    documentnode character varying COLLATE pg_catalog."default" NOT NULL DEFAULT '/'::character varying,
    CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode" PRIMARY KEY (productid, documentnode),
    CONSTRAINT "FK_ProductDocument_Document_DocumentNode" FOREIGN KEY (documentnode)
        REFERENCES prod.document (documentnode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_ProductDocument_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productdocument
    OWNER to postgres;

COMMENT ON TABLE prod.productdocument
    IS 'Cross-reference table mapping products to related product documents.';

COMMENT ON COLUMN prod.productdocument.productid
    IS 'Product identification number. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.productdocument.documentnode
    IS 'Document identification number. Foreign key to Document.DocumentNode.';