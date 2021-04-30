SQL Queries used in our application:

Database:

create database winners_game; 

Tables:

1. create table userdata (user_name varchar(255), Email varchar(255) primary key, Mobile_Number varchar(15), password varchar(255), user_type varchar(255), profile_updated varchar(255));

2. create table clubdata( name varchar(255), email varchar(255) primary key, contact_number varchar(10), availableSports varchar(255), address varchar(255), addressExtended varchar(255), city varchar(255), zipCode varchar(255), imageLocation varchar(255), docsLocation varchar(255));

ALTER TABLE clubdata ADD profileApproved varchar(255);

3. create table playerdata ( username varchar(255), email varchar(255) primary key, mobile_number varchar(15), sportsData varchar(255), roledata varchar(255), addressdata varchar(255), address2data varchar(255), citydata varchar(255), zipdata varchar(255), image_location varchar(255),docs_location varchar(255));

ALTER TABLE playerdata ADD profileApproved varchar(255);
