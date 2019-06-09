Developer : Hai Do

Description: This project is to design a database for the SKS Bank using MS SQL. 
The ER diagram has been developed based on the bank's requirements.

### Project's file explaination:
1. Project_ER_Diagram.pdf -> This is the ER diagram describing the necessary data in table form and the relationship between them.
2. CREATE_BANK_TABLES.sql -> This file contains Sql scripts that will create tables with its essential properties. All scripts to create tables are wrapped inside a Store procedure, so they will be created just in one execution command.
3. POPULATE_BANK_TABLES.sql -> This file contains sql scripts that will apply business rules for the data before it can be added to table. For each table, the business rules can be forced by using Store procedure to validate and set conditions of input data.
4. ADD_DATA_TO_BANK_TABLES -> This file contains sql scripts that will add testing data to tables by executing Store procedures created from POPULATE_BANK_TABLES.sql file.
5. BANK_QUERY_SCRIPTS -> This file contains the Query scripts that execute several bank's activities to test the accuracy and logic of the database. 
