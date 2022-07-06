-- ������ ���۾�(DML: Insert, Update, Delete, Merge, Commit, Rollback)
-- �����͸� �Է�, ����, �����ϱ� ���� ��ɾ�
-- Ʈ�����: ���� ���� ��ɹ��� �ϳ��� ������ �۾������� ó���ϴ� ���, �ϵ��ũ�� ������ ����Ѵ�.

-- ������ �Է�: INSERT, ����-���� �� �Է�. INTO ���� Į���� ������� ������, ���̺� ���� �� ������ Į�� ������ ������ ������ �Է��ؾ� �Ѵ�.
/* CHAR, VARCHAR, DATE Ÿ���� '_'���� ��� �Է��� ��
INSERT INTO table [columns] VALUES [values]
*/
DESC student; -- ������ �Է� �� ���̺��� Į���̸�, ����, ��������, ������Ÿ���� Ȯ���Ѵ�.
-- (studno, name, userid, grade, idnum, birthdate, tel, height, weight, deptno, profno) --
INSERT INTO student VALUES(10110, 'ȫ�浿', 'hong', '1', '8501011143098', '85/01/01', '041)630-3114', 170,70,101,9903);

SELECT * FROM student; -- �����Ͱ� ������ Ȯ��, 'ȫ�浿'�� �Էµ� ���� �� �� �ִ�.

-- NULL �� (���������) �Է��ϱ� : VALUES�� NULL�̳� '' ���
-- ���������� NULL�� �Է��ϴ� ���(���� �Է� ���ϸ� �ȴ�)
INSERT ALL 
INTO department(deptno, dname) VALUES (400, 'ö�а�')
INTO department(deptno, dname) VALUES (401, '�ɸ��а�')
SELECT * FROM DUAL;

COMMIT; -- commit���� ����ϱ�

SELECT * FROM department; -- ������к� �Է� Ȯ�ο�, college-loc�� null�� �Ǿ��ִ�.

-- ��������� NULL�� �Է��ϴ� ���
INSERT INTO department
VALUES (301, 'ȯ�溸���а�', '', NULL); -- ȯ�溸���а� �Է� Ȯ�ο�, ���� ���� college-loc�� null�� �Ǿ��ִ�.

-- ��¥ ������ �Է� ���: UNIX 'DD-MONTH-YY', ORACLE 'YY/MM/DD', TO_DATE �Լ��� �˸��� ���� ���� �� �ִ�.
INSERT INTO professor(profno, name, position, hiredate, deptno)
VALUES (9920, '������', '������', TO_DATE('2006/01/01', 'YYYY/MM/DD'), 102);

SELECT * FROM professor;

-- SYSDATE�� ���� ��¥�� ���� �� �ִ�.
INSERT INTO professor VALUES (9910, '��̼�', 'white', '���Ӱ���', 200, SYSDATE, 10, 101);

-- ���� �� �Է�: INSERT ALL ���� "INTO t VALUES v"�� �ݺ��ؼ� ���� �� �Է��� �ص� �ǰ�, ���������� ��� �������κ��� ���� ���� ���� ���� �ִ�.
-- �������� �̿��� ���� �� �Է�: INSERT INTO t(cols) subquery;

-- ���̺��� �����͸� ������ ���
CREATE TABLE T_STUDENT
AS SELECT * FROM STUDENT
WHERE 1=0; -- ���̺��� ������(column)�� ������, WHERE�� ������ �����ͱ��� �ٷ� ������

INSERT INTO T_STUDENT
SELECT * FROM student; -- ���̺��� ������ ������(��� ���������� �̿��� ���� �� �Է¿� ������.)

select * FROM t_student;
select * from student;

-- INSERT ALL, subquery�� �̿���.
-- ���� �� �Է��� ���� height_info, weight_info ���� ���̺� ����
CREATE TABLE height_info(
studno number(5),
name varchar2(10),
height number(5,2));

CREATE TABLE weight_info(
studno number(5),
name varchar2(10),
weight number(5,2));

INSERT FIRST
INTO height_info values (studno, name, height)
INTO weight_info values (studno, name, weight)
SELECT studno, name, height, weight -- ���������κ��� studno, name, height, weight �����͸� �޾Ƽ� ���� values�� �����Ͽ� ���� ����ִ´�.
FROM student
WHERE grade >= '2';

SELECT * FROM height_info;
SELECT * FROM weight_info;
delete from height_info;
delete from weight_info;
-- Conditional INSERT ALL: WHEN~THEN~ELSE ���������� ������ ������ �����ϴ� ���� �ش�Ǵ� ���̺� ���� �Է�.
-- DELETE ���̺��� �����͸� ����, WHERE ���� �����Ƿ� ��� �����͸� �����Ѵ�.
DELETE FROM height_info;
DELETE FROM weight_info;

/* �л� ���̺��� 2�г� �̻��� �л��� �˻��Ͽ� height_info ���̺��� Ű�� 170���� ū �л��� �й�, �̸�, Ű�� �Է��ϰ�
weight_info ���̺��� �����԰� 70���� ū �л��� �й�, �̸�, �����Ը� ���� �Է��Ͽ���.
*/
INSERT ALL
WHEN height > 170 THEN
    INTO height_info values (studno, name, height)
WHEN weight > 70 THEN
    INTO weight_info values (studno, name, weight)
SELECT studno, name, height, weight -- ���������κ��� studno, name, height, weight �����͸� �޾Ƽ� ���� values�� �����Ͽ� ���� ����ִ´�.
FROM student
WHERE grade >= '2';
-- WHEN~THEN~WHEN~THEN~ELSE������, ��� WHEN �������� ������ ������ ELSE ���� ���ϰ� �ȴ�.
select * from height_info;
select * from weight_info;

/* Conditional INSERT FIRST: ���������� ��� ���տ� ���� WHEN ���������� ������ ������ �����ϴ� ù��° ���̺� �켱������ �Է��ϱ� ���� ��ɹ��̴�.
���������� ��� �����߿��� ������ �����ϴ� ù ��° WHEN������ ������ ���̺��� �Է��ϰ�, �� ���� ������տ��� ������ WHEN���� ������ �����ϸ� ù��° ���ǿ�
INSERT�� ���� �����ϰ� INSERT, ���������� ELSE���� ���ǵ� TABLE�� INSERT
... ���̽��� if - if ���� conditional insert all, if - elif�� conditional insert first ���. */
DELETE FROM height_info;
DELETE FROM weight_info;

INSERT FIRST
WHEN height > 170 THEN
    INTO height_info values (studno, name, height)
WHEN weight > 70 THEN
    INTO weight_info values (studno, name, weight)
SELECT studno, name, height, weight -- ���������κ��� studno, name, height, weight �����͸� �޾Ƽ� ���� values�� �����Ͽ� ���� ����ִ´�.
FROM student
WHERE grade >= '2';

select * from height_info;
select * from weight_info; -- height_info �������� ���ϴ� 3���� row�� ������ �ȵǾ� 2���� row�� �� ���� �� �� �ִ�.

-- PIVOTING INSERT: �ϳ��� ���� ���� ���� ������ ����� �Է��ϴ� ���(= Unconditional INSERT ALL), �� INTO������ �ϳ��� ���̺� �����Ѵ�.
-- OLTP(Online Transaction Processing) �������� �ַ� ����Ѵ�.
-- ����: 5���� Į������ ������ ���Ϻ� �Ǹ� ���� �����͸� �ϳ��� Į������ ������ �� �ϳ��� Į������ ���յ� �Ǹ� �������� ������ �����ϱ� ���� ���� ���� Į�� �߰�
CREATE TABLE sales( -- pivoting insert �ǽ��� ���� ���� ���̺�
    sales_no    number(4),
    week_no     number(2),
    sales_mon   number(7,2),
    sales_tue   number(7,2),
    sales_wed   number(7,2),
    sales_thu   number(7,2),
    sales_fri   number(7,2));
    
