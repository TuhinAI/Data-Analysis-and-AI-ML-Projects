-- Create Customer table --

CREATE TABLE customer(
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(60) NOT NULL,
company VARCHAR(60) NULL,
street VARCHAR(50) NOT NULL,
city VARCHAR(40) NOT NULL,
state CHAR(2) NOT NULL DEFAULT 'PA',
zip SMALLINT NOT NULL,
phone VARCHAR(20) NOT NULL,
birth_date DATE NULL,
sex CHAR(1) NOT NULL,
date_entered TIMESTAMP NOT NULL,
id SERIAL PRIMARY KEY
);

INSERT INTO customer(first_name, last_name, email, company, street, city, state, zip, phone, birth_date, sex, date_entered) VALUES
('Christopher', 'Jones', 'christopherjones@bp.com', 'BP', '347 Cedar St', 'Lawrenceville', 'GA', '30044', '348-848-8291', '1938-09-11', 'M', current_timestamp);

SELECT * FROM customer;


CREATE TYPE sex_type as enum
('M', 'F');

alter table customer
alter column sex type sex_type USING sex::sex_type;

CREATE TABLE sales_person(
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(60) NOT NULL,
street VARCHAR(50) NOT NULL,
city VARCHAR(40) NOT NULL,
state CHAR(2) NOT NULL DEFAULT 'PA',
zip SMALLINT NOT NULL,
phone VARCHAR(20) NOT NULL,
birth_date DATE NULL,
sex sex_type NOT NULL,
date_hired TIMESTAMP NOT NULL,
id SERIAL PRIMARY KEY
);

-----------ALTER TABLE sales_person DROP COLUMN id ; ------------------------


CREATE TABLE product_type(
name VARCHAR(30) NOT NULL,
id SERIAL PRIMARY KEY);


CREATE TABLE product(
type_id INTEGER REFERENCES product_type(id),
name VARCHAR(30) NOT NULL,
supplier VARCHAR(30) NOT NULL,
description TEXT NOT NULL,
id SERIAL PRIMARY KEY);


CREATE TABLE item(
product_id INTEGER REFERENCES product(id),
size INTEGER NOT NULL,
color VARCHAR(30) NOT NULL,
picture VARCHAR(256) NOT NULL,
price NUMERIC(6,2) NOT NULL,
id SERIAL PRIMARY KEY);


CREATE TABLE sales_order(
cust_id INTEGER REFERENCES customer(id),
sales_person_id INTEGER REFERENCES sales_person(id),
time_order_taken TIMESTAMP NOT NULL,
purchase_order_number INTEGER NOT NULL,
credit_card_number VARCHAR(16) NOT NULL,
credit_card_exper_month SMALLINT NOT NULL,
credit_card_exper_day SMALLINT NOT NULL,
credit_card_secret_code SMALLINT NOT NULL,
name_on_card VARCHAR(100) NOT NULL,
id SERIAL PRIMARY KEY
);


CREATE TABLE sales_item(
item_id INTEGER REFERENCES item(id),
sales_order_id INTEGER REFERENCES sales_order(id),
quantity INTEGER NOT NULL,
discount NUMERIC(3,2) NULL DEFAULT 0,
taxable BOOLEAN NOT NULL DEFAULT FALSE,
sales_tax_rate NUMERIC(5,2) NOT NULL DEFAULT 0,
id SERIAL PRIMARY KEY
);


ALTER TABLE sales_item ADD day_of_week VARCHAR(8);

ALTER TABLE sales_item ALTER COLUMN day_of_week SET NOT NULL;

ALTER TABLE sales_item RENAME COLUMN day_of_week TO weekday;

ALTER TABLE sales_item DROP COLUMN weekday;


CREATE TABLE transaction_type(
name VARCHAR(30) NOT NULL,
payment_type VARCHAR(30) NOT NULL,
id SERIAL PRIMARY KEY
);

ALTER TABLE transaction_type RENAME TO transaction;

CREATE INDEX transaction_id ON transaction(name);

CREATE INDEX transaction_id_2 ON transaction(name, payment_type);

TRUNCATE TABLE transaction;

DROP TABLE transaction;


INSERT INTO product_type (name) VALUES ('Business') , ('Casual') ,('Athletic');

select * from product_type;

INSERT INTO product VALUES
(1, 'Grandview', 'Allen Edmonds', 'Classic broguing adds texture to a charming longwing derby crafted in America from lustrous leather'),
(1, 'Clarkston', 'Allen Edmonds', 'Sharp broguing touches up a charming, American-made derby fashioned from finely textured leather'),
(1, 'Derby', 'John Varvatos', 'Leather upper, manmade sole'),
(1, 'Ramsey', 'Johnston & Murphy', 'Leather upper, manmade sole'),
(1, 'Hollis', 'Johnston & Murphy', 'Leather upper, manmade sole'),
(2, 'Venetian Loafer', 'Mezlan', 'Suede upper, leather sole'),
(2, 'Malek', 'Johnston & Murphy', 'Contrast insets at the toe and sides bring updated attitude to a retro-inspired sneaker set on a sporty foam sole and triangle-lugged tread.'),
(3, 'Air Max 270 React', 'Nike', 'The reggae inspired Nike Air 270 React fuses forest green with shades of tan to reveal your righteous spirit'),
(3, 'Joyride', 'Nike', 'Tiny foam beads underfoot conform to your foot for cushioning that stands up to your mileage'),
(2, 'Air Force 1', 'Nike', 'A modern take on the icon that blends classic style and fresh, crisp details'),
(3, 'Ghost 12', 'Brooks', 'Just know that it still strikes a just-right balance of DNA LOFT softness and BioMoGo DNA responsiveness'),
(3, 'Revel 3', 'Brooks', 'Style to spare, now even softer.'),
(3, 'Glycerin 17', 'Brooks', 'A plush fit and super soft transitions make every stride luxurious');

select * from product;


ALTER TABLE customer ALTER COLUMN zip TYPE INTEGER;

INSERT INTO customer (first_name, last_name, email, company, street, city, state, zip, phone, birth_date, sex, date_entered) VALUES 
('Matthew', 'Martinez', 'matthewmartinez@ge.com', 'GE', '602 Main Place', 'Fontana', 'CA', '92336', '117-997-7764', '1931-09-04', 'M', '2015-01-01 22:39:28'), 
('Melissa', 'Moore', 'melissamoore@aramark.com', 'Aramark', '463 Park Rd', 'Lakewood', 'NJ', '08701', '269-720-7259', '1967-08-27', 'M', '2017-10-20 21:59:29'), 
('Melissa', 'Brown', 'melissabrown@verizon.com', 'Verizon', '712 View Ave', 'Houston', 'TX', '77084', '280-570-5166', '1948-06-14', 'F', '2016-07-16 12:26:45'), 
('Jennifer', 'Thomas', 'jenniferthomas@aramark.com', 'Aramark', '231 Elm St', 'Mission', 'TX', '78572', '976-147-9254', '1998-03-14', 'F', '2018-01-08 09:27:55'), 
('Stephanie', 'Martinez', 'stephaniemartinez@albertsons.com', 'Albertsons', '386 Second St', 'Lakewood', 'NJ', '08701', '820-131-6053', '1998-01-24', 'M', '2016-06-18 13:27:34'), 
('Daniel', 'Williams', 'danielwilliams@tjx.com', 'TJX', '107 Pine St', 'Katy', 'TX', '77449', '744-906-9837', '1985-07-20', 'F', '2015-07-03 10:40:18'), 
('Lauren', 'Anderson', 'laurenanderson@pepsi.com', 'Pepsi', '13 Maple Ave', 'Riverside', 'CA', '92503', '747-993-2446', '1973-09-09', 'F', '2018-02-01 16:43:51'), 
('Michael', 'Jackson', 'michaeljackson@disney.com', 'Disney', '818 Pine Ave', 'Mission', 'TX', '78572', '126-423-3144', '1951-03-03', 'F', '2017-04-02 21:57:36'), 
('Ashley', 'Johnson', 'ashleyjohnson@boeing.com', 'Boeing', '874 Oak Ave', 'Pacoima', 'CA', '91331', '127-475-1658', '1937-05-10', 'F', '2015-01-04 08:58:56'), 
('Brittany', 'Thomas', 'brittanythomas@walmart.com', 'Walmart', '187 Maple Ave', 'Brownsville', 'TX', '78521', '447-788-4913', '1986-10-22', 'F', '2018-05-23 08:04:32'), 
('Matthew', 'Smith', 'matthewsmith@ups.com', 'UPS', '123 Lake St', 'Brownsville', 'TX', '78521', '961-108-3758', '1950-06-16', 'F', '2018-03-15 10:08:54'), 
('Lauren', 'Wilson', 'laurenwilson@target.com', 'Target', '942 Fifth Ave', 'Mission', 'TX', '78572', '475-578-8519', '1965-12-26', 'M', '2017-07-16 11:01:01'), 
('Justin', 'Smith', 'justinsmith@boeing.com', 'Boeing', '844 Lake Ave', 'Lawrenceville', 'GA', '30044', '671-957-1492', '1956-03-16', 'F', '2017-10-07 10:50:08'), 
('Jessica', 'Garcia', 'jessicagarcia@toyota.com', 'Toyota', '123 Pine Place', 'Fontana', 'CA', '92336', '744-647-2359', '1996-08-05', 'F', '2016-09-14 12:33:05'), 
('Matthew', 'Jackson', 'matthewjackson@bp.com', 'BP', '538 Cedar Ave', 'Katy', 'TX', '77449', '363-430-1813', '1966-02-26', 'F', '2016-05-01 19:25:17'), 
('Stephanie', 'Thomas', 'stephaniethomas@apple.com', 'Apple', '804 Fourth Place', 'Brownsville', 'TX', '78521', '869-582-9955', '1988-08-26', 'F', '2018-10-21 22:01:57'), 
('Jessica', 'Jackson', 'jessicajackson@aramark.com', 'Aramark', '235 Pine Place', 'Chicago', 'IL', '60629', '587-334-1054', '1991-07-22', 'F', '2015-08-28 03:11:35'), 
('James', 'Martinez', 'jamesmartinez@kroger.com', 'Kroger', '831 Oak St', 'Brownsville', 'TX', '78521', '381-428-3119', '1927-12-22', 'F', '2018-01-27 07:41:48'), 
('Christopher', 'Robinson', 'christopherrobinson@ibm.com', 'IBM', '754 Cedar St', 'Pharr', 'TX', '78577', '488-694-7677', '1932-06-25', 'F', '2016-08-19 16:11:31');

