LOAD DATA INFILE '/tmp/RESummary/addrpf.txt' INTO TABLE knightwa_ircpa.Situs
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE '/tmp/RESummary/areapf.txt' INTO TABLE knightwa_ircpa.Area
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE '/tmp/RESummary/NBHD.txt' INTO TABLE knightwa_ircpa.NBHD
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
(NBHD_Code,Description);

LOAD DATA INFILE '/tmp/RESummary/lkup.txt' INTO TABLE knightwa_ircpa.Look_Up_Codes
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
(Lkup_Type,Applied_to,Lkup_Code,Description);

LOAD DATA INFILE '/tmp/RESummary/Land.txt' INTO TABLE knightwa_ircpa.Land
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE '/tmp/RESummary/Miscf.txt' INTO TABLE knightwa_ircpa.Misc
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE '/tmp/RESummary/Owner.txt' INTO TABLE knightwa_ircpa.Owners
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE '/tmp/RESummary/permpf.txt' INTO TABLE knightwa_ircpa.Permits
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE '/tmp/RESummary/prop1pf.txt' INTO TABLE knightwa_ircpa.Prop
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE '/tmp/RESummary/salepf.txt' INTO TABLE knightwa_ircpa.Prop_Sales
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' ;

LOAD DATA INFILE '/tmp/RESummary/subdivisions.txt' INTO TABLE knightwa_ircpa.SubDivision
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' ;