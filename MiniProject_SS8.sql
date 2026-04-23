create database shopping_management;
use shopping_management;

-- Tao bang
CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, 
    gender VARCHAR(10),
    birthday DATE
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(200) NOT NULL,
    price DECIMAL(15, 2) NOT NULL,
    category_id INT,
	FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE `Order` (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Detail (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(15, 2) NOT NULL,
    unique (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id) on delete cascade,
	FOREIGN KEY (product_id) REFERENCES Product(product_id) on delete cascade
);
-- Them du lieu
INSERT INTO Category (category_id, category_name) 
VALUES
(1, 'Điện tử'),
(2, 'Thời trang'),
(3, 'Gia dụng'),
(4, 'Mỹ phẩm'),
(5, 'Thực phẩm');

INSERT INTO Customer (customer_id, full_name, email, gender, birthday) 
VALUES
(1, 'Nguyễn Văn An', 'an.nguyen@gmail.com', 'Nam', '1995-05-15'),
(2, 'Trần Thị Bình', 'binh.tran@yahoo.com', 'Nữ', '1998-10-20'),
(3, 'Lê Văn Cường', 'cuong.le@outlook.com', 'Nam', '1992-03-12'),
(4, 'Phạm Thị Dung', 'dung.pham@hotmail.com', 'Nữ', '2000-12-05'),
(5, 'Hoàng Văn Em', 'em.hoang@gmail.com', 'Nam', '1997-08-25');

INSERT INTO Product (product_id, product_name, price, category_id) 
VALUES
(101, 'iPhone 15 Pro', 28000000, 1),
(102, 'Áo thun Polo', 350000, 2),
(103, 'Máy giặt LG 9kg', 8500000, 3),
(104, 'Son môi MAC', 600000, 4),
(105, 'Sữa tươi Vinamilk', 35000, 5);

INSERT INTO `Order` (order_id, customer_id, order_date) VALUES
(1001, 1, '2026-04-20 10:30:00'),
(1002, 2, '2026-04-21 14:15:00'),
(1003, 3, '2026-04-22 09:00:00'),
(1004, 4, '2026-04-22 16:45:00'),
(1005, 5, '2026-04-22 20:10:00');

INSERT INTO Order_Detail (order_id, product_id, quantity, unit_price) VALUES
(1001, 101, 1, 28000000), 
(1002, 102, 2, 350000),   
(1003, 103, 1, 8500000),  
(1004, 104, 3, 600000),   
(1005, 105, 10, 35000); 

-- Cap nhap du lieu
update product 
set price = 1000000 
where product_id =101;

update Customer 
set email = 'tuyen@gmail.com'
where customer_id = 1;


