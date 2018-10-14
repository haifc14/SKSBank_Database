USE hdo488 -- select database
GO

-- Populate data to bank tables 

-- Populate data TBranch table
	-- Create store procedure to insert into TBranch table
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PInsertTableBranch'))
 	EXEC('CREATE PROCEDURE [PInsertTableBranch] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PInsertTableBranch]
	    @BranchName NVARCHAR(100) = NULL,
	    @IsOffice INT = NULL,
	    @CityName NVARCHAR(100) = NULL,
	    @PostalCode NVARCHAR(100) = NULL

	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN

	        IF @BranchName IS NULL OR LEN(@BranchName) = 0
	            THROW 50001, 'INVALID Branch Name', 1;

	        IF @IsOffice IS NULL OR LEN(@IsOffice) = 0
	            THROW 50001, 'INVALID IsOffice', 1;

	        IF @CityName IS NULL OR LEN(@CityName) = 0
	            THROW 50001, 'INVALID City Name', 1;

	        IF @PostalCode IS NULL OR LEN(@PostalCode) = 0
	            THROW 50001, 'INVALID Postal Code', 1;

	        INSERT INTO TBranch (Name, IsOffice, CityName, PostalCode)
	        VALUES(@BranchName, @IsOffice, @CityName, @PostalCode)

	    END 
	GO

	-- EXEC SP PInsertTableBranch
	EXEC PInsertTableBranch
         @BranchName = 'SKS_Branch01',
         @IsOffice = 0,
         @CityName = 'Calgary',
         @PostalCode = 'T4A6M4';
    PRINT 'Row was inserted.';
    GO

	EXEC PInsertTableBranch
         @BranchName = 'SKS_Branch08',
         @IsOffice = 0,
         @CityName = 'Toronto',
         @PostalCode = 'T4A6M4';
    PRINT 'Row was inserted.';
    GO

    EXEC PInsertTableBranch
         @BranchName = 'SKS_Branch07',
         @IsOffice = 0,
         @CityName = 'Toronto',
         @PostalCode = 'T2A6H4';
    PRINT 'Row was inserted.';
    GO

    EXEC PInsertTableBranch
         @BranchName = 'SKS_Branch06',
         @IsOffice = 0,
         @CityName = 'Edmonton',
         @PostalCode = 'T8K6M4';
    PRINT 'Row was inserted.';
    GO

    EXEC PInsertTableBranch
         @BranchName = 'SKS_Branch05',
         @IsOffice = 0,
         @CityName = 'Edmonton',
         @PostalCode = 'T2A6M4';
    PRINT 'Row was inserted.';
    GO

    EXEC PInsertTableBranch
         @BranchName = 'SKS_Office02',
         @IsOffice = 1,
         @CityName = 'Vancouver',
         @PostalCode = 'T2J6M4';
    PRINT 'Row was inserted.';
    GO

    EXEC PInsertTableBranch
         @BranchName = 'SKS_Branch04',
         @IsOffice = 0,
         @CityName = 'Vancouver',
         @PostalCode = 'P2A6M4';
    PRINT 'Row was inserted.';
    GO

    EXEC PInsertTableBranch
         @BranchName = 'SKS_Branch03',
         @IsOffice = 0,
         @CityName = 'Vancouver',
         @PostalCode = 'K2A6M4';
    PRINT 'Row was inserted.';
    GO

    EXEC PInsertTableBranch
         @BranchName = 'SKS_Office01',
         @IsOffice = 1,
         @CityName = 'Calgary',
         @PostalCode = 'B2A6M4';
    PRINT 'Row was inserted.';
    GO

    EXEC PInsertTableBranch
         @BranchName = 'SKS_Branch02',
         @IsOffice = 0,
         @CityName = 'Calgary',
         @PostalCode = 'T2A6M4';
    PRINT 'Row was inserted.';
    GO

-- Populate data TEmployee table
	-- Create Store Procedure to insert data Employee table
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PInsertTableEmployee'))
 	EXEC('CREATE PROCEDURE [PInsertTableEmployee] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PInsertTableEmployee]
	    @StartDate DATE = NULL,
	    @FirstName NVARCHAR(80) = NULL,
	    @LastName NVARCHAR(80) = NULL,
	    @Position NVARCHAR(100) = NULL,
        @IsManagedBy NVARCHAR(100) = NULL,
        @PostalAddressCode NVARCHAR(20) = NULL

	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN

	        IF @StartDate IS NULL OR @StartDate > GETDATE()
	            THROW 50001, 'INVALID Start Date', 1;

	        IF @FirstName IS NULL OR LEN(@FirstName) = 0
	            THROW 50001, 'INVALID First Name', 1;

	        IF @LastName IS NULL OR LEN(@LastName) = 0
	            THROW 50001, 'INVALID Last Name', 1;

	        IF @Position IS NULL OR LEN(@Position) = 0
	            THROW 50001, 'INVALID employee Position', 1;

            IF @IsManagedBy IS NULL OR LEN(@IsManagedBy) = 0
                THROW 50001, 'INVALID IsManagedBy', 1;

            IF @PostalAddressCode IS NULL OR LEN(@PostalAddressCode) = 0
                THROW 50001, 'INVALID postal code', 1;

	        INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
	        VALUES(@StartDate, @FirstName, @LastName, @Position, @IsManagedBy, @PostalAddressCode)

	    END 
	GO

	-- Execute SP insert Employee by adding data
	EXEC PInsertTableEmployee
	 @StartDate = '2016-01-10',
	 @FirstName = 'Hai',
	 @LastName = 'Do',
	 @Position = 'banker',
	 @IsManagedBy = 'Ryan',
	 @PostalAddressCode = 'T2A6M4'
	PRINT 'Row was inserted';

	EXEC PInsertTableEmployee
     @StartDate = '2010-01-10',
     @FirstName = 'Ryan',
     @LastName = 'Roffal',
     @Position = 'manager',
     @IsManagedBy = 'higherboss',
     @PostalAddressCode = 'T2R6M4'
	PRINT 'Row was inserted';

	EXEC PInsertTableEmployee
     @StartDate = '2016-01-10',
     @FirstName = 'Peter',
     @LastName = 'Kerry',
     @Position = 'banker',
     @IsManagedBy = 'Ryan',
     @PostalAddressCode = 'T2Q6M4'
	PRINT 'Row was inserted';

	EXEC PInsertTableEmployee
     @StartDate = '2012-01-10',
     @FirstName = 'Jelly',
     @LastName = 'Horn',
     @Position = 'banker',
     @IsManagedBy = 'Ryan',
     @PostalAddressCode = 'T2H6K4'
	PRINT 'Row was inserted';

	EXEC PInsertTableEmployee
     @StartDate = '2014-01-10',
     @FirstName = 'John',
     @LastName = 'Smith',
     @Position = 'banker',
     @IsManagedBy = 'Ryan',
     @PostalAddressCode = 'T2B2J9'
	PRINT 'Row was inserted';

	EXEC PInsertTableEmployee
     @StartDate = '2013-01-10',
     @FirstName = 'Anderson',
     @LastName = 'Jayson',
     @Position = 'loan officer',
     @IsManagedBy = 'Ryan',
     @PostalAddressCode = 'T2J6M4'
	PRINT 'Row was inserted';

	EXEC PInsertTableEmployee
     @StartDate = '2018-04-23',
     @FirstName = 'Sandeep',
     @LastName = 'Saini',
     @Position = 'banker',
     @IsManagedBy = 'Ryan',
     @PostalAddressCode = 'J2K6L4'
	PRINT 'Row was inserted';

	EXEC PInsertTableEmployee
     @StartDate = '2017-01-10',
     @FirstName = 'Karamullah',
     @LastName = 'Agha',
     @Position = 'banker',
     @IsManagedBy = 'Ryan',
     @PostalAddressCode = 'K2A6M4'
	PRINT 'Row was inserted';

	EXEC PInsertTableEmployee
     @StartDate = '2015-08-23',
     @FirstName = 'Brijesh',
     @LastName = 'Patel',
     @Position = 'loan officer',
     @IsManagedBy = 'Ryan',
     @PostalAddressCode = 'T9A6M8'
	PRINT 'Row was inserted';

	EXEC PInsertTableEmployee
     @StartDate = '2016-03-17',
     @FirstName = 'Pablo',
     @LastName = 'Winter',
     @Position = 'banker',
     @IsManagedBy = 'Ryan',
     @PostalAddressCode = 'T2Z6K4'
	PRINT 'Row was inserted';

-- Populate data TCustomer table
	-- Create store procedure to insert data to customer table
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PInsertTableCustomer'))
 	EXEC('CREATE PROCEDURE [PInsertTableCustomer] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PInsertTableCustomer]
	    @FirstName NVARCHAR(100) = NULL,
	    @LastName NVARCHAR(100) = NULL,
	    @HomeAdrress NVARCHAR(100) = NULL,
        @PersonalRepresentative NVARCHAR(100) = NULL,
        @LoanOfficer NVARCHAR(100) = NULL

	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN

	        IF @FirstName IS NULL OR LEN(@FirstName) = 0
	            THROW 50001, 'INVALID First Name', 1;

	        IF @LastName IS NULL OR LEN(@LastName) = 0
	            THROW 50001, 'INVALID Last Name', 1;

	        IF @HomeAdrress IS NULL OR LEN(@HomeAdrress) = 0
	            THROW 50001, 'INVALID Home Address', 1;

	        INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
	        VALUES(@FirstName, @LastName, @HomeAdrress, @PersonalRepresentative, @LoanOfficer)

	    END 
	GO

	-- EXEC SP insert Customer table
		EXEC PInsertTableCustomer
		    @FirstName = 'Phuong',
		    @LastName = 'Huynh',
		    @HomeAdrress = '1234 Anland St Calgary',
		    @PersonalRepresentative = NULL,
		    @LoanOfficer = NULL
		PRINT 'Row was inserted';
		GO

		EXEC PInsertTableCustomer
		    @FirstName = 'Mary',
		    @LastName = 'Lany',
		    @HomeAdrress = '7654 Diamond St Toronto',
		    @PersonalRepresentative = NULL,
		    @LoanOfficer = NULL
		PRINT 'Row was inserted';
		GO

		EXEC PInsertTableCustomer
		    @FirstName = 'Khalib',
		    @LastName = 'Harner',
		    @HomeAdrress = '8888 LeDuc St Vancouver',
		    @PersonalRepresentative = NULL,
		    @LoanOfficer = 'Anderson'
		PRINT 'Row was inserted';
		GO

		EXEC PInsertTableCustomer
		    @FirstName = 'Andy',
		    @LastName = 'Mac',
		    @HomeAdrress = '999 Ember St Edmonton',
		    @PersonalRepresentative = NULL,
		    @LoanOfficer = NULL
		PRINT 'Row was inserted';
		GO

		EXEC PInsertTableCustomer
		    @FirstName = 'Klinger',
		    @LastName = 'Macor',
		    @HomeAdrress = '778 36 St Calgary',
		    @PersonalRepresentative = NULL,
		    @LoanOfficer = NULL
		PRINT 'Row was inserted';
		GO

		EXEC PInsertTableCustomer
		    @FirstName = 'Andrew',
		    @LastName = 'Panel',
		    @HomeAdrress = '3456 68 St Toronto',
		    @PersonalRepresentative = 'Peter Jackson',
		    @LoanOfficer = 'Brijesh'
		PRINT 'Row was inserted';
		GO

		EXEC PInsertTableCustomer
		    @FirstName = 'Yen',
		    @LastName = 'Nguyen',
		    @HomeAdrress = '456 BridgeLand St Edmonton',
		    @PersonalRepresentative = NULL,
		    @LoanOfficer = 'Anderson'
		PRINT 'Row was inserted';
		GO

		EXEC PInsertTableCustomer
		    @FirstName = 'Kim',
		    @LastName = 'Huynh',
		    @HomeAdrress = '1234 Anland St Calgary',
		    @PersonalRepresentative = NULL,
		    @LoanOfficer = NULL
		PRINT 'Row was inserted';
		GO

		EXEC PInsertTableCustomer
		    @FirstName = 'Anh',
		    @LastName = 'Mach',
		    @HomeAdrress = '1234 Anland St Calgary',
		    @PersonalRepresentative = NULL,
		    @LoanOfficer = NULL
		PRINT 'Row was inserted';
		GO

		EXEC PInsertTableCustomer
		    @FirstName = 'Ethan',
		    @LastName = 'Do',
		    @HomeAdrress = '789 Sundrige Ave Calgary',
		    @PersonalRepresentative = 'Mary Jane',
		    @LoanOfficer = NULL
		PRINT 'Row was inserted';
		GO

-- Populate data TAccount table
INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, Type,
					  MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
VALUES(1001, 1, 1, 4090, 'checking', 500, 0.01, 0);

INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, Type,
					  MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
VALUES(1004, 1, 1, 560, 'saving', 500, 0.04, 0);

INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, Type,
					  MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
VALUES(1002, 2, 1, 300, 'saving', 500, 0.04, 25);

INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, Type,
					  MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
VALUES(1003, 5, 2, 10200, 'checking', 500, 0.01, 0);

INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, Type,
					  MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
VALUES(1005, 4, 5, 20000, 'checking', 500, 0.01, 0);

INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, Type,
					  MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
VALUES(1006, 8, 8, 350, 'saving', 500, 0.04, 25);

INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, Type,
					  MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
VALUES(1007, 10, 4, 2000, 'checking', 500, 0.01, 0);

INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, Type,
					  MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
VALUES(1008, 10, 4, 350, 'saving', 500, 0.04, 25);

INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, Type,
					  MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
VALUES(1009, 7, 3, 7500, 'checking', 500, 0.01, 0);

INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, Type,
					  MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
VALUES(1010, 5, 7, 8600, 'saving', 500, 0.04, 0);
GO

-- Populate data TTransaction table
INSERT INTO TTransaction (AccountID, Amount, Type, TransactionDateTime, CheckNumber)
VALUES(1, 250, 'deposit', '2014-04-27 07:39:06', Null);

INSERT INTO TTransaction (AccountID, Amount, Type, TransactionDateTime, CheckNumber)
VALUES(2, 200, 'withdraw', '2015-04-19 09:25:16', Null);

INSERT INTO TTransaction (AccountID, Amount, Type, TransactionDateTime, CheckNumber)
VALUES(2, 700, 'deposit', '2015-04-27 10:25:16', Null);

INSERT INTO TTransaction (AccountID, Amount, Type, TransactionDateTime, CheckNumber)
VALUES(4, 500, 'withdraw', '2017-05-10 04:25:16', 12567);

INSERT INTO TTransaction (AccountID, Amount, Type, TransactionDateTime, CheckNumber)
VALUES(7, 1000, 'deposit', '2016-04-26 07:30:36', Null);

INSERT INTO TTransaction (AccountID, Amount, Type, TransactionDateTime, CheckNumber)
VALUES(8, 200, 'deposit', '2018-04-19 01:25:16', Null);

INSERT INTO TTransaction (AccountID, Amount, Type, TransactionDateTime, CheckNumber)
VALUES(5, 7000, 'withdraw', '2015-04-19 09:25:16', 7878);

INSERT INTO TTransaction (AccountID, Amount, Type, TransactionDateTime, CheckNumber)
VALUES(2, 200, 'withdraw', '2015-04-19 09:25:16', Null);

INSERT INTO TTransaction (AccountID, Amount, Type, TransactionDateTime, CheckNumber)
VALUES(10, 550, 'deposit', '2013-07-19 08:25:16', Null);

INSERT INTO TTransaction (AccountID, Amount, Type, TransactionDateTime, CheckNumber)
VALUES(10, 5000, 'withdraw', '2014-07-19 08:25:16', Null);
GO

-- Populate data TLoan table
INSERT INTO TLoan (CustomerID, BranchID, Kind, Amount)
VALUES(1, 2, 'student loan', 20000);

INSERT INTO TLoan (CustomerID, BranchID, Kind, Amount)
VALUES(3, 4, 'business', 500000);

INSERT INTO TLoan (CustomerID, BranchID, Kind, Amount)
VALUES(6, 8, 'personal', 4000);

INSERT INTO TLoan (CustomerID, BranchID, Kind, Amount)
VALUES(6, 7, 'student loan', 25000);

INSERT INTO TLoan (CustomerID, BranchID, Kind, Amount)
VALUES(8, 1, 'business', 12000);

INSERT INTO TLoan (CustomerID, BranchID, Kind, Amount)
VALUES(5, 3, 'personal', 4500);
GO

-- Populate data TLoanPaymemnt table
INSERT INTO TLoanPayment (PaymentNumber, LoanID, MonthlyPaymentDate, Amount)
VALUES(7888, 1, '2016-01-10', 300);

INSERT INTO TLoanPayment (PaymentNumber, LoanID, MonthlyPaymentDate, Amount)
VALUES(7889, 1, '2016-02-10', 440);

INSERT INTO TLoanPayment (PaymentNumber, LoanID, MonthlyPaymentDate, Amount)
VALUES(7888, 2, '2017-03-15', 1700);

INSERT INTO TLoanPayment (PaymentNumber, LoanID, MonthlyPaymentDate, Amount)
VALUES(7889, 2, '2017-04-15', 6000);

INSERT INTO TLoanPayment (PaymentNumber, LoanID, MonthlyPaymentDate, Amount)
VALUES(7998, 3, '2018-08-20', 2000);

INSERT INTO TLoanPayment (PaymentNumber, LoanID, MonthlyPaymentDate, Amount)
VALUES(7999, 3, '2018-09-20', 2000);

INSERT INTO TLoanPayment (PaymentNumber, LoanID, MonthlyPaymentDate, Amount)
VALUES(7999, 5, '2014-04-17', 4500);
GO

-- Populate data TWorkingAt table
INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(1,1);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(1,6);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(2,3);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(2,9);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(3,4);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(4,6);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(5,6);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(5,2);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(6,6);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(7,3);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(8,6);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(9,3);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(10,6);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(4,5);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(7,7);

INSERT INTO TWorkingAt (EmployeeID, BranchID)
VALUES(10,8);
GO