INSERT INTO sales VALUES(1101, 4, 100, 150, 80, 60, 120);
INSERT INTO sales VALUES(1102, 6, 300,300,230,120,150);
SELECT * FROM sales;

CREATE TABLE sales_data(
    sales_no    number(4),
    week_no     number(2),
    day_no      number(2),
    sales       number(7,2)
);
-- sales_mon ~ _fri�� ���� 12345��� pivoting ����
INSERT ALL
INTO sales_data VALUES(sales_no, week_no, '1', sales_mon)
INTO sales_data VALUES(sales_no, week_no, '2', sales_tue)
INTO sales_data VALUES(sales_no, week_no, '3', sales_wed)
INTO sales_data VALUES(sales_no, week_no, '4', sales_thu)
INTO sales_data VALUES(sales_no, week_no, '5', sales_fri)
SELECT sales_no, week_no, sales_mon, sales_tue, sales_wed, sales_thu, sales_fri
FROM sales;

SELECT * FROM sales_data
ORDER BY sales_no;

-- ������ ����(UPDATE) : UPDATE t SET col1=value1, col2=value2... WHERE condition
-- ���� ��ȣ�� 9903�� ������ ���� ������ �α����� �����Ͽ���.
select * from professor where profno = '9903';
UPDATE professor SET position='�α���' WHERE profno = '9903';

/* ���������� �̿��� ������ ����: UPDATE ��ɹ��� SET������ ���������� �̿�, �ٸ� ���̺� ����� �����͸� �˻��� �Ѳ����� ���� Į���� ����
 SET���� Į�� �̸��� ���������� Į�� �̸��� �޶� �ȴ�. ��, ������ Ÿ�԰� Į�� ���� �ݵ�� ��ġ���Ѿ� �Ѵ�.
    UPDATE table1
    SET (col1, col2, ...) = (SELECT s_c1, s_c2, ... FROM table2 WHERE ...) 
    WHERE ...
 */
 -- ���������� �̿��Ͽ� '�й��� 10201'�� �л��� '�г�� �а� ��ȣ'�� '10103�й�' �л��� '�г�� �а� ��ȣ'�� �����ϰ� �����Ͽ���.
UPDATE student
SET (grade, deptno) = (
    SELECT grade, deptno
    FROM student
    WHERE studno = 10103) -- ���������� 10103 �й� �л��� �г�� �а� ��ȣ ������ �����´�.
WHERE studno = 10201;

select * from student where studno = 10201 or studno = 10103;

-- Q. ���� ���̺��� �̸��� ������ ���ް� ���� ������ ���� ������ �� ���� �޿��� 450�� �� �Ǵ� �������� �޿��� 12% �λ��ϼ���.
select * from professor;

UPDATE professor
SET sal = sal*1.12
WHERE position = (
            SELECT position
            FROM professor
            WHERE name='�̸���')
AND sal < 450;

-- ������ ����(DELETE FROM TABLE WHERE ~~~)
-- �л� ���̺��� �й��� 20103�� �л��� �����͸� �����Ͽ���.
DELETE FROM student WHERE studno = 20103;

select * from student;
rollback;
commit;
-- ���������� �̿��� ������ ����
/*  DELETE FROM table
    WHERE (col1, col2, ...) = (SELECT s_c1, s_c2, ... FROM table2 WHERE ~);
*/
-- �л� ���̺��� ��ǻ�Ͱ��а��� �Ҽӵ� �л��� ��� �����Ͽ���.
DELETE FROM student
WHERE deptno = (SELECT deptno
                FROM department
                WHERE dname = '��ǻ�Ͱ��а�');

SELECT *
FROM student
WHERE deptno = (SELECT deptno
                FROM department
                WHERE dname = '��ǻ�Ͱ��а�');
-- ��ǻ�Ͱ��а� �л� �����Ͱ� ��� ������
rollback;

-- ������̺��� 'CHICAGO'���� �ٹ��ϴ� ������� ��� �����ϼ���(EMP, DEPT)
DELETE FROM EMP
WHERE deptno = (SELECT DEPTNO FROM DEPT WHERE LOC = 'CHICAGO');

select * from emp;

/* MERGE: ������ ���� �� ���̺��� ���Ͽ� �ϳ��� ���̺�� ��ġ�� ���� ������ ���۾�, WHEN ���� ���������� ��� ���̺� �ش� ���� �����ϸ�
 UPDATE ��ɹ����� ���� ���ο� ������ ����, �׷��� ������ INSERT ��ɹ����� ���ο� ���� �����Ѵ�.  �뷮�� ������ �м��ϱ� ���� ������ �����ϴ�. */
 /*
 MERGE INTO [table] [alias]             -> �ϳ��� ���̺�� ��ġ�� ���� ��� ���̺�
 USING [table | view | subquery] alias  -> ���̺�, ��, ���������� ���� ���� ����, WHEN ������ ������ ���� ����ؾ���
 ON [join condition]                    -> ���� ���� ����
 WHEN MATCHED THEN                      -> ���� ���� ������ �����ϸ� ������ ������ �� update
    UPDATE SET .....        
 WHEN NOT MATCHED THEN                  -> ���� ���ϸ� ���ο� ������ INSERT
    INSERT INTO ......
    VALUES ......; 
 */

CREATE TABLE professor_temp AS
    SELECT *
    FROM professor
    WHERE position = '����';
    
SELECT * FROM professor_temp; -- POSITION�� ������ ����� ���ؼ� professor_temp ���̺��� ������

UPDATE professor_temp
SET position = '������'
WHERE position = '����';

SELECT * FROM professor_temp; -- professor_temp ���̺��� ���� ������ �������� ������

INSERT INTO professor_temp
VALUES(9999, '�赵��', 'arom21', '���Ӱ���', 200, SYSDATE, 10, 101); -- ���ο� ������ �Է�

SELECT * FROM professor; -- ���� ���� �״��, ���Ӱ��� '�赵��'�� ����

MERGE INTO professor p -- professor ���̺� ���� ���� �� ���� ����
USING professor_temp f -- professor_temp�� ���� ����
ON (p.profno = f.profno) -- ���� ����(EQUI JOIN) ����
WHEN MATCHED THEN
    UPDATE SET p.position = f.position -- MATCH(���� ������ �´� ���=����)�� �� p.position�� f.position���� update
WHEN NOT MATCHED THEN
    INSERT values(f.profno, f.name, f.userid, f.position, f.sal, f.hiredate, f.comm, f.deptno); -- NOT MATCH(�赵��)�� ��, f.position�� p�� INSERT

SELECT * FROM professor; -- ���� -> ������, ���Ӱ��� '�赵��'�� UPDATE

-- Ʈ����� ���� : commit(���� ���� ��ũ�� �����ϰ� Ʈ����� ����), rollback(�۾� ���� �� Ʈ����� ��ü ����ϰ� Ʈ����� ����)

