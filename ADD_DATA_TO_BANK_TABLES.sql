
----------------------------
-- ADD DATA TO TBranch TABLE
----------------------------
EXEC PInsertTableBranch
    @BranchName = 'SKS_Branch01',
    @IsOffice = 0,
    @CityName = 'Calgary',
    @PostalCode = 'T4A6M4'
GO

EXEC PInsertTableBranch
    @BranchName = 'SKS_Branch08',
    @IsOffice = 0,
    @CityName = 'Toronto',
    @PostalCode = 'T4A6M4'
GO

EXEC PInsertTableBranch
    @BranchName = 'SKS_Branch07',
    @IsOffice = 0,
    @CityName = 'Toronto',
    @PostalCode = 'T2A6H4'
GO

EXEC PInsertTableBranch
    @BranchName = 'SKS_Branch06',
    @IsOffice = 0,
    @CityName = 'Edmonton',
    @PostalCode = 'T8K6M4'
GO

EXEC PInsertTableBranch
    @BranchName = 'SKS_Branch05',
    @IsOffice = 0,
    @CityName = 'Edmonton',
    @PostalCode = 'T2A6M4'
GO

EXEC PInsertTableBranch
    @BranchName = 'SKS_Office02',
    @IsOffice = 1,
    @CityName = 'Vancouver',
    @PostalCode = 'T2J6M4'
GO

EXEC PInsertTableBranch
    @BranchName = 'SKS_Branch04',
    @IsOffice = 0,
    @CityName = 'Vancouver',
    @PostalCode = 'P2A6M4'
GO

EXEC PInsertTableBranch
    @BranchName = 'SKS_Branch03',
    @IsOffice = 0,
    @CityName = 'Vancouver',
    @PostalCode = 'K2A6M4'
GO

EXEC PInsertTableBranch
    @BranchName = 'SKS_Office01',
    @IsOffice = 1,
    @CityName = 'Calgary',
    @PostalCode = 'B2A6M4'
GO

EXEC PInsertTableBranch
    @BranchName = 'SKS_Branch02',
    @IsOffice = 0,
    @CityName = 'Calgary',
    @PostalCode = 'T2A6M4'
GO


-------------------------------
-- ADD DATA TO TEmployee TABLE
-------------------------------

EXEC PInsertTableEmployee
    @StartDate = '2016-01-10',
    @FirstName = 'Hai',
    @LastName = 'Do',
    @Position = 'banker',
    @IsManagedBy = 'Ryan',
    @PostalAddressCode = 'T2A6M4'
GO

EXEC PInsertTableEmployee
    @StartDate = '2010-01-10',
    @FirstName = 'Ryan',
    @LastName = 'Roffal',
    @Position = 'manager',
    @IsManagedBy = 'higherboss',
    @PostalAddressCode = 'T2R6M4'
GO

EXEC PInsertTableEmployee
    @StartDate = '2016-01-10',
    @FirstName = 'Peter',
    @LastName = 'Kerry',
    @Position = 'banker',
    @IsManagedBy = 'Ryan',
    @PostalAddressCode = 'T2Q6M4'
GO

EXEC PInsertTableEmployee
    @StartDate = '2012-01-10',
    @FirstName = 'Jelly',
    @LastName = 'Horn',
    @Position = 'banker',
    @IsManagedBy = 'Ryan',
    @PostalAddressCode = 'T2H6K4'
GO

EXEC PInsertTableEmployee
    @StartDate = '2014-01-10',
    @FirstName = 'John',
    @LastName = 'Smith',
    @Position = 'banker',
    @IsManagedBy = 'Ryan',
    @PostalAddressCode = 'T2B2J9'
GO

EXEC PInsertTableEmployee
    @StartDate = '2013-01-10',
    @FirstName = 'Anderson',
    @LastName = 'Jayson',
    @Position = 'loan officer',
    @IsManagedBy = 'Ryan',
    @PostalAddressCode = 'T2J6M4'
