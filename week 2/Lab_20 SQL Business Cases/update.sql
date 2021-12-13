insert into car values ('3K096I9858','Volkswagen','Tiguan',2019,'Blue');
insert into car values ('ZM8G7BEUQZ','Peugeot','Rifter',2019,'Red'),('RKXVNNIHLV',
'Ford','Fusion',2018,'White');
insert into car values ('HKNDGS7CU3','Toyota','RAV4',2018,'Silver'),('DAM41UDN3C','Volvo',
'V60',2019,'Gray'),('DAM41UDN3C','Volvo','V60 Cross Country',2019,'Gray');
insert into customer values ('10001','Pablo Picasso',4636176382,' ',
'Paseo de la Chopera, 14','Madrid','Spain',28045),('20001','Abraham Lincoln',13059077086,' ',
'120 SW 8th St','Miami','United States',33130),('30001','Napoléon Bonaparte',33179754000,' ',
'40 Rue du Colisée','Paris','France',75008);
insert into salespers values ('00001','Petey Cruiser','Madrid'),('00002','Anna Sthesia',
'Barcelona'),('00003','Paul Molive','Berlin'),('00004','Gail Forcewind','Paris'),
('00005','Paige Turner','Mimia'),('00006','Bob Frapples','Mexico City'),('00007',
'Walter Melon','Amsterdam'),('00008','Shonda Leer','São Paulo');
Alter table invoice add carnum int, add cust_ID char(10), add staff_ID char(10);
insert into invoice values ('852399038',22-08-2018,'3K096I9858','10001','00001'),
('731166526',31-12-2018,'DAM41UDN3C','20001','00005'),
('271135104',22-01-2019,'ZM8G7BEUQZ','20001','00007');
alter table invoice add CarNum char(10), drop carnum;
insert into invoice values ('852399038',22-08-2018,'10001','00001','3K096I9858'),
('731166526',31-12-2018,'20001','00005','DAM41UDN3C'),
('271135104',22-01-2019,'20001','00007','ZM8G7BEUQZ');
update salespers set store = 'Miami' where store = 'Mimia';
update customer set email = "ppicasso@gmail.com" 
where name = 'Pablo Picasso';
update customer set email = "lincoln@us.gov" 
where name = 'Abraham Lincoln';
update customer set email = "hello@napoleon.me" 
where name = 'Napoléon Bonaparte';