-- ������ : ������ �ĺ���, �⺻ Ű ���� �ڵ����� �����ϱ� ���� �Ϸù�ȣ �����ϴ� ��ü
/*
CREATE SEQUENCE seq     -> �������� �̸� ����
[INCREMENT BY n]        -> ������ ��ȣ�� ����ġ
[START WITH n]          -> ������ ���۹�ȣ, �⺻���� 1
[MAXVALUE n]            -> ���� ������ �������� �ִ�
[MINVALUE n]            -> cycle �����ϸ�, MAXVALUE->MINVALUE�� MINVALUE->MAXVALUE�� ����Ŭ�� ����
[CYCLE]                 -> ������ ��ȯ ����
[CACHE n]               -> ������ ���� �ӵ� ������ ���� �޸𸮿� ĳ���ϴ� �������� ����, �⺻���� 20
*/
CREATE SEQUENCE s_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 100;

SELECT min_value, max_value, increment_by, last_number
FROM user_sequences
WHERE sequence_name = 'S_SEQ';

-- CURRVAL : ���������� ������ ���� ��ȣ, NEXTVAL: ���������� ���� ��ȣ ����
INSERT INTO EMP VALUES
(S_SEQ.NEXTVAL, 'TEST1', 'SALESMAN', 7698, to_date('17-12-1980','dd-mm-yyyy'), 800, NULL, 20); -- 1

INSERT INTO EMP(empno, ename)
VALUES(S_SEQ.NEXTVAL, 'TEST2'); -- 2

INSERT INTO EMP(empno, ename)
VALUES(S_SEQ.NEXTVAL, 'TEST3'); -- 3

SELECT * FROM emp;

SELECT S_SEQ.CURRVAL
FROM DUAL;

SELECT S_SEQ.NEXTVAL
FROM DUAL; -- �̰� �����ص� ���� �������� �Ѿ�Ƿ� ����

SELECT * FROM USER_SEQUENCES; -- USER�� ������ �������� �ý����� ��������(Data Dictionary)
SELECT min_value, max_value, increment_by, last_number
FROM user_sequences
WHERE sequence_name = 'S_SEQ';

-- �������� �̿��� �⺻ Ű ����: NEXTVAL �Լ��� �⺻Ű�� ������ �� �ִ�.
-- ALTER�� ������ ���� ���� ����
/*
ALTER SEQUENCE seq [INCREMENT BY n] [] [] []... : SEQUENCE ������ ���� ����.
*/
ALTER SEQUENCE S_SEQ MAXVALUE 2000;
-- SEQUENCE ����: DROP SEQUENCE seq;
DROP SEQUENCE S_SEQ;

-- //// ���̺� ���� //// --

-- 1. �����ͺ��̽� ���� ������Ʈ ����
/* ���̺� ���� �� ���ǻ���: ���ڷ� ����, 30�� �̳�, ���ڿ� Ư������(_$#) ��� ����, ��ҹ��� ���� ����,
���� �ٸ� ���̺��� ������ �����͸� �����ϴ� Į�� �̸��� �����ϸ� ���� �̸��� ����� ��(������ �� ���ϰ�) */
/* CREATE TABLE [schema] table           -> SCHEMA : �����ͺ��̽� ����� ������ ���� �ǹ�
 ( column1 datatype [DEFAULT expr] [column_constraint(��������)]
    ........ )*/
CREATE TABLE address
(id     number(3),
name    varchar2(50),
addr    varchar2(100),
phone   varchar2(30),
email   varchar2(100)
);
SELECT * FROM tab; -- ���̺� ���� Ȯ��
DESC address; -- ���̺� ���� Ȯ��

-- DEFAULT �ɼ�: �Է°��� ������ ���, NULL ��ſ� �ԷµǴ� �⺻ ��.
-- ��) addr varchar2(100) DEFAULT 'KOREA' -> addr�� ���� �ȳ����� 'KOREA'�� �ڵ����� �Էµ�

-- ���������� �̿��� ���̺� ����: ���������κ��� Ÿ ���̺��� ���� �� �����͸� ������ ���ο� ���̺� ���� ����
-- ��, Į�� �̸��� ������� ������ �������� Į�� �̸��� �����ϰ� ������. 
-- ���Ἲ ���������� NOT NULL�� ����. ����Ʈ �ɼ� ���� ���� �״�� ������.
INSERT INTO address VALUES(1, 'HGDONG', 'SEOUL','123-4567', 'gdhong@abcd.ac.kr');
INSERT INTO address VALUES(2, 'KCsu', 'JEJU','133-5779', 'kcsu@efgh.ac.kr');
SELECT * FROM address;

CREATE TABLE addr_second(id2, name2, addr2, phone2, email2)
AS SELECT * FROM address; -- column �̸��� �� ������� ������ �� �ִ�.

DESC addr_second;
SELECT * FROM addr_second; -- addr ���̺��� ������ �״�� ����Ǿ���. ������ ���� ���� '���̺��� �����Ӹ� ����'�Ϸ��� WHERE 0=1;���� �������� ���̸� �ȴ�.

CREATE TABLE addr_third(id, name)
AS SELECT id2, name2 FROM addr_second
WHERE 0=1;

SELECT * FROM addr_third; -- ������ ����Ǿ���.

-- ���̺� ���� ����(Į�� �߰�): ALTER TABLE t_name ~ ADD (col_name datatype ...)
-- �ּҷ� ���̺� ��¥ Ÿ���� ������ bitrh Į���� �߰��Ͽ���.
ALTER TABLE address
ADD (birth DATE);

ALTER TABLE address
ADD(comments VARCHAR2(100) DEFAULT 'NO Comment');

DESC address; -- birth, comments��� Į���� �߰��Ǿ���.

-- ���̺� ���� ����(Į�� ����): ALTER TABLE t_name DROP COLUMN col_name;
-- �ּҷ� ���̺��� Į�� 'comments'�� �����Ͽ���
ALTER TABLE address DROP COLUMN comments;

/* ���̺� ���� ����(Į�� ����)
���� Į���� �����Ͱ� ���� ��� Į�� Ÿ���̳� ũ�� ������ �����ο쳪, ���� Į���� �����Ͱ� �ִٸ� ���� ������ �ؼ��Ͽ��� �Ѵ�.
1. Ÿ�� ������ CHAR�� VARCHAR2�� ����Ѵ�.
2. ������ Į���� ũ�Ⱑ ����� �������� ũ�⺸�� ���ų� Ŭ ��� ������ �����ϴ�
3. ���� Ÿ�Կ����� ���е� ������ �����ϴ�(���е��� ����߸��� ���� �Ұ���: ��-�Ǽ��� �����Ͱ� �ִµ� ���������� ������ �����Ϸ��� ���)
ALTER TABLE t_name
MODIFY (col_name datatype ...);
*/
-- �ּҷ� ���̺��� phone Į���� ������ Ÿ�� ũ�⸦ 50���� �������Ѷ�
ALTER TABLE address
MODIFY phone VARCHAR2(50);

-- ���̺� �̸� ����: RENAME ��ɹ� ���: RENAME old_table_name TO new_table_name
-- addr_second ���̺� �̸��� client_address�� �����Ͽ���.
RENAME addr_second TO client_address;
SELECT * FROM tab; -- addr_second ���̺��� client_address�� �ٲ� ���� Ȯ���� �� �ִ�.

-- ���̺� ���� : DROP TABLE table_name [cascade constraints], �ٸ� ���̺��� �����ϴ� ���̺��� �����Ϸ��� ��쿡�� �Ժη� ������ �ϱⰡ ��ƴ�.
-- addr_third ���̺��� �����Ͽ���.
DROP TABLE addr_third;
SELECT * FROM tab; -- addr_third ���̺��� ������ ���� Ȯ���� �� �ִ�.

