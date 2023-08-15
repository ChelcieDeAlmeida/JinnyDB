-- Table: prod.shift

-- Sequence: prod.shift_shiftid_seq

-- DROP SEQUENCE IF EXISTS prod.shift_shiftid_seq;

CREATE SEQUENCE IF NOT EXISTS prod.shift_shiftid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;


-- DROP TABLE IF EXISTS prod.shift;

CREATE TABLE IF NOT EXISTS prod.shift
(
    shiftid integer NOT NULL DEFAULT nextval('prod.shift_shiftid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    starttime time without time zone NOT NULL,
    endtime time without time zone NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY (shiftid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.shift
    OWNER to postgres;

COMMENT ON TABLE prod.shift
    IS 'Work shift lookup table.';

COMMENT ON COLUMN prod.shift.shiftid
    IS 'Primary key for Shift records.';

COMMENT ON COLUMN prod.shift.name
    IS 'Shift description.';

COMMENT ON COLUMN prod.shift.starttime
    IS 'Shift start time.';

COMMENT ON COLUMN prod.shift.endtime
    IS 'Shift end time.';