GO

EXEC PInsertTableEmployee
    @StartDate = '2018-04-23',
    @FirstName = 'Sandeep',
    @LastName = 'Saini',
    @Position = 'banker',
    @IsManagedBy = 'Ryan',
    @PostalAddressCode = 'J2K6L4'
GO

EXEC PInsertTableEmployee
    @StartDate = '2017-01-10',
    @FirstName = 'Karamullah',
    @LastName = 'Agha',
    @Position = 'banker',
    @IsManagedBy = 'Ryan',
    @PostalAddressCode = 'K2A6M4'
GO

EXEC PInsertTableEmployee
    @StartDate = '2015-08-23',
    @FirstName = 'Brijesh',
    @LastName = 'Patel',
    @Position = 'loan officer',
    @IsManagedBy = 'Ryan',
    @PostalAddressCode = 'T9A6M8'
GO

EXEC PInsertTableEmployee
    @StartDate = '2016-03-17',
    @FirstName = 'Pablo',
    @LastName = 'Winter',
    @Position = 'banker',
    @IsManagedBy = 'Ryan',
    @PostalAddressCode = 'T2Z6K4'
GO


-------------------------------
-- ADD DATA TO TCustomer TABLE
-------------------------------

EXEC PInsertTableCustomer
    @FirstName = 'Phuong',
    @LastName = 'Huynh',
    @HomeAdrress = '1234 Anland St Calgary',
    @PersonalRepresentative = NULL,
    @LoanOfficerID = NULL
GO

EXEC PInsertTableCustomer
    @FirstName = 'Mary',
    @LastName = 'Lany',
    @HomeAdrress = '7654 Diamond St Toronto',
    @PersonalRepresentative = NULL,
    @LoanOfficerID = NULL
GO

EXEC PInsertTableCustomer
    @FirstName = 'Khalib',
    @LastName = 'Harner',
    @HomeAdrress = '8888 LeDuc St Vancouver',
    @PersonalRepresentative = NULL,
    @LoanOfficerID = 6
GO

EXEC PInsertTableCustomer
    @FirstName = 'Andy',
    @LastName = 'Mac',
    @HomeAdrress = '999 Ember St Edmonton',
    @PersonalRepresentative = NULL,
    @LoanOfficerID = NULL
GO

EXEC PInsertTableCustomer
    @FirstName = 'Klinger',
    @LastName = 'Macor',
    @HomeAdrress = '778 36 St Calgary',
    @PersonalRepresentative = NULL,
    @LoanOfficerID = NULL
GO

EXEC PInsertTableCustomer
    @FirstName = 'Andrew',
    @LastName = 'Panel',
    @HomeAdrress = '3456 68 St Toronto',
    @PersonalRepresentative = 'Peter Jackson',
    @LoanOfficerID = 9
GO

EXEC PInsertTableCustomer
    @FirstName = 'Yen',
    @LastName = 'Nguyen',
    @HomeAdrress = '456 BridgeLand St Edmonton',
    @PersonalRepresentative = NULL,
    @LoanOfficerID = 6
GO

EXEC PInsertTableCustomer
    @FirstName = 'Kim',
    @LastName = 'Huynh',
    @HomeAdrress = '1234 Anland St Calgary',
    @PersonalRepresentative = NULL,
    @LoanOfficerID = NULL
GO

EXEC PInsertTableCustomer
    @FirstName = 'Anh',
    @LastName = 'Mach',
    @HomeAdrress = '1234 Anland St Calgary',
    @PersonalRepresentative = NULL,
    @LoanOfficerID = NULL
GO

EXEC PInsertTableCustomer
    @FirstName = 'Ethan',
    @LastName = 'Do',
    @HomeAdrress = '789 Sundrige Ave Calgary',
    @PersonalRepresentative = 'Mary Jane',
    @LoanOfficerID = NULL
GO