-- TRUNCATE ��ɹ�: ���̺� ������ ����, �����Ϳ� �Ҵ�� ������ ����.
-- DELETE ��ɹ����� ����: WHERE���� ���� Ư�� �ุ �����ϴ� ���� �Ұ���, DDL�����ν� ������ �������� ��ȯ�ϴ� �Ŷ� ROLLBACK �Ұ���
TRUNCATE TABLE client_address; -- '�����Ǿ����ϴ�'�� �ƴ϶� '�߷Ƚ��ϴ�'��� ���.
rollback; -- ���� �����ʹ� ������ ���� ����. ������ �����Ǵ� �� �ƴ�(�װ� DROP)
SELECT * FROM client_address;

-- DELETE, DROP & CREATE, TRUNCATE�� ��.
/*
|����     |���̺�����|������� |������|�۾��ӵ�|SQL����|
|DELETE  |����     |����    |����  |����   |DML   |
|TRUNCATE|����     |�ݳ�    |����  |����   |DDL   |
|DROP    |����     |�ݳ�    |����  |����   |DDL   |
*/
-- Quiz_07-04
-- 1. ���� ���̺��� ���� ��ȣ, ���� �̸����� ������ ���̺� PROF1, PROF2�� �����غ�����.
CREATE TABLE PROF1(profno, prof_name)
AS (SELECT profno, name FROM professor WHERE 0=1);
CREATE TABLE PROF2(profno, prof_name)
AS (SELECT profno, name FROM professor WHERE 0=1);

/* 2. ���� ���̺��� ���� ��ȣ�� 9901 ~ 9905������ ������ ������ȣ�� �̸��� prof1 ���̺� �Է��ϰ�,
 ������ȣ�� 9906 ~ 9920������ ������ ������ȣ�� �̸��� prof2 ���̺� �Է��غ�����. */ 
INSERT INTO PROF1
(SELECT profno, name
 FROM professor
 WHERE profno BETWEEN 9901 AND 9905);
INSERT INTO PROF2
(SELECT profno, name
    FROM professor
    WHERE profno BETWEEN 9906 AND 9920);


/* 3. �� �а����� �Ի����� ���� ������ ������ ������ȣ�� �̸�, �Ի���, �а����� ����ϼ���. ��, �Ի��� ������ �����Ͻÿ�. */
SELECT profno, name, hiredate, d.dname
FROM professor p, department d
WHERE (p.deptno, hiredate) IN (SELECT deptno, MIN(HIREDATE)
                            FROM professor
                            GROUP BY deptno)
AND p.deptno = d.deptno
ORDER BY HIREDATE;

/* 4. �л� ���̺��� �й��� 20000���� 25000���� �ش��ϴ� �л����� �����Ͻÿ�.*/
DELETE FROM student
WHERE studno BETWEEN 20000 AND 25000;

/* 5. EMPNO, ENAME �׸��� DEPTNO ������ �����ϴ� EMP ���̺��� ������ ���ʷ� EMPLOYEE2 ���̺��� �����Ͻÿ�.
�� ���̺��� ID, LAST_NAME, DEPT_ID�� �� �̸��� �����Ͻÿ�. */
CREATE TABLE EMPLOYEE2(ID, LAST_NAME, DEPT_ID)
AS  (SELECT empno, ename, deptno
    FROM emp);
/* 6. 5���� ������ EMPLOYEE2 ���̺��� LAST_NAME �ʵ带 10 ---> 30���� �����ϼ���. */
ALTER TABLE employee2
MODIFY last_name varchar2(30);

-- �ּ� �߰�
-- ���̺��̳� Į���� �ִ� 2000����Ʈ���� �ּ��� �߰�. COMMENT ON TABLE ... IS ��ɹ� �̿�.
-- �߰��� �ּ��� Ȯ���ϱ� ���ؼ��� ALL_COL_COMMENTS, USER_COL_COMMENTS, ALL_TAB_COMMENTS ������ ������ ����
COMMENT ON TABLE address
IS '�� �ּҷ��� �����ϱ� ���� ���̺�';

COMMENT ON COLUMN address.name
IS '�� �̸�';

SELECT * FROM ALL_COL_COMMENTS WHERE table_name = 'ADDRESS'; -- �÷��� ������ ��� �ּ�(�ý��� + ����)�� ��µȴ�.
SELECT * FROM USER_COL_COMMENTS WHERE table_name = 'ADDRESS'; -- ������ �÷��� ������ �ּ��� ��µȴ�.
SELECT * FROM ALL_TAB_COMMENTS WHERE table_name = 'ADDRESS'; -- ��� ���̺� �� �信 ���ǵ� �ּ��� ��µȴ�.
-- �ּ��� �������� ���� column���� comment�� NULL�ΰ��� �� �� �ִ�.

COMMENT ON TABLE ADDRESS IS ''; -- ���̺� �ּ� ����
COMMENT ON COLUMN ADDRESS.NAME IS ''; -- �÷� �ּ� ����

/*-----------------------------------------------*/
-- ������ ����(Data Dictionary): DB ������ ȿ�������� �ϱ� ���� ������ ����Ǵ� ���̺��, �Ϲ������� �б� ���� �信 ���� ������ ������ ������ ��ȸ�� �� �� �ִ�.
-- �ǹ������� ���̺�, Į��, �� ��� ���� ������ ��ȸ�ϱ� ���� ����Ѵ�.
/* ������ �������� �����ϴ� ����: DB�� ������-���� ����, ����� �̸�, ��Ű�� ��ü �̸�, ���� ����, ���Ἲ ��������, Į���� �⺻��(DEFAULT), �Ҵ��(�������) ���� ũ��,
��ü ���� �� ���ſ� ���� ����(���) ����, DB �̸�, ����, ������¥, ���۸��, �ν��Ͻ� �̸� ���� ���...
- �ټ��� ����ڰ� ������ �����͸� ����
- �б� ���� ��� ������
- �����ͺ��̽� �����ڳ� ����ڿ��� ������ ������ ����� ���� ��ȸ�� ���
- �뵵�� ���� USER_(��ü �����ڸ� ���� ����), ALL_('����'�� �ο����� ��ü�� ���� ����), DBA_(DB �����ڸ� ���� ����)�� ����
*/
-- USER_: '�Ϲ� �����'�� ���� �����ϰ� ���õ� ��� �ڽ��� ������ ���̺�, �ε���, ��, ���Ǿ� �� ��ü�� �ش� ����ڿ��� �ο��� ���� ������ ��ȸ
SELECT table_name FROM user_tables; -- ����ڰ� ������ ���̺��� ������ ��ȸ
-- ALL_: �����ͺ��̽� ��ü ����ڿ� ���õ� ���, OWNER Į���� �����Ѵ�. ���� (����ڰ�) ������ �� �ִ� ��� ��ü�� ���� ������ ��ȸ�� �� �ִ�.
SELECT owner, table_name FROM all_tables; -- �ڱ� ���� or ������ �ο��޴� ���̺� ���� ������ ��ȸ�� �� �ִ�. SYS, SYSTEM ��� OWNER�� Ȯ���� �� �ִ�.
-- DBA_: �ý��� ������ ���õ� ���, DBA�� SELECT ANY TABLE �ý��� ������ ���� ����ڷ�, ����� ���� ���� �� �����ͺ��̽� �ڿ������� ������ �ش�.
SELECT owner, table_name FROM dba_tables; -- ������ ���� 'hr' �����̱� ������ �̰� ���� �Ұ����ϴ�.
-- "conn system/manager"���� DB �����ڷ� �α��� �� �ڿ� ���� ������ �� �ִ�.

