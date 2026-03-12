-- Create dimension tables

SELECT DISTINCT Department
INTO DimDepartment
FROM HR_Analytics

SELECT DISTINCT JobRole
INTO DimJobRole
FROM HR_Analytics

SELECT DISTINCT MaritalStatus
INTO DimMaritalStatus
FROM HR_Analytics

SELECT DISTINCT EducationField
INTO DimEducationField
FROM HR_Analytics

SELECT DISTINCT AgeGroup
INTO DimAgeGroup
FROM HR_Analytics

SELECT DISTINCT BusinessTravel
INTO DimBusinessTravel
FROM HR_Analytics

SELECT DISTINCT SalarySlab
INTO DimSalarySlab
FROM HR_Analytics

SELECT DISTINCT Gender
INTO DimGender
FROM HR_Analytics

-- Add dimension primary keys

ALTER TABLE DimDepartment
ADD DepartmentId INT IDENTITY PRIMARY KEY

ALTER TABLE DimJobRole
ADD JobRoleId INT IDENTITY PRIMARY KEY

ALTER TABLE DimMaritalStatus
ADD MaritalStatusId INT IDENTITY PRIMARY KEY

ALTER TABLE DimEducationField
ADD EducationFieldId INT IDENTITY PRIMARY KEY

ALTER TABLE DimAgeGroup
ADD AgeGroupId INT IDENTITY PRIMARY KEY

ALTER TABLE DimBusinessTravel
ADD BusinessTravelId INT IDENTITY PRIMARY KEY

ALTER TABLE DimSalarySlab
ADD SalarySlabId INT IDENTITY PRIMARY KEY

ALTER TABLE DimGender
ADD GenderId INT IDENTITY PRIMARY KEY

GO

-- Create fact table

SELECT 
    HRA.EmpID,
    HRA.Age,
    AG.AgeGroupId as AgeGroupId,
    HRA.Attrition,
    BT.BusinessTravelId as BusinessTravelId,
    D.DepartmentId as DepartmentId,
    HRA.DistanceFromHome,
    HRA.Education,
    EF.EducationFieldId as EducationFieldId,
    --HRA.EmployeeCount, --This has the same value for all records, useless for analysis
    HRA.EmployeeNumber,
    HRA.EnvironmentSatisfaction,
    G.GenderId as GenderId,
    HRA.HourlyRate,
    HRA.JobInvolvement,
    HRA.JobLevel,
    JR.JobRoleId as JobRoleId,
    HRA.JobSatisfaction,
    MS.MaritalStatusId as MaritalStatusId,
    HRA.MonthlyIncome,
    SS.SalarySlabId as SalarySlabId,
    HRA.MonthlyRate,
    HRA.NumCompaniesWorked,
    --HRA.Over18, --This has the same value for all records, useless for analysis
    HRA.OverTime,
    HRA.PercentSalaryHike,
    HRA.PerformanceRating,
    HRA.RelationshipSatisfaction,
    HRA.StandardHours,
    HRA.StockOptionLevel,
    HRA.TotalWorkingYears,
    HRA.TrainingTimesLastYear,
    HRA.WorkLifeBalance,
    HRA.YearsAtCompany,
    HRA.YearsInCurrentRole,
    HRA.YearsSinceLastPromotion,
    HRA.YearsWithCurrManager,
    HRA.DailyRate
INTO FactEmployee
FROM dbo.HR_Analytics HRA
    inner join dbo.DimAgeGroup AG on AG.AgeGroup = HRA.AgeGroup
    inner join dbo.DimBusinessTravel BT on BT.BusinessTravel = HRA.BusinessTravel
    inner join dbo.DimDepartment D on D.Department = HRA.Department
    inner join dbo.DimEducationField EF on EF.EducationField = HRA.EducationField
    inner join dbo.DimGender G on G.Gender = HRA.Gender
    inner join dbo.DimJobRole JR on JR.JobRole = HRA.JobRole
    inner join dbo.DimMaritalStatus MS on MS.MaritalStatus = HRA.MaritalStatus
    inner join dbo.DimSalarySlab SS on SS.SalarySlab = HRA.SalarySlab

GO

-- Add Foreign Keys

ALTER TABLE FactEmployee
ADD CONSTRAINT FK_FactEmployee_AgeGroup
FOREIGN KEY (AgeGroupId)
REFERENCES DimAgeGroup(AgeGroupId)

ALTER TABLE FactEmployee
ADD CONSTRAINT FK_FactEmployee_BusinessTravel
FOREIGN KEY (BusinessTravelId)
REFERENCES DimBusinessTravel(BusinessTravelId)

ALTER TABLE FactEmployee
ADD CONSTRAINT FK_FactEmployee_Department
FOREIGN KEY (DepartmentId)
REFERENCES DimDepartment(DepartmentId)

ALTER TABLE FactEmployee
ADD CONSTRAINT FK_FactEmployee_EducationField
FOREIGN KEY (EducationFieldId)
REFERENCES DimEducationField(EducationFieldId)

ALTER TABLE FactEmployee
ADD CONSTRAINT FK_FactEmployee_Gender
FOREIGN KEY (GenderId)
REFERENCES DimGender(GenderId)

ALTER TABLE FactEmployee
ADD CONSTRAINT FK_FactEmployee_JobRole
FOREIGN KEY (JobRoleId)
REFERENCES DimJobRole(JobRoleId)

ALTER TABLE FactEmployee
ADD CONSTRAINT FK_FactEmployee_MaritalStatus
FOREIGN KEY (MaritalStatusId)
REFERENCES DimMaritalStatus(MaritalStatusId)

ALTER TABLE FactEmployee
ADD CONSTRAINT FK_FactEmployee_SalarySlab
FOREIGN KEY (SalarySlabId)
REFERENCES DimSalarySlab(SalarySlabId)

GO