-------------------------------
-- ADD DATA TO TAccount TABLE
-------------------------------

EXEC PInsertTableAccount
    @AccountNumber = 1001,
    @CustomerID = 1, 
    @BranchID = 1,
    @CurrentBalance = 4090,
    @Type = 'checking'
GO

EXEC PInsertTableAccount
    @AccountNumber = 1004,
    @CustomerID = 1, 
    @BranchID = 1,
    @CurrentBalance = 560,
    @Type = 'saving'
GO

EXEC PInsertTableAccount
    @AccountNumber = 1002,
    @CustomerID = 2, 
    @BranchID = 1,
    @CurrentBalance = 300,
    @Type = 'saving'
GO

EXEC PInsertTableAccount
    @AccountNumber = 1003,
    @CustomerID = 5, 
    @BranchID = 2,
    @CurrentBalance = 10200,
    @Type = 'checking'
GO


EXEC PInsertTableAccount
    @AccountNumber = 1005,
    @CustomerID = 4, 
    @BranchID = 5,
    @CurrentBalance = 20000,
    @Type = 'checking'
GO


EXEC PInsertTableAccount
    @AccountNumber = 1006,
    @CustomerID = 8, 
    @BranchID = 8,
    @CurrentBalance = 350,
    @Type = 'saving'
GO


EXEC PInsertTableAccount
    @AccountNumber = 1007,
    @CustomerID = 10, 
    @BranchID = 4,
    @CurrentBalance = 2000,
    @Type = 'checking'
GO


EXEC PInsertTableAccount
    @AccountNumber = 1008,
    @CustomerID = 10, 
    @BranchID = 4,
    @CurrentBalance = 350,
    @Type = 'saving'
GO


EXEC PInsertTableAccount
    @AccountNumber = 1009,
    @CustomerID = 7, 
    @BranchID = 3,
    @CurrentBalance = 7500,
    @Type = 'checking'
GO


EXEC PInsertTableAccount
    @AccountNumber = 1010,
    @CustomerID = 5, 
    @BranchID = 7,
    @CurrentBalance = 8600,
    @Type = 'saving'
GO

-----------------------------------
-- ADD DATA TO TTransaction TABLE
------------------------------------

EXEC PInsertTableTransaction
    @AccountID = 1,
    @Amount = 250,
    @Type = 'deposit',
    @TransactionDateTime = '2014-04-27 07:39:06',
    @CheckNumber = NULL
GO

EXEC PInsertTableTransaction
    @AccountID = 2,
    @Amount = 200,
    @Type = 'withdraw',
    @TransactionDateTime = '2015-04-19 09:25:16',
    @CheckNumber = NULL
GO

EXEC PInsertTableTransaction
    @AccountID = 2,
    @Amount = 700,
    @Type = 'deposit',
    @TransactionDateTime = '2015-04-27 10:25:16',
    @CheckNumber = NULL
GO

EXEC PInsertTableTransaction
    @AccountID = 4,
    @Amount = 500,
    @Type = 'withdraw',
    @TransactionDateTime = '2017-05-10 04:25:16',
    @CheckNumber = 12567
GO

EXEC PInsertTableTransaction
    @AccountID = 7,
    @Amount = 1000,
    @Type = 'deposit',
    @TransactionDateTime = '2016-04-26 07:30:36',
    @CheckNumber = NULL
GO

EXEC PInsertTableTransaction
    @AccountID = 8,
    @Amount = 200,
    @Type = 'deposit',
    @TransactionDateTime = '2018-04-19 01:25:16',
    @CheckNumber = NULL
GO

EXEC PInsertTableTransaction
    @AccountID = 5,
    @Amount = 7000,
    @Type = 'withdraw',
    @TransactionDateTime = '2015-04-19 09:25:16',
    @CheckNumber = 7878
GO

