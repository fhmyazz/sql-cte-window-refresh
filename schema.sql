CREATE TABLE sales (
 id INT, salesperson VARCHAR(50),
 region VARCHAR(50), sale_date DATE, amount INT
);
INSERT INTO sales VALUES
(1,'Budi','Jakarta','2024-01-05',500),
(2,'Ani','Jakarta','2024-01-12',800),
(3,'Budi','Jakarta','2024-01-20',300),
(4,'Citra','Bandung','2024-01-08',600),
(5,'Deni','Bandung','2024-01-15',900),
(6,'Citra','Bandung','2024-01-22',450),
(7,'Ani','Jakarta','2024-02-03',700),
(8,'Budi','Jakarta','2024-02-10',1000),
(9,'Deni','Bandung','2024-02-18',550),
(10,'Citra','Bandung','2024-02-25',800)
(11,'Citra','Bandung','2024-03-30',1000);


CREATE TABLE runners2 (
 name VARCHAR(50),
 category VARCHAR(20),
 finish_time DECIMAL(4,1)
);

INSERT INTO runners2 VALUES
('Eko',   'Junior', 9.5),
('Ani',   'Junior', 9.8),
('Budi',  'Senior', 10.2),
('Citra', 'Senior', 10.2),
('Deni',  'Senior', 11.0);

CREATE TABLE raw_transactions (
  id INT,
  user_id INT,
  product_id INT,
  category VARCHAR(50),
  amount DECIMAL(10,2),
  status VARCHAR(20),
  created_at TIMESTAMP
);

INSERT INTO raw_transactions VALUES
(1,  101, 1, 'Electronics', 1500000, 'completed', '2024-01-05 10:00:00'),
(2,  102, 2, 'Fashion',      250000, 'completed', '2024-01-06 11:00:00'),
(3,  101, 1, 'Electronics', 1500000, 'completed', '2024-01-05 10:00:00'),
(4,  103, 3, 'Electronics',  750000, 'completed', '2024-01-07 09:00:00'),
(5,  102, 4, 'Fashion',      180000, 'cancelled', '2024-01-08 14:00:00'),
(6,  104, 2, 'Fashion',      250000, 'completed', '2024-01-09 16:00:00'),
(7,  101, 5, 'Food',          45000, 'completed', '2024-01-10 12:00:00'),
(8,  103, 1, 'Electronics', 1500000, 'completed', '2024-01-11 10:00:00'),
(9,  104, 3, 'Electronics',  750000, 'completed', '2024-01-12 15:00:00'),
(10, 102, 5, 'Food',          45000, 'completed', '2024-01-13 08:00:00'),
(11, 101, 1, 'Electronics', 1500000, 'completed', '2024-01-05 10:00:00'),
(12, 105, 2, 'Fashion',      250000, 'completed', '2024-01-14 13:00:00');


CREATE TABLE products (
  id INT,
  name VARCHAR(100),
  category VARCHAR(50),
  cost_price DECIMAL(10,2)
);

INSERT INTO products VALUES
(1, 'iPhone 15',      'Electronics', 1200000),
(2, 'Kemeja Polos',   'Fashion',      180000),
(3, 'Samsung Galaxy', 'Electronics',  600000),
(4, 'Celana Jeans',   'Fashion',      120000),
(5, 'Nasi Goreng Box','Food',          30000);

CREATE TABLE users (
  id INT,
  name VARCHAR(100),
  email VARCHAR(100),
  tier VARCHAR(20),
  created_at DATE
);

INSERT INTO users VALUES
(101, 'Budi Santoso',  'budi@email.com',  'gold',   '2023-01-15'),
(102, 'Ani Wijaya',    'ani@email.com',   'silver', '2023-03-20'),
(103, 'Citra Dewi',    'citra@email.com', 'gold',   '2023-02-10'),
(104, 'Deni Kusuma',   'deni@email.com',  'bronze', '2023-06-05'),
(105, 'Eko Prasetyo',  'eko@email.com',   'silver', '2023-08-12'),
(106, 'Fani Larasati', 'fani@email.com',  'gold',   '2023-04-30');