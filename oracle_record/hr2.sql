-- 데이터 조작어(DML: Insert, Update, Delete, Merge, Commit, Rollback)
-- 데이터를 입력, 수정, 삭제하기 위한 명령어
-- 트랜잭션: 여러 개의 명령문을 하나의 논리적인 작업단위로 처리하는 기능, 하드디스크에 온전히 기록한다.

-- 데이터 입력: INSERT, 단일-다중 행 입력. INTO 절에 칼럼을 명시하지 않으면, 테이블 생성 시 정의한 칼럼 순서와 동일한 순서로 입력해야 한다.
/* CHAR, VARCHAR, DATE 타입은 '_'으로 묶어서 입력할 것
INSERT INTO table [columns] VALUES [values]
*/
DESC student; -- 데이터 입력 전 테이블의 칼럼이름, 순서, 제약조건, 데이터타입을 확인한다.
-- (studno, name, userid, grade, idnum, birthdate, tel, height, weight, deptno, profno) --
INSERT INTO student VALUES(10110, '홍길동', 'hong', '1', '8501011143098', '85/01/01', '041)630-3114', 170,70,101,9903);

SELECT * FROM student; -- 데이터가 들어갔는지 확인, '홍길동'이 입력된 것을 볼 수 있다.

-- NULL 값 (명시적으로) 입력하기 : VALUES에 NULL이나 '' 사용
-- 묵시적으로 NULL을 입력하는 경우(값을 입력 안하면 된다)
INSERT ALL 
INTO department(deptno, dname) VALUES (400, '철학과')
INTO department(deptno, dname) VALUES (401, '심리학과')
SELECT * FROM DUAL;

COMMIT; -- commit으로 기록하기

SELECT * FROM department; -- 생명공학부 입력 확인용, college-loc가 null로 되어있다.

-- 명시적으로 NULL을 입력하는 경우
INSERT INTO department
VALUES (301, '환경보건학과', '', NULL); -- 환경보건학과 입력 확인용, 위와 같이 college-loc가 null로 되어있다.

-- 날짜 데이터 입력 방법: UNIX 'DD-MONTH-YY', ORACLE 'YY/MM/DD', TO_DATE 함수로 알맞은 값을 넣을 수 있다.
INSERT INTO professor(profno, name, position, hiredate, deptno)
VALUES (9920, '최윤식', '조교수', TO_DATE('2006/01/01', 'YYYY/MM/DD'), 102);

SELECT * FROM professor;

-- SYSDATE로 현재 날짜를 넣을 수 있다.
INSERT INTO professor VALUES (9910, '백미선', 'white', '전임강사', 200, SYSDATE, 10, 101);

-- 다중 행 입력: INSERT ALL 이후 "INTO t VALUES v"를 반복해서 다중 행 입력을 해도 되고, 서브쿼리의 결과 집합으로부터 다중 행을 넣을 수도 있다.
-- 서브쿼리 이용한 다중 행 입력: INSERT INTO t(cols) subquery;

-- 테이블의 데이터를 복사할 경우
CREATE TABLE T_STUDENT
AS SELECT * FROM STUDENT
WHERE 1=0; -- 테이블의 프레임(column)만 복사함, WHERE절 없으면 데이터까지 바로 복사함

INSERT INTO T_STUDENT
SELECT * FROM student; -- 테이블의 내용을 복사함(사실 서브쿼리를 이용한 다중 행 입력에 가깝다.)

select * FROM t_student;
select * from student;

-- INSERT ALL, subquery를 이용한.
-- 다중 행 입력을 위한 height_info, weight_info 예제 테이블 생성
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
SELECT studno, name, height, weight -- 서브쿼리로부터 studno, name, height, weight 데이터를 받아서 위의 values에 대입하여 각각 집어넣는다.
FROM student
WHERE grade >= '2';

SELECT * FROM height_info;
SELECT * FROM weight_info;
delete from height_info;
delete from weight_info;
-- Conditional INSERT ALL: WHEN~THEN~ELSE 조건절에서 지정한 조건을 만족하는 행을 해당되는 테이블에 각각 입력.
-- DELETE 테이블의 데이터를 삭제, WHERE 절이 없으므로 모든 데이터를 삭제한다.
DELETE FROM height_info;
DELETE FROM weight_info;

/* 학생 테이블에서 2학년 이상의 학생을 검색하여 height_info 테이블에는 키가 170보다 큰 학생의 학번, 이름, 키를 입력하고
weight_info 테이블에는 몸무게가 70보다 큰 학생의 학번, 이름, 몸무게를 각각 입력하여라.
*/
INSERT ALL
WHEN height > 170 THEN
    INTO height_info values (studno, name, height)
WHEN weight > 70 THEN
    INTO weight_info values (studno, name, weight)
SELECT studno, name, height, weight -- 서브쿼리로부터 studno, name, height, weight 데이터를 받아서 위의 values에 대입하여 각각 집어넣는다.
FROM student
WHERE grade >= '2';
-- WHEN~THEN~WHEN~THEN~ELSE문에서, 모든 WHEN 조건절에 속하지 않으면 ELSE 절에 속하게 된다.
select * from height_info;
select * from weight_info;

/* Conditional INSERT FIRST: 서브쿼리의 결과 집합에 대해 WHEN 조건절에서 지정한 조건을 만족하는 첫번째 테이블에 우선적으로 입력하기 위한 명령문이다.
서브쿼리의 결과 집합중에서 조건을 만족하는 첫 번째 WHEN절에서 지정한 테이블에만 입력하고, 그 외의 결과집합에서 나머지 WHEN절에 조건이 만족하면 첫번째 조건에
INSERT한 행을 제외하고 INSERT, 마지막에는 ELSE절에 정의된 TABLE에 INSERT
... 파이썬의 if - if 문이 conditional insert all, if - elif가 conditional insert first 취급. */
DELETE FROM height_info;
DELETE FROM weight_info;

INSERT FIRST
WHEN height > 170 THEN
    INTO height_info values (studno, name, height)
WHEN weight > 70 THEN
    INTO weight_info values (studno, name, weight)
SELECT studno, name, height, weight -- 서브쿼리로부터 studno, name, height, weight 데이터를 받아서 위의 values에 대입하여 각각 집어넣는다.
FROM student
WHERE grade >= '2';

select * from height_info;
select * from weight_info; -- height_info 조건절에 속하는 3개의 row가 적용이 안되어 2개의 row가 된 것을 볼 수 있다.

