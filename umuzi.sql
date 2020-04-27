-- Adminer 4.7.6 PostgreSQL dump
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

DROP VIEW IF EXISTS "CustomerRecords";
CREATE TABLE "CustomerRecords" ("customerid" integer, "firstname" character varying(50), "lastname" character varying(50), "gender" character varying, "address" character varying(200), "phone" character varying(10), "email" character varying(100), "city" character varying(20), "country" character varying(50));


DROP VIEW IF EXISTS "RecordsFromCustomer";
CREATE TABLE "RecordsFromCustomer" ("customerid" integer, "firstname" character varying(50), "lastname" character varying(50), "gender" character varying, "address" character varying(200), "phone" character varying(10), "email" character varying(100), "city" character varying(20), "country" character varying(50));


DROP TABLE IF EXISTS "customers";
DROP SEQUENCE IF EXISTS customers_customerid_seq;
CREATE SEQUENCE customers_customerid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."customers" (
    "customerid" integer DEFAULT nextval('customers_customerid_seq') NOT NULL,
    "firstname" character varying(50) NOT NULL,
    "lastname" character varying(50) NOT NULL,
    "gender" character varying NOT NULL,
    "address" character varying(200),
    "phone" character varying(10),
    "email" character varying(100),
    "city" character varying(20),
    "country" character varying(50),
    CONSTRAINT "customers_pkey" PRIMARY KEY ("customerid")
) WITH (oids = false);

INSERT INTO "customers" ("customerid", "firstname", "lastname", "gender", "address", "phone", "email", "city", "country") VALUES
(3,	'Leon',	'Glen',	'Male',	'81 Everton Rd,Gillits',	'0820832830',	'Leon@gmail.com',	'Durban',	'South Africa'),
(4,	'Charl',	'Muller',	'Male',	'290A Dorset Ecke',	'0856872553',	'Charl.muller@yahoo.com',	'Berlin',	'Germany'),
(5,	'Julia',	'Stein',	'Female',	'2 Wernerring',	'0867244505',	'Js234@yahoo.com',	'Frankfurt',	'South Africa'),
(1,	'Lerato',	'Mabitso',	'Male',	'284 chaucer st',	'084789657',	'john@gmail.com',	'Johannesburg',	'South Africa');

DROP TABLE IF EXISTS "employees";
DROP SEQUENCE IF EXISTS employees_employeeid_seq;
CREATE SEQUENCE employees_employeeid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."employees" (
    "employeeid" integer DEFAULT nextval('employees_employeeid_seq') NOT NULL,
    "firstname" character varying(50) NOT NULL,
    "lastname" character varying(50) NOT NULL,
    "email" character varying(100),
    "jobtitle" character varying(20),
    CONSTRAINT "employees_pkey" PRIMARY KEY ("employeeid")
) WITH (oids = false);

INSERT INTO "employees" ("employeeid", "firstname", "lastname", "email", "jobtitle") VALUES
(1,	'Kani',	'Matthew',	'mat@gmail.com',	'Manager'),
(2,	'Lesly',	'Cronje',	'LesC@gmail.com',	'Clerk'),
(3,	'Gideon',	'Maduku',	'm@gmail.com',	'Accountant');

DROP TABLE IF EXISTS "orders";
DROP SEQUENCE IF EXISTS orders_orderid_seq;
CREATE SEQUENCE orders_orderid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."orders" (
    "orderid" integer DEFAULT nextval('orders_orderid_seq') NOT NULL,
    "productid" integer,
    "paymentid" integer,
    "fullfilledbyemployeeid" integer,
    "daterequired" date NOT NULL,
    "dateshipped" date,
    "status" character varying(20) NOT NULL,
    CONSTRAINT "orders_pkey" PRIMARY KEY ("orderid"),
    CONSTRAINT "orders_fullfilledbyemployeeid_fkey" FOREIGN KEY (fullfilledbyemployeeid) REFERENCES employees(employeeid) NOT DEFERRABLE,
    CONSTRAINT "orders_paymentid_fkey" FOREIGN KEY (paymentid) REFERENCES payments(paymentid) NOT DEFERRABLE,
    CONSTRAINT "orders_productid_fkey" FOREIGN KEY (productid) REFERENCES products(productid) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "orders" ("orderid", "productid", "paymentid", "fullfilledbyemployeeid", "daterequired", "dateshipped", "status") VALUES
(1,	1,	1,	2,	'2020-04-25',	NULL,	'Not shipped'),
(2,	1,	2,	2,	'2020-04-23',	'2020-04-25',	'Shipped'),
(3,	3,	3,	3,	'2020-04-28',	NULL,	'Not shipped');

DROP TABLE IF EXISTS "payments";
DROP SEQUENCE IF EXISTS payments_paymentid_seq;
CREATE SEQUENCE payments_paymentid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."payments" (
    "customerid" integer,
    "paymentid" integer DEFAULT nextval('payments_paymentid_seq') NOT NULL,
    "paymentdate" date NOT NULL,
    "amount" numeric NOT NULL,
    CONSTRAINT "payments_pkey" PRIMARY KEY ("paymentid"),
    CONSTRAINT "payments_customerid_fkey" FOREIGN KEY (customerid) REFERENCES customers(customerid) NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "payments" ("customerid", "paymentid", "paymentdate", "amount") VALUES
(1,	1,	'2020-04-24',	150.75),
(3,	3,	'2020-04-24',	700.60),
(1,	2,	'2020-04-24',	150.75);

DROP TABLE IF EXISTS "products";
DROP SEQUENCE IF EXISTS products_productid_seq;
CREATE SEQUENCE products_productid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."products" (
    "productid" integer DEFAULT nextval('products_productid_seq') NOT NULL,
    "productname" character varying(100) NOT NULL,
    "description" character varying(300),
    "buyprice" numeric NOT NULL,
    CONSTRAINT "products_pkey" PRIMARY KEY ("productid")
) WITH (oids = false);

INSERT INTO "products" ("productid", "productname", "description", "buyprice") VALUES
(1,	'Harley Davidson Chopper',	'This replica features working kickstand, front suspension, gear-shift lever',	150.75),
(2,	'Classic Car',	'Turnable front wheels, steering function',	150.75),
(3,	'Harley Davidson Chopper',	'Turnable front wheels, steering function',	700.60);




-- PART 2: QUERING A DATABASE

------------------------------------------------------------------------------------
//The command selects all the records from customer table.

1. 
SELECT * FROM Customers

--------------------------------------------------------------------------------
//Select only the FirstName records from customer table 

2. 
SELECT FirstName FROM Customers

--------------------------------------------------------------------------------
//The command show only the name of a customer whose customerID is 1.

3.
SELECT FirstName FROM Customers WHERE CustomerID = 1

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


