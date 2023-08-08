-- Table: prod.employeedepartmenthistory

-- DROP TABLE IF EXISTS prod.employeedepartmenthistory;

CREATE TABLE IF NOT EXISTS prod.employeedepartmenthistory
(
    businessentityid integer NOT NULL,
    departmentid smallint NOT NULL,
    shiftid smallint NOT NULL,
    startdate date NOT NULL,
    enddate date,
    modifieddate timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm" PRIMARY KEY (businessentityid, startdate, departmentid, shiftid),
    CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" FOREIGN KEY (departmentid)
        REFERENCES prod.department (departmentid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_EmployeeDepartmentHistory_Employee_BusinessEntityID" FOREIGN KEY (businessentityid)
        REFERENCES prod.employee (businessentityid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" FOREIGN KEY (shiftid)
        REFERENCES prod.shift (shiftid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK (enddate >= startdate OR enddate IS NULL)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS prod.employeedepartmenthistory
    OWNER to postgres;

COMMENT ON TABLE prod.employeedepartmenthistory
    IS 'Employee department transfers.';

COMMENT ON COLUMN prod.employeedepartmenthistory.businessentityid
    IS 'Employee identification number. Foreign key to Employee.BusinessEntityID.';

COMMENT ON COLUMN prod.employeedepartmenthistory.departmentid
    IS 'Department in which the employee worked including currently. Foreign key to Department.DepartmentID.';

COMMENT ON COLUMN prod.employeedepartmenthistory.shiftid
    IS 'Identifies which 8-hour shift the employee works. Foreign key to Shift.Shift.ID.';

COMMENT ON COLUMN prod.employeedepartmenthistory.startdate
    IS 'Date the employee started work in the department.';

COMMENT ON COLUMN prod.employeedepartmenthistory.enddate
    IS 'Date the employee left the department. NULL = Current department.';