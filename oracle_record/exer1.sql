-- Quiz 0706
/* 1. system�̳� sys ������ EMPLOYEE ���̺��� �����ϰ�, �����͸� �ϳ� �Է��Ͽ���. */
-- system���� ����
SQL> conn system/manager
Connected.

SQL> show user
USER is "SYSTEM"
-- employee ���̺� ����
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
-- ������ �Է�
SQL> INSERT into employee values(1234567, 'Kane', 'Jin', 9876543);

1 row created.

SQL> select * from employee;

        ID LAST_NAME  FIRST_NAME    DEPT_ID
---------- ---------- ---------- ----------
   1234567 Kane       Jin           9876543

/* 2. system�� employee ���̺� ���� pub_employee��� ���� ���Ǿ �����Ͽ���. */

SQL> CREATE PUBLIC SYNONYM pub_employee FOR employee;

Synonym created.

/* 3. 2���� ������ ���� ���Ǿ ���� system ������ employee ���̺��� hr ������ ��ȸ�ϵ��� �Ͽ��� */

SQL> GRANT select on pub_employee to hr;

Grant succeeded.

SQL> conn hr/hr
Connected.

SQL> select * from pub_employee;

        ID LAST_NAME  FIRST_NAME    DEPT_ID
---------- ---------- ---------- ----------
   1234567 Kane       Jin           9876543

/* 4. ���뵿�Ǿ� pub_employee�� �����ϼ���. */

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

/* 5. test��� ���̺� �����̽��� �⺻ 100m�� �����ϼ��� */
SQL> conn system/manager
Connected.
SQL> create tablespace test
  2  datafile 'C:\oraclexe\app\oracle\oradata\XE\TEST.dbf' size 100m;

Tablespace created.

/* 6. HR�� professor, student ���̺��� ��� �ް�, */

SQL> host

C:\oraclexe\app\oracle\product\11.2.0\server\BIN>cd C:\Users\user

C:\Users\user>exp hr/hr file=hr_test.dmp tables=professor, student rows=y compress=y

-- export�� �����Ͽ� hr_test.dmp�� �����մϴ� --

/* 7. test/test333## �̶�� ���� ���� �� ����Ʈ ���̺� �����̽��� test, temporary ���̺� �����̽��� temp�� �����Ͻÿ�. */
SQL> CREATE USER test IDENTIFIED BY test333##
  2      DEFAULT TABLESPACE test
  3      TEMPORARY TABLESPACE temp;

User created.

SQL> GRANT connect, resource TO test;

Grant succeeded.

/* 8. 6���� ������� HR�� professor, student ���̺��� test���� import ��Ű�� import �Ǿ����� Ȯ���ϼ���. */
SQL> host

C:\oraclexe\app\oracle\product\11.2.0\server\BIN > cd C:\Users\user

C:\Users\user > imp system/manager file=hr_test.dmp fromuser=hr touser=test

-- ���� hr �����ͺ��̽��� pk-fk ���迡 ���� ���� �޽����� �߻��ϸ鼭 import�� ��Ĩ�ϴ� --

SQL> conn test/test333##
Connected.

SQL> select * from tab where tabtype='TABLE';

TNAME                                                        TABTYPE         CLUSTERID
------------------------------------------------------------ -------------- ----------
STUDENT                                                      TABLE
PROFESSOR                                                    TABLE

/* 9. ���̽� ����: ȫ�浿���� ���� ������ ���� ������ ����. ȫ�浿���� ��� ������ ���Ͻÿ�. */

import numpy
hong_score = [80,75,53]
avg_score = numpy.average(hong_score);
print(avg_score)












