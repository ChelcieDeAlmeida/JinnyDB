-- Table: prod.productreview

CREATE SEQUENCE IF NOT EXISTS prod.productreview_productreviewid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.productreview;

CREATE TABLE IF NOT EXISTS prod.productreview
(
    productreviewid integer NOT NULL DEFAULT nextval('prod.productreview_productreviewid_seq'::regclass),
    productid integer NOT NULL,
    reviewername character varying COLLATE pg_catalog."default" NOT NULL,
    reviewdate timestamp without time zone NOT NULL DEFAULT now(),
    emailaddress character varying(50) COLLATE pg_catalog."default" NOT NULL,
    rating integer NOT NULL,
    comments character varying(3850) COLLATE pg_catalog."default",
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ProductReview_ProductReviewID" PRIMARY KEY (productreviewid),
    CONSTRAINT "FK_ProductReview_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_ProductReview_Rating" CHECK (rating >= 1 AND rating <= 5)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.productreview
    OWNER to postgres;

COMMENT ON TABLE prod.productreview
    IS 'Customer reviews of products they have purchased.';

COMMENT ON COLUMN prod.productreview.productreviewid
    IS 'Primary key for ProductReview records.';

COMMENT ON COLUMN prod.productreview.productid
    IS 'Product identification number. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.productreview.reviewername
    IS 'Name of the reviewer.';

COMMENT ON COLUMN prod.productreview.reviewdate
    IS 'Date review was submitted.';

COMMENT ON COLUMN prod.productreview.emailaddress
    IS 'Reviewer''s e-mail address.';

COMMENT ON COLUMN prod.productreview.rating
    IS 'Product rating given by the reviewer. Scale is 1 to 5 with 5 as the highest rating.';

COMMENT ON COLUMN prod.productreview.comments
    IS 'Reviewer''s comments';