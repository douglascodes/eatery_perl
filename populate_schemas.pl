#! /usr/bin/perl
use strict;
use warnings;
use DBI();
use Try::Tiny;


our $dsn = "DBI:mysql:database=" . $ENV{'EATERY_DB'} . ";host=localhost",
my $dbh = DBI->connect($dsn,
    $ENV{'EATERY_USER'},
    $ENV{'EATERY_PASS'},
    {   'RaiseError' => 1,
        'PrintError' => 0,
        'AutoCommit' => 1,
        'PrintWarn'  => 1
    }
);

# Initialize Customer Table
$dbh->do(
    "Create TABLE if not exists Customers (
	id INT PRIMARY KEY auto_increment,
	firstname VARCHAR(20) NOT NULL,
	lastname VARCHAR(20),
	phone CHAR(10) NOT NULL,
	email VARCHAR(50) NOT NULL,
	member_since TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT uc_CustomerIS UNIQUE (LastName, email, phone )
	) ENGINE=InnoDB"
);

# Initialize order table
$dbh->do(
    "Create TABLE if not exists Orders (
	id INT PRIMARY KEY auto_increment,
	order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	cust_id INT,
	FOREIGN KEY (cust_id) REFERENCES Customers(id) 
	) ENGINE=InnoDB"
);

# Initialize Items table
# BIT field for Prep stations equals
# 1st - Salad/Cold
# 2nd - Grill/Hot
# 3rd - Vegetable/Fry
# 4th - Bar/Beverage
# Cold/Hot/Bar prep would be 1011 = 11
# Bar only would be 1000 = 8

$dbh->do(
    "Create TABLE if not exists Items (
	sku INT PRIMARY KEY auto_increment,
	item_name VARCHAR(20) NOT NULL,
	price DECIMAL(4,2) DEFAULT NULL,
	gluten_free BOOLEAN DEFAULT FALSE,
	needs_temp BOOLEAN DEFAULT FALSE,
	prep_locations Bit(4) DEFAULT NULL,
	protein CHAR(4) DEFAULT NULL,
	update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT uc_ItemIS UNIQUE ( item_name, price )
	) ENGINE=InnoDB"
);

# Initialize order lines tables
$dbh->do(
    "Create TABLE if not exists OrderLines (
	id INT PRIMARY KEY auto_increment,
	order_id INT,
	item_id INT,
	qty INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES Orders(id),	
	FOREIGN KEY (item_id) REFERENCES Items(sku),
	CONSTRAINT uc_OrderLineIS UNIQUE (order_id, item_id )
	) ENGINE=InnoDB"
);

#Populate the Customer table
$dbh->do(
    "INSERT INTO Customers(firstname, lastname, phone, email)
	VALUES('Douglas', 'King', '2153339626', 'douglas\@eatery.com'),
	('Glenn', 'St. Coeur', '6102587412', 'glenn\@hotmail.com'),
	('Steve', 'Reemy', '6099874563', 'steveo\@hotmail.com'),
	('Justine', 'Jenkins', '8569784563', 'justine\@sessions.com'),
	('Laura', 'Rendere', '2154789636', 'ginny\@gmail.com'),
	('Henry', 'Michaels', '6098745631', 'h3nry\@hotmail.com'),
	('Jennifer', 'Michaels', '6102587111', 'jm1nty\@hotmail.com'),
	('Unger', 'Felicias', '2152225555', 'felix\@gmail.com'),
	('Arthur', 'Weintraub', '6098884444', 'awein\@msn.com'),
	('Ingrid', 'Bergman', '7721987777', 'ingrid\@hotmail.net'),
	('Kyle', 'Fennie', '6102587412', 'glenn\@hotmail.co.uk'),
	('Leila', 'Marcus', '6607213232', 'l-marc\@msn.com')
	"
);

