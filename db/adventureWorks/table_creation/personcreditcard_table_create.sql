-- Table: prod.personcreditcard

-- DROP TABLE IF EXISTS prod.personcreditcard;

CREATE TABLE IF NOT EXISTS prod.personcreditcard
(
    businessentityid integer NOT NULL,
    creditcardid integer NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY (businessentityid, creditcardid),
    CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" FOREIGN KEY (creditcardid)
        REFERENCES prod.creditcard (creditcardid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.person (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.personcreditcard
    OWNER to postgres;

COMMENT ON TABLE prod.personcreditcard
    IS 'Cross-reference table mapping people to their credit card information in the CreditCard table.';

COMMENT ON COLUMN prod.personcreditcard.businessentityid
    IS 'Business entity identification number. Foreign key to Person.BusinessEntityID.';

COMMENT ON COLUMN prod.personcreditcard.creditcardid
    IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';