/* ������ ������ ����
dictionary, dict_columns : ������ ���� ���̺�, ��, Į���� ���� ����
dba_tables, dba_objects, dba_tab_columns, dba_constraints : ���̺�, ��������, Į��, ����� ��ü�� ���õ� ����
dba_users, dba_sys_privs, dba_roles : ����� ���Ѱ� �ѿ� ���� ����
dba_extents, dba_free_space, dba_segments : �����ͺ��̽� ��ü�� ���� ���� �Ҵ� ����
dba_rollback_segs, dba_data_files, dba_tablespaces : �����ͺ��̽� ���� ������ ���� ����
dba_audit_trail, dba_audit_object, dba_obj_audit_opts : ����(���� �� ���)�� ���õ� ����
�̷��� �ֱ��� �ϰ� �Ѿ�� �ȴ�.
*/

/*-------------------------------------------------------------------------------------*/
-- ������ ���Ἲ ��������: �������� ��Ȯ���� �ϰ����� �����ϱ� ���� ����Ǵ� ��������. ������ ��Ģ
-- ����: student ���̺��� ��� �й��� ����(��ġ�� �ȵ�)�Ͽ��� �Ѵ�. student ���̺��� profno�� professor ���̺��� ������ȣ�� �ش��ؾ� �Ѵ�.
/* ���Ἲ �������� ����
NOT NULL(���� NULL�� ������ �� ����), ����Ű(unique key, ��ġ�� �ȵ�), �⺻Ű(primary key, ������ �����ؾ� �ϸ� unique + not null�� ����),
 ����Ű(foreign key, �ٸ� ���̺��� Į���� �����ϴ� Ű�� ǥ��), CHECK(�ش� Į���� ���� ������ ������ ���� '����'�� '����' ����)

* �������� ���� ���(���̺� ������ ��)
CREATE TABLE [schema_name.] table_name
(column datatype [DEFAULT] [col_constraints ...]
...);

* ���Ἲ �������� ������������ Ű����
- ON DELETE CASCADE(������ ���޾Ƽ� �ڽ� ���̺�� �Բ� ����), USING INDEX(���������� �����Ǵ� �ε����� ���� �Ķ���� ����), NOT DEFERRABLE(DML ó���� ������ �������� ���� ���� �˻�),
DEFERRABLE(DML ��ɹ� �������� �˻縦 Ʈ����� ���� �ñ��� ����), INITIALLY IMMEDIATE(DML ��ɹ��� ����� ������ �������� �˻�), INITIALLY DEFFERED(Ʈ������� ���� ���� �������� �˻�)

* ����
*/
CREATE TABLE subject
(subno NUMBER(5)
 CONSTRAINT subject_no_pk PRIMARY KEY -- �⺻Ű ����
 DEFERRABLE INITIALLY DEFERRED -- deferrable, initially deferred Ű���� ����, Ʈ����� ���� ������ DML �������� �˻縦 �̷�ٴ� ��
 USING INDEX TABLESPACE INDX, -- tablespace�� INDX��� �ε����� ����ϰڴٴ� �ǹ�
subname VARCHAR2(20)
    CONSTRAINT subject_name_nn NOT NULL, -- NOT NULL ����
term VARCHAR2(1)
    CONSTRAINT subject_term_ck CHECK (term in ('1', '2')), -- CHECK ����
type VARCHAR2(8));
-- tablespace 'INDX' does not exist, "tablespace '%s' does not exist" ���� �߻�
-- 1. system ���� -> 2. ������ os install -> 3. dbms ����(oracle, mysql, ...) -> 4. create tablespace(�����Ͱ� ���� �� �������� ����)
--> 5. create user -> 6. data backup and import OR create table -> 7. insert data

-- ��ġ: C:\oraclexe\app\oracle\oradata\XE (11g)�� tablespace 'indx'�� �����ϴ� ���(conn system/manager�� �����ڷ� �α��� �ʿ�)
/* SQL> create tablespace indx
        datafile 'C:\oraclexe\app\oracle\oradata\XE\indx.dbf' size 100m; */
-- ���� ������� indx ������ �� ���� create ���� �����ϸ� ���������� table 'subject'�� �����ȴ�.

DESC subject;

ALTER TABLE student
ADD CONSTRAINT stud_no_pk PRIMARY KEY(studno); -- studno Į���� �⺻Ű ���������� �߰��Ѵ�

CREATE TABLE sugang
(studno NUMBER(5)
    CONSTRAINT sugang_studno_fk REFERENCES student(studno), -- Į�� ������ ���� ����
subno   NUMBER(5)
    CONSTRAINT sugang_subno_fk REFERENCES subject(subno), -- Į�� ������ ���� ����
regdate DATE,
result NUMBER(3),
    CONSTRAINT sugang_pk PRIMARY KEY(studno, subno)); -- ���̺� ������ ���� ����

-- USER_CONSTRAINTS ������ �������� ���Ἲ �������� ��ȸ�ϱ�, C(check or NOT NULL), P(Primary key), U(Unique key), R(Foreign key)
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('SUBJECT', 'SUGANG');

-- ���� ���̺� ���Ἲ �������� �߰�
ALTER TABLE student
ADD CONSTRAINT stud_idnum_uk UNIQUE(idnum); -- NULL�� ������ ���Ἲ ���������� �߰��Ϸ��� ADD CONSTRAINT ��ɹ��� ����Ѵ�.

ALTER TABLE student
MODIFY (name CONSTRAINT stud_name_nn NOT NULL); -- NOT NULL ���Ἲ �߰��Ϸ��� MODIFY ��ɹ��� ����ؾ� �Ѵ�.

ALTER TABLE student ADD CONSTRAINT stud_deptno_fk
FOREIGN KEY(deptno) REFERENCES department(deptno); -- department ���̺��� deptno Į���� �⺻Ű or ����Ű �������� ������ �ܷ�Ű ���ǽ� ����
-- department�� deptno Į���� �⺻Ű�� �ο��غ���.

desc department; -- deptno Į���� �⺻Ű�� �ο��ϴ� NOT NULL�� ǥ�õǴ� ���� �� �� �ִ�.
ALTER TABLE department ADD CONSTRAINT dep_deptno_pk PRIMARY KEY (deptno);
-- deptno Į���� �⺻Ű�� �ο��ϴ� �ܷ�Ű ���ǰ� �Ϸ�ȴ�.

-- �ǽ� ����1: department ���̺��� dname�� not null ���Ἲ ���������� �߰��Ͽ���.
ALTER TABLE department MODIFY (dname CONSTRAINT dname_nn NOT NULL);

-- ���Ἲ �������ǿ� ���ݵǴ� insert�� �� ���
select * from department;
insert into department(deptno, dname) values(301, '�����а�'); -- deptno�� Unique ������ �����ؼ� �Է��� �ȵȴ�.
select * from department;
insert into department(deptno, dname) values(303, ''); -- dname�� NOT NULL ������ �����ؼ� �Է��� �ȵȴ�.

/* �ǽ� ����2: professor ���̺� �ν��Ͻ��� �����Ͽ� profno�� �⺻Ű, name�� NOT NULL, deptno�� ���� ���Ἲ ���������� �߰��϶�.
�̶�, deptno�� department�� deptno�� �����Ѵ�. */
ALTER TABLE professor ADD CONSTRAINT profno_pk PRIMARY KEY (profno);
ALTER TABLE professor MODIFY (name CONSTRAINT pname_nn NOT NULL);
ALTER TABLE professor ADD CONSTRAINT prof_dept_fk FOREIGN KEY(deptno) REFERENCES department(deptno);
DESC professor;

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('DEPARTMENT', 'PROFESSOR');