select * from customer;


ALTER TABLE sales_person ALTER COLUMN zip TYPE INTEGER;

INSERT INTO item VALUES 
(2, 10, 'Gray', 'Coming Soon', 199.60), 
(11, 12, 'Red', 'Coming Soon', 155.65), 
(2, 11, 'Red', 'Coming Soon', 128.87), 
(11, 11, 'Green', 'Coming Soon', 117.52), 
(5, 8, 'Black', 'Coming Soon', 165.39), 
(7, 11, 'Brown', 'Coming Soon', 168.15), 
(5, 8, 'Gray', 'Coming Soon', 139.48), 
(5, 11, 'Blue', 'Coming Soon', 100.14), 
(4, 10, 'Brown', 'Coming Soon', 117.66), 
(8, 10, 'Brown', 'Coming Soon', 193.53), 
(7, 8, 'Light Brown', 'Coming Soon', 154.62), 
(12, 10, 'Green', 'Coming Soon', 188.32), 
(3, 12, 'Green', 'Coming Soon', 101.49), 
(7, 9, 'Black', 'Coming Soon', 106.39), 
(8, 12, 'Red', 'Coming Soon', 124.77), 
(5, 8, 'Black', 'Coming Soon', 86.19), 
(8, 12, 'Blue', 'Coming Soon', 196.86), 
(8, 8, 'Blue', 'Coming Soon', 123.27), 
(7, 11, 'Red', 'Coming Soon', 130.76), 
(9, 12, 'Black', 'Coming Soon', 152.98), 
(11, 8, 'Blue', 'Coming Soon', 175.58), 
(7, 11, 'Light Brown', 'Coming Soon', 146.83), 
(4, 8, 'Green', 'Coming Soon', 159.82), 
(12, 8, 'Light Brown', 'Coming Soon', 171.92), 
(1, 12, 'Light Brown', 'Coming Soon', 128.77), 
(2, 10, 'Gray', 'Coming Soon', 102.45), 
(10, 8, 'Green', 'Coming Soon', 186.86), 
(1, 8, 'Blue', 'Coming Soon', 139.73), 
(9, 8, 'Light Brown', 'Coming Soon', 151.57), 
(2, 10, 'Green', 'Coming Soon', 177.16), 
(3, 9, 'Gray', 'Coming Soon', 124.87), 
(8, 8, 'Black', 'Coming Soon', 129.40), 
(5, 9, 'Black', 'Coming Soon', 107.55), 
(5, 8, 'Light Brown', 'Coming Soon', 103.71), 
(11, 10, 'Green', 'Coming Soon', 152.31), 
(6, 12, 'Red', 'Coming Soon', 108.96), 
(7, 12, 'Blue', 'Coming Soon', 173.14), 
(3, 10, 'Green', 'Coming Soon', 198.44), 
(1, 9, 'Light Brown', 'Coming Soon', 119.61), 
(1, 10, 'Black', 'Coming Soon', 114.36), 
(7, 9, 'Light Brown', 'Coming Soon', 181.93), 
(5, 10, 'Black', 'Coming Soon', 108.32), 
(1, 12, 'Black', 'Coming Soon', 153.97), 
(2, 12, 'Gray', 'Coming Soon', 184.27), 
(2, 9, 'Blue', 'Coming Soon', 151.63), 
(6, 8, 'Brown', 'Coming Soon', 159.39), 
(11, 9, 'Red', 'Coming Soon', 150.49), 
(9, 10, 'Gray', 'Coming Soon', 139.26), 
(4, 8, 'Gray', 'Coming Soon', 166.87), 
(12, 9, 'Red', 'Coming Soon', 110.77);

select * from item;

ALTER TABLE sales_order ALTER column purchase_order_number TYPE BIGINT;


---You must first insert data into sales_person table, then insert into sales_order.---


SELECT * FROM sales_person;
INSERT INTO sales_person 
(first_name, last_name, email, street, city, state, zip, phone, birth_date, sex, date_hired)
VALUES 
('John', 'Smith', 'JohnSmith@gmail.com', '123 Main St', 'New York', 'NY', 10001, '123-456-7890', '1990-05-20', 'M', '2020-01-15'),
('Michael', 'Johnson', 'MichaelJohnson@gmail.com', '456 Elm St', 'Los Angeles', 'CA', 90001, '234-567-8901', '1988-08-10', 'M', '2019-03-20'),
('Emily', 'Davis', 'EmilyDavis@gmail.com', '789 Pine St', 'Chicago', 'IL', 60601, '345-678-9012', '1992-12-05', 'F', '2021-07-10'),
('Sarah', 'Wilson', 'SarahWilson@gmail.com', '321 Oak St', 'Houston', 'TX', 77001, '456-789-0123', '1995-03-15', 'F', '2022-05-05');

SELECT * FROM sales_person;

