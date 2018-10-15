USE hdo488
GO

--Question1."LIST BRANCH SUMMARY" Display a summary row for each bank branch showing the name, 
-- postal address (as one field), number of accounts, number of loans, total account balance
-- total loan balance , and average transaction amount against savings or checking accounts


-- Question 2
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PAddServiceCharge'))
 	EXEC('CREATE PROCEDURE [PAddServiceCharge] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PAddServiceCharge]

	    @AccountType NVARCHAR(100),
        @DefinedServiceFee MONEY
	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN TRY

           UPDATE TAccount 
           SET MonthlyServiceFee = @DefinedServiceFee
           WHERE TAccount.[Type] = @AccountType
       
	    END TRY

        BEGIN CATCH

            PRINT('The update Service charged is failed');

        END CATCH
	GO


DECLARE @AccType NVARCHAR(100), @ServiceFee MONEY
SET @AccType = 'checking'
SET @ServiceFee = 25
EXEC PAddServiceCharge @AccountType = @AccType ,
                          @DefinedServiceFee = @ServiceFee;
GO
 
SELECT * FROM TAccount -- testing the current balance is updated
GO

-- Question 3
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PListAccountsBelowMinimumBalance'))
 	EXEC('CREATE PROCEDURE [PListAccountsBelowMinimumBalance] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PListAccountsBelowMinimumBalance]
	    
	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN

	        SELECT  TCustomer.CustomerID, TCustomer.FirstName + ' ' + TCustomer.LastName AS 'Customer Name',
                    TAccount.AccountNumber, TAccount.[Type], TAccount.MinimumRequiredBalance,
                    TAccount.CurrentBalance, TAccount.MonthlyServiceFee
            FROM TAccount JOIN TCustomer
            ON TAccount.CustomerID = TCustomer.CustomerID
            WHERE TAccount.CurrentBalance < TAccount.MinimumRequiredBalance

	    END 
	GO

EXEC PListAccountsBelowMinimumBalance
GO

-- Question 4
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PApplyInterestCredits'))
 	EXEC('CREATE PROCEDURE [PApplyInterestCredits] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PApplyInterestCredits]
	    
	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN

	        UPDATE TAccount
            SET CurrentBalance = CurrentBalance + (CurrentBalance * InterestRate)

	    END 
	GO

EXEC PApplyInterestCredits
GO

SELECT * FROM TAccount -- testing the current balance is updated
GO

-- Question 5
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PApplyServiceCharge'))
 	EXEC('CREATE PROCEDURE [PApplyServiceCharge] AS BEGIN SET NOCOUNT ON; END');
	GO

	ALTER PROCEDURE [PApplyServiceCharge]

	
	AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	    BEGIN TRY

            UPDATE TAccount 
            SET CurrentBalance = CurrentBalance - MonthlyServiceFee
            WHERE CurrentBalance < MinimumRequiredBalance
           
	    END TRY

        BEGIN CATCH

            PRINT('The update Service charged is failed');

        END CATCH
	GO


EXEC PApplyServiceCharge
GO

SELECT * FROM TAccount -- testing the current balance is updated
GO

-- Question 6
DELETE FROM TCustomer 
WHERE CustomerID = 3
GO

-- Question 8
SELECT TBranch.Name, TCustomer.FirstName + ' ' + TCustomer.LastName AS 'Customer FullName', 
        TAccount.[Type], TAccount.CurrentBalance, 
        (SELECT TOP 1 (TransactionDateTime) 
         FROM TTransaction 
         WHERE AccountID = TAccount.AccountID 
         ORDER BY TransactionDateTime DESC) AS 'DateTime of Last Transaction'
FROM TAccount 
JOIN TCustomer ON TAccount.CustomerID = TCustomer.CustomerID
JOIN TBranch ON TAccount.BranchID = TBranch.BranchID
JOIN TTransaction ON TAccount.AccountID = TTransaction.AccountID

