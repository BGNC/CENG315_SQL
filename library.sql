DROP TABLE author;

DROP TABLE CD;
DROP TABLE magazine;
DROP TABLE book;
DROP TABLE Current_Loan;
DROP TABLE reservation;

DROP TABLE item;
DROP TABLE penalty;

DROP TABLE member;


DROP TABLE publisher;



DROP TABLE role;


DROP TABLE category;


CREATE TABLE author (
  author_id number(11) NOT NULL PRIMARY KEY,
  author_name VARCHAR2(255) NOT NULL,
  author_surname VARCHAR2(255) NOT NULL
);


CREATE TABLE publisher(
    publisher_id number(11) NOT NULL PRIMARY KEY,
    publisher varchar2(255) NOT NULL
);


CREATE TABLE role(
    role_id number(10) NOT NULL PRIMARY KEY,
    role_title varchar2(255) NOT NULL
);

CREATE TABLE member(
    member_id number(11) NOT NULL PRIMARY KEY,
    member_name varchar2(255) NOT NULL,
    member_surname varchar2(255) NOT NULL,
    gender varchar2(30) NOT NULL,
    birthdate DATE,
    phone varchar2(11),
    mail varchar2(255) NOT NULL,
    member_password varchar2(255) NOT NULL,
    address varchar2(255) not null,
    status number(1),
    role_id number(10) NOT NULL
);

CREATE TABLE category(
    category_id number(10) NOT NULL PRIMARY KEY,
    category_name varchar2(255) NOT NULL
);

CREATE TABLE reservation(
    reservation_id number(10) NOT NULL PRIMARY KEY,
    member_id number(11) NOT NULL,
    item_id number(11) NOT NULL,
    start_date DATE,
    end_date DATE,
    status number(1)
);

CREATE TABLE penalty(
    member_id number(11) NOT NULL,
    punishment_cost number(3),
    punishment_rate number(3),
    total_cost number(11)

);

CREATE TABLE item(
    item_id number(11) NOT NULL PRIMARY KEY,
    member_id number(11) ,
    publish_date DATE,
    is_occupied NUMBER(1) NOT NULL,
    publisher_id number(11) NOT NULL
    
);

CREATE TABLE book(
    item_id number(11) NOT NULL,
    book_name varchar2(255) NOT NULL,
    book_volume number(2) NOT NULL,
    page_count number(5) NOT NULL
    
);

CREATE TABLE CD(
    item_id number(11) not null,
    film_name varchar2(255) not null,
    age_constraint number(2)
);

CREATE TABLE magazine(
    item_id number(11) NOT NULL,
    magazine_name varchar2(255) NOT NULL,
    page_count number(5)
    

);

CREATE TABLE Current_Loan(
    loan_id number(10) NOT NULL PRIMARY KEY,
    item_id number(11) NOT NULL,
    loan_date DATE,
    due_date DATE
);


ALTER SESSION SET NLS_LANGUAGE='ENGLISH';

ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-YYYY';




-- UNIQUE KEYS 
ALTER TABLE member ADD CONSTRAINT member_phone_UK UNIQUE (phone);
ALTER TABLE penalty ADD CONSTRAINT member_id_UK UNIQUE (member_id);


-- FOREIGN KEYS 


ALTER TABLE item ADD CONSTRAINT FK_Publisher_Id FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id) ON DELETE CASCADE;

ALTER TABLE item ADD CONSTRAINT FK_Member FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE SET NULL;

ALTER TABLE member ADD CONSTRAINT role_id_foreign_key FOREIGN KEY (role_id) REFERENCES role(role_id) ON DELETE CASCADE;

ALTER TABLE reservation ADD CONSTRAINT member_id_foreign_key FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE CASCADE;

ALTER TABLE reservation ADD CONSTRAINT item_id_foreign_key FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;

ALTER TABLE magazine ADD CONSTRAINT fk_item_id FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;

ALTER TABLE CD ADD CONSTRAINT fk_cd FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;

ALTER TABLE book ADD CONSTRAINT Fk_Book FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;

ALTER TABLE Current_Loan ADD CONSTRAINT FK_Item FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE;




-- PRIMARY KEYS
ALTER TABLE magazine ADD CONSTRAINT PK_MAGAZINE_ITEM PRIMARY KEY (item_id);
ALTER TABLE CD ADD CONSTRAINT PK_CD_ITEM PRIMARY KEY (item_id);
ALTER TABLE book ADD CONSTRAINT PK_Book_ITEM PRIMARY KEY (item_id);





-- CHECK CONSTRAINTS

ALTER TABLE Current_Loan ADD CONSTRAINT loanItem CHECK(due_date - loan_date < 16);
ALTER TABLE reservation ADD CONSTRAINT checkDate CHECK (end_date-start_date <16);
ALTER TABLE magazine ADD CONSTRAINT checkPageCount CHECK(page_count>50);
ALTER TABLE book ADD CONSTRAINT checkPageCount CHECK(page_count>50);