INSERT INTO sales_order VALUES 
(1, 2, '2018-03-23 10:26:23', 20183231026, 5440314057399014, 3, 5, 415, 'Ashley Martin'), 
(8, 2, '2017-01-09 18:58:15', 2017191858, 6298551651340835, 10, 27, 962, 'Michael Smith'), 
(9, 3, '2018-12-21 21:26:57', 201812212126, 3194084144609442, 7, 16, 220, 'Lauren Garcia'), 
(8, 2, '2017-08-20 15:33:17', 20178201533, 2704487907300646, 7, 10, 430, 'Jessica Robinson'), 
(3, 4, '2017-09-19 13:28:35', 20179191328, 8102877849444788, 4, 15, 529, 'Melissa Jones'), 
(14, 1, '2016-10-02 18:30:13', 20161021830, 7294221943676784, 10, 22, 323, 'Lauren Moore'), 
(4, 2, '2016-03-21 07:24:30', 2016321724, 1791316080799942, 1, 24, 693, 'Joshua Wilson'), 
(1, 1, '2018-08-04 12:22:06', 2018841222, 4205390666512184, 5, 16, 758, 'Jennifer Garcia'), 
(8, 4, '2016-08-25 10:36:09', 20168251036, 3925972513042074, 1, 10, 587, 'Michael Thomas'), 
(8, 4, '2018-08-10 20:24:52', 20188102024, 2515001187633555, 10, 7, 354, 'David Martin'), 
(5, 2, '2016-11-28 15:21:48', 201611281521, 6715538212478349, 5, 25, 565, 'Jennifer Johnson'), 
(5, 3, '2016-12-07 10:20:05', 20161271020, 5125085038984547, 10, 27, 565, 'Brittany Garcia'), 
(13, 3, '2018-10-11 16:27:04', 201810111627, 5559881213107031, 7, 14, 593, 'Sarah Jackson'), 
(14, 1, '2018-04-26 20:35:34', 20184262035, 2170089500922701, 7, 26, 105, 'Daniel Harris'), 
(3, 2, '2016-11-14 04:32:50', 20161114432, 6389550669359545, 7, 19, 431, 'Brittany Williams'), 
(18, 3, '2016-07-10 17:55:01', 20167101755, 7693323933630220, 4, 22, 335, 'Christopher Thomas'), 
(12, 2, '2018-05-13 06:20:56', 2018513620, 1634255384507587, 1, 4, 364, 'Megan Garcia'), 
(3, 4, '2016-03-04 20:52:36', 2016342052, 7720584466409961, 2, 7, 546, 'Justin Taylor'), 
(17, 1, '2017-02-16 15:44:27', 20172161544, 7573753924723630, 3, 15, 148, 'Michael White'), 
(19, 3, '2017-08-04 07:24:30', 201784724, 9670036242643402, 10, 24, 803, 'Melissa Taylor'), 
(8, 2, '2018-07-08 15:51:11', 2018781551, 5865443195522495, 2, 2, 793, 'James Thompson'), 
(18, 1, '2017-03-02 03:08:03', 20173238, 9500873657482557, 6, 22, 793, 'Daniel Williams'), 
(7, 1, '2018-03-19 10:54:30', 20183191054, 7685678049357511, 2, 9, 311, 'Joshua Martinez'), 
(18, 1, '2017-07-04 18:48:02', 2017741848, 2254223828631172, 6, 18, 621, 'Justin Taylor'), 
(16, 1, '2018-07-23 21:44:51', 20187232144, 8669971462260333, 10, 3, 404, 'Ashley Garcia'), 
(8, 4, '2016-05-21 16:26:49', 20165211626, 9485792104395686, 2, 4, 270, 'Andrew Taylor'), 
(19, 4, '2018-09-04 18:24:36', 2018941824, 5293753403622328, 8, 4, 362, 'Matthew Miller'), 
(9, 2, '2018-07-01 18:19:10', 2018711819, 7480694928317516, 10, 5, 547, 'Justin Thompson'), 
(8, 4, '2018-09-10 20:15:06', 20189102015, 7284020879927491, 4, 15, 418, 'Samantha Anderson'), 
(17, 2, '2016-07-13 16:30:53', 20167131630, 7769197595493852, 1, 19, 404, 'Jessica Thomas'), 
(17, 4, '2016-09-22 22:58:11', 20169222258, 1394443435119786, 7, 5, 955, 'James Wilson'), 
(17, 4, '2017-10-28 11:35:05', 201710281135, 6788591532433513, 8, 13, 512, 'Michael Williams'), 
(12, 4, '2018-11-11 04:55:50', 20181111455, 1854718494260005, 3, 26, 928, 'Melissa Jones'), 
(15, 4, '2016-08-11 23:05:58', 2016811235, 7502173302686796, 3, 11, 836, 'Michael Thompson'), 
(2, 3, '2018-07-13 07:50:24', 2018713750, 5243198834590551, 10, 12, 725, 'Joseph Thomas'), 
(9, 3, '2017-09-28 11:42:16', 20179281142, 7221309687109696, 2, 5, 845, 'James Martinez'), 
(7, 1, '2016-01-09 18:15:08', 2016191815, 9202139348760334, 4, 4, 339, 'Samantha Wilson'), 
(18, 1, '2016-03-14 17:33:26', 20163141733, 3066530074499665, 6, 23, 835, 'David Garcia'), 
(12, 3, '2017-08-21 18:14:01', 20178211814, 1160849457958425, 8, 19, 568, 'Samantha Miller'), 
(8, 1, '2018-09-12 19:25:25', 20189121925, 6032844702934349, 8, 13, 662, 'Justin Brown'), 
(19, 2, '2016-11-06 03:07:33', 201611637, 1369214097312715, 9, 23, 330, 'Joseph Jones'), 
(3, 4, '2016-06-06 01:07:15', 20166617, 7103644598069058, 1, 5, 608, 'Brittany Thomas'), 
(13, 4, '2017-05-15 01:02:57', 201751512, 2920333635602602, 11, 14, 139, 'Stephanie Smith'), 
(15, 4, '2016-03-27 02:18:18', 2016327218, 7798214190926405, 5, 13, 809, 'Stephanie Taylor'), 
(9, 2, '2018-01-25 14:43:01', 20181251443, 4196223548846892, 10, 17, 115, 'Melissa Martin'), 
(6, 3, '2017-01-08 13:54:49', 2017181354, 8095784052038731, 8, 23, 416, 'Amanda White'), 
(12, 2, '2017-09-24 15:24:44', 20179241524, 6319974420646022, 2, 4, 755, 'Megan Anderson'), 
(11, 2, '2018-04-09 18:53:22', 2018491853, 3258192259182097, 11, 22, 730, 'Samantha Thompson'), 
(10, 2, '2018-01-11 22:20:29', 20181112220, 8336712415869878, 3, 18, 872, 'Melissa Wilson'), 
(14, 3, '2018-11-10 03:08:36', 2018111038, 6942550153605236, 9, 18, 250, 'Jessica Johnson'), 
(6, 4, '2016-06-26 16:48:19', 20166261648, 5789348928562200, 2, 7, 458, 'Christopher Jones'), 
(5, 1, '2018-06-23 02:25:16', 2018623225, 8550095429571317, 9, 25, 590, 'Samantha Wilson'), 
(18, 2, '2017-07-01 01:16:04', 201771116, 2651011719468438, 11, 11, 107, 'Andrew Miller'), 
(12, 4, '2017-01-17 21:42:51', 20171172142, 7354378345646144, 3, 14, 772, 'Andrew Moore'), 
(7, 3, '2016-01-07 22:56:31', 2016172256, 3429850164043973, 2, 6, 295, 'Joseph Taylor'), 
(10, 1, '2016-01-27 01:14:53', 2016127114, 2480926933843246, 7, 3, 704, 'Ashley Taylor'), 
(13, 1, '2018-09-15 08:15:17', 2018915815, 6626319262681476, 4, 8, 837, 'Stephanie Thomas'), 
(9, 1, '2018-04-06 15:40:28', 2018461540, 4226037621059886, 10, 26, 896, 'Stephanie Jones'), 
(17, 3, '2016-10-17 21:31:09', 201610172131, 7862008338119027, 10, 25, 767, 'Amanda Robinson'), 
(12, 2, '2016-06-04 22:27:57', 2016642227, 4472081783581101, 10, 9, 279, 'Justin Williams'), 
(9, 3, '2018-01-27 06:57:23', 2018127657, 2384491606066483, 11, 23, 417, 'Joshua Garcia'), 
(14, 2, '2018-07-19 22:11:23', 20187192211, 2680467440231722, 10, 8, 545, 'Ashley Wilson'), 
(19, 4, '2018-11-06 03:12:35', 2018116312, 3973342791188144, 10, 9, 749, 'Megan Martinez'), 
(11, 2, '2017-01-15 14:11:54', 20171151411, 3042008865691398, 8, 3, 695, 'Brittany White'), 
(10, 4, '2018-10-07 01:26:57', 2018107126, 7226038495242154, 8, 7, 516, 'Stephanie White'), 
(12, 3, '2018-10-02 16:13:23', 20181021613, 7474287104417454, 11, 1, 184, 'Daniel Davis'), 
(8, 1, '2018-08-12 23:54:52', 20188122354, 6454271840792089, 1, 19, 914, 'Michael Robinson'), 
(11, 2, '2016-07-06 04:57:33', 201676457, 6767948287515839, 8, 7, 127, 'Samantha Anderson'), 
(12, 2, '2018-09-06 10:34:03', 2018961034, 2724397042248973, 11, 11, 686, 'Ashley Harris'), 
(16, 1, '2017-11-12 07:05:38', 2017111275, 4832060124173185, 11, 27, 697, 'Brittany White'), 
(16, 4, '2016-06-08 17:38:18', 2016681738, 2187337846675221, 5, 9, 895, 'Megan Wilson'), 
(3, 3, '2016-02-08 21:46:46', 2016282146, 8361948319742012, 6, 26, 157, 'Jessica Taylor'), 
(8, 1, '2016-10-22 03:01:13', 2016102231, 1748352966511490, 8, 7, 815, 'Justin Davis'), 
(5, 4, '2018-12-06 12:51:24', 20181261251, 3987075017699453, 7, 18, 557, 'Andrew Martinez'), 
(4, 1, '2017-09-23 07:14:32', 2017923714, 4497706297852239, 2, 12, 756, 'Justin Moore'), 
(5, 3, '2016-02-28 23:16:42', 20162282316, 9406399694013062, 1, 26, 853, 'Joseph Moore'), 
(11, 4, '2016-05-24 14:37:36', 20165241437, 4754563147105980, 8, 8, 742, 'Amanda Brown'), 
(1, 2, '2018-04-08 09:35:58', 201848935, 5031182534686567, 2, 11, 760, 'Andrew Thompson'), 
(11, 1, '2017-10-07 20:45:13', 20171072045, 9736660892936088, 5, 19, 240, 'Megan Robinson'), 
(19, 2, '2017-03-19 23:03:38', 2017319233, 1154891936822433, 2, 14, 554, 'Christopher Davis'), 
(1, 1, '2018-04-26 11:58:53', 20184261158, 5672494499371853, 11, 18, 692, 'James Thomas'), 
(1, 3, '2018-07-20 10:05:17', 2018720105, 9695318985866569, 2, 12, 107, 'Jennifer Martin'), 
(7, 3, '2018-06-21 18:41:12', 20186211841, 2824438494479373, 1, 12, 296, 'Joseph Miller'), 
(6, 1, '2016-04-07 08:47:40', 201647847, 5608599820055114, 7, 2, 163, 'Brittany Brown'), 
(15, 3, '2016-07-22 19:25:23', 20167221925, 3011298350076480, 1, 9, 352, 'Jessica Jackson'), 
(16, 4, '2016-10-14 10:17:30', 201610141017, 5250543218399397, 9, 16, 975, 'David Wilson'), 
(3, 4, '2018-05-15 03:51:28', 2018515351, 8835896606865589, 11, 4, 675, 'Andrew Garcia'), 
(19, 3, '2017-05-25 07:44:57', 2017525744, 9159566098395188, 6, 23, 112, 'Ashley Brown'), 
(11, 2, '2017-12-02 19:07:39', 2017122197, 9920715756046783, 2, 25, 490, 'Joshua Garcia'), 
(7, 4, '2016-05-01 04:50:28', 201651450, 8393790616940265, 9, 22, 490, 'Matthew White'), 
(15, 3, '2018-01-21 19:54:46', 20181211954, 8078408967493993, 6, 18, 316, 'Jessica Thomas'), 
(6, 1, '2018-04-11 11:23:58', 20184111123, 3921559263693643, 11, 17, 221, 'Andrew Jackson'), 
(13, 3, '2018-03-05 10:26:27', 2018351026, 4739593984654108, 10, 18, 925, 'Samantha White'), 
(8, 4, '2018-11-15 14:53:55', 201811151453, 8752393645304583, 4, 14, 554, 'Daniel Jackson'), 
(10, 1, '2017-09-03 12:57:29', 2017931257, 3434269111389638, 6, 18, 360, 'Megan Johnson'), 
(7, 1, '2018-06-28 12:10:58', 20186281210, 6543388006451934, 5, 19, 491, 'Megan Thomas'), 
(15, 3, '2018-07-13 12:21:29', 20187131221, 4717498129166869, 5, 21, 386, 'Megan Davis'), 
(4, 1, '2016-08-01 16:26:39', 2016811626, 1822404586758111, 3, 2, 346, 'Joseph Davis'), 
(3, 2, '2016-10-27 10:53:05', 201610271053, 8446943405552052, 11, 17, 266, 'Daniel Smith'), 
(18, 3, '2018-10-20 15:28:54', 201810201528, 6433477195769821, 8, 26, 723, 'Lauren Smith');

