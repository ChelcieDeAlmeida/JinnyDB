-- Table: prod.employeepayhistory

-- DROP TABLE IF EXISTS prod.employeepayhistory;

CREATE TABLE IF NOT EXISTS prod.employeepayhistory
(
    businessentityid integer NOT NULL,
    ratechangedate timestamp without time zone NOT NULL,
    rate numeric NOT NULL,
    payfrequency smallint NOT NULL,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate" PRIMARY KEY (businessentityid, ratechangedate),
    CONSTRAINT "FK_EmployeePayHistory_Employee_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.employee (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK (payfrequency = ANY (ARRAY[1, 2])),
    CONSTRAINT "CK_EmployeePayHistory_Rate" CHECK (rate >= 6.50 AND rate <= 200.00)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.employeepayhistory
    OWNER to postgres;

COMMENT ON TABLE prod.employeepayhistory
    IS 'Employee pay history.';

COMMENT ON COLUMN prod.employeepayhistory.businessentityid
    IS 'Employee identification number. Foreign key to Employee.BusinessEntityID.';

COMMENT ON COLUMN prod.employeepayhistory.ratechangedate
    IS 'Date the change in pay is effective';

COMMENT ON COLUMN prod.employeepayhistory.rate
    IS 'Salary hourly rate.';

COMMENT ON COLUMN prod.employeepayhistory.payfrequency
    IS '1 = Salary received monthly, 2 = Salary received biweekly';