-- PIVOTING INSERT: 하나의 행을 여러 개의 행으로 나누어서 입력하는 기능(= Unconditional INSERT ALL), 단 INTO절에서 하나의 테이블만 지정한다.
-- OLTP(Online Transaction Processing) 업무에서 주로 사용한다.
-- 예시: 5개의 칼럼으로 구성된 요일별 판매 실적 데이터를 하나의 칼럼으로 통합할 때 하나의 칼럼으로 통합된 판매 데이터의 요일을 구분하기 위해 오일 구분 칼럼 추가
CREATE TABLE sales( -- pivoting insert 실습을 위한 예제 테이블
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
-- sales_mon ~ _fri에 각각 12345라는 pivoting 수행
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

-- 데이터 수정(UPDATE) : UPDATE t SET col1=value1, col2=value2... WHERE condition
-- 교수 번호가 9903인 교수의 현재 직급을 부교수로 수정하여라.
select * from professor where profno = '9903';
UPDATE professor SET position='부교수' WHERE profno = '9903';

/* 서브쿼리를 이용한 데이터 수정: UPDATE 명령문의 SET절에서 서브쿼리를 이용, 다른 테이블에 저장된 데이터를 검색해 한꺼번에 여러 칼럼을 수정
 SET절의 칼럼 이름은 서브쿼리의 칼럼 이름과 달라도 된다. 단, 데이터 타입과 칼럼 수는 반드시 일치시켜야 한다.
    UPDATE table1
    SET (col1, col2, ...) = (SELECT s_c1, s_c2, ... FROM table2 WHERE ...) 
    WHERE ...
 */
 -- 서브쿼리를 이용하여 '학번이 10201'인 학생의 '학년과 학과 번호'를 '10103학번' 학생의 '학년과 학과 번호'와 동일하게 수정하여라.
UPDATE student
SET (grade, deptno) = (
    SELECT grade, deptno
    FROM student
    WHERE studno = 10103) -- 서브쿼리로 10103 학번 학생의 학년과 학과 번호 정보를 가져온다.
WHERE studno = 10201;

select * from student where studno = 10201 or studno = 10103;

-- Q. 교수 테이블에서 이만식 교수의 직급과 동일 직급을 가진 교수들 중 현재 급여가 450이 안 되는 교수들의 급여를 12% 인상하세요.
select * from professor;

UPDATE professor
SET sal = sal*1.12
WHERE position = (
            SELECT position
            FROM professor
            WHERE name='이만식')
AND sal < 450;

-- 데이터 삭제(DELETE FROM TABLE WHERE ~~~)
-- 학생 테이블에서 학번이 20103인 학생의 데이터를 삭제하여라.
DELETE FROM student WHERE studno = 20103;

select * from student;
rollback;
commit;
-- 서브쿼리를 이용한 데이터 삭제
/*  DELETE FROM table
    WHERE (col1, col2, ...) = (SELECT s_c1, s_c2, ... FROM table2 WHERE ~);
*/
-- 학생 테이블에서 컴퓨터공학과에 소속된 학생을 모두 삭제하여라.
DELETE FROM student
WHERE deptno = (SELECT deptno
                FROM department
                WHERE dname = '컴퓨터공학과');

SELECT *
FROM student
WHERE deptno = (SELECT deptno
                FROM department
                WHERE dname = '컴퓨터공학과');
-- 컴퓨터공학과 학생 데이터가 모두 삭제됨
rollback;

-- 사원테이블에서 'CHICAGO'에서 근무하는 사원들을 모두 삭제하세요(EMP, DEPT)
DELETE FROM EMP
WHERE deptno = (SELECT DEPTNO FROM DEPT WHERE LOC = 'CHICAGO');

select * from emp;

/* MERGE: 구조가 같은 두 테이블을 비교하여 하나의 테이블로 합치기 위한 데이터 조작어, WHEN 절의 조건절에서 결과 테이블에 해당 행이 존재하면
 UPDATE 명령문으로 인해 새로운 값으로 수정, 그렇지 않으면 INSERT 명령문으로 새로운 행을 삽입한다.  대량의 데이터 분석하기 위한 업무에 유용하다. */
 /*
 MERGE INTO [table] [alias]             -> 하나의 테이블로 합치기 위한 결과 테이블
 USING [table | view | subquery] alias  -> 테이블, 뷰, 서브쿼리에 대한 별명 지정, WHEN 절에서 지정한 별명 사용해야함
 ON [join condition]                    -> 조인 조건 지정
 WHEN MATCHED THEN                      -> 절의 조인 조건을 만족하면 지정된 값으로 행 update
    UPDATE SET .....        
 WHEN NOT MATCHED THEN                  -> 만족 안하면 새로운 행으로 INSERT
    INSERT INTO ......
    VALUES ......; 
 */

CREATE TABLE professor_temp AS
    SELECT *
    FROM professor
    WHERE position = '교수';
    
SELECT * FROM professor_temp; -- POSITION이 교수인 사람에 대해서 professor_temp 테이블을 생성함

UPDATE professor_temp
SET position = '명예교수'
WHERE position = '교수';

SELECT * FROM professor_temp; -- professor_temp 테이블의 교수 직급을 명예교수로 수정함

INSERT INTO professor_temp
VALUES(9999, '김도경', 'arom21', '전임강사', 200, SYSDATE, 10, 101); -- 새로운 데이터 입력

SELECT * FROM professor; -- 교수 직급 그대로, 전임강사 '김도경'씨 없음

MERGE INTO professor p -- professor 테이블에 병합 정의 및 별명 지정
USING professor_temp f -- professor_temp이 별명 지정
ON (p.profno = f.profno) -- 조인 조건(EQUI JOIN) 지정
WHEN MATCHED THEN
    UPDATE SET p.position = f.position -- MATCH(조인 조건이 맞는 경우=교수)일 때 p.position을 f.position으로 update
WHEN NOT MATCHED THEN
    INSERT values(f.profno, f.name, f.userid, f.position, f.sal, f.hiredate, f.comm, f.deptno); -- NOT MATCH(김도경)일 때, f.position을 p에 INSERT

SELECT * FROM professor; -- 교수 -> 명예교수, 전임강사 '김도경'씨 UPDATE

-- 트랜잭션 관리 : commit(변경 내역 디스크에 저장하고 트랜잭션 종료), rollback(작업 내용 및 트랜잭션 전체 취소하고 트랜잭션 종료)

-- 시퀀스 : 유일한 식별자, 기본 키 값을 자동으로 생성하기 위해 일련번호 생성하는 객체
/*
CREATE SEQUENCE seq     -> 시퀀스의 이름 지정
[INCREMENT BY n]        -> 시퀀스 번호의 증가치
[START WITH n]          -> 시퀀스 시작번호, 기본값은 1
[MAXVALUE n]            -> 생성 가능한 시퀀스의 최댓값
[MINVALUE n]            -> cycle 설정하면, MAXVALUE->MINVALUE나 MINVALUE->MAXVALUE로 사이클을 돈다
[CYCLE]                 -> 시퀀스 순환 여부
[CACHE n]               -> 시퀀스 생성 속도 개선을 위해 메모리에 캐쉬하는 시퀀스의 개수, 기본값은 20
*/
CREATE SEQUENCE s_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 100;

SELECT min_value, max_value, increment_by, last_number
FROM user_sequences
WHERE sequence_name = 'S_SEQ';

-- CURRVAL : 시퀀스에서 생성된 현재 번호, NEXTVAL: 시퀀스에서 다음 번호 생성
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
FROM DUAL; -- 이거 수행해도 다음 시퀀스로 넘어가므로 주의

SELECT * FROM USER_SEQUENCES; -- USER가 정의한 시퀀스를 시스템이 관리해줌(Data Dictionary)
SELECT min_value, max_value, increment_by, last_number
FROM user_sequences
WHERE sequence_name = 'S_SEQ';

-- 시퀀스를 이용한 기본 키 생성: NEXTVAL 함수로 기본키를 정의할 수 있다.
-- ALTER로 시퀀스 정의 변경 가능
/*
ALTER SEQUENCE seq [INCREMENT BY n] [] [] []... : SEQUENCE 생성할 때와 같다.
*/
ALTER SEQUENCE S_SEQ MAXVALUE 2000;
-- SEQUENCE 삭제: DROP SEQUENCE seq;
DROP SEQUENCE S_SEQ;

-- //// 테이블 관리 //// --

-- 1. 데이터베이스 응용 프로젝트 개발
/* 테이블 생성 시 유의사항: 문자로 시작, 30자 이내, 숫자와 특수문자(_$#) 사용 가능, 대소문자 구별 없음,
서로 다른 테이블에서 동일한 데이터를 저장하는 칼럼 이름은 가능하면 같은 이름을 사용할 것(조인할 때 편하게) */
/* CREATE TABLE [schema] table           -> SCHEMA : 데이터베이스 사용자 계정과 같은 의미
 ( column1 datatype [DEFAULT expr] [column_constraint(제약조건)]
    ........ )*/
CREATE TABLE address
(id     number(3),
name    varchar2(50),
addr    varchar2(100),
phone   varchar2(30),
email   varchar2(100)
);
SELECT * FROM tab; -- 테이블 생성 확인
DESC address; -- 테이블 구조 확인

-- DEFAULT 옵션: 입력값이 생략될 경우, NULL 대신에 입력되는 기본 값.
-- 예) addr varchar2(100) DEFAULT 'KOREA' -> addr에 값을 안넣으면 'KOREA'가 자동으로 입력됨