SELECT * FROM sales_order;

INSERT INTO sales_item VALUES   
(48,	411,	2,	0.12,	FALSE,0.0),
(35,	412,	2,	0.07,	FALSE,0.0),
(29,	413,	1,	0.15,	FALSE,0.0),
(15,	414,	2,	0.13,	FALSE,0.0),
(27,	415,	2,	0.07,	FALSE,0.0),
(30,	416,	1,	0.05,	FALSE,0.0),
(45,	417,	1,	0.09,	FALSE,0.0),
(31,	418,	1,	0.18,	FALSE,0.0),
(32,	419,	1,	0.13,	FALSE,0.0),
(47,	420,	1,	0.09,	FALSE,0.0),
(23,	421,	2,	0.16,	FALSE,0.0),
(44,	422,	2,	0.18,	FALSE,0.0),
(35,	423,	2,	0.12,	FALSE,0.0),
(24,	424,	1,	0.08,	FALSE,0.0),
(31,	425,	1,	0.14,	FALSE,0.0),
(21,	426,	2,	0.14,	FALSE,0.0),
(21,	427,	2,	0.06,	FALSE,0.0),
(48,	428,	1,	0.06,	FALSE,0.0),
(37,	429,	1,	0.11,	FALSE,0.0),
(38,	430,	1,	0.13,	FALSE,0.0),
(14,	431,	2,	0.13,	FALSE,0.0),
(26,	432,	2,	0.2	,   FALSE,0.0),
(21,	433,	2,	0.16,	FALSE,0.0),
(8,		434,	2,	0.18,	FALSE,0.0),
(40,	435,	1,	0.19,	FALSE,0.0),
(49,	436,	1,	0.15,	FALSE,0.0),
(41,	437,	2,	0.06,	FALSE,0.0),
(36,	438,	1,	0.1	,   FALSE,0.0),
(14,	439,	2,	0.14,	FALSE,0.0),
(30,	440,	2,	0.19,	FALSE,0.0),
(12,	441,	2,	0.18,	FALSE,0.0),
(5,		442,	1,	0.18,	FALSE,0.0),
(10,	443,	1,	0.09,	FALSE,0.0),
(39,	444,	2,	0.2	,   FALSE,0.0),
(46,	445,	2,	0.13,	FALSE,0.0),
(47,	446,	1,	0.15,	FALSE,0.0),
(25,	447,	2,	0.09,	FALSE,0.0),
(36,	448,	2,	0.12,	FALSE,0.0),
(18,	449,	2,	0.12,	FALSE,0.0),
(35,	450,	1,	0.14,	FALSE,0.0),
(41,	451,	1,	0.14,	FALSE,0.0),
(9,		452,	1,	0.07,	FALSE,0.0),
(42,	453,	1,	0.09,	FALSE,0.0),
(18,	454,	1,	0.1	,   FALSE,0.0),
(25,	455,	1,	0.16,	FALSE,0.0),
(44,	456,	1,	0.13,	FALSE,0.0),
(2,		457,	2,	0.06,	FALSE,0.0),
(18,	458,	2,	0.08,	FALSE,0.0),
(35,	459,	2,	0.16,	FALSE,0.0),
(49,	460,	1,	0.07,	FALSE,0.0),
(7,		461,	2,	0.14,	FALSE,0.0),
(42,	462,	2,	0.15,	FALSE,0.0),
(8,		463,	2,	0.18,	FALSE,0.0),
(27,	464,	2,	0.08,	FALSE,0.0),
(21,	465,	1,	0.1	,   FALSE,0.0),
(42,	466,	2,	0.08,	FALSE,0.0),
(31,	467,	2,	0.18,	FALSE,0.0),
(29,	468,	1,	0.11,	FALSE,0.0),
(48,	469,	2,	0.14,	FALSE,0.0),
(15,	470,	2,	0.15,	FALSE,0.0),
(34,	471,	1,	0.16,	FALSE,0.0),
(22,	472,	1,	0.19,	FALSE,0.0),
(22,	473,	2,	0.11,	FALSE,0.0),
(38,	474,	2,	0.08,	FALSE,0.0),
(21,	475,	2,	0.17,	FALSE,0.0),
(13,	476,	1,	0.09,	FALSE,0.0),
(12,	477,	1,	0.17,	FALSE,0.0),
(41,	478,	2,	0.13,	FALSE,0.0),
(22,	479,	2,	0.09,	FALSE,0.0),
(43,	480,	1,	0.13,	FALSE,0.0),
(33,	481,	1,	0.1	,   FALSE,0.0),
(39,	482,	2,	0.2	,   FALSE,0.0),
(27,	483,	2,	0.17,	FALSE,0.0),
(10,	484,	2,	0.12,	FALSE,0.0),
(41,	485,	2,	0.15,	FALSE,0.0),
(11,	486,	1,	0.05,	FALSE,0.0),
(29,	487,	1,	0.08,	FALSE,0.0),
(25,	488,	1,	0.15,	FALSE,0.0),
(15,	489,	2,	0.09,	FALSE,0.0),
(7,		490,	1,	0.07,	FALSE,0.0),
(26,	491,	2,	0.1	,   FALSE,0.0),
(43,	492,	2,	0.08,	FALSE,0.0),
(47,	493,	1,	0.06,	FALSE,0.0),
(29,	494,	1,	0.12,	FALSE,0.0),
(36,	495,	2,	0.06,	FALSE,0.0),
(41,	496,	1,	0.08,	FALSE,0.0),
(12,	497,	2,	0.15,	FALSE,0.0),
(38,	498,	1,	0.05,	FALSE,0.0),
(22,	499,	2,	0.13,	FALSE,0.0),
(12,	500,	2,	0.11,	FALSE,0.0),
(30,	403,	2,	0.15,	FALSE,0.0),
(38,	404,	1,	0.15,	FALSE,0.0),
(22,	405,	1,	0.09,	FALSE,0.0),
(14,	406,	2,	0.07,	FALSE,0.0),
(1,		407,	1,	0.07,	FALSE,0.0),
(47,	408,	1,	0.1	,   FALSE,0.0),
(7,		409,	2,	0.07,	FALSE,0.0),
(46,	410,	1,	0.18,	FALSE,0.0),
(9,		411,	1,	0.15,	FALSE,0.0),
(35,	412,	1,	0.13,	FALSE,0.0),
(15,	413,	2,	0.07,	FALSE,0.0),
(47,	414,	1,	0.14,	FALSE,0.0),
(10,	415,	1,	0.08,	FALSE,0.0),
(49,	416,	2,	0.06,	FALSE,0.0),
(13,	417,	1,	0.19,	FALSE,0.0),
(6,		418,	1,	0.08,	FALSE,0.0),
(21,	419,	1,	0.12,	FALSE,0.0),
(26,	420,	1,	0.13,	FALSE,0.0),
(38,	421,	1,	0.19,	FALSE,0.0),
(40,	422,	2,	0.16,	FALSE,0.0),
(25,	423,	1,	0.18,	FALSE,0.0),
(11,	424,	1,	0.18,	FALSE,0.0),
(48,	425,	1,	0.12,	FALSE,0.0),
(26,	426,	1,	0.12,	FALSE,0.0),
(1,		427,	1,	0.19,	FALSE,0.0),
(6,		428,	1,	0.12,	FALSE,0.0),
(33,	429,	2,	0.11,	FALSE,0.0),
(15,	430,	1,	0.15,	FALSE,0.0),
(41,	480,	2,	0.14,	FALSE,0.0),
(8,		481,	2,	0.18,	FALSE,0.0),
(36,	482,	2,	0.18,	FALSE,0.0),
(42,	483,	2,	0.18,	FALSE,0.0),
(27,	484,	1,	0.19,	FALSE,0.0),
(20,	485,	1,	0.18,	FALSE,0.0),
(14,	486,	2,	0.16,	FALSE,0.0),
(15,	487,	1,	0.12,	FALSE,0.0),
(25,	488,	1,	0.12,	FALSE,0.0),
(30,	489,	2,	0.11,	FALSE,0.0),
(18,	490,	2,	0.09,	FALSE,0.0),
(17,	491,	2,	0.13,	FALSE,0.0),
(43,	492,	1,	0.08,	FALSE,0.0),
(20,	493,	2,	0.11,	FALSE,0.0),
(1,		494,	2,	0.1	,   FALSE,0.0),
(49,	495,	2,	0.09,	FALSE,0.0),
(1,		496,	2,	0.1	,   FALSE,0.0),
(24,	497,	1,	0.14,	FALSE,0.0),
(19,	498,	1,	0.17,	FALSE,0.0),
(13,	499,	2,	0.1	,   FALSE,0.0),
(17,	500,	1,	0.08,	FALSE,0.0),
(45,	403,	2,	0.13,	FALSE,0.0),
(6,		404,	2,	0.19,	FALSE,0.0),
(25,	405,	1,	0.08,	FALSE,0.0),
(47,	415,	1,	0.16,	FALSE,0.0),
(39,	416,	2,	0.17,	FALSE,0.0),
(47,	417,	1,	0.12,	FALSE,0.0),
(6,		418,	1,	0.17,	FALSE,0.0),
(15,	419,	2,	0.11,	FALSE,0.0),
(49,	420,	1,	0.15,	FALSE,0.0),
(34,	421,	2,	0.09,	FALSE,0.0),
(20,	422,	1,	0.1	,   FALSE,0.0),
(13,	423,	1,	0.12,	FALSE,0.0),
(10,	424,	1,	0.13,	FALSE,0.0),
(24,	425,	2,	0.09,	FALSE,0.0),
(11,	426,	2,	0.14,	FALSE,0.0),
(20,	427,	1,	0.17,	FALSE,0.0),
(42,	428,	1,	0.1	,   FALSE,0.0),
(1,		429,	2,	0.17,	FALSE,0.0),
(35,	430,	1,	0.11,	FALSE,0.0),
(14,	431,	1,	0.18,	FALSE,0.0),
(23,	432,	2,	0.13,	FALSE,0.0),
(4,		433,	2,	0.15,	FALSE,0.0),
(32,	434,	2,	0.11,	FALSE,0.0),
(49,	435,	2,	0.17,	FALSE,0.0),
(37,	436,	2,	0.11,	FALSE,0.0),
(43,	437,	1,	0.16,	FALSE,0.0),
(26,	438,	1,	0.15,	FALSE,0.0),
(16,	415,	1,	0.16,	FALSE,0.0),
(6,		416,	2,	0.07,	FALSE,0.0),
(6,		417,	2,	0.2	,   FALSE,0.0),
(27,	418,	1,	0.19,	FALSE,0.0),
(37,	419,	1,	0.13,	FALSE,0.0),
(44,	420,	1,	0.18,	FALSE,0.0),
(49,	421,	1,	0.11,	FALSE,0.0),
(30,	422,	2,	0.09,	FALSE,0.0),
(33,	423,	2,	0.09,	FALSE,0.0),
(24,	424,	2,	0.05,	FALSE,0.0),
(42,	425,	2,	0.14,	FALSE,0.0),
(43,	426,	1,	0.16,	FALSE,0.0),
(39,	427,	2,	0.12,	FALSE,0.0),
(1,		428,	1,	0.19,	FALSE,0.0),
(42,	429,	1,	0.1	,   FALSE,0.0),
(2,		430,	2,	0.11,	FALSE,0.0),
(24,	431,	2,	0.07,	FALSE,0.0),
(42,	432,	1,	0.17,	FALSE,0.0),
(45,	433,	1,	0.18,	FALSE,0.0),
(10,	434,	2,	0.05,	FALSE,0.0),
(15,	435,	2,	0.15,	FALSE,0.0),
(24,	436,	2,	0.09,	FALSE,0.0),
(30,	437,	1,	0.15,	FALSE,0.0),
(22,	438,	1,	0.19,	FALSE,0.0);
SELECT * FROM sales_order;