-- ���Ἲ �������ǿ� ���� DML ��ɹ��� ����
/*  - ��� �������ǿ� ����: ���̺� �����͸� ���� �Է��� ���� ���Ἲ ���������� �����ϴ� ��ɹ��� �ѹ�
    - ���� �������ǿ� ����: Ʈ����� �� DML ��ɹ����� �������� �˻縦 commit �������� �ѹ��� ó���� Ʈ������� ó�� ������ ����Ű�� ���� ���
    -> �ؼ�) �������� DML �����Ҷ����� �˻��ϸ� �����ɸ��ϱ�, �ѹ��� �����̷� �˻��ؼ� �ð��� ��������! */
insert into subject values(1, 'SQL', '1', '�ʼ�');

insert into subject values(2, '', '2', '�ʼ�'); -- subname�� not null ���� ����
insert into subject values(3, 'java', '3', '����'); -- term�� check ���� ����

select * from subject;

-- ���� ��������(commit���� �������� �˻�)
insert into subject values(4, 'database', '1', '�ʼ�'); -- �̰� �ι� �ݺ�
commit; -- Ŀ�� �� ���� �߻�, rollback ����

select constraint_name, constraint_type, deferrable, deferred from user_constraints
where table_name = 'SUBJECT'; -- ���� NOT DEFERRABLE�� (INITIALLY)IMMEDIATE�� ����Ʈ ���̴�.

-- ���Ἲ �������� ����: ALTER TABLE table_name DROP CONSTRAINT constraint_name [CASCADE]; --> CASCADE�� �����Ǵ� Į���� �����ϴ� ���� ���Ἲ �������ǵ� �Բ� �����Ѵ�.
--> ���� �Ҹ��ĸ�, Ư�� PK ���������� ������ �� �� PK�� '����'�ϴ� ���𰡰� �ִٸ� ������ �ȵ�. CASCADE�� �־�� '����'�� �ش��ϴ� ���������� ���� ��������.
ALTER TABLE subject DROP CONSTRAINT subject_term_ck;
-- Ȯ��
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('SUBJECT');

-- ���Ἲ �������� Ȱ��ȭ �� ��Ȱ��ȭ: ���������� �Ͻ������� ��Ȱ��ȭ�Ϸ��� ���, ���� ���� ���ϰ� ��Ȱ��ȭ �ϸ� �ȴ�.
/*  ALTER TABLE table_name
    [DISABLE | ENABLE (+ NOVALIDATE)] CONSTRAINT constraint_name [CASCADE];
-- ������ NOVALIDATE : ���� �����Ϳ� ���ؼ��� �������� �������� �ʰ�, ���� ������(�����Ǵ�) �����Ϳ��� ���������� �˻��ϰ� �Ѵ�. */
ALTER TABLE sugang
DISABLE CONSTRAINT sugang_pk;

ALTER TABLE sugang
DISABLE CONSTRAINT sugang_studno_fk;

SELECT constraint_name, constraint_type, status -- status�� ENABLED(Ȱ��ȭ) / DISABLED(��Ȱ��ȭ) ���θ� ����Ѵ�.
FROM user_constraints
WHERE table_name IN ('SUGANG');

ALTER TABLE sugang
ENABLE CONSTRAINT sugang_pk;

ALTER TABLE sugang
ENABLE CONSTRAINT sugang_studno_fk; -- STATUS�� ENABLED�� ��

-- USER_CONSTRAINTS : ���������� ������ ���̺� �̸�, �������� �̸�, ���Ἲ ���� �� Ȱ��ȭ ���� ������ ���� (Data Dictionary)
-- USER_CONS_COLUMNS : ���������� ������ Į���� �̸��� ����
SELECT table_name, column_name, constraint_name
FROM user_cons_columns
WHERE table_name IN ('STUDENT','PROFESSOR','DEPARTMENT');

-- �ε��� ����
/*  CREATE [UNIQUE] INDEX index_name
    ON table_name (column [ASC|DESC] , column2 [] ...);
*/
-- ���� �ε���
CREATE UNIQUE INDEX idx_dept_name
ON department(dname);
-- ����� �ε���(NON UNIQUE)
CREATE INDEX idx_stud_birthdate
ON student(birthdate);
-- ���� �ε��� VS ���� �ε���(�� �� �̻��� Į���� �����Ͽ� �����ϴ� �ε���)
CREATE INDEX idx_stud_dno_grade
ON student(deptno, grade);

-- DESCENDING INDEX: Į������ ���� ������ ������ ������ ���� �ε����� �����ϱ� ���� ���
CREATE INDEX fidx_stud_no_name ON student(deptno DESC, name ASC); -- deptno�� ��������, name�� ������������ �����ϵ��� ����

-- �Լ� ��� �ε���(Function Based Index): Į���� ���� �����̳� �Լ��� ��� ����� �ε����� ���� ����
CREATE INDEX uppercase_idx ON emp (UPPER(ename)); -- �Լ� UPPER()�� ��� ����� �ε����� �����Ͽ���.
select * from emp where upper(ename) = 'KING'; -- �̷��� �˻��� �� ����.

-- �ε��� ���� ��� Ȯ��
/* SQL Command Line����...
conn system/manager -> grant plustrace to hr -> conn hr/hr -> set autotrace on; -> ��! */
-- �����ȹ ���� : autotrace off;
SELECT deptno, dname
FROM department
WHERE dname = '�����̵���к�'; -- sqldeveloper������ F10�� ���� ��������.

-- �ε��� �����ϰ� �����ϸ�?
DROP INDEX IDX_DEPT_NAME;

commit;

-- USER_INDEXES: �ε��� �̸��� ���ϼ� ���� ���� Ȯ��
SELECT index_name, uniqueness
FROM user_indexes
WHERE table_name = 'STUDENT';

-- USER_IND_COLUMNS: �ε��� �̸�, �ε����� ������ ���̺� �̸��� Į�� �̸� �� Ȯ��
SELECT index_name, table_name, column_name
FROM user_ind_columns
WHERE table_name = 'STUDENT';

-- �ε��� ����: DROP INDEX index_name;
drop index fidx_stud_no_name;

-- �ε��� �籸�� : ���ʿ��ϰ� ������ �ε��� ���� ��带 �����ϴ� �۾�
ALTER INDEX stud_no_pk REBUILD;

/*--------------------------------------------------------------------------------*/
-- ��(View) : �������̺�, ���Ȱ� ����� ���Ǽ����� ������ ������.
-- �ܼ� ��(�ϳ��� ���̺�), ���� ��(�������� ���̺�)
create view view_professor as
select profno, name, userid, position, hiredate, deptno
from professor;

select * from view_professor;

-- �� ������, Į�� �̸��� ������� ������ �⺻ ���̺��� Į�� �̸��� ����Ѵ�.
-- create [or replace: ������ ������ �� ������ ���] view view_name [Į�� �̸�(����)] AS �������� ...
create view v_stud_dept101 as
        select studno, name, deptno
        from student
        where deptno = 101;
        
select * from v_stud_dept101;

create view v_stud_dept102
as select s.studno, s.name, s.grade, d.dname
from student s, department d
where s.deptno = d.deptno AND s.deptno = 102;

select * from v_stud_dept102;

create view v_prof_avg_sal
as select deptno, sum(sal) sum_sal, avg(sal) avg_sal
from professor
group by deptno;
 -- �Լ�(sum, avg)�� ����Ͽ� �並 ������ �� Į�������� ������� ������ ������ �߻��Ѵ�.
 
select * from v_prof_avg_sal;

