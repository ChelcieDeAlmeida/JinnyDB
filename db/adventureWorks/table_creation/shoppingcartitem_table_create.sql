-- Table: prod.shoppingcartitem

CREATE SEQUENCE IF NOT EXISTS prod.shoppingcartitem_shoppingcartitemid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.shoppingcartitem;

CREATE TABLE IF NOT EXISTS prod.shoppingcartitem
(
    shoppingcartitemid integer NOT NULL DEFAULT nextval('prod.shoppingcartitem_shoppingcartitemid_seq'::regclass),
    shoppingcartid character varying(50) COLLATE pg_catalog."default" NOT NULL,
    quantity integer NOT NULL DEFAULT 1,
    productid integer NOT NULL,
    datecreated timestamp without time zone NOT NULL DEFAULT now(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY (shoppingcartitemid),
    CONSTRAINT "FK_ShoppingCartItem_Product_ProductID" FOREIGN KEY (productid)
        REFERENCES prod.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK (quantity >= 1)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.shoppingcartitem
    OWNER to postgres;

COMMENT ON TABLE prod.shoppingcartitem
    IS 'Contains online customer orders until the order is submitted or cancelled.';

COMMENT ON COLUMN prod.shoppingcartitem.shoppingcartitemid
    IS 'Primary key for ShoppingCartItem records.';

COMMENT ON COLUMN prod.shoppingcartitem.shoppingcartid
    IS 'Shopping cart identification number.';

COMMENT ON COLUMN prod.shoppingcartitem.quantity
    IS 'Product quantity ordered.';

COMMENT ON COLUMN prod.shoppingcartitem.productid
    IS 'Product ordered. Foreign key to Product.ProductID.';

COMMENT ON COLUMN prod.shoppingcartitem.datecreated
    IS 'Date the time the record was created.';