SELECT * FROM sales_item;


SELECT * FROM sales_item WHERE discount > .15;

SELECT  time_order_taken FROM sales_order 
WHERE time_order_taken >= '2018-12-01' AND time_order_taken <= '2018-12-31';

SELECT time_order_taken
FROM sales_order
WHERE time_order_taken BETWEEN '2018-12-01' AND '2018-12-31';


SELECT * FROM sales_item WHERE discount > .15 ORDER BY discount DESC;

SELECT * FROM sales_item WHERE discount > .15 ORDER BY discount DESC LIMIT 5;

SELECT CONCAT(first_name , '' , last_name) AS Name , phone , state FROM customer WHERE state = 'TX';

SELECT product_id, SUM(price) AS Total FROM item WHERE product_id=1 GROUP BY product_id;

SELECT DISTINCT product_id FROM item;

SELECT product_id , SUM(price) AS Total From item WHERE product_id = 10 GROUP BY product_id;

-- SELECT product_id , SUM(price) AS Total From item WHERE product_id = 10; -- GROUP BY product_id;


SELECT * FROM item;

SELECT DISTINCT State FROM customer ;

SELECT DISTINCT state FROM customer  ORDER BY state

SELECT DISTINCT state FROM customer WHERE state != 'CA' ;

SELECT DISTINCT state FROM customer WHERE state IN ('CA', 'NJ') ORDER BY state;

SELECT * FROM item;

SELECT * FROM sales_item;

SELECT price , item_id FROM  item INNER JOIN sales_item
ON item.id = sales_item.item_id
ORDER BY item_id;

SELECT SUM(price) , item_id FROM  item INNER JOIN sales_item
ON item.id = sales_item.item_id
GROUP BY item_id 
ORDER BY item_id;

SELECT item_id , price FROM item inner join sales_item
ON item.id = sales_item.item_id
AND price > 120.00 ORDER BY item_id ;


SELECT item_id , price FROM item inner join sales_item
ON item.id = sales_item.item_id
AND price > 120.00 ORDER BY price DESC ;


SELECT * FROM sales_order; -- (1st Table Table)sales_order.id
SELECT * FROM sales_item; --(2nd Table sales item) sales_item.sales_order_id AND sales_item.item_id
SELECT * FROM item; --(3rd Table item) item.id

/* JOINING OF 3 Table */

SELECT sales_order.id , sales_item.quantity , item.price , 
(sales_item.quantity * item.price) AS Total FROM sales_order
JOIN sales_item ON sales_order.id = sales_item.sales_order_id
JOIN item ON sales_item.item_id = item.id 
ORDER BY sales_order.id;

-- Joining Two Table with where condition --

SELECT item_id , price FROM sales_item , item
WHERE sales_item.item_id = item.id
AND price > 120  ORDER BY item_id ;

SELECT item_id , SUM(price) FROM sales_item , item
WHERE sales_item.item_id = item.id
AND price > 120 GROUP BY item_id ORDER BY item_id ;

-----------------------------FULL OUTER JOIN --------------------------------
SELECT * FROM sales_item; --(2nd Table sales item) sales_item.sales_order_id AND sales_item.item_id
SELECT * FROM item; --(3rd Table item) item.id

SELECT * FROM sales_item FULL OUTER JOIN item
ON sales_item.item_id  = item.id ; 

-----------------------------LEFT OUTER JOIN ----------------------------------

SELECT * FROM sales_item LEFT OUTER JOIN item
ON sales_item.item_id  = item.id ; 


-----------------------------RIGHT OUTER JOIN----------------------------------

SELECT * FROM sales_item RIGHT OUTER JOIN item
ON sales_item.item_id  = item.id ; 


SELECT * FROM product;

SELECT name, supplier, price
FROM product LEFT JOIN item
ON  product.id = item.product_id
ORDER BY name;


SELECT  sales_order_id , quantity , product_id
FROM item CROSS JOIN sales_item ORDER BY sales_order_id;

SELECT first_name , last_name , street , city , zip , birth_date FROM customer
WHERE EXTRACT(MONTH FROM birth_date) = 12
UNION
SELECT first_name , last_name , street , city , zip , birth_date FROM customer
WHERE EXTRACT(MONTH FROM birth_date) = 12
ORDER BY birth_date;