-- 서브쿼리를 이용한 테이블 생성: 서브쿼리로부터 타 테이블의 구조 및 데이터를 복사해 새로운 테이블 생성 가능
-- 단, 칼럼 이름을 명시하지 않으면 서브쿼리 칼럼 이름과 동일하게 생성됨. 
-- 무결성 제약조건은 NOT NULL만 복사. 디폴트 옵션 정의 값은 그대로 복사함.
INSERT INTO address VALUES(1, 'HGDONG', 'SEOUL','123-4567', 'gdhong@abcd.ac.kr');
INSERT INTO address VALUES(2, 'KCsu', 'JEJU','133-5779', 'kcsu@efgh.ac.kr');
SELECT * FROM address;

CREATE TABLE addr_second(id2, name2, addr2, phone2, email2)
AS SELECT * FROM address; -- column 이름을 내 마음대로 정의할 수 있다.

DESC addr_second;
SELECT * FROM addr_second; -- addr 테이블의 내용이 그대로 복사되었다. 데이터 복사 없이 '테이블의 프레임만 복사'하려면 WHERE 0=1;같은 조건절을 붙이면 된다.

CREATE TABLE addr_third(id, name)
AS SELECT id2, name2 FROM addr_second
WHERE 0=1;

SELECT * FROM addr_third; -- 구조만 복사되었다.

-- 테이블 구조 변경(칼럼 추가): ALTER TABLE t_name ~ ADD (col_name datatype ...)
-- 주소록 테이블에 날짜 타입을 가지는 bitrh 칼럼을 추가하여라.
ALTER TABLE address
ADD (birth DATE);

ALTER TABLE address
ADD(comments VARCHAR2(100) DEFAULT 'NO Comment');

DESC address; -- birth, comments라는 칼럼이 추가되었다.

-- 테이블 구조 변경(칼럼 삭제): ALTER TABLE t_name DROP COLUMN col_name;
-- 주소록 테이블의 칼럼 'comments'를 삭제하여라
ALTER TABLE address DROP COLUMN comments;

/* 테이블 구조 변경(칼럼 변경)
기존 칼럼에 데이터가 없는 경우 칼럼 타입이나 크기 변경이 자유로우나, 기존 칼럼에 데이터가 있다면 다음 제한을 준수하여야 한다.
1. 타입 변경은 CHAR와 VARCHAR2만 허용한다.
2. 변경한 칼럼의 크기가 저장된 데이터의 크기보다 같거나 클 경우 변경이 가능하다
3. 숫자 타입에서는 정밀도 증가가 가능하다(정밀도를 떨어뜨리는 것은 불가능: 예-실수형 데이터가 있는데 정수형으로 강제로 변경하려는 경우)
ALTER TABLE t_name
MODIFY (col_name datatype ...);
*/
-- 주소록 테이블에서 phone 칼럼의 데이터 타입 크기를 50으로 증가시켜라
ALTER TABLE address
MODIFY phone VARCHAR2(50);

-- 테이블 이름 변경: RENAME 명령문 사용: RENAME old_table_name TO new_table_name
-- addr_second 테이블 이름을 client_address로 변경하여라.
RENAME addr_second TO client_address;
SELECT * FROM tab; -- addr_second 테이블이 client_address로 바뀐 것을 확인할 수 있다.

-- 테이블 삭제 : DROP TABLE table_name [cascade constraints], 다른 테이블에서 참조하는 테이블을 삭제하려는 경우에는 함부로 삭제를 하기가 어렵다.
-- addr_third 테이블을 삭제하여라.
DROP TABLE addr_third;
SELECT * FROM tab; -- addr_third 테이블이 삭제된 것을 확인할 수 있다.

