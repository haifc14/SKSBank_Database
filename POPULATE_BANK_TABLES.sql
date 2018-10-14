USE hdo488 -- select database
GO

-- Populate data to bank tables 

-- Populate data TBranch table
INSERT INTO TBranch (Name, IsOffice, CityName)
VALUES('SKS_Branch01', 0, 'Calgary');

INSERT INTO TBranch (Name, IsOffice, CityName)
VALUES('SKS_Branch08', 0, 'Toronto');

INSERT INTO TBranch (Name, IsOffice, CityName)
VALUES('SKS_Branch07', 0, 'Toronto');

INSERT INTO TBranch (Name, IsOffice, CityName)
VALUES('SKS_Branch06', 0, 'Edmonton');

INSERT INTO TBranch (Name, IsOffice, CityName)
VALUES('SKS_Branch05', 0, 'Edmonton');

INSERT INTO TBranch (Name, IsOffice, CityName)
VALUES('SKS_Office02', 1, 'Vancouver');

INSERT INTO TBranch (Name, IsOffice, CityName)
VALUES('SKS_Branch04', 0, 'Vancouver');

INSERT INTO TBranch (Name, IsOffice, CityName)
VALUES('SKS_Branch03', 0, 'Vancouver');

INSERT INTO TBranch (Name, IsOffice, CityName)
VALUES('SKS_Office01', 1, 'Calgary');

INSERT INTO TBranch (Name, IsOffice, CityName)
VALUES('SKS_Branch02', 0, 'Calgary');
GO

-- Populate data TEmployee table
INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
VALUES('2016-01-10', 'Hai', 'Do', 'banker', 'Ryan', 'T2A6M4');

INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
VALUES('2010-01-10', 'Ryan', 'Roffal', 'manager', 'higherboss', 'T2R6M4');

INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
VALUES('2016-01-10', 'Peter', 'Kerry', 'banker', 'Ryan', 'T2Q6M4');

INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
VALUES('2012-01-10', 'Jelly', 'Horn', 'banker', 'Ryan', 'T2H6K4');

INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
VALUES('2014-01-10', 'John', 'Smith', 'banker', 'Ryan', 'T2B2J9');

INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
VALUES('2013-01-10', 'Anderson', 'Jayson', 'loan officer', 'Ryan', 'T2J6M4');

INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
VALUES('2018-04-23', 'Sandeep', 'Saini', 'banker', 'Ryan', 'J2K6L4');

INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
VALUES('2017-01-10', 'Karamullah', 'Agha', 'banker', 'Ryan', 'K2A6M4');

INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
VALUES('2015-08-23', 'Brijesh', 'Patel', 'loan officer', 'Ryan', 'T9A6M8');

INSERT INTO TEmployee (StartDate, FirstName, LastName, Position, IsManagedBy, PostalAddressCode)
VALUES('2016-03-17', 'Pablo', 'Winter', 'banker', 'Ryan', 'T2Z6K4');
GO

-- Populate data TCustomer table
INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
VALUES('Phuong', 'Huynh', '1234 Anland St Calgary', Null, Null);

INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
VALUES('Mary', 'Lany', '7654 Diamond St Toronto', Null, Null);

INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
VALUES('Khalib', 'Harner', '8888 LeDuc St Vancouver', Null, 'Anderson');

INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
VALUES('Andy', 'Mac', '999 Ember St Edmonton', Null, Null);

INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
VALUES('Klinger', 'Macor', '778 36 St Calgary', Null, Null);

INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
VALUES('Andrew', 'Panel', '3456 68 St Toronto', 'Peter Jackson', 'Brijesh');

INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
VALUES('Yen', 'Nguyen', '456 BridgeLand St Edmonton', Null, 'Anderson');

INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
VALUES('Kim', 'Huynh', '1234 Anland St Calgary', Null, Null);

INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
VALUES('Anh', 'Mach', '1234 Anland St Calgary', Null, Null);

INSERT INTO TCustomer (FirstName, LastName, HomeAdrress, PersonalRepresentative, LoanOfficer)
VALUES('Ethan', 'Do', '789 Sundrige Ave Calgary', 'Mary Jane', Null);
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





