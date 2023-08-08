-- Table: prod.department

-- Sequence: prod.department_departmentid_seq

-- DROP SEQUENCE IF EXISTS prod.department_departmentid_seq;

CREATE SEQUENCE IF NOT EXISTS prod.department_departmentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.department;

CREATE TABLE IF NOT EXISTS prod.department
(
    departmentid integer NOT NULL DEFAULT nextval('prod.department_departmentid_seq'::regclass),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    groupname character varying COLLATE pg_catalog."default" NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY (departmentid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.department
    OWNER to postgres;

COMMENT ON TABLE prod.department
    IS 'Lookup table containing the departments within the Adventure Works Cycles company.';

COMMENT ON COLUMN prod.department.departmentid
    IS 'Primary key for Department records.';

COMMENT ON COLUMN prod.department.name
    IS 'Name of the department.';

COMMENT ON COLUMN prod.department.groupname
    IS 'Name of the group to which the department belongs.';
	