# Try to update an individual row
$dbh->do("UPDATE Customers
	SET phone='2151987777'
	WHERE email='ingrid\@hotmail.net'
	");

#Populate the Items tables
$dbh->do(
    "INSERT INTO Items(item_name, price, gluten_free, needs_temp, prep_locations, protein)
	VALUES('Filet', 49, 1, 1, b'0010', 'BEEF'),
	('NY Strip', 52, 1, 1, b'0010', 'BEEF'),
	('Rack', 39, 1, 1, b'0010', 'LAMB'),
	('Roast Chicken', 26, 1, NULL, b'0010', 'CHIX'),
	('Veal Chop', 39, 1, 1, b'0010', 'VEAL'),
	('Chopped Steak', 26, 1, 1, b'0010', 'BEEF'),
	('Pork Chop', 28, 1, 1, b'0010', 'PORK'),
	('Tuna', 38, 1, 1, b'0010', 'FISH'),
	('Lobster', 65, 1, NULL, b'0110', 'FISH'),
	('Sea Bass', 38, 1, NULL, b'0010', 'FISH'),
	('Fried Shrimp', 32, NULL, NULL, b'0110', 'FISH'),
	('Salmon', 29, 1, NULL, b'0010', 'FISH'),
	('Crab Cakes', 37, NULL, NULL, b'0010', 'FISH'),
	('Vegetable Platter', 26, 1, NULL, b'0100', 'VEGE'),
	('Grey Goose Martini', 12.75, 1, NULL, b'1000', 'BEVE'),
	('Tanqueray Martini', 12.75, 1, NULL, b'1000', 'BEVE'),
	('Manhattan', 11, 1, NULL, b'1000', 'BEVE'),
	('Pina Colada', 12.75, 1, NULL, b'1000', 'BEVE'),
	('Jack Daniels', 9, 1, NULL, b'1000', 'BEVE'),
	('Cosmopolitan', 11.75, 1, NULL, b'1000', 'BEVE'),
	('Banana Dacqueri', 10.50, 1, NULL, b'1000', 'BEVE'),
	('Asparagus', 6, 1, NULL, b'0100', 'VEGE'),
	('Creamed Spinach', 6, NULL, NULL, b'0100', 'VEGE'),
	('Mashed Potato', 6, 1, NULL, b'0100', 'POTA'),
	('Steak Fries', 6, 1, NULL, b'0100', 'POTA'),
	('Baked Potato', 5, 1, NULL, b'0100', 'POTA'),
	('String Beans', 6, 1, NULL, b'0100', 'VEGE'),
	('Mushrooms', 7, 1, NULL, b'0100', 'VEGE'),
	('Artichokes', 9, 1, NULL, b'0100', 'VEGE'),
	('Brussels Sprouts', 8, 1, NULL, b'0100', 'VEGE'),
	('Lobster Bisque', 10, NULL, NULL, b'0100', 'FISH'),
	('Tomato Soup', 10, NULL, NULL, b'0100', 'VEGE'),
	('French Onion Soup', 10, NULL, NULL, b'0100', 'BEEF'),
	('Chicken Piccata', 26, 1, NULL, b'0110', 'CHIX'),
	('Prime Rib - Small', 36, 1, 1, b'0010', 'BEEF'),
	('Prime Rib - Large', 55, 1, 1, b'0010', 'BEEF'),
	('Burger', 24, NULL, 1, b'0110', 'BEEF'),
	('Shrimp Cocktail', 18, 1, NULL, b'0001', 'FISH'),
	('Escargot', 16, NULL, NULL, b'0010', 'FISH'),
	('Tuna Tartare', 18.50, 1, NULL, b'0001', 'FISH'),
	('Clams Casino', 16, NULL, NULL, b'0011', 'FISH'),
	('Crab Cake', 18, NULL, NULL, b'0010', 'FISH'),
	('Oysters Rockefeller', 15, NULL, NULL, b'0011', 'FISH'),
	('Oysters RAW', 15, 1, NULL, b'0001', 'FISH'),
	('Clams RAW', 14, 1, NULL, b'0001', 'FISH'),
	('Potato Skins', 10, 1, NULL, b'0100', 'VEGE'),
	('Steak Salad', 23, 1, 1, b'0011', 'VEGE'),
	('Salmon Salad', 21, 1, 1, b'0011', 'VEGE'),
	('House Salad', 13, NULL, NULL, b'0001', 'VEGE'),
	('Caeser Salad', 13, NULL, NULL, b'0001', 'VEGE'),
	('Buzz Salad', 13, 1, NULL, b'0001', 'VEGE'),
	('Wedge Salad', 13, 1, NULL, b'0001', 'VEGE')
	"
);

# Verify UNIQUE constraint on customer table with error checking.
try {
    $dbh->do(
        "INSERT INTO Customers(firstname, lastname, phone, email)
		VALUES ('Steve', 'Reemy', '6099874563', 'steveo\@hotmail.com')"
    );
}
catch {
    warn "Uniqueness enforced on Customers";
};

try {
    $dbh->do(
        "INSERT INTO Items(item_name, price)
		('Chopped Steak', 26)
    ");
}
catch {
    warn "Uniqueness enforced on Items";
};


#populate Orders table
	$dbh->do(
    'INSERT INTO Orders(cust_id, order_date)
		VALUES (1, "2013-08-26 16:49:16"),
		(2, "2013-08-25 16:49:16"),
		(3, "2013-08-24 16:49:16"),
		(4, "2013-08-23 16:49:16"),
		(5, "2013-08-22 16:49:16")'
		);

#populate Orderlines
    $dbh->do(
        "INSERT INTO OrderLines(order_id, item_id, qty)
		VALUES (1, 2, 6),
	 	(5, 2, 6),
	 	(5, 6, 1),
	 	(5, 23, 4),
	 	(5, 9, 2),
	 	(2, 4, 2),
	 	(2, 33, 3),
	 	(2, 10, 2),
	 	(2, 1, 1),
	 	(2, 2, 2),
	 	(2, 6, 1),
	 	(3, 3, 2),
	 	(3, 2, 2),
	 	(3, 1, 2),
	 	(3, 4, 4)"
		);

