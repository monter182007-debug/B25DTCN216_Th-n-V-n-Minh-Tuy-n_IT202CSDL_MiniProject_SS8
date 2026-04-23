create database shopping_management;
use shopping_management;

-- Tao bang
CREATE TABLE Categorys (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, 
    gender int default 0 not null check(gender between 0 and 1),
    birthday DATE 
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(200) NOT NULL,
    price DECIMAL(15, 2) NOT NULL check(price>=0),
    category_id INT,
	FOREIGN KEY (category_id) REFERENCES Categorys(category_id) on delete cascade
);

CREATE TABLE `Orders` (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) on delete cascade
);

CREATE TABLE Order_Details (
	order_details int primary key auto_increment ,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL check(quantity >=0),
    unit_price DECIMAL(15, 2) NOT NULL,
    unique (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES `Orders`(order_id) on delete cascade,
	FOREIGN KEY (product_id) REFERENCES Products(product_id) on delete cascade
);
-- Them du lieu
INSERT INTO Categorys (category_id, category_name) 
VALUES
(1, 'Điện tử'),
(2, 'Thời trang'),
(3, 'Gia dụng'),
(4, 'Mỹ phẩm'),
(5, 'Thực phẩm');

INSERT INTO Customers (customer_id, full_name, email, gender, birthday) 
VALUES
(1, 'Nguyễn Văn An', 'an.nguyen@gmail.com', '1', '1995-05-15'),
(2, 'Trần Thị Bình', 'binh.tran@yahoo.com','0', '1998-10-20'),
(3, 'Lê Văn Cường', 'cuong.le@outlook.com', '1', '1992-03-12'),
(4, 'Phạm Thị Dung', 'dung.pham@hotmail.com', '0', '2000-12-05'),
(5, 'Hoàng Văn Em', 'em.hoang@gmail.com', '1', '1997-08-25');

INSERT INTO Products (product_id, product_name, price, category_id) 
VALUES
(101, 'iPhone 15 Pro', 28000000, 1),
(102, 'Áo thun Polo', 350000, 2),
(103, 'Máy giặt LG 9kg', 8500000, 3),
(104, 'Son môi MAC', 600000, 4),
(105, 'Sữa tươi Vinamilk', 35000, 5);

INSERT INTO `Orders` (order_id, customer_id, order_date) VALUES
(1001, 1, '2026-04-20 10:30:00'),
(1002, 2, '2026-04-21 14:15:00'),
(1003, 3, '2026-04-22 09:00:00'),
(1004, 4, '2026-04-22 16:45:00'),
(1005, 5, '2026-04-22 20:10:00');

INSERT INTO Order_Details (order_id, product_id, quantity, unit_price) VALUES
(1001, 101, 1, 28000000), 
(1002, 102, 2, 350000),   
(1003, 103, 1, 8500000),  
(1004, 104, 3, 600000),   
(1005, 105, 10, 35000); 

-- Cap nhap du lieu
update Products 
set price = 1000000 
where product_id =101;

update Customers
set email = 'tuyen@gmail.com'
where customer_id = 1;

-- Xoa du lieu 
delete from `Orders`
where order_id = 1005;

-- Truy van du lieu
-- 1 
select full_name,email,
	case 
		when gender = 1 then 'Nam'
        else 'Nữ'
        End as 'Giới tính'
from Customers;
-- 2 
select full_name ,email,
	year(now())-year(birthday) as age
from Customers 
order by age asc
limit 3;

-- 3
select Orders.*,Customers.full_name
from Orders
join Customers on Orders.customer_id = Customers.customer_id;

-- 4
select Categorys.category_name ,count(Products.product_id) as quanity
from Categorys 
join Products on  Products.category_id = Categorys.category_id 
group by Categorys.category_name
having quanity >=2;

-- 5
select * 
from Products 
where price > (
	select avg(products.price)
	from Products
);

-- 6
select full_name , email
from Customers 
where customer_id not in (
	select customer_id
    from `Orders`
);

-- 7 
select c.category_name,sum(p.price * od.quantity) as total_revenue
from Categorys c
join Products p on c.category_id = p.category_id
join Order_Details od on p.product_id = od.product_id
group by c.category_id
having total_revenue > (
	select avg(revenue_per_cart) *1.2
    from (
		select sum(od2.quantity * p2.price) as revenue_per_cart
        from Order_Details od2
        join Products p2 on od2.product_id=p2.product_id
    )as sub_table
);

-- 8
select *
from Products p1
where p1.price =(
	select max(p2.price)
	from Products p2
    where p2.product_id=p1.product_id
);

-- 9 
SELECT DISTINCT c.full_name
FROM Customers c
JOIN `Orders` o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
JOIN Categorys cat ON p.category_id = cat.category_id
WHERE cat.category_name = 'Điện tử';