SELECT product_id, price
FROM item
WHERE price IS NULL;

SELECT product_id, price
FROM item
WHERE price IS NOT NULL;

SELECT first_name, last_name
FROM customer
WHERE first_name SIMILAR TO 'M%';

SELECT first_name, last_name
FROM customer
WHERE first_name LIKE '%isto%';

SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'A_____';


SELECT first_name, last_name
FROM customer
WHERE first_name SIMILAR TO 'D%' OR last_name SIMILAR TO '%n';


SELECT first_name, last_name
FROM customer
WHERE first_name ~ '^Ma';


SELECT first_name, last_name
FROM customer
WHERE last_name ~ 'ez$';


SELECT first_name, last_name
FROM customer
WHERE last_name ILIKE '%ez';


SELECT first_name, last_name
FROM customer
WHERE last_name ILIKE 'Ma%';

--Match last names that end with ez or son
SELECT first_name, last_name
FROM customer
WHERE last_name ~ 'ez|son';


SELECT first_name, last_name
FROM customer
WHERE last_name iLIKE '%ez' OR '%son';

SELECT first_name, last_name
FROM customer
WHERE last_name ILIKE '%ez' OR last_name ILIKE '%son';


SELECT first_name, last_name
FROM customer
WHERE last_name ~ '[k-w]';


SELECT EXTRACT(MONTH FROM birth_date) AS Month, COUNT(*) AS Amount
FROM customer
GROUP BY Month
ORDER BY Month;


SELECT * FROM customer;


SELECT EXTRACT(MONTH FROM birth_date) AS Month, COUNT(*)
FROM customer
GROUP BY Month
HAVING COUNT(*) > 1
ORDER BY Month;


SELECT SUM(price)
FROM item;

SELECT COUNT(*) AS Items, 
SUM(price) AS Value, 
ROUND(AVG(price), 2) AS Avg,
MIN(price) AS Min,
MAX(price) AS Max
FROM item;

SELECT * FROM item;

SELECT COUNT(*) FROM item;


CREATE VIEW purchase_order_overview AS
SELECT 
    sales_order.purchase_order_number, 
    customer.company, 
    sales_item.quantity, 
    product.supplier, 
    product.name, 
    item.price, 
    (sales_item.quantity * item.price) AS Total,
    CONCAT(sales_person.first_name, ' ', sales_person.last_name) AS Salesperson
FROM sales_order
JOIN sales_item ON sales_item.sales_order_id = sales_order.id
JOIN item ON item.id = sales_item.item_id
JOIN customer ON sales_order.cust_id = customer.id
JOIN product ON product.id = item.product_id
JOIN sales_person ON sales_person.id = sales_order.sales_person_id
ORDER BY purchase_order_number;

SELECT * FROM purchase_order_overview;


SELECT *, (quantity * price) AS Total
FROM purchase_order_overview;


SELECT company, SUM(quantity * price) AS Total 
FROM purchase_order_overview GROUP BY company  ORDER BY total DESC;


CREATE VIEW purchase_order_overview2 AS
SELECT sales_order.purchase_order_number, customer.company, 
sales_item.quantity, product.supplier, product.name, item.price, 
--Can’t use total if you want this to be updated Fix Below
(sales_item.quantity * item.price) AS Total,
--Remove concat if you want this to be updatable 
CONCAT(sales_person.first_name, ' ', sales_person.last_name) AS Salesperson
FROM sales_order     -- Join some tables
JOIN sales_item
ON sales_item.sales_order_id = sales_order.id    -- Tables go together by joining on sales order id
-- Any time you join tables you need to find foreign and primary keys that match up
JOIN item
ON item.id = sales_item.item_id    -- Join item as well using matching item id
JOIN customer
ON sales_order.cust_id = customer.id    -- Join customer using customer ids
JOIN product
ON product.id = item.product_id
JOIN sales_person
ON sales_person.id = sales_order.sales_person_id
ORDER BY purchase_order_number;


SELECT * FROM purchase_order_overview2;

DROP VIEW purchase_order_overview;
DROP VIEW purchase_order_overview2;







CREATE OR REPLACE FUNCTION fn_add_ints(a INT, b INT)
RETURNS INT AS
$$
    SELECT a + b;
$$
LANGUAGE SQL;

SELECT fn_add_ints(5,7);



CREATE OR REPLACE FUNCTION is_even(n INT)
RETURNS TEXT AS
$$
BEGIN
    IF n % 2 = 0 THEN
        RETURN 'Even';
    ELSE
        RETURN 'Odd';
    END IF;
END;
$$
LANGUAGE plpgsql;

SELECT is_even(5);

/*
CREATE OR REPLACE FUNCTION fn_max_product_price()
RETURNS numeric AS
$$
	SELECT MAX(price)
	FROM item
$$
LANGUAGE plpgsql;

SELECT fn_max_product_price();*/

CREATE OR REPLACE FUNCTION fn_max_product_price()
RETURNS numeric AS
$$
	BEGIN
		RETURN(
				SELECT MAX(price)
				FROM item
			  );
	END;
$$
LANGUAGE plpgsql;


SELECT fn_max_product_price();

CREATE OR REPLACE FUNCTION fn_number_customers() 
RETURNS numeric AS
$$
    SELECT COUNT(*) FROM customer;
$$  
LANGUAGE SQL;

SELECT fn_number_customers();

CREATE OR REPLACE FUNCTION fn_number_customers_no_phone() 
RETURNS numeric as
$$
	SELECT count(*)
	FROM customer
	WHERE phone is NULL;	
$$
LANGUAGE SQL

SELECT fn_number_customers_no_phone();


CREATE OR REPLACE FUNCTION fn_get_number_customers_from_state(state_name char(2)) 
RETURNS numeric as
$$
	SELECT count(*)
	FROM customer
	WHERE state = state_name;	
$$
LANGUAGE SQL

SELECT fn_get_number_customers_from_state('TX');


SELECT COUNT(*) FROM sales_order 
NATURAL JOIN
customer
WHERE customer.first_name = 'christopher'
AND customer.last_name = 'Jones';


CREATE OR REPLACE Function fn_get_number_orders_from_customer
(cus_fname VARCHAR , cus_lname VARCHAR)
RETURNS numeric AS
$body$
	DECLARE
		order_count INTEGER;
	BEGIN
	SELECT COUNT(*) INTO order_count FROM sales_order 
	NATURAL JOIN
	customer
	WHERE customer.first_name = 'Michael'
	AND customer.last_name = 'Jackson';

	RETURN order_count ;
	END ;
$body$
LANGUAGE plpgsql;


SELECT fn_get_number_orders_from_customer('Michael', 'Jackson');

SELECT * FROM customer;

SELECT * FROM sales_order;

SELECT DISTINCT(id) FROM customer;



SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS name,
    c.id AS customer_id,
    s.id AS order_id,
    s.cust_id,
    s.time_order_taken
FROM customer c
INNER JOIN sales_order s ON c.id = s.cust_id;






CREATE OR REPLACE FUNCTION fn_get_number_orders_from_customer
(cus_fname VARCHAR, cus_lname VARCHAR)
RETURNS numeric AS
$body$
DECLARE
    order_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO order_count
    FROM sales_order
    NATURAL JOIN customer
    WHERE customer.first_name = cus_fname
      AND customer.last_name = cus_lname;

    RETURN order_count;
END;
$body$
LANGUAGE plpgsql;

SELECT fn_get_number_orders_from_customer('Michael', 'Jackson');


CREATE OR REPLACE FUNCTION fn_get_last_order() 
RETURNS sales_order as
$body$
	SELECT *
	FROM sales_order
	ORDER BY time_order_taken DESC
	LIMIT 1;
$body$
LANGUAGE SQL

SELECT fn_get_last_order();


CREATE OR REPLACE FUNCTION fn_get_number_orders_from_customer(cus_fname varchar, cus_lname varchar) 
RETURNS numeric as
$body$
	SELECT COUNT(*)
	FROM sales_order
	NATURAL JOIN customer
	WHERE customer.first_name = cus_fname AND customer.last_name = cus_lname;	
$body$
LANGUAGE SQL

SELECT fn_get_number_orders_from_customer('Christopher', 'Jones');



--Get in table format
SELECT (fn_get_last_order()).*;

--Get just the date
SELECT (fn_get_last_order()).*;

SELECT *
FROM sales_person
WHERE state = 'CA';



CREATE OR REPLACE FUNCTION fn_get_employees_location(loc varchar) 
RETURNS SETOF sales_person as
$body$
	SELECT *
	FROM sales_person
	WHERE state = loc;
$body$
LANGUAGE SQL

SELECT (fn_get_employees_location('CA')).*;

SELECT first_name , last_name ,  phone from   fn_get_employees_location('CA');

/*PL/pgSQL

PL/pgSQL is influenced by Oracle SQL. It allows for loops, conditionals, functions, data types and much more. 
CREATE OR REPLACE FUNCTION func_name(parameter par_type) RETURNS ret_type AS
$body$
BEGIN
--statements
END
$body$
LANGUAGE plpqsql*/



