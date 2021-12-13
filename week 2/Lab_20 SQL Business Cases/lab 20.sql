CREATE DATABASE lab_mysql;
USE lab_mysql;
create table CAR (VIN char(10), manufacturer varchar(100), 
model varchar(100), carYear int, color text);
create table Customer (cust_ID char(10), name varchar(100), 
phone_num int, email varchar(100), address varchar(100), city varchar(100), 
country varchar(100), zip_code int);
create table salespers (staff_ID char(10), name varchar(100), 
store varchar(100));
create table invoice (invoice_num char(10), invDate date);

