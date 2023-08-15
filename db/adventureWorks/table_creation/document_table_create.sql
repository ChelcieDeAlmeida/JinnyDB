-- Table: prod.document

SET search_path TO prod;

-- DROP TABLE IF EXISTS prod.document;

CREATE TABLE IF NOT EXISTS prod.document
(
    title character varying(50) COLLATE pg_catalog."default" NOT NULL,
    owner integer NOT NULL,
    folderflag boolean NOT NULL DEFAULT false,
    filename character varying(400) COLLATE pg_catalog."default" NOT NULL,
    fileextension character varying(8) COLLATE pg_catalog."default",
    revision character(5) COLLATE pg_catalog."default" NOT NULL,
    changenumber integer NOT NULL DEFAULT 0,
    status smallint NOT NULL,
    documentsummary text COLLATE pg_catalog."default",
    document bytea,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    documentnode character varying COLLATE pg_catalog."default" NOT NULL DEFAULT '/'::character varying,
    CONSTRAINT "PK_Document_DocumentNode" PRIMARY KEY (documentnode),
    CONSTRAINT document_rowguid_key UNIQUE (rowguid),
    CONSTRAINT "FK_Document_Employee_Owner" FOREIGN KEY (owner)
        REFERENCES prod.employee (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_Document_Status" CHECK (status >= 1 AND status <= 3)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.document
    OWNER to postgres;

COMMENT ON TABLE prod.document
    IS 'Product maintenance documents.';

COMMENT ON COLUMN prod.document.title
    IS 'Title of the document.';

COMMENT ON COLUMN prod.document.owner
    IS 'Employee who controls the document.  Foreign key to Employee.BusinessEntityID';

COMMENT ON COLUMN prod.document.folderflag
    IS '0 = This is a folder, 1 = This is a document.';

COMMENT ON COLUMN prod.document.filename
    IS 'File name of the document';

COMMENT ON COLUMN prod.document.fileextension
    IS 'File extension indicating the document type. For example, .doc or .txt.';

COMMENT ON COLUMN prod.document.revision
    IS 'Revision number of the document.';

COMMENT ON COLUMN prod.document.changenumber
    IS 'Engineering change approval number.';

COMMENT ON COLUMN prod.document.status
    IS '1 = Pending approval, 2 = Approved, 3 = Obsolete';

COMMENT ON COLUMN prod.document.documentsummary
    IS 'Document abstract.';

COMMENT ON COLUMN prod.document.document
    IS 'Complete document.';

COMMENT ON COLUMN prod.document.rowguid
    IS 'ROWGUIDCOL number uniquely identifying the record. Required for FileStream.';

COMMENT ON COLUMN prod.document.documentnode
    IS 'Primary key for Document records.';