-- TRUNCATE 명령문: 테이블 구조는 유지, 데이터와 할당된 공간만 삭제.
-- DELETE 명령문과의 차이: WHERE절을 통해 특정 행만 삭제하는 것이 불가능, DDL문으로써 물리적 공간까지 반환하는 거라 ROLLBACK 불가능
TRUNCATE TABLE client_address; -- '삭제되었습니다'가 아니라 '잘렸습니다'라고 뜬다.
rollback; -- 안의 데이터는 복원이 되지 않음. 구조가 삭제되는 건 아님(그건 DROP)
SELECT * FROM client_address;

-- DELETE, DROP & CREATE, TRUNCATE를 비교.
/*
|구분     |테이블정의|저장공간 |데이터|작업속도|SQL종류|
|DELETE  |존재     |유지    |삭제  |느림   |DML   |
|TRUNCATE|존재     |반납    |삭제  |빠름   |DDL   |
|DROP    |삭제     |반납    |삭제  |빠름   |DDL   |
*/
-- Quiz_07-04
-- 1. 교수 테이블에서 교수 번호, 교수 이름으로 구성된 테이블 PROF1, PROF2를 생성해보세요.
CREATE TABLE PROF1(profno, prof_name)
AS (SELECT profno, name FROM professor WHERE 0=1);
CREATE TABLE PROF2(profno, prof_name)
AS (SELECT profno, name FROM professor WHERE 0=1);

/* 2. 교수 테이블에서 교수 번호가 9901 ~ 9905까지인 교수의 교수번호와 이름은 prof1 테이블에 입력하고,
 교수번호가 9906 ~ 9920까지인 교수의 교수번호와 이름은 prof2 테이블에 입력해보세요. */ 
INSERT INTO PROF1
(SELECT profno, name
 FROM professor
 WHERE profno BETWEEN 9901 AND 9905);
INSERT INTO PROF2
(SELECT profno, name
    FROM professor
    WHERE profno BETWEEN 9906 AND 9920);


/* 3. 각 학과별로 입사일이 가장 오래된 교수의 교수번호와 이름, 입사일, 학과명을 출력하세요. 단, 입사일 순으로 정렬하시오. */
SELECT profno, name, hiredate, d.dname
FROM professor p, department d
WHERE (p.deptno, hiredate) IN (SELECT deptno, MIN(HIREDATE)
                            FROM professor
                            GROUP BY deptno)
AND p.deptno = d.deptno
ORDER BY HIREDATE;

/* 4. 학생 테이블에서 학번이 20000에서 25000번에 해당하는 학생들을 삭제하시오.*/
DELETE FROM student
WHERE studno BETWEEN 20000 AND 25000;

/* 5. EMPNO, ENAME 그리고 DEPTNO 열만을 포함하는 EMP 테이블의 구조를 기초로 EMPLOYEE2 테이블을 생성하시오.
새 테이블에서 ID, LAST_NAME, DEPT_ID로 열 이름을 지정하시오. */
CREATE TABLE EMPLOYEE2(ID, LAST_NAME, DEPT_ID)
AS  (SELECT empno, ename, deptno
    FROM emp);
/* 6. 5에서 생성한 EMPLOYEE2 테이블에서 LAST_NAME 필드를 10 ---> 30으로 변경하세요. */
ALTER TABLE employee2
MODIFY last_name varchar2(30);

-- 주석 추가
-- 테이블이나 칼럼에 최대 2000바이트까지 주석을 추가. COMMENT ON TABLE ... IS 명령문 이용.
-- 추가된 주석을 확인하기 위해서는 ALL_COL_COMMENTS, USER_COL_COMMENTS, ALL_TAB_COMMENTS 데이터 사전에 질의
COMMENT ON TABLE address
IS '고객 주소록을 관리하기 위한 테이블';

COMMENT ON COLUMN address.name
IS '고객 이름';

SELECT * FROM ALL_COL_COMMENTS WHERE table_name = 'ADDRESS'; -- 컬럼에 설정된 모든 주석(시스템 + 유저)이 출력된다.
SELECT * FROM USER_COL_COMMENTS WHERE table_name = 'ADDRESS'; -- 유저가 컬럼에 정의한 주석이 출력된다.
SELECT * FROM ALL_TAB_COMMENTS WHERE table_name = 'ADDRESS'; -- 모든 테이블 및 뷰에 정의된 주석이 출력된다.
-- 주석을 설정하지 않은 column에는 comment가 NULL인것을 볼 수 있다.

COMMENT ON TABLE ADDRESS IS ''; -- 테이블 주석 삭제
COMMENT ON COLUMN ADDRESS.NAME IS ''; -- 컬럼 주석 삭제

/*-----------------------------------------------*/
-- 데이터 사전(Data Dictionary): DB 관리를 효율적으로 하기 위한 정보가 저장되는 테이블로, 일반적으로 읽기 전용 뷰에 의해 데이터 사전의 내용을 조회만 할 수 있다.
-- 실무에서는 테이블, 칼럼, 뷰 등과 같은 정보를 조회하기 위해 사용한다.
/* 데이터 사전에서 관리하는 정보: DB의 물리적-논리적 구조, 사용자 이름, 스키마 객체 이름, 접근 권한, 무결성 제약조건, 칼럼별 기본값(DEFAULT), 할당된(사용중인) 공간 크기,
객체 접근 및 갱신에 대한 감사(기록) 정보, DB 이름, 버전, 생성날짜, 시작모드, 인스턴스 이름 정보 등등...
- 다수의 사용자가 동일한 데이터를 공유
- 읽기 전용 뷰로 구성됨
- 데이터베이스 관리자나 사용자에게 데이터 사전에 저장된 정보 조회를 허용
- 용도에 따라 USER_(객체 소유자만 접근 가능), ALL_('권한'을 부여받은 객체만 접근 가능), DBA_(DB 관리자만 접근 가능)로 나뉨
*/
-- USER_: '일반 사용자'와 가장 밀접하게 관련된 뷰로 자신이 생성한 테이블, 인덱스, 뷰, 동의어 등 객체나 해당 사용자에게 부여된 권한 정보를 조회
SELECT table_name FROM user_tables; -- 사용자가 소유한 테이블의 정보를 조회
-- ALL_: 데이터베이스 전체 사용자와 관련된 뷰로, OWNER 칼럼이 존재한다. 또한 (사용자가) 접근할 수 있는 모든 객체에 대한 정보를 조회할 수 있다.
SELECT owner, table_name FROM all_tables; -- 자기 소유 or 권한을 부여받는 테이블에 대한 정보를 조회할 수 있다. SYS, SYSTEM 등등 OWNER를 확인할 수 있다.
-- DBA_: 시스템 관리와 관련된 뷰로, DBA나 SELECT ANY TABLE 시스템 권한을 가진 사용자로, 사용자 접근 권한 및 데이터베이스 자원관리에 목적을 준다.
SELECT owner, table_name FROM dba_tables; -- 지금은 유저 'hr' 상태이기 때문에 이건 실행 불가능하다.
-- "conn system/manager"으로 DB 관리자로 로그인 한 뒤에 위를 실행할 수 있다.

