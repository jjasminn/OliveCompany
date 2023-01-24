import 'package:postgres/postgres.dart';
import 'dart:io';
import 'dart:convert';

class Database {
  void ConnectToDatabase() async {
    final con = PostgreSQLConnection('10.0.2.2', 5435, 'Zeytinyagi',
        username: 'postgres', password: 'password');

    await con.open();
    print("Connected to database...");

//    BURADAKI TUM TABLOLAR BIR KERE CREATE EDILDI

//     await con.query('''
//   CREATE TABLE customer(
// 	c_name varchar(25),
// 	c_surname varchar(25),
//     c_id INTEGER PRIMARY KEY,
//     c_location VARCHAR(255),
//     tel_no INTEGER
// );

//  ''');
//     await con.query('''
//   CREATE TABLE farmer (
// 	f_name varchar(25),
// 	f_surname varchar(25),
//     f_id INTEGER PRIMARY KEY,
//     f_location VARCHAR(255),
//     tel_no INTEGER
// );

//  ''');

//     await con.query('''
//   CREATE TABLE factory (
//     fac_id INTEGER primary KEY,
//     fac_location VARCHAR(255) NOT NULL
// );

//  ''');
//     await con.query('''
//   CREATE TABLE product (
//     p_id INTEGER PRIMARY KEY,
//     olive_type VARCHAR(255) NOT NULL,
// 	oil_stock INTEGER,
//     olive_oil_price DECIMAL(10,2),
//     liter_per_kilo INTEGER NOT NULL
// );

//  ''');

//     await con.query('''
//   CREATE SEQUENCE order_number_seq_transform;
//  ''');
//     await con.query('''

// CREATE TABLE orders_for_transform (
//     order_date TIMESTAMP NOT NULL,
//     order_number INTEGER NOT NULL DEFAULT nextval('order_number_seq_transform'),
//     farmer_id INTEGER NOT NULL,
//     product_id INTEGER NOT NULL,
//     weight INTEGER CHECK (weight >= 50),
// 	factory_id INTEGER,
//     PRIMARY KEY (order_number),
//     FOREIGN KEY (farmer_id) REFERENCES farmer(f_id) ON DELETE CASCADE,
// 	FOREIGN KEY (factory_id) REFERENCES factory(fac_id) ON DELETE CASCADE,
// 	FOREIGN KEY (product_id) REFERENCES product(p_id) ON DELETE CASCADE
// );
//  ''');
//     await con.query('''
//   CREATE SEQUENCE order_number_seq_sale;
//  ''');

//     await con.query('''
// CREATE TABLE orders_for_sale (
//     order_date TIMESTAMP NOT NULL,
//     order_number INTEGER NOT NULL DEFAULT nextval('order_number_seq_sale'),
//     customer_id INTEGER NOT NULL,
//     product_id INTEGER NOT NULL,

// 	liter INTEGER,
// 	factory_id INTEGER,
//     PRIMARY KEY (order_number),
//     FOREIGN KEY (customer_id) REFERENCES customer(c_id) ON DELETE CASCADE,
// 	FOREIGN KEY (factory_id) REFERENCES factory(fac_id) ON DELETE CASCADE,
// 	FOREIGN KEY (product_id) REFERENCES product(p_id) ON DELETE CASCADE
// );

//  ''');

// TRIGGERS

//     await con.query('''
// CREATE OR REPLACE FUNCTION check_weight() RETURNS TRIGGER AS '
// BEGIN
//     IF NEW.weight < 50 THEN
// 		return old;
//     END IF;
//     RETURN NEW;
// END;
// ' LANGUAGE plpgsql;

//  ''');

//     await con.query('''
// CREATE TRIGGER weight_check
// BEFORE INSERT ON orders_for_transform
// FOR EACH ROW
// EXECUTE FUNCTION check_weight();

//  ''');

//TYPES

//     await con.query('''
// CREATE TYPE olive_infos AS (olive_type VARCHAR(255), total_orders INTEGER);

//  ''');

//FUNCTIONS

//     await con.query('''
// CREATE OR REPLACE FUNCTION return_order_cost(orderNum INTEGER)
// RETURNS DECIMAL
// AS '
// DECLARE
// 	oil_price DECIMAL(10,2);
// 	liter_bought INT;
//     farmer_customer INTEGER;
// 	curr cursor for SELECT o.customer_id, o.product_id, o.order_number from orders_for_sale as o;
// BEGIN
// 	for line in curr LOOP
// 		IF line.order_number = orderNum THEN

// 			SELECT f_id
// 			INTO farmer_customer
// 			FROM farmer
// 			INTERSECT
// 			SELECT c_id
// 			FROM customer as c
// 			WHERE c.c_id = line.customer_id;

// 			SELECT liter into liter_bought from orders_for_sale as o where o.customer_id=line.customer_id;
// 			SELECT olive_oil_price into oil_price from product as o where o.p_id=line.product_id;

// 			IF farmer_customer IS NOT NULL THEN
// 				RETURN liter_bought*oil_price * 0.9;

// 			ELSE
// 				RETURN liter_bought*oil_price;
// 			END IF;

// 			END IF;
// 		END LOOP;

// END;
// ' LANGUAGE plpgsql;

//  ''');
//     await con.query("""drop function best_selling_olive_type()""");
//     await con.query('''
//   CREATE OR REPLACE FUNCTION best_selling_olive_type()
// RETURNS varchar(255) AS '
// DECLARE
// max_selled_olive olive_infos;
// BEGIN
//     SELECT P.olive_type , COUNT(*) as total_orders into max_selled_olive
//     FROM orders_for_sale as O
//     JOIN product as P ON O.product_id = P.p_id
//     GROUP BY P.olive_type
//     HAVING COUNT(*) = (SELECT MAX(cnt) FROM (SELECT COUNT(*) as cnt FROM orders_for_sale O JOIN product as P ON O.product_id = P.p_id GROUP BY P.olive_type) as subquery)
//     ORDER BY total_orders DESC;

// 	return max_selled_olive.olive_type;
// END;
// ' LANGUAGE plpgsql;

//  ''');

//     await con.query('''
// CREATE OR REPLACE FUNCTION delete_order_for_sale(x_order_number INTEGER)
// RETURNS VOID AS '
//     DECLARE product_id INTEGER;
//     DECLARE liter INTEGER;
// 	DECLARE oilstock INTEGER;
// 	cur_for_orderNum CURSOR FOR Select o.order_number
// 								from orders_for_sale as o;
// BEGIN
// 	for line in cur_for_orderNum Loop
// 		IF line.order_number = x_order_number then
// 			SELECT o.product_id into product_id FROM orders_for_sale as o WHERE o.order_number = x_order_number;
// 			SELECT o.liter into liter FROM orders_for_sale as o WHERE o.order_number = x_order_number;
// 			SELECT o.oil_stock into oilstock FROM product as o WHERE p_id = product_id;
// 			UPDATE product SET oil_stock = oil_stock + liter WHERE p_id = product_id;
// 			DELETE FROM orders_for_sale WHERE order_number = x_order_number;

//

// 		end if;
// 	end loop;
// END;
// ' LANGUAGE plpgsql;

//  ''');

//    VIEW

//     await con.query('''
//   CREATE VIEW order_info AS
// SELECT  orders_for_sale.order_date, orders_for_sale.customer_id, orders_for_sale.liter,
//        product.olive_type
// FROM orders_for_sale
// JOIN product ON orders_for_sale.product_id = p_id ;

//  ''');

//BASTAKI INSERTLER

//     await con.query('''
// INSERT INTO customer (c_name, c_surname, c_id, c_location, tel_no)
// VALUES ('John', 'Doe', 11, 'New York', 1234567890),
//        ('Jane', 'Doe', 24, 'Los Angeles', 1234567890),
//        ('Bob', 'Smith', 35, 'Chicago', 1234567890),
//        ('Alice', 'Johnson', 14, 'Houston', 1234567890),
//        ('Charlie', 'Williams', 55, 'Philadelphia', 1234567890),
//        ('David', 'Jones', 26, 'Phoenix', 1234567890),
//        ('Amy', 'Brown', 37, 'San Antonio', 1234567890),
//        ('Brian', 'Miller', 8, 'San Diego', 1234567890),
//        ('Emily', 'Moore', 9, 'Dallas', 1234567890),
//        ('Daniel', 'Taylor', 10, 'San Jose', 1234567890);

//  ''');
//     await con.query('''
// INSERT INTO farmer (f_name, f_surname, f_id, f_location, tel_no)
// VALUES ('Mark', 'Johnson', 19, 'New York', 1234567890),
//        ('Stuart', 'Williams', 29, 'Los Angeles', 1234567890),
//        ('Jeremy', 'Jones', 34, 'Chicago', 1234567890),
//        ('Benjamin', 'Brown', 44, 'Houston', 1234567890),
//        ('Greg', 'Miller', 85, 'Philadelphia', 1234567890),
//        ('Joshua', 'Moore', 16, 'Phoenix', 1234567890),
//        ('Andrew', 'Taylor', 71, 'San Antonio', 1234567890),
//        ('Brian', 'Miller', 8, 'San Diego', 1234567890),
//        ('Emily', 'Moore', 9, 'Dallas', 1234567890),
//        ('Donald', 'Jackson', 13, 'San Jose', 1234567890);

//  ''');
//     await con.query('''
// INSERT INTO factory (fac_id, fac_location)
// VALUES (1, 'New York'),
//        (2, 'Los Angeles'),
//        (3, 'Chicago'),
//        (4, 'Houston'),
//        (5, 'Philadelphia'),
//        (6, 'Phoenix'),
//        (7, 'San Antonio'),
//        (8, 'San Diego'),
//        (9, 'Dallas'),
//        (10, 'San Jose');

//  ''');
//     await con.query('''
// INSERT INTO product (p_id, olive_type, oil_stock, olive_oil_price, liter_per_kilo)
// VALUES (1, 'Black Extra Virgin', 2500, 7.5, 0.5),
//        (2, 'Black Virgin', 2000, 8.5, 0.4),
//        (3, 'Black Pure', 3000, 6.5, 0.3),
//        (4, 'Black Extra Light', 4000, 5.5, 0.25),
//        (5, 'Black Light', 3500, 4.5, 0.2),
//        (6, 'Green Extra Virgin', 6000, 3.5, 0.15),
//        (7, 'Green Virgin', 1500, 3.5, 0.1),
// 	   (8, 'Green Pure', 4000, 2.5, 0.05),
//        (9, 'Green Extra Light', 9000, 0.5, 0.02),
//        (10,'Green Light', 5000, 3.25, 0.01);

//  ''');
//     await con.query('''
// INSERT INTO orders_for_transform (order_date, farmer_id, product_id, weight, factory_id)
// VALUES (current_timestamp, 19, 1, 100, 1),
//        (current_timestamp, 29, 2, 200, 1),
//        (current_timestamp, 34, 3, 53, 1),
//        (current_timestamp, 44, 4, 64, 1),
//        (current_timestamp, 85, 5, 50, 1),
//        (current_timestamp, 16, 6, 60, 1),
//        (current_timestamp, 71, 7, 70, 1),
//        (current_timestamp, 8, 8, 80, 1),
//        (current_timestamp, 9, 9, 90, 1),
//        (current_timestamp, 13, 10, 150, 1);

//  ''');
//     await con.query('''
// INSERT INTO orders_for_sale (order_date, customer_id, product_id, liter, factory_id)
// VALUES (current_timestamp, 11, 1, 10, 1),
//        (current_timestamp, 24, 2, 20, 1),
//        (current_timestamp, 35, 3, 30, 1),
//        (current_timestamp, 14, 4, 40, 1),
//        (current_timestamp, 55, 5, 50, 1),
//        (current_timestamp, 26, 6, 60, 1),
//        (current_timestamp, 37, 7, 70, 1),
//        (current_timestamp, 8, 8, 80, 1),
//        (current_timestamp, 9, 9, 90, 1),
//        (current_timestamp, 10, 10, 100, 1);
//  ''');

    await con.close();
  }

