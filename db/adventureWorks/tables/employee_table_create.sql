-- Table: prod.employee

-- DROP TABLE IF EXISTS prod.employee;

SET search_path TO prod;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS prod.employee
(
    businessentityid integer NOT NULL,
    nationalidnumber character varying(15) COLLATE pg_catalog."default" NOT NULL,
    loginid character varying(256) COLLATE pg_catalog."default" NOT NULL,
    jobtitle character varying(50) COLLATE pg_catalog."default" NOT NULL,
    birthdate date NOT NULL,
    maritalstatus character(1) COLLATE pg_catalog."default" NOT NULL,
    gender character(1) COLLATE pg_catalog."default" NOT NULL,
    hiredate date NOT NULL,
    salariedflag boolean NOT NULL DEFAULT true,
    vacationhours smallint NOT NULL DEFAULT 0,
    sickleavehours smallint NOT NULL DEFAULT 0,
    currentflag boolean NOT NULL DEFAULT true,
    rowguid uuid NOT NULL DEFAULT uuid_generate_v1(),
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    organizationnode character varying COLLATE pg_catalog."default" DEFAULT '/'::character varying,
    CONSTRAINT "PK_Employee_BusinessEntityID" PRIMARY KEY (businessentityid),
    CONSTRAINT "FK_Employee_Person_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.person (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_Employee_BirthDate" CHECK (birthdate >= '1930-01-01'::date AND birthdate <= (now() - '18 years'::interval)),
    CONSTRAINT "CK_Employee_MaritalStatus" CHECK (upper(maritalstatus::text) = ANY (ARRAY['M'::text, 'S'::text])),
    CONSTRAINT "CK_Employee_HireDate" CHECK (hiredate >= '1996-07-01'::date AND hiredate <= (now() + '1 day'::interval)),
    CONSTRAINT "CK_Employee_Gender" CHECK (upper(gender::text) = ANY (ARRAY['M'::text, 'F'::text])),
    CONSTRAINT "CK_Employee_VacationHours" CHECK (vacationhours >= '-40'::integer AND vacationhours <= 240),
    CONSTRAINT "CK_Employee_SickLeaveHours" CHECK (sickleavehours >= 0 AND sickleavehours <= 120)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.employee
    OWNER to postgres;

COMMENT ON TABLE prod.employee
    IS 'Employee information such as salary, department, and title.';

COMMENT ON COLUMN prod.employee.businessentityid
    IS 'Primary key for Employee records.  Foreign key to BusinessEntity.BusinessEntityID.';

COMMENT ON COLUMN prod.employee.nationalidnumber
    IS 'Unique national identification number such as a social security number.';

COMMENT ON COLUMN prod.employee.loginid
    IS 'Network login.';

COMMENT ON COLUMN prod.employee.jobtitle
    IS 'Work title such as Buyer or Sales Representative.';

COMMENT ON COLUMN prod.employee.birthdate
    IS 'Date of birth.';

COMMENT ON COLUMN prod.employee.maritalstatus
    IS 'M = Married, S = Single';

COMMENT ON COLUMN prod.employee.gender
    IS 'M = Male, F = Female';

COMMENT ON COLUMN prod.employee.hiredate
    IS 'Employee hired on this date.';

COMMENT ON COLUMN prod.employee.salariedflag
    IS 'Job classification. 0 = Hourly, not exempt from collective bargaining. 1 = Salaried, exempt from collective bargaining.';

COMMENT ON COLUMN prod.employee.vacationhours
    IS 'Number of available vacation hours.';

COMMENT ON COLUMN prod.employee.sickleavehours
    IS 'Number of available sick leave hours.';

COMMENT ON COLUMN prod.employee.currentflag
    IS '0 = Inactive, 1 = Active';

COMMENT ON COLUMN prod.employee.organizationnode
    IS 'Where the employee is located in corporate hierarchy.';