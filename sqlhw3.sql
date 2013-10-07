--HW 3 
--1
SELECT city
FROM agents
WHERE agents.aid
IN (SELECT orders.aid FROM orders 
WHERE orders.cid='c002');
-- Get City from agents table because that is what we ultimately want our output to be. 
--Get aid from agents table because since you placed an order through a03. And you must locate aid in the agents table since it is the primary key.  
--To find this you must go to the orders table and locate where cid = c002.

--2
Select Distinct city 
From agents Inner Join orders
ON agents.aid= orders.aid
WHERE orders.cid='c002'
--You are looking to output the city therefore in your select statement you must choose disctint city therefore you do not have any duplicates. 
--You must inner join agents and orders to see where the cid and aid match up. When you are joining tables you must join a primary key to a foreign key. Therefore you will match the aid(primary key in the agents table) to the foreign key in the orders table. 
--Than you must put a where statement so you can filter out and see where the cid= c002. 

--3
SELECT DISTINCT orders.pid
FROM orders
WHERE orders.aid
IN (SELECT orders.aid
FROM orders
WHERE orders.cid
IN (SELECT customers.cid FROM customers WHERE customers.city ='Kyoto'));
--Find cid and names. Want to be our output. 
--Orders.cid is located in orders table. Customers.name is located in customers table because you want the cid and names of customers. 
--Must locate data in the orders table because that is where the aid key and the cid key are BOTH located. 
--Since it can not be placed through agent a03 you must select the cid from orders where it does not = a03. 

--4
Select Distinct o2.pid  
From Orders o1
Inner join customers on customers.cid= o1.cid
Inner join orders o2 ON o1.aid=o2.aid
WHERE customers.city='Kyoto'
--In this query you must have to aliases because the problem want you to have at least one order. 
--Therefore in order to match up the appropiate aid to cids you must have two orders. 
--Where filter so you can locate where the city is Kyoto therefore the compiler knows where to filter out what it needs. 


--5
Select customers.name
From customers
Where Not in 
(Select cid 
From orders);
--To get the names of customers who did not place an order you must make a where clause that will select all of the info that is not located in orders. 


--6
Select customers.name
from customers
left outer join orders on customers.cid=orders.cid
where orders.cid is null;
--for this problem you want customers name. However since you only want the customers name you must use 
--left outer join. Therefore you will only see where the customers is null. outer joins must be used in order to view nulls. 
--the problem is asking you to see what customer is not placing an order. Which means that you must match up the cid in the orders table. 
--Null means that there is no information that is associated with that table so by setting the cid to null you can find where there is currently no information associated with the cid and orders. 

--7 Get the names of customers who placed at least one order through an agent in their city, 
--along with those agent(s) names.
Select Distinct customers.name, agents.name 
From Customers
INNER JOIN orders ON customers.cid=orders.cid
INNER JOIN agents ON agents.aid= orders.aid
WHERE customers.city=agents.city
--You must join the customer orders and agents table to see where the foreign and primary keys match up. 
--therefore you must match primary key aid from agents to aid in orders. to get the agents name. 
--than you must match the primary id customers the foreign key in orders. 
--last you must put a filter in order to see where cities matched up in the customer and agents table. 

--8 Get the names of customers and agents in the same city, along with the name of the city, 
--regardles of whether or not the customer has ever placed an order with that agent.
Select customers.name, agents.name, customers.city 
From customers
INNER join agents on customers.city=agents.city
--you must inner join the customer and agents table to see where the cities connect. 
-- You must match both the customer.city and the agents city. 



--9. Get the name and city of customers who live in the city where the least number of products are made

Select agents.name, agents.city
From Agents
WHERE Agents.city=(Select city 
			From products
			WHERE quantity=(Select min(quantity)
			From products))
			
--For this one you must set the where clause where the quantity is minimum amount from the product table.
--Than you must match it to where the agent equals the city. 

--10 Get the name and city of customers who live in a city where the most number of products are made.
SELECT Distinct customers.name, customers.city
FROM customers 
WHERE customers.city = (SELECT city 
				FROM products 
				WHERE quantity = (SELECT max(quantity) 
								  FROM products))
--For this you must first select the customers and there city, in order to get the name and the city that you want. 
--Than you must create a where clause to determine the the maximum quanity of products. 

--11 Get the name and city of customers who live in any city where the most number of products are made.
Select customers.name, customers.city 
From customers
Where customers.city= 
(Select city 
From Products 
Where ANY quantity > (300000)
(Select max(quantity)
From products))



--12
--List the products whose priceUSD is above the average priceUSD.
SELECT products.name, products.priceUSD
FROM products 
WHERE products.priceUSD > (SELECT avg(priceUSD) 
				  FROM products);
--Here we must create a where clause that filters through the price therefore we can select the average 
--that is greater than the average price of products.
				  
--13. Show the customer name, pid ordered, and the dollars for all customer
--orders, sorted by dollars from high to low.
--Use Customer table and products table 
Select customers.name, orders.pid, orders.dollars
From Orders Inner join Customers 
On orders.cid=customers.cid 
Order by orders.dollars DESC;
--You must inner join customers and orders. 
--you have to match the pk in customers to the fk in orders. therefore you can see where the customers name 
--and pids match up. 


--14
--Show all customer names (in order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs.
Select customers.name, coalesce(sum(orders.qty),0)
From customers 
Left outer join orders on orders.cid=customers.cid
Order by customers.name ASC;
--We use the coalesece function in order for us to avoid nulls or set them equal to zero. 
--We must inner join customers and orders so we can see the customers name and what they ordered. 



--15  Show the names of all customers who bought products from agents based in 
--New York along with the names of the products they ordered, 
--and the names of the agents who sold it to them.
SELECT customers.name, products.name, agents.name
FROM customers 
INNER JOIN orders ON customers.cid = orders.cid
INNER JOIN products ON products.pid = orders.pid
INNER JOIN agents ON agents.aid = orders.aid
WHERE agents.city = 'New York'
ORDER BY customers.name;
--For this one you have to inner join all four tables. 
--THe select statement must be from customers because the output that you want is from the customers table (customers names) 
--Than you must innner join and match orders and customers cids to match the foreign key to primary key. 
--Match the two pids therefore you can know who bought the products. 
--Match the agnets aid and orders to get the agents name to be your output. 
--Than you must write a where clause because you only want the names products from where the city is New York which is located in the agents table. 

--16
-- Write a query to check the accuracy of the dollars column in the Orders table. 
--This means calculating Orders.dollars from other data in other tables and then comparing those values to the values in Orders.dollars.
SELECT orders.ordno, orders.dollars, ((products.priceUSD * orders.qty) - ((customers.discount / 100) * (price.priceUSD * orders.qty)))
FROM orders 
INNER JOIN products ON orders.pid = products.pid
INNER JOIN customers ON orders.cid = customers.cid
AND orders.dollars = ((products.priceUSD * orders.qty) - ((customers.discount / 100) * (products.priceUSD * orders.qty)));
--You must write a formula refering to the dollars column in the orders table. 
--when you write your formula you must compare values 
				  

--17
UPDATE orders
SET dollars = 610.00
WHERE ordno = 1026;
--For this you must use the update feature, and change the information in the table in order to create an error. 
--For the specific question it requred us to change the info, in order to check our accuracy. This ultimatly allows us to check for accuracy. 