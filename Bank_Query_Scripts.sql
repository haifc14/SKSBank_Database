USE hdo488
GO

--1."LIST BRANCH SUMMARY" Display a summary row for each bank branch showing the name, 
-- postal address (as one field), number of accounts, number of loans, total account balance
-- total loan balance , and average transaction amount against savings or checking accounts

SELECT Name , Count(*) AS 'Total Accounts'
FROM TBranch  JOIN TAccount ON TBranch.BranchID = TAccount.BranchID
GROUP BY Name

-- get total accounts for each branch
SELECT COUNT(*) 
FROM TBranch JOIN TAccount
    ON TBranch.BranchID = TAccount.BranchID
-- get total account balance

-- get number loans for each branch


-- get total loan balance

-- average transaction amount for savings acc

-- average transaction amount for checking acc