/* 데이터 사전의 종류
dictionary, dict_columns : 데이터 사전 테이블, 뷰, 칼럼에 대한 정보
dba_tables, dba_objects, dba_tab_columns, dba_constraints : 테이블, 제약조건, 칼럼, 사용자 객체와 관련된 정보
dba_users, dba_sys_privs, dba_roles : 사용자 권한과 롤에 관한 정보
dba_extents, dba_free_space, dba_segments : 데이터베이스 객체에 대한 공간 할당 정보
dba_rollback_segs, dba_data_files, dba_tablespaces : 데이터베이스 내부 공간의 구조 정보
dba_audit_trail, dba_audit_object, dba_obj_audit_opts : 감사(감시 및 기록)와 관련된 정보
이런게 있구나 하고 넘어가면 된다.
*/

/*-------------------------------------------------------------------------------------*/
-- 데이터 무결성 제약조건: 데이터의 정확성과 일관성을 보장하기 위해 적용되는 제약조건. 일종의 규칙
-- 예시: student 테이블에서 모든 학번은 유일(겹치면 안됨)하여야 한다. student 테이블의 profno는 professor 테이블의 교수번호에 해당해야 한다.
/* 무결성 제약조건 종류
NOT NULL(열이 NULL을 포함할 수 없음), 고유키(unique key, 겹치면 안됨), 기본키(primary key, 무조건 존재해야 하며 unique + not null의 형태),
 참조키(foreign key, 다른 테이블의 칼럼을 참조하는 키를 표현), CHECK(해당 칼럼에 저장 가능한 데이터 값의 '범위'나 '조건' 지정)

* 제약조건 생성 방법(테이블 생성할 때)
CREATE TABLE [schema_name.] table_name
(column datatype [DEFAULT] [col_constraints ...]
...);

* 무결성 제약조건 생성문에서의 키워드
- ON DELETE CASCADE(삭제를 연달아서 자식 테이블과 함께 삭제), USING INDEX(묵시적으로 생성되는 인덱스에 대한 파라미터 정의), NOT DEFERRABLE(DML 처리될 때마다 제약조건 위반 여부 검사),
DEFERRABLE(DML 명령문 제약조건 검사를 트랜잭션 종료 시까지 연기), INITIALLY IMMEDIATE(DML 명령문이 종료될 때마다 제약조건 검사), INITIALLY DEFFERED(트랜잭션이 끝날 때만 제약조건 검사)

* 예시
*/
CREATE TABLE subject
(subno NUMBER(5)
 CONSTRAINT subject_no_pk PRIMARY KEY -- 기본키 설정
 DEFERRABLE INITIALLY DEFERRED -- deferrable, initially deferred 키워드 설정, 트랜잭션 종료 때까지 DML 제약조건 검사를 미룬다는 뜻
 USING INDEX TABLESPACE INDX, -- tablespace의 INDX라는 인덱스를 사용하겠다는 의미
subname VARCHAR2(20)
    CONSTRAINT subject_name_nn NOT NULL, -- NOT NULL 설정
term VARCHAR2(1)
    CONSTRAINT subject_term_ck CHECK (term in ('1', '2')), -- CHECK 설정
type VARCHAR2(8));
-- tablespace 'INDX' does not exist, "tablespace '%s' does not exist" 에러 발생
-- 1. system 구매 -> 2. 구매한 os install -> 3. dbms 선택(oracle, mysql, ...) -> 4. create tablespace(데이터가 저장 될 물리적인 공간)
--> 5. create user -> 6. data backup and import OR create table -> 7. insert data

-- 위치: C:\oraclexe\app\oracle\oradata\XE (11g)에 tablespace 'indx'를 생성하는 방법(conn system/manager로 관리자로 로그인 필요)
/* SQL> create tablespace indx
        datafile 'C:\oraclexe\app\oracle\oradata\XE\indx.dbf' size 100m; */
-- 위의 방식으로 indx 생성한 뒤 위의 create 문을 실행하면 정상적으로 table 'subject'가 생성된다.

DESC subject;

ALTER TABLE student
ADD CONSTRAINT stud_no_pk PRIMARY KEY(studno); -- studno 칼럼에 기본키 제약조건을 추가한다

CREATE TABLE sugang
(studno NUMBER(5)
    CONSTRAINT sugang_studno_fk REFERENCES student(studno), -- 칼럼 레벨의 제약 조건
subno   NUMBER(5)
    CONSTRAINT sugang_subno_fk REFERENCES subject(subno), -- 칼럼 레벨의 제약 조건
regdate DATE,
result NUMBER(3),
    CONSTRAINT sugang_pk PRIMARY KEY(studno, subno)); -- 테이블 레벨의 제약 조건

-- USER_CONSTRAINTS 데이터 사전에서 무결성 제약조건 조회하기, C(check or NOT NULL), P(Primary key), U(Unique key), R(Foreign key)
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('SUBJECT', 'SUGANG');

-- 기존 테이블에 무결성 제약조건 추가
ALTER TABLE student
ADD CONSTRAINT stud_idnum_uk UNIQUE(idnum); -- NULL을 제외한 무결성 제약조건을 추가하려면 ADD CONSTRAINT 명령문을 사용한다.

ALTER TABLE student
MODIFY (name CONSTRAINT stud_name_nn NOT NULL); -- NOT NULL 무결성 추가하려면 MODIFY 명령문을 사용해야 한다.

ALTER TABLE student ADD CONSTRAINT stud_deptno_fk
FOREIGN KEY(deptno) REFERENCES department(deptno); -- department 테이블의 deptno 칼럼이 기본키 or 고유키 제약조건 없으면 외래키 정의시 오류
-- department의 deptno 칼럼에 기본키를 부여해보자.

desc department; -- deptno 칼럼에 기본키를 부여하니 NOT NULL이 표시되는 것을 볼 수 있다.
ALTER TABLE department ADD CONSTRAINT dep_deptno_pk PRIMARY KEY (deptno);
-- deptno 칼럼에 기본키를 부여하니 외래키 정의가 완료된다.

-- 실습 예시1: department 테이블의 dname에 not null 무결성 제약조건을 추가하여라.
ALTER TABLE department MODIFY (dname CONSTRAINT dname_nn NOT NULL);