EXEC PInsertTableTransaction
    @AccountID = 2,
    @Amount = 200,
    @Type = 'withdraw',
    @TransactionDateTime = '2015-04-19 09:25:16',
    @CheckNumber = NULL
GO

EXEC PInsertTableTransaction
    @AccountID = 10,
    @Amount = 550,
    @Type = 'deposit',
    @TransactionDateTime = '2013-07-19 08:25:16',
    @CheckNumber = NULL
GO

EXEC PInsertTableTransaction
    @AccountID = 10,
    @Amount = 5000,
    @Type = 'withdraw',
    @TransactionDateTime = '2014-07-19 08:25:16',
    @CheckNumber = NULL
GO

EXEC PInsertTableTransaction
    @AccountID = 9,
    @Amount = 7000,
    @Type = 'withdraw',
    @TransactionDateTime = '2014-07-19 08:25:16',
    @CheckNumber = 9999
GO

-----------------------------------
-- ADD DATA TO TLoan TABLE
-----------------------------------

EXEC PInsertTableLoan
    @CustomerID = 1,
    @BranchID = 2,
    @Kind = 'student loan',
    @Amount = 2000
GO

EXEC PInsertTableLoan
    @CustomerID = 4,
    @BranchID = 4,
    @Kind = 'business',
    @Amount = 5000
GO


EXEC PInsertTableLoan
    @CustomerID = 5,
    @BranchID = 7,
    @Kind = 'student loan',
    @Amount = 2000
GO

EXEC PInsertTableLoan
    @CustomerID = 8,
    @BranchID = 1,
    @Kind = 'business',
    @Amount = 1000
GO

EXEC PInsertTableLoan
    @CustomerID = 5,
    @BranchID = 3,
    @Kind = 'personal',
    @Amount = 1000
GO

-----------------------------------
-- ADD DATA TO TLoanPaymemnt TABLE
-----------------------------------

EXEC PInsertTableLoanPayment
    @PaymentNumber = 7888,
    @LoanID = 1,
    @MonthlyPaymentDate = '2016-01-10',
    @Amount = 300
GO

EXEC PInsertTableLoanPayment
    @PaymentNumber = 7889,
    @LoanID = 4,
    @MonthlyPaymentDate = '2016-02-10',
    @Amount = 440
GO

EXEC PInsertTableLoanPayment
    @PaymentNumber = 7888,
    @LoanID = 2,
    @MonthlyPaymentDate = '2017-03-15',
    @Amount = 300
GO

EXEC PInsertTableLoanPayment
    @PaymentNumber = 7998,
    @LoanID = 3,
    @MonthlyPaymentDate = '2018-08-20',
    @Amount = 400
GO


EXEC PInsertTableLoanPayment
    @PaymentNumber = 7999,
    @LoanID = 5,
    @MonthlyPaymentDate = '2014-04-17',
    @Amount = 5
GO

EXEC PInsertTableLoanPayment
    @PaymentNumber = 7999,
    @LoanID = 3,
    @MonthlyPaymentDate = '2014-04-17',
    @Amount = 150
GO

-----------------------------------
-- ADD DATA TO TWorkingAt TABLE
-----------------------------------

EXEC PInsertTableWorkingAt
    @EmployeeID = 1,
    @BranchID = 1
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 1,
    @BranchID = 6
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 2,
    @BranchID = 3
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 2,
    @BranchID = 9
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 3,
    @BranchID = 4
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 4,
    @BranchID = 6
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 5,
    @BranchID = 6
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 5,
    @BranchID = 2
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 6,
    @BranchID = 6
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 7,
    @BranchID = 3
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 8,
    @BranchID = 6
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 9,
    @BranchID = 3
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 10,
    @BranchID = 6
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 4,
    @BranchID = 5
GO

EXEC PInsertTableWorkingAt
    @EmployeeID = 7,
    @BranchID = 7
GO

EXEC PInsertTableWorkingAt
	    @EmployeeID = 10,
	    @BranchID = 8
GO
