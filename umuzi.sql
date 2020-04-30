-- PART 1 : CREATING A DATABASE
-- DOCUMENTATION

/*

-- Creating a database called Umuzi which contains the tables Customers, Employees, Orders, Payments and Products.
-- Creating Customers table containing columns customerID(primary key and auto-increments),firsrname, lastname, gender, address, phone, email, city and country.
-- Creating employees table containing columns employeeId(primary key and auto-increments), firstname, lastname, email and jobtitle.
-- Creating Products table containing columns productID(primary ke and auto-increments), productname, description and buyprice.
-- Creating Payments table containing columns paymentID(primary key and aouto-increments), customerID(foreign key referenced from customers table), paymentdate and amount. 
-- Creating Orders table containing ordersID(primary key and auto-increments), productID(foreign key referenced from products table), paymentID(foreign key referenced from payments table), fullfilledbyemployeeID(foregin key reference from employee table), daterequired, dateshipped and status.  

*/


CREATE DATABASE umuzi

CREATE TABLE Customers (
    CustomerID serial PRIMARY KEY,
    FirstName varchar(50) NOT NULL,
    LastName varchar(50) NOT NULL,
    Gender varchar NOT NULL,
    Address varchar(200),
    Phone varchar(10),
    Email varchar(100),
    City varchar(20),
    Country varchar(50)
    
);


CREATE TABLE Employees (
    EmployeeID serial PRIMARY KEY,
    FirstName varchar(50) NOT NULL,
    LastName varchar(50) NOT NULL,
    Email varchar(100),
    JobTitle varchar(20)
    
);


CREATE TABLE Products (
    ProductID serial PRIMARY KEY,
    ProductName varchar(100) NOT NULL,
    Description varchar(300),
    BuyPrice numeric NOT NULL
    
);


CREATE TABLE Payments (
    CustomerID INTEGER REFERENCES Customers(CustomerID),
    PaymentID serial PRIMARY KEY,
    PaymentDate Date NOT NULL,
    Amount numeric NOT NULL
    
);


create table Orders(
    OrderID serial PRIMARY KEY,
    ProductID INTEGER REFERENCES Products(ProductID),
    PaymentID INTEGER REFERENCES Payments(PaymentID),
    FullfilledByEmployeeID INTEGER REFERENCES Employees(EmployeeID),
    DateRequired Date NOT NULL,
    DateShipped Date,
    Status varchar(20) NOT NULL
)


INSERT INTO Customers(FirstName,LastName,Gender,Address,Phone,Email,City,Country)
VALUES('John','Hibert','Male','284 chaucer st','084789657','john@gmail.com','Johannesburg','South Africa'),
      ('Thando','Sithole','Female','240 Sect 1','0794445584','thando@gmail.com','Cape Town','South Africa'),
      ('Leon','Glen','Male','81 Everton Rd,Gillits','0820832830','Leon@gmail.com','Durban','South Africa'),
      ('Charl','Muller','Male','290A Dorset Ecke','0856872553','Charl.muller@yahoo.com','Berlin','Germany'),
      ('Julia','Stein','Female','2 Wernerring','0867244505','Js234@yahoo.com','Frankfurt','South Africa');


INSERT INTO Employees(FirstName,LastName,Email,JobTitle)
VALUES('Kani','Matthew','mat@gmail.com','Manager'),
      ('Lesly','Cronje','LesC@gmail.com','Clerk'),
      ('Gideon','Maduku','m@gmail.com','Accountant');


INSERT INTO Products(ProductName,Description,BuyPrice)
VALUES('Harley Davidson Chopper','This replica features working kickstand, front suspension, gear-shift lever',150.75), 
      ('Classic Car','Turnable front wheels, steering function',150.75),
      ('Harley Davidson Chopper','Turnable front wheels, steering function',700.60);


INSERT INTO Payments(CustomerIDPaymentDate,Amount)
VALUES(1,CURRENT_DATE,150.75), 
      (1,CURRENT_DATE,150.75),
      (3,CURRENT_DATE,700.60);


INSERT INTO Orders(ProductID,PaymentID,FullfilledByEmployeeID,DateRequired,DateShipped,Status)
VALUES(1,1,2,'2020-04-25',NULL,'Not shipped'), 
      (1,2,2,'2020-04-23','2020-04-25','Shipped'),
      (3,3,3,'2020-04-28',NULL,'Not shipped');


-- PART 2: QUERING A DATABASE

------------------------------------------------------------------------------------
//The command selects all the records from customer table.

1. 
SELECT * FROM Customers

--------------------------------------------------------------------------------
//Select only the FirstName records from customer table 

2. 
SELECT FirstName, LastName FROM Customers

--------------------------------------------------------------------------------
//The command show only the name of a customer whose customerID is 1.

3.
SELECT FirstName, LastName FROM Customers WHERE CustomerID = 1

--------------------------------------------------------------------------------
//The command updates only the names of a user with a customerID = 1

4. 
UPDATE Customers
SET FirstName = 'Lerato', LastName = 'Mabitso'
WHERE CustomerID = 1

--------------------------------------------------------------------------------
//The command delete the record/customer with customerID = 1

5. 
DELETE FROM Customers
WHERE CustomerID = 2

--------------------------------------------------------------------------------
//The command get the total number of orders that are shipped.

6. 
SELECT COUNT(Status) FROM Orders

--------------------------------------------------------------------------------
//The command returns the maximum payment from Payments table.

7. 
SELECT MAX(Amount) FROM Payments

--------------------------------------------------------------------------------
//The command returns all the customer records ordered by country

8. 
SELECT * FROM Customers
ORDER BY Country

--------------------------------------------------------------------------------
//The command returns all the products from Products table with a price range from 100 to 600.

9. 
SELECT * FROM Products
WHERE BuyPrice BETWEEN 100 AND 600;

--------------------------------------------------------------------------------
//The command returns all the customers who are from Germany and Berlin as city from customer table.

10. 
SELECT * FROM Customers
WHERE City = 'Berlin' AND Country = 'Germany'

--------------------------------------------------------------------------------
//The command returns all the records that has Durban or Cape Town as a city from the customer table.

11. 
SELECT * FROM Customers
WHERE City = 'Durban' OR City = 'Cape Town'

--------------------------------------------------------------------------------
//It returns all the records with the price of more than R500.

12. 
SELECT * FROM Products
WHERE BuyPrice > 500

--------------------------------------------------------------------------------
//It returns the sum of all the amounts in a Payments table.

13. 
SELECT SUM(Amount) FROM Payments

--------------------------------------------------------------------------------
//It returns the total number of shipped orders from orders table

14. 
SELECT COUNT(Status) FROM Orders
WHERE Status = 'Shipped'

--------------------------------------------------------------------------------
//IT returns the average price of all the products as Rands and Dollars

15. 
SELECT AVG(BuyPrice) AS Rands, AVG(BuyPrice * 12) AS  Dollars FROM Products

--------------------------------------------------------------------------------
//It returns all the records of the joint table Payments and Customers

16. 
SELECT * FROM Payments
INNER JOIN Customers ON Payments.CustomerID = Customers.CustomerID

--------------------------------------------------------------------------------
//It return all products that have turnable front wheels from products table
17. 
SELECT * FROM Products
WHERE Description LIKE 'Turnable front wheels%'