-- 무결성 제약조건에 위반되는 insert를 한 경우
select * from department;
insert into department(deptno, dname) values(301, '보건학과'); -- deptno의 Unique 조건을 위반해서 입력이 안된다.
select * from department;
insert into department(deptno, dname) values(303, ''); -- dname의 NOT NULL 조건을 위반해서 입력이 안된다.

/* 실습 예시2: professor 테이블 인스턴스를 참조하여 profno에 기본키, name에 NOT NULL, deptno에 참조 무결성 제약조건을 추가하라.
이때, deptno는 department의 deptno를 참조한다. */
ALTER TABLE professor ADD CONSTRAINT profno_pk PRIMARY KEY (profno);
ALTER TABLE professor MODIFY (name CONSTRAINT pname_nn NOT NULL);
ALTER TABLE professor ADD CONSTRAINT prof_dept_fk FOREIGN KEY(deptno) REFERENCES department(deptno);
DESC professor;

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('DEPARTMENT', 'PROFESSOR');

-- 무결성 제약조건에 의한 DML 명령문의 영향
/*  - 즉시 제약조건에 위배: 테이블에 데이터를 먼저 입력한 다음 무결성 제약조건을 위반하는 명령문을 롤백
    - 지연 제약조건에 위배: 트랜잭션 내 DML 명령문에서 제약조건 검사를 commit 시점에서 한번에 처리해 트랜잭션의 처리 성능을 향상시키기 위해 사용
    -> 해설) 제약조건 DML 적용할때마다 검사하면 오래걸리니까, 한번에 뭉탱이로 검사해서 시간을 절약하자! */
insert into subject values(1, 'SQL', '1', '필수');

insert into subject values(2, '', '2', '필수'); -- subname의 not null 조건 위배
insert into subject values(3, 'java', '3', '선택'); -- term의 check 조건 위배

select * from subject;

-- 지연 제약조건(commit에서 제약조건 검사)
insert into subject values(4, 'database', '1', '필수'); -- 이걸 두번 반복
commit; -- 커밋 시 오류 발생, rollback 진행

select constraint_name, constraint_type, deferrable, deferred from user_constraints
where table_name = 'SUBJECT'; -- 각각 NOT DEFERRABLE와 (INITIALLY)IMMEDIATE가 디폴트 값이다.

-- 무결성 제약조건 삭제: ALTER TABLE table_name DROP CONSTRAINT constraint_name [CASCADE]; --> CASCADE는 삭제되는 칼럼을 참조하는 참조 무결성 제약조건도 함께 삭제한다.
--> 무슨 소리냐면, 특정 PK 제약조건을 삭제할 때 이 PK를 '참조'하는 무언가가 있다면 삭제가 안됨. CASCADE가 있어야 '참조'에 해당하는 제약조건을 같이 삭제해줌.
ALTER TABLE subject DROP CONSTRAINT subject_term_ck;
-- 확인
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('SUBJECT');

-- 무결성 제약조건 활성화 및 비활성화: 제약조건을 일시적으로 비활성화하려는 경우, 굳이 삭제 안하고 비활성화 하면 된다.
/*  ALTER TABLE table_name
    [DISABLE | ENABLE (+ NOVALIDATE)] CONSTRAINT constraint_name [CASCADE];
-- 위에서 NOVALIDATE : 기존 데이터에 대해서는 제약조건 적용하지 않고, 새로 들어오는(수정되는) 데이터에만 제약조건을 검사하게 한다. */
ALTER TABLE sugang
DISABLE CONSTRAINT sugang_pk;

ALTER TABLE sugang
DISABLE CONSTRAINT sugang_studno_fk;

SELECT constraint_name, constraint_type, status -- status는 ENABLED(활성화) / DISABLED(비활성화) 여부를 출력한다.
FROM user_constraints
WHERE table_name IN ('SUGANG');

ALTER TABLE sugang
ENABLE CONSTRAINT sugang_pk;

ALTER TABLE sugang
ENABLE CONSTRAINT sugang_studno_fk; -- STATUS가 ENABLED가 됨

-- USER_CONSTRAINTS : 제약조건이 설정된 테이블 이름, 제약조건 이름, 무결성 종류 및 활성화 상태 정보를 저장 (Data Dictionary)
-- USER_CONS_COLUMNS : 제약조건이 설정된 칼럼의 이름을 저장
SELECT table_name, column_name, constraint_name
FROM user_cons_columns
WHERE table_name IN ('STUDENT','PROFESSOR','DEPARTMENT');

-- 인덱스 생성
/*  CREATE [UNIQUE] INDEX index_name
    ON table_name (column [ASC|DESC] , column2 [] ...);
*/
-- 고유 인덱스
CREATE UNIQUE INDEX idx_dept_name
ON department(dname);
-- 비고유 인덱스(NON UNIQUE)
CREATE INDEX idx_stud_birthdate
ON student(birthdate);
-- 단일 인덱스 VS 결합 인덱스(두 개 이상의 칼럼을 결합하여 생성하는 인덱스)
CREATE INDEX idx_stud_dno_grade
ON student(deptno, grade);

-- DESCENDING INDEX: 칼럼별로 정렬 순서를 별도로 지정해 결합 인덱스를 생성하기 위한 방법
CREATE INDEX fidx_stud_no_name ON student(deptno DESC, name ASC); -- deptno는 내림차순, name은 오름차순으로 정렬하도록 설정

-- 함수 기반 인덱스(Function Based Index): 칼럼에 대한 연산이나 함수의 계산 결과를 인덱스로 생성 가능
CREATE INDEX uppercase_idx ON emp (UPPER(ename)); -- 함수 UPPER()의 계산 결과를 인덱스로 생성하였다.
select * from emp where upper(ename) = 'KING'; -- 이렇게 검색할 때 좋다.

-- 인덱스 실행 경로 확인
/* SQL Command Line에서...
conn system/manager -> grant plustrace to hr -> conn hr/hr -> set autotrace on; -> 끝! */
-- 실행계획 끄기 : autotrace off;
SELECT deptno, dname
FROM department
WHERE dname = '정보미디어학부'; -- sqldeveloper에서는 F10을 눌러 실행하자.

-- 인덱스 삭제하고 실행하면?
DROP INDEX IDX_DEPT_NAME;

commit;

-- USER_INDEXES: 인덱스 이름과 유일성 여부 등을 확인
SELECT index_name, uniqueness
FROM user_indexes
WHERE table_name = 'STUDENT';

-- USER_IND_COLUMNS: 인덱스 이름, 인덱스가 생성된 테이블 이름과 칼럼 이름 등 확인
SELECT index_name, table_name, column_name
FROM user_ind_columns
WHERE table_name = 'STUDENT';

