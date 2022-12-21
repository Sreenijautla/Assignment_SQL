CREATE database Assignment;
USE Assignment;

CREATE table SalesPeople
(
	Snum int,
    Sname varchar(30),
    City varchar(30),
    Comm int,
    primary key(Snum),
    unique (Sname)
);
INSERT INTO SalesPeople VALUES
	('1001','Peel','London','12'),
	('1002','Serres','Sanjose','13'),
	('1004','Motika','London','11'),
	('1007','Rifkin','Barcelona','15'),
	('1003','Axelrod','Newyork','10');
SELECT * from SalesPeople;

CREATE table Customers
(
	Cnum int,
    Cname varchar(30),
    City varchar(30) NOT NULL,
    Snum int,
    primary key(Cnum),
    foreign key(Snum) references SalesPeople(Snum)
);
INSERT INTO Customers VALUES
	('2001','Hoffman','London','1001'),
	('2002','Giovanni','Rome','1003'),
	('2003','Liu','Sanjose','1002'),
	('2004','Grass','Berlin','1002'),
	('2006','Clemens','London','1001'),
	('2008','Cisneros','Sanjose','1007'),
	('2007','Pereira','Rome','1004');
SELECT * from Customers;

CREATE table Orders
(
	Onum int,
    Amt DECIMAL(10,2),
    Odate DATE,
    Cnum int,
    Snum int,
    primary key(Onum),
    foreign key(Cnum) references Customers(Cnum),
    foreign key(Snum) references SalesPeople(Snum)
);
INSERT INTO Orders VALUES
	('3001','18.69','1990-10-03','2008','1007'),
	('3003','767.19','1990-10-03','2001','1001'),
	('3002','1900.10','1990-10-03','2007','1004'),
	('3005','5160.45','1990-10-03','2003','1002'),
	('3006','1098.16','1990-10-03','2008','1007'),
	('3009','1713.23','1990-10-04','2002','1003'),
	('3007','75.75','1990-10-04','2004','1002'),
	('3008','4273.00','1990-10-05','2006','1001'),
	('3010','1309.95','1990-10-06','2004','1002'),
	('3011','9891.88','1990-10-06','2006','1001');
SELECT * from Orders;

-- 1. Count the number of Salesperson whose name begin with ‘a’/’A’.
SELECT count(Sname) AS Total_SalesPersons FROM SalesPeople WHERE Sname LIKE 'a%' OR Sname LIKE 'A%';

-- 2. Display all the Salesperson whose all orders worth is more than Rs. 2000.
SELECT s.sname AS All_SalesPersons, o.amt
FROM SalesPeople as s
INNER JOIN
Orders as o
ON s.snum = o.snum
WHERE o.amt>2000;

-- 3. Count the number of Salesperson belonging to Newyork.
SELECT City, count(Sname) AS No_of_SalesPersons FROM SalesPeople WHERE city='Newyork';

-- 4. Display the number of Salespeople belonging to London and belonging to Paris.
SELECT s.city, count(Sname) AS No_of_SalesPersons
FROM SalesPeople as s
INNER JOIN
Customers as c
ON s.city = c.city
GROUP BY City HAVING City='London' OR 'Paris';

-- 5. Display the number of orders taken by each Salesperson and their date of orders.
SELECT Sname AS SalesPerson, count(*) AS No_of_Orders, odate AS Date_of_Orders
FROM SalesPeople as s
INNER JOIN
Orders as o
ON o.snum = s.snum
GROUP BY Sname, odate;
    