  void AddFarmerOrder(
    String name,
    String lastname,
    String location,
    int weight,
    String type,
  ) async {
    final con = PostgreSQLConnection('10.0.2.2', 5435, 'Zeytinyagi',
        username: 'postgres', password: 'password');
    await con.open();
    var fIdsql = await con.query("""
        SELECT f_id
        FROM FARMER
        WHERE f_name = '$name' and f_surname = '$lastname';
      """);
    int fId = fIdsql[0][0];
    var factoryIdsql = await con.query("""
        SELECT FAC_ID
        FROM FACTORY
        WHERE fac_location = '$location';
""");
    int factoryId = factoryIdsql[0][0];

    var productIdsql = await con.query("""
        SELECT p_id
        FROM PRODUCT
        WHERE olive_type ='$type';

""");
    int productId = productIdsql[0][0];
    await con.query("""
        INSERT INTO orders_for_transform(order_date, farmer_id, product_id, weight, factory_id)
        VALUES (current_timestamp,'$fId','$productId','$weight','$factoryId');
""");
  }

  Future AddCustomerOrder(
    String name,
    String lastname,
    String location,
    int liter,
    String type,
  ) async {
    final con = PostgreSQLConnection('10.0.2.2', 5435, 'Zeytinyagi',
        username: 'postgres', password: 'password');
    await con.open();

    print(" $name, $lastname $location $liter $type");
    var cIdsql = await con.query("""
        SELECT c_id
        FROM CUSTOMER
        WHERE c_name='$name' and c_surname = '$lastname';
      """);
    int cId = cIdsql[0][0];

    //musterinin varligina emin olduk

    var factoryIdsql = await con.query("""
        SELECT FAC_ID
        FROM FACTORY
        WHERE fac_location = '$location';
"""); //factory idsi kendisini oldugu bolgedeolan factorye gore yapilacak

    int factoryId = factoryIdsql[0][0];

    var productIdsql = await con.query("""
        SELECT p_id
        FROM PRODUCT
        WHERE olive_type = '$type';

"""); //product id alindi

    int productId = productIdsql[0][0];
    print(productId);
    await con.query("""
  INSERT INTO orders_for_sale (order_date, customer_id, product_id, liter, factory_id)
VALUES (current_timestamp, '$cId', '$productId', '$liter', '$factoryId');
""");
    var orderIdsql = await con.query("""
    SELECT order_number
    from orders_for_sale
    group by order_number
    order by order_number desc
    limit 1

""");

    int orderId = orderIdsql[0][0];

    var costSQL = await con.query("""
    SELECT return_order_cost('$orderId');
""");

    print(costSQL);
    double cost = double.parse(costSQL[0][0]);

    print("$cId $factoryId $productId $orderId $cost");

    await con.query("""
    SELECT delete_order_for_sale('$orderId');
""");
    await con.close();
    return cost;
  }

  void DeleteOrder(int orderId) async {
    final con = PostgreSQLConnection('10.0.2.2', 5435, 'Zeytinyagi',
        username: 'postgres', password: 'password');
    await con.open();
    print("connected to database");
    print(orderId);

    con.query("""
    SELECT delete_order_for_sale('$orderId');
    """);

    con.close();
  }

  Future most_selled_oil() async {
    final con = PostgreSQLConnection('10.0.2.2', 5435, 'Zeytinyagi',
        username: 'postgres', password: 'password');
    await con.open();

    var oil = await con.query("""

select best_selling_olive_type();



""");
    print(oil);

    con.close();
    return oil;
  }

  Future AllOrders() async {
    final con = PostgreSQLConnection('10.0.2.2', 5435, 'Zeytinyagi',
        username: 'postgres', password: 'password');
    await con.open();
    var orders = await con.query("""
    Select *
    From order_info
    """);

    con.close();
    return orders;
  }
}
