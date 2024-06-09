CREATE DATABASE Shopapp;
USE Shopapp;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(100) NOT NULL DEFAULT '',
    phone_number VARCHAR(10) NOT NULL,
    address VARCHAR(200) DEFAULT '',
    password VARCHAR(100) NOT NULL DEFAULT '', 
    created_at DATETIME DEFAULT,
    updated_at DATETIME DEFAULT,
    is_active TINYINT(1) DEFAULT 1,
    date_of_birth DATE,
    facebook_account_id INT DEFAULT 0,
    google_account_id INT DEFAULT 0
);
ALTER TABLE users ADD COLUMN role_id INT;

--ROLES
CREATE TABLE roles(
	id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);
ALTER TABLE users ADD FOREIGN KEY (role_id) REFERENCES roles (id);
CREATE TABLE tokens(
	id int PRIMARY KEY AUTO_INCREMENT,
    token varchar(255) UNIQUE NOT NULL,
    token_type varchar(50) NOT NULL,
    expiration_date DATETIME,
    revoked tinyint(1) NOT NULL,
    expired tinyint(1) NOT NULL,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--- hỗ trợ đăng nhập facebook và google
CREATE TABLE social_accounts(
	id INT PRIMARY KEY AUTO_INCREMENT,
	provider VARCHAR(20) NOT NULL COMMENT 'tên nhà social network',
	email VARCHAR(150) NOT NULL COMMENT 'Email tài khoảng',
	name VARCHAR(100) NOT NULL COMMENT 'tên người dùng',
	user_id INT,
	FOREIGN KEY (user_id) REFERENCES users(id)
);

-- danh mục sản phẩm.

CREATE TABLE categories(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name varchar(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục, vd: đồ điện tử'
);

-- bảng sản phẩm.

CREATE TABLE products(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(350) COMMENT 'Tên sản phẩm',
	price FLOAT NOT NULL,
	thumbnail VARCHAR(300) DEFAULT '',
	description LONGTEXT DEFAULT '',
	created_at DATETIME,
	update_at DATETIME,
	category_id INT,
	FOREIGN KEY (category_id) REFERENCES categories (id),
	image_url VARCHAR(300)
);



--Mới tạo
-- xóa sản phẩm thì bảng ảnh cũng bị xóa theo
CREATE TABLE product_images(
	id INT PRIMARY KEY AUTO_INCREMENT,
	product_id INT,
	FOREIGN KEY (product_id) REFERENCES products (id),
	CONSTRAINT fk_product_images_product_id
	FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    image_url varchar(300)
);




-- đặt hàng - oders

CREATE TABLE orders(
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    fullname VARCHAR(100) DEFAULT '',
    email VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT NULL,
    note VARCHAR(100) DEFAULT '',
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    total_money FLOAT CHECK(total_money >= 0),
	shipping_method VARCHAR(100),
	shipping_address VARCHAR(200),
	shipping_date DATE,
	tracking_number VARCHAR(100),
	payment_method VARCHAR(100)
);

--xóa một đơn hàng => xóa mềm => thêm trường active.
	ALTER TABLE orders ADD COLUMN active TINYINT(1);
	-- enum kiểu dữ liệu liệt kê
	ALTER TABLE orders
	MODIFY COLUMN status ENUM('pending', 'processing', 'shipped', 'delivered' , 'cancelled')
	COMMENT 'Trạng thái đơn hàng';

-- chi tiết đặt hàng.
CREATE TABLE order_details(
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES orders (id),
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products(id),
    price FLOAT CHECK(price >= 0),
    number_of_products INT CHECK(number_of_products > 0),
    total_money FLOAT CHECK(total_money >= 0),
    color VARCHAR(20) DEFAULT ''
);