SELECT item.price FROM item
NATURAL JOIN 
product WHERE product.name = 'Grandview';

CREATE OR REPLACE FUNCTION fn_get_price_product_name(prod_name varchar)
RETURNS numeric AS
$body$
	BEGIN
		
		SELECT item.price FROM item
		NATURAL JOIN 
		product WHERE product.name = 'Grandview';

	END;
$body$

LANGUAGE plpgsql;

SELECT fn_get_price_product_name('Grandview');



CREATE OR REPLACE FUNCTION fn_get_price_product_name(prod_name varchar)
RETURNS numeric AS
$body$
	DECLARE v_price integer;
	BEGIN
	
	SELECT i.price INTO v_price
	FROM item AS i
	NATURAL JOIN 
	product AS p
	WHERE p.name = prod_name;
	
	RETURN v_price;
	END;
$body$
	LANGUAGE plpgsql;
	
SELECT  fn_get_price_product_name ('Grandview');



CREATE OR REPLACE FUNCTION fn_get_sum(val1 INT, val2 INT)
RETURNS INT AS
$body$
DECLARE
    ans INT;
BEGIN
    ans := val1 + val2;
    RETURN ans;
END;
$body$
LANGUAGE plpgsql;


SELECT fn_get_sum(7 , 5);


CREATE OR REPLACE FUNCTION fn_get_random_number(min_val int , max_val int)
RETURNS int AS
$body$
	DECLARE
		rand int;
		BEGIN
			SELECT random() * (max_val - min_val) + min_val INTO rand;
			RETURN rand;
		END;
$body$
	LANGUAGE plpgsql;


SELECT fn_get_random_number(1,5);


CREATE OR REPLACE FUNCTION fn_get_random_salesperson() 
RETURNS varchar AS
$body$
	--Put variables here
	DECLARE
		rand int;
		--Use record to store row data
		emp record;
	BEGIN
		--Generate random number
		SELECT random()*(5 - 1) + 1 INTO rand;
		
		--Get row data for a random sales person and store in emp
		SELECT *
		FROM sales_person
		INTO emp
		WHERE id = rand;
		
		--Concat the first and last name and return it
		RETURN CONCAT(emp.first_name, ' ', emp.last_name);
		
	END;
$body$
LANGUAGE plpgsql;

SELECT fn_get_random_salesperson();


CREATE OR REPLACE FUNCTION fn_get_sum_2(IN v1 int, IN v2 int, OUT ans int) AS
$body$
	BEGIN
		ans := v1 + v2;
	END;
$body$
LANGUAGE plpgsql;

SELECT fn_get_sum_2(4,5);



CREATE OR REPLACE FUNCTION fn_get_cust_birthday
(IN the_month int, OUT bd_month int , OUT bd_day int , OUT f_name VARCHAR , OUT l_name VARCHAR) AS
$body$
	BEGIN
		SELECT EXTRACT(MONTH FROM birth_date),
		EXTRACT(DAY FROM birth_date),
		first_name , bd_day , f_name , l_name
		FROM customer
		WHERE EXTRACT(MONTH FROM birth_date) = the_month
		LIMIT 1;
	END;
$body$
LANGUAGE plpgsql;

--SELECT fn_get_cust_birthday(12);
SELECT * FROM fn_get_cust_birthday(12);


DROP FUNCTION IF EXISTS fn_get_cust_birthday(int);



CREATE OR REPLACE FUNCTION fn_get_cust_birthday(
    IN the_month INT,
    OUT bd_month INT,
    OUT bd_day INT,
    OUT f_name VARCHAR,
    OUT l_name VARCHAR
)
AS
$body$
BEGIN
    SELECT 
        EXTRACT(MONTH FROM birth_date)::INT,
        EXTRACT(DAY FROM birth_date)::INT,
        first_name,
        last_name
    INTO
        bd_month, bd_day, f_name, l_name
    FROM customer
    WHERE EXTRACT(MONTH FROM birth_date) = the_month
    LIMIT 1;
END;
$body$
LANGUAGE plpgsql;

SELECT * FROM fn_get_cust_birthday(12);


CREATE OR REPLACE FUNCTION fn_get_sales_people() 
RETURNS SETOF sales_person AS
$body$
	BEGIN
		RETURN QUERY
		SELECT *
		FROM sales_person;
	END;
$body$
LANGUAGE plpgsql;

SELECT (fn_get_sales_people()).*;



SELECT product.name , product.supplier , item.price FROM item
NATURAL JOIN product
ORDER BY item.price DESC
LIMIT 10;

CREATE OR REPLACE FUNCTION fn_get_10_expensive_prods() 
RETURNS TABLE (
	name varchar,
	supplier varchar,
	price numeric
) AS
$body$
	BEGIN
		RETURN QUERY
		SELECT product.name, product.supplier, item.price
		FROM item
		NATURAL JOIN product
		ORDER BY item.price DESC
		LIMIT 10;
	END;
$body$
LANGUAGE plpgsql;

SELECT (fn_get_10_expensive_prods()).*;



CREATE OR REPLACE FUNCTION fn_check_month_orders(the_month int) 
RETURNS varchar AS
$body$
	--Put variables here
	DECLARE
		total_orders int;
	BEGIN
		--Check total orders
		SELECT COUNT(purchase_order_number)
    	INTO total_orders
		FROM sales_order
		WHERE EXTRACT(MONTH FROM time_order_taken) = the_month;
		
		--Use conditionals to provide different output
		IF total_orders > 5 THEN
			RETURN CONCAT(total_orders, ' Orders : Doing Good');
		ELSEIF total_orders < 5 THEN
			RETURN CONCAT(total_orders, ' Orders : Doing Bad');
		ELSE
			RETURN CONCAT(total_orders, ' Orders : On Target');
		END IF;	
	END;
$body$
LANGUAGE plpgsql;

SELECT fn_check_month_orders(12);


CREATE OR REPLACE FUNCTION fn_check_month_orders(the_month int) 
RETURNS varchar AS
$body$
	--Put variables here
	DECLARE
		total_orders int;
	BEGIN
		--Check total orders
		SELECT COUNT(purchase_order_number)
    	INTO total_orders
		FROM sales_order
		WHERE EXTRACT(MONTH FROM time_order_taken) = the_month;
		
		-- Case executes different code depending on an exact value
    	-- for total_orders or a range of values
		CASE
			WHEN total_orders < 1 THEN
				RETURN CONCAT(total_orders, ' Orders : Terrible');
			WHEN total_orders > 1 AND total_orders < 5 THEN
				RETURN CONCAT(total_orders, ' Orders : Get Better');
			WHEN total_orders = 5 THEN
				RETURN CONCAT(total_orders, ' Orders : On Target');
			ELSE
				RETURN CONCAT(total_orders, ' Orders : Doing Good');
		END CASE;	
	END;
$body$
LANGUAGE plpgsql;

SELECT fn_check_month_orders(11);


CREATE OR REPLACE FUNCTION fn_loop_test(max_num int) 
RETURNS int AS
$body$
	--Put variables here
	DECLARE
		j INT DEFAULT 1;
		tot_sum INT DEFAULT 0;
	BEGIN
		LOOP
			tot_sum := tot_sum + j;
			j := j + 1;
			EXIT WHEN j > max_num;
		END LOOP;
	RETURN tot_sum;
END;
$body$
LANGUAGE plpgsql;

SELECT fn_loop_test(5);


CREATE OR REPLACE FUNCTION fn_for_test(max_num int) 
RETURNS int AS
$body$
	--Put variables here
	DECLARE
		tot_sum INT DEFAULT 0;
	BEGIN
		FOR i IN 1 .. max_num BY 2
		LOOP
			tot_sum := tot_sum + i;
		END LOOP;
	RETURN tot_sum;
END;
$body$
LANGUAGE plpgsql;

SELECT fn_for_test(5);


DO
$$
	DECLARE
		rec record;
	BEGIN
		FOR rec IN
			SELECT first_name, last_name
			FROM sales_person
			LIMIT 5
		LOOP
			--Outputs info to Messages
			RAISE NOTICE '%, %', rec.first_name, rec.last_name;
		END LOOP;
	END;
$$
LANGUAGE plpgsql;



FOREACH var IN ARRAY array_name
-- Print all values in the array
DO
$body$
	DECLARE
		arr1 int[] := array[1,2,3];
		i int;
	
	BEGIN
		FOREACH i IN ARRAY arr1;
		LOOP
			RAISE NOTICE '%', i;
		END LOOP;
	END;
$body$
LANGUAGE plpgsql;


DO
$body$
DECLARE
    arr1 int[] := array[1, 2, 3];
    i int;
BEGIN
    FOREACH i IN ARRAY arr1
    LOOP
        RAISE NOTICE '%', i;
    END LOOP;
END;
$body$
LANGUAGE plpgsql;



-- Sums values as long as a condition is true
DO
$body$
	DECLARE
		j INT DEFAULT 1;
		tot_sum INT DEFAULT 0;
	
	BEGIN
		WHILE j <= 10
		LOOP
			tot_sum := tot_sum + j;
			j := j + 1;
		END LOOP;
		RAISE NOTICE '%', tot_sum;
	END;