-- 인덱스 삭제: DROP INDEX index_name;
drop index fidx_stud_no_name;

-- 인덱스 재구성 : 불필요하게 생성된 인덱스 내부 노드를 정리하는 작업
ALTER INDEX stud_no_pk REBUILD;

/*--------------------------------------------------------------------------------*/
-- 뷰(View) : 가상테이블, 보안과 사용자 편의성에서 강점을 가진다.
-- 단순 뷰(하나의 테이블), 복합 뷰(여러개의 테이블)
create view view_professor as
select profno, name, userid, position, hiredate, deptno
from professor;

select * from view_professor;

-- 뷰 생성시, 칼럼 이름을 명시하지 않으면 기본 테이블의 칼럼 이름을 상속한다.
-- create [or replace: 기존에 동일한 뷰 있으면 덮어씀] view view_name [칼럼 이름(별명)] AS 서브쿼리 ...
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
 -- 함수(sum, avg)를 사용하여 뷰를 생성할 때 칼럼별명을 사용하지 않으면 오류가 발생한다.
 
select * from v_prof_avg_sal;

-- 인라인 뷰(inline view): FROM 절에서 참조하는 테이블의 크기가 클 경우, 필요한 행과 컬럼만으로 구성된 집합을 재정의하여 질의문을 효율적으로 구성하는 것
-- 인라인 뷰를 사용하여 학과별로 학생들의 평균 키와 평균 몸무게, 학과 이름을 출력하여라.
select dname, avg_height, avg_weight
from (select deptno, round(avg(height),2) avg_height, round(avg(weight),2) avg_weight
        from student   
        group by deptno) s, department d
where s.deptno = d.deptno;

-- inline view QUIZ: 각 학년의 평균 키를 구하고, 해당 평균 키보다 큰 학생의 학년, 이름, 키, 각 학년의 평균 키를 출력하세요.
SELECT s.grade as "학년", name as "이름", height as "키", avg_height as "학년별 평균키"
FROM ( SELECT grade, round(AVG(height)) avg_height
        FROM student
        GROUP BY grade) av, student s
WHERE s.grade = av.grade AND s.height >= avg_height
ORDER BY s.grade;
/* 뷰의 내부 처리 과정
1) USER_VIEW 데이터 딕셔너리에서 뷰에 대한 정의를 조회
2) 기본 테이블에 대한 뷰의 접근 권한을 확인
3) 뷰에 대한 질의를 기본 테이블에 대한 질의로 변환
4) 기본 테이블에 대한 질의를 통해 데이터를 검색
5) 검색된 결과를 출력
*/

-- USER_VIEWS(DATA DICTIONARY): 사용자가 생성한 모든 뷰에 대한 정의를 저장
select view_name, text
from user_views;

-- 뷰 변경: 기존 뷰에 대한 정의를 삭제한 후에 재생성한다(사실장 변경은 아님;). 따라서, OR REPLACE 옵션을 무조건 삽입해야 함.
create or replace view v_stud_dept101
as select studno, name, deptno, grade
    from student
    where deptno = 101;

/* 뷰에서 데이터 조작이 불가능한 경우.
1. 기본 테이블의 칼럼이 'NOT NULL' 제약조건으로 지정된 경우
2. 뷰 정의시 표현식으로 정의된 칼럼에 대해 'update, insert' 실행 불가능
3. 뷰 정의시 그룹 함수, DISTINCT, GROUP BY 절 포함한 경우, 모든 DML 문 사용 불가
*/
-- 뷰 삭제: DROP VIEW view_name;
drop view v_stud_dept101;
drop view v_stud_dept102;


/*---------------------------------------------------------------------------------------------*/
-- 16. 사용자 권한 제어
/* 다중 사용자 환경에서는, 불법적 접근 및 유출 방지를 위하여 보안 대첵이 필요하다. "접근권한, 소유권, 암호"를 철저히 관리해야 한다.
또한, 중앙 집중적인 데이터 관리는 분산적으로 관리되는 것보다 보안이 취약하다는 점에 주의해야 한다.
오라클에서는 시스템 보안(DB 자체에 대한 사용자의 접근 권한 및 정보 관리), 데이터 보안(객체를 조작하기 위한 동작 및 접근 권한을 관리)을 수행한다.
*/
-- 권한: 사용자가 데이터베이스 시스템(시스템 권한)을 관리하거나 객체(객체 권한)를 이용할 수 있는 권리.
-- 데이터베이스 관리자가 가지는 시스템 권한: 사용자 생성 및 삭제, 사용자 계정에서 객체 생성 및 수정, 데이터베이스 백업 관리
/* CREATE USER, DROP USER, DROP ANY TABLE, QUERY REWRITE, BACKUP ANY TABLE */

-- 일반 사용자가 가지는 시스템 권한: 사용자가 생성한 객체 관리 및 내장 프로시저 관리
/* CREATE SESSION(DB에 접속할 수 있는 권한), CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE */

-- 시스템 권한은 특정 사용자나 모든 사용자에게 부여 가능
/* (예시) query rewrite 시스템 권한을 scott과 모든 사용자에게 부여하기(함수 기반 인덱스를 생성하기 위해 필요한 권한)
conn system/manager
grant query rewrite to scott;
grant query rewrite to public;
conn scott/tiger
select * from user_sys_privs;
*/
-- SESSION_PRIVS : 현재 세션에서 사용자와 롤에 부여된 시스템 권한 조회 가능.

-- 시스템 권한 철회 : revoke query rewrite from scott;


