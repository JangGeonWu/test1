-- Quiz 0706
/* 1. system이나 sys 소유의 EMPLOYEE 테이블을 생성하고, 데이터를 하나 입력하여라. */
-- system으로 접속
SQL> conn system/manager
Connected.

SQL> show user
USER is "SYSTEM"
-- employee 테이블 생성
SQL> CREATE TABLE employee(
  2  id number(7),
  3  last_name varchar2(25),
  4  first_name varchar2(25),
  5  dept_id number(7));

Table created.

SQL> desc employee;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ID                                                 NUMBER(7)
 LAST_NAME                                          VARCHAR2(25)
 FIRST_NAME                                         VARCHAR2(25)
 DEPT_ID                                            NUMBER(7)
-- 데이터 입력
SQL> INSERT into employee values(1234567, 'Kane', 'Jin', 9876543);

1 row created.

SQL> select * from employee;

        ID LAST_NAME  FIRST_NAME    DEPT_ID
---------- ---------- ---------- ----------
   1234567 Kane       Jin           9876543

/* 2. system의 employee 테이블에 대해 pub_employee라는 공용 동의어를 생성하여라. */

SQL> CREATE PUBLIC SYNONYM pub_employee FOR employee;

Synonym created.

/* 3. 2에서 생성한 공용 동의어에 의해 system 소유의 employee 테이블을 hr 유저가 조회하도록 하여라 */

SQL> GRANT select on pub_employee to hr;

Grant succeeded.

SQL> conn hr/hr
Connected.

SQL> select * from pub_employee;

        ID LAST_NAME  FIRST_NAME    DEPT_ID
---------- ---------- ---------- ----------
   1234567 Kane       Jin           9876543

/* 4. 공용동의어 pub_employee를 삭제하세요. */

SQL> conn system/manager
Connected.

SQL> DROP PUBLIC synonym pub_employee;

Synonym dropped.

SQL> conn hr/hr
Connected.
SQL> select * from pub_employee;
select * from pub_employee
              *
ERROR at line 1:
ORA-00942: table or view does not exist

/* 5. test라는 테이블 스페이스를 기본 100m로 생성하세요 */
SQL> conn system/manager
Connected.
SQL> create tablespace test
  2  datafile 'C:\oraclexe\app\oracle\oradata\XE\TEST.dbf' size 100m;

Tablespace created.

/* 6. HR의 professor, student 테이블을 백업 받고, */

SQL> host

C:\oraclexe\app\oracle\product\11.2.0\server\BIN>cd C:\Users\user

C:\Users\user>exp hr/hr file=hr_test.dmp tables=professor, student rows=y compress=y

-- export를 수행하여 hr_test.dmp를 생성합니다 --

/* 7. test/test333## 이라는 유저 생성 후 디폴트 테이블 스페이스는 test, temporary 테이블 스페이스는 temp를 지정하시오. */
SQL> CREATE USER test IDENTIFIED BY test333##
  2      DEFAULT TABLESPACE test
  3      TEMPORARY TABLESPACE temp;

User created.

SQL> GRANT connect, resource TO test;

Grant succeeded.

/* 8. 6에서 백업받은 HR의 professor, student 테이블을 test에게 import 시키고 import 되었는지 확인하세요. */
SQL> host

C:\oraclexe\app\oracle\product\11.2.0\server\BIN > cd C:\Users\user

C:\Users\user > imp system/manager file=hr_test.dmp fromuser=hr touser=test

-- 기존 hr 데이터베이스의 pk-fk 관계에 의한 에러 메시지가 발생하면서 import를 마칩니다 --

SQL> conn test/test333##
Connected.

SQL> select * from tab where tabtype='TABLE';

TNAME                                                        TABTYPE         CLUSTERID
------------------------------------------------------------ -------------- ----------
STUDENT                                                      TABLE
PROFESSOR                                                    TABLE

/* 9. 파이썬 문제: 홍길동씨의 과목별 점수는 각각 다음과 같다. 홍길동씨의 평균 점수를 구하시오. */

import numpy
hong_score = [80,75,53]
avg_score = numpy.average(hong_score);
print(avg_score)