-- �ζ��� ��(inline view): FROM ������ �����ϴ� ���̺��� ũ�Ⱑ Ŭ ���, �ʿ��� ��� �÷������� ������ ������ �������Ͽ� ���ǹ��� ȿ�������� �����ϴ� ��
-- �ζ��� �並 ����Ͽ� �а����� �л����� ��� Ű�� ��� ������, �а� �̸��� ����Ͽ���.
select dname, avg_height, avg_weight
from (select deptno, round(avg(height),2) avg_height, round(avg(weight),2) avg_weight
        from student   
        group by deptno) s, department d
where s.deptno = d.deptno;

-- inline view QUIZ: �� �г��� ��� Ű�� ���ϰ�, �ش� ��� Ű���� ū �л��� �г�, �̸�, Ű, �� �г��� ��� Ű�� ����ϼ���.
SELECT s.grade as "�г�", name as "�̸�", height as "Ű", avg_height as "�г⺰ ���Ű"
FROM ( SELECT grade, round(AVG(height)) avg_height
        FROM student
        GROUP BY grade) av, student s
WHERE s.grade = av.grade AND s.height >= avg_height
ORDER BY s.grade;
/* ���� ���� ó�� ����
1) USER_VIEW ������ ��ųʸ����� �信 ���� ���Ǹ� ��ȸ
2) �⺻ ���̺� ���� ���� ���� ������ Ȯ��
3) �信 ���� ���Ǹ� �⺻ ���̺� ���� ���Ƿ� ��ȯ
4) �⺻ ���̺� ���� ���Ǹ� ���� �����͸� �˻�
5) �˻��� ����� ���
*/

-- USER_VIEWS(DATA DICTIONARY): ����ڰ� ������ ��� �信 ���� ���Ǹ� ����
select view_name, text
from user_views;

-- �� ����: ���� �信 ���� ���Ǹ� ������ �Ŀ� ������Ѵ�(����� ������ �ƴ�;). ����, OR REPLACE �ɼ��� ������ �����ؾ� ��.
create or replace view v_stud_dept101
as select studno, name, deptno, grade
    from student
    where deptno = 101;

/* �信�� ������ ������ �Ұ����� ���.
1. �⺻ ���̺��� Į���� 'NOT NULL' ������������ ������ ���
2. �� ���ǽ� ǥ�������� ���ǵ� Į���� ���� 'update, insert' ���� �Ұ���
3. �� ���ǽ� �׷� �Լ�, DISTINCT, GROUP BY �� ������ ���, ��� DML �� ��� �Ұ�
*/
-- �� ����: DROP VIEW view_name;
drop view v_stud_dept101;
drop view v_stud_dept102;


/*---------------------------------------------------------------------------------------------*/
-- 16. ����� ���� ����
/* ���� ����� ȯ�濡����, �ҹ��� ���� �� ���� ������ ���Ͽ� ���� ��ý�� �ʿ��ϴ�. "���ٱ���, ������, ��ȣ"�� ö���� �����ؾ� �Ѵ�.
����, �߾� �������� ������ ������ �л������� �����Ǵ� �ͺ��� ������ ����ϴٴ� ���� �����ؾ� �Ѵ�.
����Ŭ������ �ý��� ����(DB ��ü�� ���� ������� ���� ���� �� ���� ����), ������ ����(��ü�� �����ϱ� ���� ���� �� ���� ������ ����)�� �����Ѵ�.
*/
-- ����: ����ڰ� �����ͺ��̽� �ý���(�ý��� ����)�� �����ϰų� ��ü(��ü ����)�� �̿��� �� �ִ� �Ǹ�.
-- �����ͺ��̽� �����ڰ� ������ �ý��� ����: ����� ���� �� ����, ����� �������� ��ü ���� �� ����, �����ͺ��̽� ��� ����
/* CREATE USER, DROP USER, DROP ANY TABLE, QUERY REWRITE, BACKUP ANY TABLE */

-- �Ϲ� ����ڰ� ������ �ý��� ����: ����ڰ� ������ ��ü ���� �� ���� ���ν��� ����
/* CREATE SESSION(DB�� ������ �� �ִ� ����), CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE */

-- �ý��� ������ Ư�� ����ڳ� ��� ����ڿ��� �ο� ����
/* (����) query rewrite �ý��� ������ scott�� ��� ����ڿ��� �ο��ϱ�(�Լ� ��� �ε����� �����ϱ� ���� �ʿ��� ����)
conn system/manager
grant query rewrite to scott;
grant query rewrite to public;
conn scott/tiger
select * from user_sys_privs;
*/
-- SESSION_PRIVS : ���� ���ǿ��� ����ڿ� �ѿ� �ο��� �ý��� ���� ��ȸ ����.

-- �ý��� ���� öȸ : revoke query rewrite from scott;


-- ��ü ���� �ο� ����
/*  CREATE USER tiger IDENTIFIED BY tiger123 -- USER ����
    DEFAULT TABLESPACE users -- �⺻ TABLESPACE
    TEMPORARY TABLESPACE temp; -- �ӽ� TABLESPACE

    GRANT connect, resource TO tiger; -- ���� ����, ���̺� ���� ����
    
    CONNECT scott/tiger
    GRANT SELECT ON scott.salgrade TO tiger; -- tiger���� �ڽ��� salgrade table�� ���� SELECT ������ �ο���
    
    CONNECT tiger/tiger123
    SELECT * FROM scott.salgrade; -- tiger�� �����Ͽ� scott�� salgrade table�� ���� select�� ����, ������ �����Ƿ� ���� �۵�.
    
    UPDATE scott.salgrade
    SET hisal = 9000
    WHERE grade = 5; -- tiger�� �����Ͽ� scott�� salgrade table�� ���� update�� ����, ������ �����Ƿ� ���� �Ұ�(insufficient privileges)
    
    CONNECT scott/tiger
    GRANT UPDATE(hisal) ON salgrade TO tiger; -- salgrade ���̺� �� 'hisal'�� ����(UPDATE)�� �� �ִ� ������ �ο���.
    
    UPDATE scott.salgrade
    SET hisal = 9000
    WHERE grade = 5; -- tiger�� �����Ͽ� scott�� salgrade table�� 'hisal'�� ���� update�� ����, ������ �����Ƿ� ���� �۵�
    
    UPDATE scott.salgrade
    SET losal = 1000
    WHERE grade = 1; -- tiger�� �����Ͽ� scott�� salgrade table�� 'losal'�� ���� update�� ����, ������ �����Ƿ� ���� �Ұ���(insufficient privileges)
    
    conn tiger/tiger123
    
    select * from user_tab_privs_made; -- �ڽ��� Ÿ�ο��� �ο��� ��ü ������ ��ȸ
    select * from user_tab_privs_recd; -- �ڽ��� Ÿ�ο��� ���� ��ü ������ ��ȸ
    select * from user_col_privs_made; -- Į���� ���� ����
    select * from user_col_privs_recd;
    
    -- ��ü ���� öȸ
    conn scott/tiger
    REVOKE UPDATE ON salgrade FROM tiger; -- tiger�κ��� salgrade�� ���� update ���� ȸ��
    REVOKE SELECT ON salgrade FROM tiger; -- select ���� ȸ��
    REVOKE DELETE ON salgrade FROM tiger; -- ������ ���� ���� ȸ���Ϸ��� �ϸ� �����޽��� �� (cannot REVOKE privileges you did not grant)
    
    conn tiger/tiger123
    select * from scott.salgrade; -- ������ ȸ�����߱� ������ ���� �Ұ���
*/