-- 객체 권한 부여 예시
/*  CREATE USER tiger IDENTIFIED BY tiger123 -- USER 생성
    DEFAULT TABLESPACE users -- 기본 TABLESPACE
    TEMPORARY TABLESPACE temp; -- 임시 TABLESPACE

    GRANT connect, resource TO tiger; -- 접속 권한, 테이블 생성 권한
    
    CONNECT scott/tiger
    GRANT SELECT ON scott.salgrade TO tiger; -- tiger에게 자신의 salgrade table에 대한 SELECT 권한을 부여함
    
    CONNECT tiger/tiger123
    SELECT * FROM scott.salgrade; -- tiger로 접속하여 scott의 salgrade table에 대한 select를 수행, 권한이 있으므로 정상 작동.
    
    UPDATE scott.salgrade
    SET hisal = 9000
    WHERE grade = 5; -- tiger로 접속하여 scott의 salgrade table에 대한 update를 수행, 권한이 없으므로 실행 불가(insufficient privileges)
    
    CONNECT scott/tiger
    GRANT UPDATE(hisal) ON salgrade TO tiger; -- salgrade 테이블 중 'hisal'을 수정(UPDATE)할 수 있는 권한을 부여함.
    
    UPDATE scott.salgrade
    SET hisal = 9000
    WHERE grade = 5; -- tiger로 접속하여 scott의 salgrade table의 'hisal'에 대한 update를 수행, 권한이 있으므로 정상 작동
    
    UPDATE scott.salgrade
    SET losal = 1000
    WHERE grade = 1; -- tiger로 접속하여 scott의 salgrade table의 'losal'에 대한 update를 수행, 권한이 없으므로 실행 불가능(insufficient privileges)
    
    conn tiger/tiger123
    
    select * from user_tab_privs_made; -- 자신이 타인에게 부여한 객체 권한을 조회
    select * from user_tab_privs_recd; -- 자신이 타인에게 받은 객체 권한을 조회
    select * from user_col_privs_made; -- 칼럼에 대한 내용
    select * from user_col_privs_recd;
    
    -- 객체 권한 철회
    conn scott/tiger
    REVOKE UPDATE ON salgrade FROM tiger; -- tiger로부터 salgrade에 대한 update 권한 회수
    REVOKE SELECT ON salgrade FROM tiger; -- select 권한 회수
    REVOKE DELETE ON salgrade FROM tiger; -- 주지도 않은 권한 회수하려고 하면 에러메시지 뜸 (cannot REVOKE privileges you did not grant)
    
    conn tiger/tiger123
    select * from scott.salgrade; -- 권한을 회수당했기 때문에 실행 불가능
*/

-- Quiz-07-05
-- 6. 학과별 최대키를 구하고 최대키를 가진 학생의 학과명, 최대키, 이름, 키를 출력하세요
select d.dname "학과명", m.max_height "최대키", s.name "이름", s.height "키"
from (select deptno, max(height) max_height
from student
group by deptno) m, student s, department d
WHERE d.deptno = s.deptno AND s.height = m.max_height;

-- 롤 : 다수 사용자와 다양한 권한을 효과적으로 관리하기 위해, 서로 관련된 권한을 '그룹화'한 개념.
-- 활성화/비활성화 기능, 암호 부여 기능, 접근 권한 관리, 자신에 대한 롤 부여나 순환적 부여 불가능(관리자가 해야함), 롤은 특정 소유자나 객체에 속하지 않음
-- 사전에 정의된 롤: connect, resource, dba. 예시) SQL> GRANT connect, resource TO tiger; -- 접속 권한, 테이블 생성 권한
-- connect: alter session, create [cluster, database link, sequence, session, synonym, table, view], DB에 접속해 세션 & 객체를 생성할 수 있는 권한
-- resource: create [cluster, procedure, sequence, table, trigger], 더 다양한 객체를 생성할 수 있는 권한
-- dba: with admin option 있는 모든 권한, 시스템 자원의 무제한적인 사용이나 시스템 관리에 필요한 모든 권한으로 DBA 권한을 다른 사람에게 부여할 수 있다.

-- 사전에 정의되지는 않은, 사용자 정의 롤
-- CREATE ROLE role [NOT IDENTIFIED | IDENTIFIED] { BY password | EXTERNALLY }
/*
SQL> conn system/manager
Connected.
SQL> CREATE ROLE hr_clerk;

Role created.

SQL> CREATE ROLE hr_mgr
  2  IDENTIFIED BY manager; -- 'manager'라는 패스워드 지정

Role created.
*/
-- 롤에 권한 또는 롤 부여
-- GRANT role TO {user | role | public} ...
/*
SQL> GRANT create session TO hr_mgr;

Grant succeeded.

SQL> GRANT select, insert, delete ON hr.student TO hr_clerk;

Grant succeeded.

SQL> grant hr_clerk to hr_mgr; -- 롤에게 롤 부여

Grant succeeded.

SQL> grant hr_clerk to tiger; -- 사용자에게 롤 부여

Grant succeeded.

*/
-- role_sys_privs: 롤에 부여한 시스템 권한 조회
select * from role_sys_privs;

-- role_tab_privs, user_role_privs : 롤에 부여산 시스템 권한 조회
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

-- 동의어: 하나의 객체에 대해 다른 이름을 정의하는 방법으로, 데이터베이스 전체에서 사용한다.
-- 전용 동의어, 공용 동의어
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

SQL> col project_name format a20; -- project_name 칸이 지나치게 커서 조정함
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
-- scott에게 권한이 없어 synonym을 만들 수 없으므로, system으로 들어가 권한을 부여해줌
Grant succeeded.

SQL> conn scott/tiger
Connected.
SQL> create synonym my_project for system.project;

Synonym created.
-- 동의어 생성 완료
SQL> select * from my_project;

PROJECT_ID PROJECT_NAME             STUDNO     PROFNO
---------- -------------------- ---------- ----------
     12345 portfolio                 10101       9901

*/

-- 사용 예시: system 사용자의 project 테이블에 대해 공용 동의어를 생성하여라.
/*
SQL> conn system/manager;
Connected.
SQL> CREATE PUBLIC SYNONYM pub_project FOR project;
-- pub_project라는 공용 동의어를 생성하였다.
Synonym created.

SQL> conn tiger/tiger123;
Connected.
SQL> SELECT * FROM pub_project;
SELECT * FROM pub_project -- 이는 사실상 다음 명령문과 같다: SELECT * FROM system.project;
              *
ERROR at line 1:
ORA-00942: table or view does not exist
-- tiger에게는 pub_project(system.project)에 대한 접근 권한이 없기 때문에 실행 불가능

SQL> conn scott/tiger;
Connected.
SQL> SELECT * FROM pub_project;

PROJECT_ID PROJECT_NAME             STUDNO     PROFNO
---------- -------------------- ---------- ----------
     12345 portfolio                 10101       9901

-- scott 사용자가 별도로 동의어를 생성하지 않아도, 공용 동의어에 의해 system소유의 project 테이블을 조회한다.
*/
-- 동의어 삭제: DROP SYNONYM synonym_name;
/*
SQL> conn scott/tiger
Connected.
SQL> drop synonym my_project;

Synonym dropped.

SQL> DROP synonym pub_project;
DROP synonym pub_project
             *
ERROR at line 1:
ORA-01434: private synonym to be dropped does not exist -- pub_project라는 동의어가 "public"이기 때문에 함부로 삭제 불가, 개인 동의어(-private synonym)만 삭제 가능

SQL> DROP PUBLIC synonym pub_project; -- "public"을 붙여 공용 동의어(-public synonym)를 명확하게 삭제한다.

Synonym dropped.
*/