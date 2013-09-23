--1
SELECT city
FROM agents
WHERE agents.aid
IN (SELECT orders.aid FROM orders WHERE orders.cid='c002');
-- Get City from agents table because that is what we ultimately want our output to be. 
--Get aid from agents table because since you placed an order through a03. And you must locate aid in the agents table since it is the primary key.  
--To find this you must go to the orders table and locate where cid = c002. 
--2
SELECT DISTINCT orders.pid
FROM orders
WHERE orders.aid
IN (SELECT orders.aid
FROM orders
WHERE orders.cid
IN (SELECT customers.cid FROM customers WHERE customers.city ='Kyoto'));
-- Overal objective is to get the pid from products. Must output the pids which is in orders. 
--Must locate the aid and cid from orders table. 
--Must locate the cid and city which is in the customers table. 
--3
SELECT orders.cid, customers.name
FROM orders,customers
WHERE orders.cid= orders.cid
AND orders.cid
NOT IN (SELECT cid FROM orders WHERE aid='a03');
--Find cid and names. Want to be our output. 
--Orders.cid is located in orders table. Customers.name is located in customers table because you want the cid and names of customers. 
--Must locate data in the orders table because that is where the aid key and the cid key are BOTH located. 
--Since it can not be placed through agent a03 you must select the cid from orders where it does not = a03. 
--4
select distinct cid, name
from Customers 
where cid in 
	(select cid
	from Orders o1
	where pid = 'p07'
	AND cid in (select cid 
	from Orders o2
	where  pid = 'p01'))
--Output must be the cid and name. Located in the customers table. 
--Locate cid and and pid which are located in orders. 
--Since it is two pids you must have to separate functions for each order. 
--5
SELECT DISTINCT pid
FROM products
WHERE EXISTS(SELECT * FROM agents WHERE agents.aid ='a03'
AND EXISTS (SELECT * FROM orders WHERE orders.pid = products.pid
AND orders.aid =agents.aid));
--Want your output to be pid from the product table. 
--Must locate the aid from agents table where aid = 'a03'. 
--Must locate where the pid from the orders table and the pid from the product table both equal. 
--Aid from orders must equal the aid from products. 

--6
SELECT name , discount
FROM customers
WHERE city in
(SELECT city
FROM agents
WHERE city = 'Dallas'
OR city = 'Duluth'
)
--Output name and discount from customer table.
--Have to get the city from the agents table And it can either be Dallas or Duluth. 
--7
select
customers.cid,
customers.name
from 
customers
where
customers. discount in (
select
customers.discount
from
customers
where
customers.city = 'Dallas' or 
customers.city ='kyoto');
--Output must be from customers. Need to get names. 
--Locate the discount in the customer table. Where the city must be dallas or Kyoto. 