-- Quiz-07-05
-- 6. �а��� �ִ�Ű�� ���ϰ� �ִ�Ű�� ���� �л��� �а���, �ִ�Ű, �̸�, Ű�� ����ϼ���
select d.dname "�а���", m.max_height "�ִ�Ű", s.name "�̸�", s.height "Ű"
from (select deptno, max(height) max_height
from student
group by deptno) m, student s, department d
WHERE d.deptno = s.deptno AND s.height = m.max_height;

-- �� : �ټ� ����ڿ� �پ��� ������ ȿ�������� �����ϱ� ����, ���� ���õ� ������ '�׷�ȭ'�� ����.
-- Ȱ��ȭ/��Ȱ��ȭ ���, ��ȣ �ο� ���, ���� ���� ����, �ڽſ� ���� �� �ο��� ��ȯ�� �ο� �Ұ���(�����ڰ� �ؾ���), ���� Ư�� �����ڳ� ��ü�� ������ ����
-- ������ ���ǵ� ��: connect, resource, dba. ����) SQL> GRANT connect, resource TO tiger; -- ���� ����, ���̺� ���� ����
-- connect: alter session, create [cluster, database link, sequence, session, synonym, table, view], DB�� ������ ���� & ��ü�� ������ �� �ִ� ����
-- resource: create [cluster, procedure, sequence, table, trigger], �� �پ��� ��ü�� ������ �� �ִ� ����
-- dba: with admin option �ִ� ��� ����, �ý��� �ڿ��� ���������� ����̳� �ý��� ������ �ʿ��� ��� �������� DBA ������ �ٸ� ������� �ο��� �� �ִ�.

-- ������ ���ǵ����� ����, ����� ���� ��
-- CREATE ROLE role [NOT IDENTIFIED | IDENTIFIED] { BY password | EXTERNALLY }
/*
SQL> conn system/manager
Connected.
SQL> CREATE ROLE hr_clerk;

Role created.

SQL> CREATE ROLE hr_mgr
  2  IDENTIFIED BY manager; -- 'manager'��� �н����� ����

Role created.
*/
-- �ѿ� ���� �Ǵ� �� �ο�
-- GRANT role TO {user | role | public} ...
/*
SQL> GRANT create session TO hr_mgr;

Grant succeeded.

SQL> GRANT select, insert, delete ON hr.student TO hr_clerk;

Grant succeeded.

SQL> grant hr_clerk to hr_mgr; -- �ѿ��� �� �ο�

Grant succeeded.

SQL> grant hr_clerk to tiger; -- ����ڿ��� �� �ο�

Grant succeeded.

*/
-- role_sys_privs: �ѿ� �ο��� �ý��� ���� ��ȸ
select * from role_sys_privs;

-- role_tab_privs, user_role_privs : �ѿ� �ο��� �ý��� ���� ��ȸ
select * from role_tab_privs;
select * from user_role_privs;

/*
SQL> conn tiger/tiger123;

SQL> select * from role_tab_privs;

ROLE                 OWNER                TABLE_NAME           COLUMN_NAME          PRIVILEGE            GRANTA
-------------------- -------------------- -------------------- -------------------- -------------------- ------
HR_CLERK             HR                   STUDENT                                   INSERT               NO
HR_CLERK             HR                   STUDENT                                   DELETE               NO
HR_CLERK             HR                   STUDENT                                   SELECT               NO

SQL> select * from user_role_privs;

USERNAME             GRANTED_ROLE                                                 ADMIN_ DEFAUL OS_GRA
-------------------- ------------------------------------------------------------ ------ ------ ------
TIGER                CONNECT                                                      NO     YES    NO
TIGER                HR_CLERK                                                     NO     YES    NO
TIGER                RESOURCE                                                     NO     YES    NO
*/

-- ���Ǿ�: �ϳ��� ��ü�� ���� �ٸ� �̸��� �����ϴ� �������, �����ͺ��̽� ��ü���� ����Ѵ�.
-- ���� ���Ǿ�, ���� ���Ǿ�
-- CREATE [public] SYNONYM [schema.]synonym_name FOR [schema.]object;
/*
SQL> conn system/manager
Connected.
SQL> create table project(
  2  project_id number(5) constraint pro_id_pk primary key,
  3  project_name varchar2(100),
  4  studno number(5),
  5  profno number(5));

Table created.

SQL> insert into project values(12345, 'portfolio', 10101, 9901);

1 row created.

SQL> col project_name format a20; -- project_name ĭ�� ����ġ�� Ŀ�� ������
SQL> select * from project;

PROJECT_ID PROJECT_NAME             STUDNO     PROFNO
---------- -------------------- ---------- ----------
     12345 portfolio                 10101       9901

SQL> GRANT select on project to scott;

Grant succeeded.

SQL> show user
USER is "SYSTEM"

SQL> conn scott/tiger;
Connected.
SQL> select * from system.project;

PROJECT_ID PROJECT_NAME             STUDNO     PROFNO
---------- -------------------- ---------- ----------
     12345 portfolio                 10101       9901
     
SQL> create synonym my_project for system.project;
create synonym my_project for system.project
*
ERROR at line 1:
ORA-01031: insufficient privileges

SQL> conn system/manager
Connected.
SQL> GRANT create synonym to scott;
-- scott���� ������ ���� synonym�� ���� �� �����Ƿ�, system���� �� ������ �ο�����
Grant succeeded.

SQL> conn scott/tiger
Connected.
SQL> create synonym my_project for system.project;

Synonym created.
-- ���Ǿ� ���� �Ϸ�
SQL> select * from my_project;

PROJECT_ID PROJECT_NAME             STUDNO     PROFNO
---------- -------------------- ---------- ----------
     12345 portfolio                 10101       9901

*/

-- ��� ����: system ������� project ���̺� ���� ���� ���Ǿ �����Ͽ���.
/*
SQL> conn system/manager;
Connected.
SQL> CREATE PUBLIC SYNONYM pub_project FOR project;
-- pub_project��� ���� ���Ǿ �����Ͽ���.
Synonym created.

SQL> conn tiger/tiger123;
Connected.
SQL> SELECT * FROM pub_project;
SELECT * FROM pub_project -- �̴� ��ǻ� ���� ��ɹ��� ����: SELECT * FROM system.project;
              *
ERROR at line 1:
ORA-00942: table or view does not exist
-- tiger���Դ� pub_project(system.project)�� ���� ���� ������ ���� ������ ���� �Ұ���

SQL> conn scott/tiger;
Connected.
SQL> SELECT * FROM pub_project;

PROJECT_ID PROJECT_NAME             STUDNO     PROFNO
---------- -------------------- ---------- ----------
     12345 portfolio                 10101       9901

-- scott ����ڰ� ������ ���Ǿ �������� �ʾƵ�, ���� ���Ǿ ���� system������ project ���̺��� ��ȸ�Ѵ�.
*/
-- ���Ǿ� ����: DROP SYNONYM synonym_name;
/*
SQL> conn scott/tiger
Connected.
SQL> drop synonym my_project;

Synonym dropped.

SQL> DROP synonym pub_project;
DROP synonym pub_project
             *
ERROR at line 1:
ORA-01434: private synonym to be dropped does not exist -- pub_project��� ���Ǿ "public"�̱� ������ �Ժη� ���� �Ұ�, ���� ���Ǿ�(-private synonym)�� ���� ����

SQL> DROP PUBLIC synonym pub_project; -- "public"�� �ٿ� ���� ���Ǿ�(-public synonym)�� ��Ȯ�ϰ� �����Ѵ�.

Synonym dropped.
*/