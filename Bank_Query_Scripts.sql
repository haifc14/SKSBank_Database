USE hdo488
GO

--Question1."LIST BRANCH SUMMARY" Display a summary row for each bank branch showing the name, 
-- postal address (as one field), number of accounts, number of loans, total account balance
-- total loan balance , and average transaction amount against savings or checking accounts
-- Branch and Accounts
IF NOT EXISTS (SELECT *
FROM sys.objects
WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PListBranchSummary'))
 	EXEC('CREATE PROCEDURE [PListBranchSummary] AS BEGIN SET NOCOUNT ON; END');
	GO

ALTER PROCEDURE [PListBranchSummary]

AS
	 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

    BEGIN

    -- Branch and Accounts
    SELECT Branch.Name , Branch.PostalCode, BA.NumberOfAccounts, BA.TotalBalance,
        LA.NumberOfLoans, LA.TotalLoansBalance, ACT.AverageCheckingTransaction,
        AST.AverageSavingTransaction

    FROM TBranch AS Branch

        LEFT JOIN
        ( 
            SELECT TBranch.Name, SUM(TAccount.CurrentBalance) AS 'TotalBalance',
            COUNT(*) AS 'NumberOfAccounts'
        FROM TBranch JOIN TAccount
            ON TBranch.BranchID = TAccount.BranchID
        GROUP BY TBranch.Name 
            ) AS BA -- for Branch and Account

        ON BA.Name = Branch.Name

        LEFT JOIN
        ( 
            SELECT TBranch.Name, SUM(TLoan.Amount) AS 'TotalLoansBalance',
            COUNT(*) AS 'NumberOfLoans'
        FROM TBranch JOIN TLoan
            ON TBranch.BranchID = TLoan.BranchID
        GROUP BY TBranch.Name 
            ) AS LA -- for Loan and Account

        ON LA.Name = Branch.Name

        LEFT JOIN
        (
            SELECT TBranch.Name, AVG(TTransaction.Amount) AS 'AverageCheckingTransaction'
        FROM TAccount JOIN TTransaction ON TAccount.AccountID = TTransaction.AccountID
            JOIN TBranch ON TAccount.BranchID = TBranch.BranchID
        WHERE TAccount.[Type] LIKE 'checking'
        GROUP BY TBranch.Name
        ) AS ACT -- Average Checking Transaction

        ON ACT.Name = Branch.Name

        LEFT JOIN
        (
            SELECT TBranch.Name, AVG(TTransaction.Amount) AS 'AverageSavingTransaction'
        FROM TAccount JOIN TTransaction ON TAccount.AccountID = TTransaction.AccountID
            JOIN TBranch ON TAccount.BranchID = TBranch.BranchID
        WHERE TAccount.[Type] LIKE 'saving'
        GROUP BY TBranch.Name
        ) AS AST -- Average Saving Transaction

        ON AST.Name = Branch.Name

    END

EXEC PListBranchSummary;




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
           SET CurrentBalance = CurrentBalance - @DefinedServiceFee
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

    DECLARE @AccountID INT, @CurrentBalance MONEY, @InterestRate FLOAT;

    DECLARE ApplyInterest_Cursor CURSOR 
    FOR
        SELECT AccountID, CurrentBalance, InterestRate
        FROM TAccount;
    
    OPEN ApplyInterest_Cursor;

    FETCH NEXT FROM ApplyInterest_Cursor INTO @AccountID, @CurrentBalance, @InterestRate;
    
    WHILE @@FETCH_STATUS <> -1

        BEGIN
            
            DECLARE @InterestAmount MONEY;
            SET @InterestAmount = @CurrentBalance * @InterestRate;

            DECLARE @TransAddingTime DATETIME2;
            SET @TransAddingTime = SYSDATETIME();

            EXEC PInsertTableTransaction
                @AccountID = @AccountID,
                @Amount = @InterestAmount,
                @Type = 'deposit',
                @TransactionDateTime = @TransAddingTime,
                @CheckNumber = NULL;   
            
            FETCH NEXT FROM ApplyInterest_Cursor INTO  @AccountID, @CurrentBalance, @InterestRate;

        END;
        
    CLOSE ApplyInterest_Cursor;

    DEALLOCATE ApplyInterest_Cursor;

END
GO

EXEC PApplyInterestCredits;

SELECT * FROM TAccount -- testing the current balance is updated
SELECT * FROM TTransaction -- testing the rows are added 
GO


-- Question 5
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PApplyServiceCharge'))
 	EXEC('CREATE PROCEDURE [PApplyServiceCharge] AS BEGIN SET NOCOUNT ON; END');
GO

ALTER PROCEDURE [PApplyServiceCharge]
    
AS
    
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

    DECLARE @AccountID INT, @AccountType NVARCHAR(80), @CurrentBalance MONEY, @MinimumRequiredBalance MONEY, @ServiceFee MONEY;

    DECLARE ApplyServiceCharge_Cursor CURSOR 
    FOR
        SELECT AccountID, [Type] ,CurrentBalance, MinimumRequiredBalance, MonthlyServiceFee
        FROM TAccount;
    
    OPEN ApplyServiceCharge_Cursor;

    FETCH NEXT FROM ApplyServiceCharge_Cursor INTO @AccountID, @AccountType, @CurrentBalance, @MinimumRequiredBalance, @ServiceFee;
    
    WHILE @@FETCH_STATUS <> -1

        BEGIN
            
            -- get the server cuurent time
            DECLARE @TransactionDateTime DATETIME2;
            SET @TransactionDateTime = SYSDATETIME();

            -- check number for checking account type
            DECLARE @CheckNumber INT;
            SET @CheckNumber = 6767;
            
            IF @CurrentBalance < @MinimumRequiredBalance

                BEGIN

                    IF @AccountType = 'checking'

                        BEGIN

                            EXEC PInsertTableTransaction
                                @AccountID = @AccountID,
                                @Amount = @ServiceFee,
                                @Type = 'withdraw',
                                @TransactionDateTime = @TransactionDateTime,
                                @CheckNumber = @CheckNumber;  

                        END

                    ELSE -- Account type is not checking

                        BEGIN

                            EXEC PInsertTableTransaction
                                @AccountID = @AccountID,
                                @Amount = @ServiceFee,
                                @Type = 'withdraw',
                                @TransactionDateTime = @TransactionDateTime,
                                @CheckNumber = NULL;

                        END
                END

            Set @CheckNumber = @CheckNumber + 100;
                      
            FETCH NEXT FROM ApplyServiceCharge_Cursor INTO @AccountID, @AccountType, @CurrentBalance, @MinimumRequiredBalance, @ServiceFee;

        END;
        
    CLOSE ApplyServiceCharge_Cursor;

    DEALLOCATE ApplyServiceCharge_Cursor;

END
GO

EXEC PApplyServiceCharge
GO

SELECT * FROM TAccount -- testing the current balance is updated
SELECT * FROM TTransaction -- testing the rows are added 
GO

-- Question 6
IF NOT EXISTS (SELECT *
FROM sys.objects
WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PDeleteCustomerTest'))
 	EXEC('CREATE PROCEDURE [PDeleteCustomerTest] AS BEGIN SET NOCOUNT ON; END');
GO

ALTER PROCEDURE [PDeleteCustomerTest]
    @CustomerID INT

AS
    
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

    DELETE FROM TCustomer
    WHERE CustomerID = @CustomerID;

END

EXEC PDeleteCustomerTest @CustomerID = 5;

-- Question 7 need to fix

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('PWithdrawLoanPayment'))
 	EXEC('CREATE PROCEDURE [PWithdrawLoanPayment] AS BEGIN SET NOCOUNT ON; END');
GO

ALTER PROCEDURE [PWithdrawLoanPayment]
    
AS
    
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

   DECLARE @CustomerID INT, @LoanID INT, @LoanAmount MONEY, @MonthlyPaymentDate DATE, @MonthlyPayAmount MONEY;

    DECLARE WithdrawLoanPayment_Cursor CURSOR 
    FOR
        SELECT TCustomer.CustomerID, TLoan.LoanID, TLoan.Amount AS 'Loan amount', 
               TLoanPayment.MonthlyPaymentDate, TLoanPayment.Amount AS 'Monthly pay amount'
        FROM TLoan JOIN TLoanPayment ON TLoan.LoanID = TLoanPayment.LoanID
                   JOIN TCustomer ON TLoan.CustomerID = TCustomer.CustomerID
    
    OPEN WithdrawLoanPayment_Cursor;

    FETCH NEXT FROM WithdrawLoanPayment_Cursor INTO @CustomerID, @LoanID, @LoanAmount, @MonthlyPaymentDate, @MonthlyPayAmount ;
    
    WHILE @@FETCH_STATUS <> -1

        BEGIN
            
            -- GET AccountID from CustomerID
            DECLARE @AccountID INT;
            SET @AccountID = (SELECT AccountID FROM TAccount WHERE TAccount.CustomerID = @CustomerID);

            -- Get AccounType from AccountID
            DECLARE @AccountType NVARCHAR(80);
            SET @AccountType = (SELECT TOP 1([Type]) FROM TAccount WHERE TAccount.CustomerID = @CustomerID);

            -- Get Current date to compare with LoanPayment date
            DECLARE @CurrentDate DATE;
            SET @CurrentDate = (SELECT FORMAT(GetDate(), 'yyyy-MM-dd'));

            -- Get current server time to insert transaction
            DECLARE @currentServerTime DATETIME2;
            SET @currentServerTime = SYSDATETIME();

            -- Declare check number for checking account
            DECLARE @CheckNumber INT;
            SET @CheckNumber = 9967;

            IF @CurrentDate = @MonthlyPaymentDate

                BEGIN

                    IF @AccountType = 'checking'

                        BEGIN

                            EXEC PInsertTableTransaction
                                @AccountID = @AccountID,
                                @Amount = @MonthlyPayAmount,
                                @Type = 'withdraw',
                                @TransactionDateTime = @currentServerTime,
                                @CheckNumber = @CheckNumber;

                            
                            UPDATE TAccount
                            SET CurrentBalance = CurrentBalance - @MonthlyPayAmount
                            WHERE AccountID  = @AccountID;

                            UPDATE TLoan
                            SET Amount = Amount - @MonthlyPayAmount
                            WHERE LoanID = @LoanID;

                        END

                    ELSE -- account type is not checking

                        BEGIN

                            EXEC PInsertTableTransaction
                                @AccountID = @AccountID,
                                @Amount = @MonthlyPayAmount,
                                @Type = 'withdraw',
                                @TransactionDateTime = @currentServerTime,
                                @CheckNumber = NULL;

                            
                            UPDATE TAccount
                            SET CurrentBalance = CurrentBalance - @MonthlyPayAmount
                            WHERE AccountID  = @AccountID;

                            UPDATE TLoan
                            SET Amount = Amount - @MonthlyPayAmount
                            WHERE LoanID = @LoanID;

                        END

                END

                SET @CheckNumber = @CheckNumber + 100;
                      
            FETCH NEXT FROM WithdrawLoanPayment_Cursor INTO @CustomerID, @LoanID, @LoanAmount, @MonthlyPaymentDate, @MonthlyPayAmount ;

        END;
        
    CLOSE WithdrawLoanPayment_Cursor;

    DEALLOCATE WithdrawLoanPayment_Cursor;

END

GO

EXEC PWithdrawLoanPayment;

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

