USE hdo488
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PCreateBankTables'))
   EXEC('CREATE PROCEDURE [PCreateBankTables] AS BEGIN SET NOCOUNT ON; END');
GO
 
-- Update SP to hold the script below.
ALTER PROCEDURE [PCreateBankTables]
 
AS
 
SET NOCOUNT ON;
SET XACT_ABORT ON;
 	
	BEGIN TRY
 
		-- Scripts to create bank tables
        -- Drop table if it already exitsted
        IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'TBranch')) DROP TABLE TBranch 
        IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'TCustomer')) DROP TABLE TCustomer 
        IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'TAccount')) DROP TABLE TAccount
        IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'TTransaction')) DROP TABLE TTransaction
        IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'TLoan')) DROP TABLE TLoan
        IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'TLoanPayment')) DROP TABLE TLoanPayment
        IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'TEmployee')) DROP TABLE TEmployee
        IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'TWorkingAt')) DROP TABLE TWorkingAt

        CREATE TABLE TBranch (
            BranchID INT IDENTITY,
            Name NVARCHAR(100) NOT NULL,
            IsOffice INT DEFAULT 0, -- 0 is branch, -- 1 is office
            CityName NVARCHAR(100) NOT NULL,
            PostalCode NVARCHAR(10) NOT NULL,
            CONSTRAINT PK_Branch PRIMARY KEY (BranchID),
            CONSTRAINT Check_BranchName UNIQUE (Name)
        )
        
        CREATE TABLE TEmployee (
            EmployeeID INT IDENTITY,
            StartDate DATE NOT NULL DEFAULT GETDATE(),
            FirstName NVARCHAR(80) NOT NULL,
            LastName NVARCHAR(80) NOT NULL,
            Position NVARCHAR(100) NOT NULL,
            IsManagedBy NVARCHAR(100) NOT NULL,
            PostalAddressCode NVARCHAR(20) NOT NULL,
            CONSTRAINT PK_Employee PRIMARY KEY (EmployeeID)
        )
        
        CREATE TABLE TCustomer (
            CustomerID INT IDENTITY,
            FirstName NVARCHAR(100) NOT NULL,
            LastName NVARCHAR(100) NOT NULL,
            HomeAdrress NVARCHAR(100) NOT NULL,
            PersonalRepresentative NVARCHAR(100),
            LoanOfficer NVARCHAR(100), -- To know who is loan officer of customer
            CONSTRAINT PK_Customer PRIMARY KEY (CustomerID)
        )
        
        CREATE TABLE TAccount (
            AccountID INT IDENTITY,
            AccountNumber INT UNIQUE,
            CustomerID INT FOREIGN KEY REFERENCES TCustomer(CustomerID),
            BranchID INT FOREIGN KEY REFERENCES TBranch(BranchID),
            CurrentBalance MONEY NOT NULL DEFAULT 0,
            Type NVARCHAR(80) NOT NULL,
            MinimumRequiredBalance MONEY NOT NULL DEFAULT 500, -- default $500
            InterestRate FLOAT NOT NULL, -- 4% for saving acc , 1% for checking acc
            MonthlyServiceFee MONEY NOT NULL, -- fee cost $25
            CONSTRAINT PK_Account PRIMARY KEY (AccountID)
        )
        
        CREATE TABLE TTransaction (
            TransactionID INT IDENTITY,
            AccountID INT FOREIGN KEY REFERENCES TAccount(AccountID),
            Amount MONEY NOT NULL,
            Type NVARCHAR(100) NOT NULL,
            TransactionDateTime DATETIME2 NOT NULL,
            CheckNumber INT, -- only for checking acc and withdrawals
            CONSTRAINT PK_Transaction PRIMARY KEY (TransactionID)	
        )
        
        CREATE TABLE TLoan (
            LoanID INT IDENTITY,
            CustomerID INT FOREIGN KEY REFERENCES TCustomer(CustomerID),
            BranchID INT FOREIGN KEY REFERENCES TBranch(BranchID),
            Kind NVARCHAR(100) NOT NULL,
            Amount MONEY NOT NULL,
            CONSTRAINT PK_Loan PRIMARY KEY (LoanID)
        )
        
        CREATE TABLE TLoanPayment (
            PaymentNumber INT NOT NULL,
            LoanID INT FOREIGN KEY REFERENCES TLoan(LoanID),
            MonthlyPaymentDate DATE NOT NULL DEFAULT GETDATE(),
            Amount MONEY NOT NULL,
            CONSTRAINT PK_LoanPayment PRIMARY KEY (PaymentNumber, LoanID)
        )
        
        CREATE TABLE TWorkingAt (
            EmployeeID INT FOREIGN KEY REFERENCES TEmployee(EmployeeID),
            BranchID INT FOREIGN KEY REFERENCES TBranch(BranchID),
            CONSTRAINT PK_WorkingAt PRIMARY KEY (EmployeeID, BranchID)
        )
        
        -- Return number to test if script run successfully
		RETURN 28 -- or any "success" code you wish.
 
	END TRY
 
	BEGIN CATCH
 
		DECLARE @msg nvarchar(2048) = error_message()
		RAISERROR (@msg, 16, 1)
        -- Return number to test if script run fail
		RETURN -1
 
	END CATCH
GO

EXEC PCreateBankTables
GO
