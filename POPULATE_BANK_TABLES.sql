
-- Select database
USE hdo488
GO


-- Business Rules to validate the data before they are inserted
-- into bank tables

-- Adding data to tables is done on file AddDataToBankTables.sql

	-- Rules for TBranch
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


	-- Rules for TEmployee
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

	
	-- Rules for TCustomer
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PInsertTableCustomer'))
 	EXEC('CREATE PROCEDURE [PInsertTableCustomer] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PInsertTableCustomer]
	    @FirstName NVARCHAR(100) = NULL,
	    @LastName NVARCHAR(100) = NULL,
	    @HomeAdrress NVARCHAR(100) = NULL,
        @PersonalRepresentative NVARCHAR(100) = NULL,
        @LoanOfficerID INT = NULL,
        @EmployeePosition NVARCHAR(100) = NULL

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

	        IF @LoanOfficerID IS NOT NULL AND (NOT EXISTS (SELECT * FROM TEmployee WHERE EmployeeID = @LoanOfficerID))
	        	THROW 50001, 'INVALID Loanofficer ID', 1;
	        ELSE -- LoanofficerID was found in Employee table
	        	BEGIN
	        		SET @EmployeePosition = (SELECT Position FROM TEmployee WHERE EmployeeID = @LoanOfficerID)
	        		IF @EmployeePosition != 'loan officer'
	        			THROW 50001, 'INVALID LoanOfficerID', 1;
	        	END

	        INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficerID)
	        VALUES(@FirstName, @LastName, @HomeAdrress, @PersonalRepresentative, @LoanOfficerID)

	    END 
	GO
		

	-- Rules for TAccount
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PInsertTableAccount'))
 	EXEC('CREATE PROCEDURE [PInsertTableAccount] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PInsertTableAccount]

	    @AccountNumber INT = NULL,
        @CustomerID INT = NULL,
        @BranchID INT = NULL,
        @CurrentBalance MONEY = NULL,
        @Type NVARCHAR(80) = NULL,
        @DefaultMinRequiredBalance MONEY = 500,
        @MinimumRequiredBalance MONEY = @DefaultMinRequiredBalance,
        @InterestRate FLOAT = NULL,
        @MonthlyServiceFee MONEY = NULL

	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN

	        IF @AccountNumber IS NULL
	            THROW 50001, 'INVALID Account number', 1;

	        IF NOT EXISTS (SELECT * FROM TCustomer WHERE CustomerID = @CustomerID)
	            THROW 50001, 'CustomerID cannot null', 1;

	        IF NOT EXISTS (SELECT * FROM TBranch WHERE BranchID = @BranchID)
	            THROW 50001, 'BranchID cannot null', 1;

            IF @CurrentBalance IS NULL OR @CurrentBalance < 0
                THROW 50001, 'INVALID current balance', 1 ;
            
            IF @Type IS NULL OR LEN(@Type) = 0
                THROW 50001, 'INVALID Account type', 1;

            IF @Type = 'saving'
                SET @InterestRate = 0.04;
            
            IF @Type = 'checking'
                SET @InterestRate = 0.01;

            IF @CurrentBalance < @MinimumRequiredBalance
                SET @MonthlyServiceFee = 30 -- set the monthlyChargeFee by default is 30
            ELSE -- current balance is equal or greater than MinimumRequiredBalance
                SET @MonthlyServiceFee = 0

	        INSERT INTO TAccount (AccountNumber, CustomerID, BranchID, CurrentBalance, [Type], MinimumRequiredBalance, InterestRate, MonthlyServiceFee)
	        VALUES(@AccountNumber, @CustomerID, @BranchID, @CurrentBalance, @Type, @MinimumRequiredBalance, @InterestRate, @MonthlyServiceFee)

	    END 
	GO
	

	-- Rules for TTransaction
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PInsertTableTransaction'))
 	EXEC('CREATE PROCEDURE [PInsertTableTransaction] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PInsertTableTransaction]

	    @AccountID INT = NULL,
        @Amount MONEY = NULL,
        @Type NVARCHAR(100) = NULL,
        @TransactionDateTime DATETIME2 = NULL,
        @CheckNumber INT = NULL,
        @AccountType NVARCHAR(80) = '',
        @CurrentBalanceInAccount MONEY = 0
        
	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN

	        IF NOT EXISTS (SELECT * FROM TAccount WHERE AccountID = @AccountID)
                THROW 50001, 'INVALID AccountID', 1;

            IF @Amount IS NULL OR @Amount < 0
                THROW 50001, 'INVALID transaction amount', 1;

			IF @Type IS NULL OR LEN(@Type) = 0
                THROW 50001, 'INVALID Transaction Type', 1;

            IF @Type = 'withdraw'

                BEGIN

					SET @AccountType = (SELECT [Type] FROM TAccount WHERE AccountID = @AccountID);

                    SET @CurrentBalanceInAccount = (SELECT CurrentBalance FROM TAccount WHERE AccountID = @AccountID);

                    IF @Amount > @CurrentBalanceInAccount
                        THROW 50001, 'Transaction amount of withdraw cannot over the current balance in account', 1;

					ELSE -- Withdraw amount is less than or equal current balance => update current balance in acc
						BEGIN TRY

							UPDATE TAccount 
							SET CurrentBalance = CurrentBalance - @Amount
							WHERE AccountID = @AccountID;

						END TRY

						BEGIN CATCH

							PRINT('Failed to Updated balance when adding withdraw transaction');

						END CATCH

					IF @AccountType = 'checking' AND @CheckNumber IS NULL
                        -- if account type is checking and transaction action is withdraw
                        -- AND Checknumber is null -> throw exception
                        THROW 50001, 'Checknumber cannot be null with typre withdraw of checking account', 1;

                END

			IF @Type = 'deposit'

				BEGIN TRY

					UPDATE TAccount
					SET CurrentBalance = CurrentBalance + @Amount
					WHERE AccountID = @AccountID;

				END TRY

				BEGIN CATCH

					PRINT('Failed to Updated balance when adding deposit transaction');

				END CATCH

            IF @TransactionDateTime IS NULL
                THROW 50001, 'INVALID Transaction datetime', 1;

	        INSERT INTO TTransaction (AccountID, Amount, [Type], TransactionDateTime, CheckNumber)
	        VALUES(@AccountID, @Amount, @Type, @TransactionDateTime, @CheckNumber)

	    END 
	GO
	

	-- Rules for TLoan
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PInsertTableLoan'))
 	EXEC('CREATE PROCEDURE [PInsertTableLoan] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PInsertTableLoan]
	    @CustomerID INT = NULL,
        @BranchID INT = NULL,
        @Kind NVARCHAR(100) = NULL,
        @Amount MONEY = NULL
	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN

            IF NOT EXISTS (SELECT * FROM TCustomer WHERE CustomerID = @CustomerID)
                THROW 50001, 'INVALID CustomerID', 1;

            ELSE -- CustomerID found in Customer table
            	BEGIN
					-- customer without having acc, not allowed to loan money
            		DECLARE @AccountID INT;
            		SET @AccountID = (SELECT TOP 1 (AccountID) FROM TAccount WHERE TAccount.CustomerID = @CustomerID);
            		IF @AccountID IS NULL
            			THROW 50001, 'INVALID CustomerID', 1;
            	END

            IF NOT EXISTS (SELECT * FROM TBranch WHERE BranchID = @BranchID)
                THROW 50001, 'INVALID BranchID', 1;

            IF @Kind IS NULL OR LEN(@Kind) = 0
                THROW 50001, 'INVALID LOAN KIND', 1;

            IF @Amount IS NULL OR @Amount <= 0
                THROW 50001, 'INVALID LOAN AMOUNT', 1;
			
	        INSERT INTO TLoan (CustomerID, BranchID, [Kind], Amount)
	        VALUES(@CustomerID, @BranchID, @Kind, @Amount)

	    END 
	GO

	-- Rules for TLoanPayment
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PInsertTableLoanPayment'))
 	EXEC('CREATE PROCEDURE [PInsertTableLoanPayment] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PInsertTableLoanPayment]
	    @PaymentNumber INT = NULL,
        @LoanID INT = NULL,
        @MonthlyPaymentDate DATE = NULL,
        @Amount MONEY = NULL,
        @CurrentLoanAmount MONEY = NULL
	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN

            IF @PaymentNumber IS NULL
                THROW 50001, 'INVALID PAYMENT NUMBER', 1;

            IF NOT EXISTS (SELECT * FROM TLoan WHERE LoanID = @LoanID)
                THROW 50001, 'INVALID LOANID', 1;

            IF @MonthlyPaymentDate IS NULL
                THROW 50001, 'INVALID MonthlyPaymentDate', 1;

            SET @CurrentLoanAmount = (SELECT Amount FROM TLoan WHERE LoanID = @LoanID)

            IF @Amount IS NULL OR ( @Amount <= 0 OR @Amount > @CurrentLoanAmount )
                THROW 50001, 'INVALID LOAN PAYMENT AMOUNT', 1;

	        INSERT INTO TLoanPayment (PaymentNumber, LoanID, MonthlyPaymentDate, Amount)
	        VALUES(@PaymentNumber, @LoanID, @MonthlyPaymentDate, @Amount)

	    END 
	GO


	-- Rules for TWorkingAt
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PInsertTableWorkingAt'))
 	EXEC('CREATE PROCEDURE [PInsertTableWorkingAt] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PInsertTableWorkingAt]

	    @EmployeeID INT = NULL,
        @BranchID INT = NULL

	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN

            IF NOT EXISTS (SELECT * FROM TEmployee WHERE EmployeeID = @EmployeeID)
                THROW 50001, 'INVALID EMPLOYEE ID', 1;

            IF NOT EXISTS (SELECT * FROM TBranch WHERE BranchID = @BranchID)
                THROW 50001, 'INVALID BRANCH ID', 1;

	        INSERT INTO TWorkingAt (EmployeeID, BranchID)
	        VALUES(@EmployeeID, @BranchID)

	    END 
	GO

	





