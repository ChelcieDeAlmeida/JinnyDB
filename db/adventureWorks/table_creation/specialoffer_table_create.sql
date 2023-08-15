-- Table: prod.specialoffer
SET search_path TO prod;

CREATE SEQUENCE IF NOT EXISTS prod.specialoffer_specialofferid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.specialoffer;

CREATE TABLE IF NOT EXISTS prod.specialoffer
(
    specialofferid integer NOT NULL DEFAULT nextval('prod.specialoffer_specialofferid_seq'::regclass),
    description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    discountpct numeric NOT NULL DEFAULT 0.00,
    type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    category character varying(50) COLLATE pg_catalog."default" NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone NOT NULL,
    minqty integer NOT NULL DEFAULT 0,
    maxqty integer,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY (specialofferid),
    CONSTRAINT "CK_SpecialOffer_EndDate" CHECK (enddate >= startdate),
    CONSTRAINT "CK_SpecialOffer_DiscountPct" CHECK (discountpct >= 0.00),
    CONSTRAINT "CK_SpecialOffer_MinQty" CHECK (minqty >= 0),
    CONSTRAINT "CK_SpecialOffer_MaxQty" CHECK (maxqty >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.specialoffer
    OWNER to postgres;

COMMENT ON TABLE prod.specialoffer
    IS 'Sale discounts lookup table.';

COMMENT ON COLUMN prod.specialoffer.specialofferid
    IS 'Primary key for SpecialOffer records.';

COMMENT ON COLUMN prod.specialoffer.description
    IS 'Discount description.';

COMMENT ON COLUMN prod.specialoffer.discountpct
    IS 'Discount precentage.';

COMMENT ON COLUMN prod.specialoffer.type
    IS 'Discount type category.';

COMMENT ON COLUMN prod.specialoffer.category
    IS 'Group the discount applies to such as Reseller or Customer.';

COMMENT ON COLUMN prod.specialoffer.startdate
    IS 'Discount start date.';

COMMENT ON COLUMN prod.specialoffer.enddate
    IS 'Discount end date.';

COMMENT ON COLUMN prod.specialoffer.minqty
    IS 'Minimum discount percent allowed.';

COMMENT ON COLUMN prod.specialoffer.maxqty
    IS 'Maximum discount percent allowed.';