$body$
LANGUAGE plpgsql;


DO
$$
	DECLARE
		i int DEFAULT 1;
	BEGIN
		LOOP
			i := i + 1;
		EXIT WHEN i > 10;
		CONTINUE WHEN MOD(i, 2) = 0;
		RAISE NOTICE 'Num : %', i;
		END LOOP;
	END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_get_supplier_value(the_supplier varchar) 
RETURNS varchar AS
$body$
DECLARE
	supplier_name varchar;
	price_sum numeric;
BEGIN
	SELECT product.supplier, SUM(item.price)
 	INTO supplier_name, price_sum
	FROM product, item
	WHERE product.supplier = the_supplier
	GROUP BY product.supplier;
	RETURN CONCAT(supplier_name, ' Inventory Value : $', price_sum);
END;
$body$
LANGUAGE plpgsql

SELECT fn_get_supplier_value('Nike');


SELECT * FROM product;



-- Create a sample table that stores customer ids with balances due
CREATE TABLE past_due(
id SERIAL PRIMARY KEY,
cust_id INTEGER NOT NULL,
balance NUMERIC(6,2) NOT NULL);

SELECT * FROM customer;

INSERT INTO past_due(cust_id, balance)
VALUES
(1, 123.45),
(2, 324.50);

SELECT * FROM past_due;


CREATE OR REPLACE PROCEDURE pr_debt_paid(
	past_due_id int,
	payment numeric
)
AS
$body$
DECLARE

BEGIN
	UPDATE past_due
	SET balance = balance - payment
	WHERE id = past_due_id;
	
	COMMIT;
END;
$body$
LANGUAGE PLPGSQL;


CALL pr_debt_paid(2, 20.00);

SELECT * FROM past_due;



CREATE TABLE distributor(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100));


INSERT INTO distributor (name) VALUES
('Parawholesale'),
('J & B Sales'),
('Steel City Clothing');


SELECT * FROM distributor;

CREATE TABLE distributor_audit(
	id SERIAL PRIMARY KEY,
	dist_id INT NOT NULL,
	name VARCHAR(100) NOT NULL,
	edit_date TIMESTAMP NOT NULL);


-- Create trigger function
CREATE OR REPLACE FUNCTION fn_log_dist_name_change()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
AS
$body$
BEGIN
	-- If name changes log the change
	IF NEW.name <> OLD.name THEN
		INSERT INTO distributor_audit
		(dist_id, name, edit_date)
		VALUES
		(OLD.id, OLD.name, NOW());
	END IF;
	
	-- Trigger information Variables
	RAISE NOTICE 'Trigger Name : %', TG_NAME;
	RAISE NOTICE 'Table Name : %', TG_TABLE_NAME;
	RAISE NOTICE 'Operation : %', TG_OP;
	RAISE NOTICE 'When Executed : %', TG_WHEN;
	RAISE NOTICE 'Row or Statement : %', TG_LEVEL;
	RAISE NOTICE 'Table Schema : %', TG_TABLE_SCHEMA;
	
	-- Return the updated new data
	RETURN NEW;
END;
$body$

-- Bind function to trigger
CREATE TRIGGER tr_dist_name_changed
	-- Call function before name is updated
	BEFORE UPDATE 
	ON distributor
	-- We want to run this on every row where an update occurs
	FOR EACH ROW
	EXECUTE PROCEDURE fn_log_dist_name_change();

-- Update distributor name and log changes
UPDATE distributor
SET name = 'Western Clothing'
WHERE id = 2;

-- Check the log
SELECT * FROM distributor_audit; 



-- Create the log table
CREATE TABLE user_log (
  log_id SERIAL PRIMARY KEY,
  username TEXT,
  action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the main table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT
);

-- Create the trigger function
CREATE OR REPLACE FUNCTION log_user_insert()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO user_log(username)
  VALUES (NEW.name);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger
CREATE TRIGGER user_insert_trigger
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION log_user_insert();

----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION fn_block_weekend_changes()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$body$
BEGIN
	RAISE NOTICE 'No database changes allowed on the weekend';
	RETURN NULL;
END;
$body$

-- Bind function to trigger
CREATE TRIGGER tr_block_weekend_changes
	-- Call function before name is updated
	BEFORE UPDATE OR INSERT OR DELETE OR TRUNCATE 
	ON distributor
	-- We want to run this on statement level
	FOR EACH STATEMENT
	-- Block if on weekend
	WHEN(
		EXTRACT('DOW' FROM CURRENT_TIMESTAMP) BETWEEN 6 AND 7
	)
	EXECUTE PROCEDURE fn_block_weekend_changes();

UPDATE distributor
SET name = 'Western Clothing'
WHERE id = 2;

-- Drop triggers
DROP TRIGGER tr_block_weekend_changes ON distributor;


DECLARE cur_products CURSOR FOR
	SELECT name, supplier FROM product;

DO $$
DECLARE
    my_cursor CURSOR FOR SELECT * FROM users;
    row_data RECORD;
BEGIN
    OPEN my_cursor;
    LOOP
        FETCH my_cursor INTO row_data;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'User: %', row_data;
    END LOOP;
    CLOSE my_cursor;
END $$;


BEGIN;

DECLARE cur_products CURSOR FOR
    SELECT name, supplier FROM product;

-- Fetch one row from the cursor
FETCH NEXT FROM cur_products;

-- Optional: fetch more rows
-- FETCH ALL FROM cur_products;

-- When done, close the cursor
CLOSE cur_products;

COMMIT;

----- CURSORS -----
Cursors are used to step backwards or forwards through rows of data. They can be pointed at a row and then select, update or delete. Cursor gets data, pushes it to another language for processing operations that add, edit, or delete. 
Cursors are first declared defining the selection options to be used. It is then opened so it retrieves the data. Then individual rows can be fetched. After use the cursor is closed freeing memory. When needed the cursor can be used as needed.
-- Declare cursor
DECLARE cursor_name refcursor;

-- Cursor that references all the product data
DECLARE cur_products refcursor;

-- Declare cursor tied to a query / SELECT
-- SCROLL / NO SCROLL : Whether it can scroll backward or not
-- The query is a SELECT statement
cursor_name [scrollability] CURSOR (parameter datatype, ...) FOR the_query

-- It is best to get as small a data set as possible
DECLARE cur_products CURSOR FOR
	SELECT name, supplier FROM product;
	
-- Create cursor that takes parameters
DECLARE cur_products CURSOR (company)
FOR
	SELECT name, supplier
	FROM product
	WHERE supplier = company;

Opening Cursors
-- Bound & Unbound Cursors
-- Create an unbound cursor that can be bound to any query
OPEN ub_cursor_var [NO SCROLL | SCROLL] FOR query;

select * from customer;

DECLARE cur_customers refcursor;

OPEN cur_customers
FOR 
	SELECT first_name, last_name, phone, state
	FROM customer
	WHERE state = 'CA';

-- Create an unbound cursor and attach a query
OPEN ub_cursor_var [NO SCROLL | SCROLL] 
FOR EXECUTE
query;

-- Bound Cursor
-- Since it is bound to a query we only pass arguments when we open it if required
OPEN bound_cur_name (para:=val,...); 

OPEN cur_customers;

Example with Cursors
DO
$body$
	DECLARE
		msg text DEFAULT '';
		rec_customer record;
		
		-- Declare cursor with customer data
		cur_customers CURSOR
		FOR
			SELECT * FROM customer;
	BEGIN
		-- Open cursor
		OPEN cur_customers;
		
		LOOP
			-- Fetch records from cursor
			FETCH cur_customers INTO rec_customer;
			
			-- Loop until nothing more is found
			EXIT WHEN NOT FOUND;
			
			-- Concatenates all customer names together
			msg := msg || rec_customer.first_name || ' ' || rec_customer.last_name || ', ';
		END LOOP;
	
	RAISE NOTICE 'Customers : %', msg;
	END;
$body$

Using Cursors with Functions
-- Cursurs & Functions
-- Function returns a list of all customers in provided state
CREATE OR REPLACE FUNCTION fn_get_cust_by_state(c_state varchar)
RETURNS text
LANGUAGE PLPGSQL
AS
$body$
DECLARE
	cust_names text DEFAULT '';
	rec_customer record;
	
	cur_cust_by_state CURSOR (c_state varchar)
	FOR
		SELECT
			first_name, last_name, state
		FROM customer
		WHERE state = c_state;
BEGIN
	-- Open cursor and pass the parameter
	OPEN cur_cust_by_state(c_state);
	
	LOOP
		-- Move row of data to rec_customer
		FETCH cur_cust_by_state INTO rec_customer;
		
		-- Loop until nothing more is found
		EXIT WHEN NOT FOUND;
		
		-- Concat customer name for each row
		cust_names := cust_names || rec_customer.first_name || ' ' || rec_customer.last_name || ', ';
		
	END LOOP;
	
	-- Close cursor
	CLOSE cur_cust_by_state;

	RETURN cust_names;
END;
$body$
 
SELECT fn_get_cust_by_state('CA');

INSTALLATION

































































































