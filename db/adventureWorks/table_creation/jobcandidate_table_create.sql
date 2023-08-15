-- Table: prod.jobcandidate


-- Sequence: prod.department_departmentid_seq

-- DROP SEQUENCE IF EXISTS prod.department_departmentid_seq;

CREATE SEQUENCE IF NOT EXISTS prod.jobcandidate_jobcandidateid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE 
    NO MAXVALUE 
    CACHE 1;

-- DROP TABLE IF EXISTS prod.jobcandidate;

CREATE TABLE IF NOT EXISTS prod.jobcandidate
(
    jobcandidateid integer NOT NULL DEFAULT nextval('prod.jobcandidate_jobcandidateid_seq'::regclass),
    businessentityid integer,
    resume xml,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY (jobcandidateid),
    CONSTRAINT "FK_JobCandidate_Employee_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.employee (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.jobcandidate
    OWNER to postgres;

COMMENT ON TABLE prod.jobcandidate
    IS 'RÃ©sumÃ©s submitted to Human Resources by job applicants.';

COMMENT ON COLUMN prod.jobcandidate.jobcandidateid
    IS 'Primary key for JobCandidate records.';

COMMENT ON COLUMN prod.jobcandidate.businessentityid
    IS 'Employee identification number if applicant was hired. Foreign key to Employee.BusinessEntityID.';

COMMENT ON COLUMN prod.jobcandidate.resume
    IS 'RÃ©sumÃ© in XML format.';