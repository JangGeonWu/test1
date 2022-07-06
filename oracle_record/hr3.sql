/*----------------------------------------------------------------------------------*/
-- 17. ������ ���ǹ�: ������ DB���� ������ �� �θ� ���踦 ǥ���� �� �ִ� Į���� ������ �������� ���踦 ǥ���Ѵ�.
/*
1. �ϳ��� ���̺��� �������� ������ ǥ���ϴ� ���踦 ��ȯ������ ��
2. �������� �����͸� ������ Į�����κ��� �����͸� �˻��Ͽ� ���������� ����ϴ� ����� �����Ѵ�.
3. ������ �� ������ �������� ǥ���ϴ� ���¿� ���� ����
*/
-- SELECT������ START WITH�� CONNECT BY ���� �̿��Ѵ�.
/*
SELECT [LEVEL], COLs... -- LEVEL: �������� ���� ǥ��, ��Ʈ�� 1���� ������ 1�� ����
FROM table
WHERE condition
START WITH condition -- ������ ��� ���� ǥ��
CONNECT BY PRIOR condition; -- ���� ������ �����͸� ����
*/
/*
1. TOP-DOWN ����
    CONNECT BY PRIOR col1 = col2
    col1 = �ڽ� Ű, col2 = �θ� Ű
2. BOTTOM-UP ����
    CONNECT BY PRIOR col1 = col2
    col1 = �θ� Ű, col2 = �ڽ� Ű
3. ���ѷ��� ����
    CONNECT BY NOCYCLE PRIOR col1 = col2 ...
4. SubQuery�� ����� �� ����.
5. Order siblings by: Ʈ���� ������ �״�� �����ϸ鼭 ���� ���� ��Ҹ� �����Ѵ�.
6. connect by�� ���� ����: start with ~> connect by ~> where
*/
-- ������ ���ǹ��� ����� �μ� ���̺��� �а�, �к�, �ܰ������� �˻��Ͽ� �ܴ�-�к�-�а� ������ top-down ������ ���� ������ ����Ͽ���. ���� �����ʹ� 10���̴�.
SELECT  level, deptno, dname, college
FROM    department
START WITH deptno = 10
CONNECT BY PRIOR deptno = college;

-- ������ ���ǹ��� ����� �μ� ���̺��� �а�, �к�, �ܰ������� �˻��Ͽ� �а�-�к�-�ܴ� ������ bottom-up ������ ���� ������ ����Ͽ���. ���� �����ʹ� 102���̴�.
SELECT  level, deptno, dname, college
FROM    department
START WITH deptno = 102
CONNECT BY PRIOR college = deptno;

-- ������ ���ǹ��� ����� �μ� ���̺��� �а�, �к�, �ܰ������� �˻��Ͽ� �ܴ�-�к�-�а� ������ top-down ������ ���� ������ ����Ͽ���. ���� �����ʹ� ���������̰� �� �������� �������� 2ĭ �̵��Ͽ� ����Ͽ���.
SELECT  LEVEL, LPAD(' ',(LEVEL - 1) * 2) || dname as "������"
FROM    department
START WITH deptno = 10
CONNECT BY PRIOR deptno = college;

-- ������ ���ǹ�, DUAL���� ����ϴ� ���
SELECT LEVEL-1 AS HOUR -- ���� ������ ������ �ٿ� ǥ��
FROM DUAL -- ���̺� DUAL���� start ������ ����.
CONNECT BY LEVEL <= 24; -- ���� ���谡 �����Ƿ� PRIOR�� ���� ����, �������� �����Ѵ�.

-- ���� �������� ���� ���� ���: WHERE���� ������ ��带 �����ϰ�, CONNECT BY���� ������ ���� �ڽ� ������ ���ÿ� �����Ѵ�.
SELECT  level, deptno, dname, college
FROM    department
WHERE dname != '�����̵���к�' -- '�����̵�� �к�'�� �ش��ϴ� row�� �����ϰ� �����´�.
START WITH deptno = 10
CONNECT BY PRIOR deptno = college;

SELECT  level, deptno, dname, college
FROM    department
START WITH deptno = 10
CONNECT BY PRIOR deptno = college AND dname != '�����̵���к�'; -- '�����̵�� �к�'�� �ش��ϴ� ������ �����ϰ� �����´�.

SELECT  level, deptno, dname, college
FROM    department
START WITH deptno = 10
CONNECT BY PRIOR dname != '�����̵���к�' AND deptno = college; 

SELECT  level, deptno, dname, college
FROM    department
START WITH deptno = 10
CONNECT BY dname != '�����̵���к�' AND prior deptno = college; -- PRIOR�� 'CONNECT BY'�� �ƴ϶� 'col1 = col2'�� �ٴ´ٴ� �� �� �� �ִ�.

-- connect_by_root: level�� 1�� �ֻ��� �ο��� ������ ���� �� �ִ�.
SELECT LPAD(' ', 4*(level - 1)) || ename as "�����",
    empno as "���",
    CONNECT_BY_ROOT empno "�ֻ������",
    LEVEL
FROM emp
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr;

-- connect_by_isleaf: �ο��� ���������� '����(False/True)'�� ��ȯ�Ѵ�.
SELECT LPAD(' ', 4*(level - 1)) || ename as "�����",
    empno as "���",
    CONNECT_BY_ISLEAF Leaf_YN, -- �ڽ��� �ܸ�(leaf)���� 0,1�� ǥ��
    LEVEL
FROM emp
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr;

SELECT LPAD(' ', 4*(level - 1)) || ename as "�����",
    empno as "���",
    CONNECT_BY_ISLEAF Leaf_YN, -- �ڽ��� �ܸ�(leaf)���� 0,1�� ǥ��
    LEVEL
FROM emp
WHERE connect_by_isleaf = 1 -- �ܸ��� row�� ǥ���Ѵ�.
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr;

-- SYS_CONNECT_BY_PATH: �ο��� path ������ ��ȯ�Ѵ�.
SELECT LPAD(' ', 4*(level - 1)) || ename as "�����",
    empno as "���",
    SYS_CONNECT_BY_PATH(ename,'/') e_path, -- sys_connect_by_path�� �Լ��̸�, ��θ� Į���� �Է��� Ư�����ڷ� ǥ���Ѵ�,
    LEVEL
FROM emp
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr;

-- ORDER 'SIBLINGS' BY: Ʈ�� ������ �״�� �ΰ�, sibling ���� ������ �����Ѵ�.
SELECT LPAD(' ', 4*(level - 1)) || ename as "�����",
    empno as "���",
    CONNECT_BY_ISLEAF Leaf_YN, -- �ڽ��� �ܸ�(leaf)���� 0,1�� ǥ��
    LEVEL
FROM emp
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr
ORDER SIBLINGS BY ename; -- Ʈ�� ����

SELECT LPAD(' ', 4*(level - 1)) || ename as "�����",
    empno as "���",
    CONNECT_BY_ISLEAF Leaf_YN, -- �ڽ��� �ܸ�(leaf)���� 0,1�� ǥ��
    LEVEL
FROM emp
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr
ORDER BY ename; -- Ʈ�� ���� ����

-- CONNECT_BY_ISCYCLE: ���� �ο찡 �ڽ��� ���� �ִµ� ���ÿ� �� �ڽ� �ο찡 �θ� �ο��̸� 1, �ƴϸ� 0�� ��ȯ�Ѵ�(������ �����Ǵ� ���� ã�� ���� ����).
-- 'NOCYCLE PRIOR' �������� '����'�� �����ϰ� ����ϴ� ��Ȳ�� ������ ���� �ִ�.

/*----------------------------------------------------------------------------*/
-- 18. PL/SQL(Procedural Language, ������ �� SQL�� ����): DB ���뿡 ���� ����
-- 19. PL/SQL Programming
-- 20. Trigger(� ����� �߻����� �� ���������� (�ڵ�����) ����ǵ��� �����ͺ��̽��� ������ ���ν���)�� �ѱ��.
/*----------------------------------------------------------------------------*/
-- 21. ���� �����ͺ��̽� ������
/*
a. Network���� ����� Database���� ����� ���� SQL*Net �Ǵ� Net8�̶�� Network ��Ÿ���� �����ȴ�.
b. Network���� ����� Database�� Access �ϱ� ���� Client���� tnsnames.ora�� sqlnet.ora ������ �־�� �ϸ�, �������� listener.ora ������ �־�� ��
c. ������ client�� ��û�� �ޱ� ���� listener�� �����Ǿ� �־�� �Ѵ�.
d. Database ���� ����� ���� Database link�� ����� �� �ִ�.
*/
---- �̷��� ������ �ִ��� Ȯ���غ���. ----
/* �������: Oracle, �������: OracleXE
(���� ��ǻ����) "C:\oraclexe\app\oracle\product\11.2.0\server\network\ADMIN"���� listener.ora, sqlnet.ora, tnsnames.ora�� �ִ� ���� Ȯ���� �� �ִ�.
*/
-------------------------------------
/* tnsnames.ora
XE =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-1JHGQ0T)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
  )

EXTPROC_CONNECTION_DATA =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1))
    )
    (CONNECT_DATA =
      (SID = PLSExtProc)
      (PRESENTATION = RO)
    )
  )

ORACLR_CONNECTION_DATA = 
  (DESCRIPTION = 
    (ADDRESS_LIST = 
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1)) 
    ) 
    (CONNECT_DATA = 
      (SID = CLRExtProc) 
      (PRESENTATION = RO) 
    ) 
  )
  
 <����>
 kakao(Network ���� �̸�) = 
  (DESCRIPTION = 
    (ADDRESS_LIST = 
      (ADDRESS = (PROTOCOL = IPC)(HOST = 192.168.64.3(ȣ��Ʈ ������))(PORT = 1521)) 
    ) 
    (CONNECT_DATA = 
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl(���� �̸�)) 
    ) 
  )
  
*/
/* Transparent Network Substrate NAMES - Database Instance�� ������ ��ġ�� ����Ǵ���,
Application�� Net Service Name�� �����ϹǷ� ������ �ʿ䰡 ����. ����, Client ���� tnsnames.ora ������
Host ������ �����ϸ� �ȴ�.
*/
----------------------------------------------------------------
-- '���� -> ���� -> OracleXETNSListener'�� ����Ǿ��ִ� �� �� �� �ִ�.

/* (�ܺο���) �������� ����Ǵ��� Ȯ��
SQL> conn scott/tiger@xe
Connected. */

/* listener.ora
SID_LIST_LISTENER =
  (SID_LIST =
    (SID_DESC =
      (SID_NAME = PLSExtProc)
      (ORACLE_HOME = C:\oraclexe\app\oracle\product\11.2.0\server)
      (PROGRAM = extproc)
    )
    (SID_DESC =
      (SID_NAME = CLRExtProc)
      (ORACLE_HOME = C:\oraclexe\app\oracle\product\11.2.0\server)
      (PROGRAM = extproc)
    )
  )

LISTENER =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1))
      (ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-1JHGQ0T)(PORT = 1521))
    )
  )

DEFAULT_SERVICE_LISTENER = (XE)
*/
---------------------------------------------------------
/*
SQL> conn /as sysdba
Connected.
SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down. -- DB ������

SQL> conn hr/hr
ERROR:
ORA-01034: ORACLE not available
ORA-27101: shared memory realm does not exist
Process ID: 0
Session ID: 0 Serial number: 0


Warning: You are no longer connected to ORACLE. -- DB�� ������ �ƹ��� ���� �Ұ���

SQL> conn /as sysdba
Connected to an idle instance.
-- DB �츮��
SQL> startup
ORACLE instance started.

Total System Global Area 1068937216 bytes
Fixed Size                  2260048 bytes
Variable Size             658506672 bytes
Database Buffers          402653184 bytes
Redo Buffers                5517312 bytes
Database mounted.
Database opened.

SQL> conn hr/hr
Connected.
SQL> conn hr/hr@xe -- �������ε� ����Ǵ� �� Ȯ�� �ʿ�
Connected.
*/
----------------------------------------------------------
-- 22. EXPORT , IMPORT: Database �� ������ �� ������ ���� �̵���ų �� �ִ� ������ ����� ������.
/* export-import ��� ����
���̺� �籸�� - Row Migration�� ���� �߻��� ���, �� Block�� ���� ���, Fragmentation�� ���� �߻��� ���, ������ �ּ�
ȭ ���� ������ ���̺��� �籸���ؾ� �ϴ� ��� ���.
����ڰ��� ������ �̵� - ����� ������ �����ϰų� ���� �й� �� ���
�����ͺ��̽� ���� ������ �̵� - ���� DB���� ���� ���� DB�� �����͸� ������ �� ���
�ٸ� �÷��� �Ǵ� �ٸ� ���������� ������ �̵�, Locigal Backup(���)�� ��쿡 ���
--------------------------------------------------------------------------
1. catexp.sql�� export-import�� ���� �並 ����. �Ϲ������� database ���� �� catalog.sql�� �����Ǵµ�, �� �ȿ� ���ԵǾ�����.
2. export-import�� command line, interactive mode, graphic interface���� ����ȴ�.
3. ���������� ���Ǵ� �Ķ���ʹ� Parameter ���Ͽ� �����Ѵ�.
4. Export �۾��� �ϱ� ���� Disk ������ ������� Ȯ���Ѵ�.
----------------------------export-------------------------------------
Run SQL Command Line���� Host�Է� �� "C:\Users\user"�� �̵��ؼ� ���� -> "C:\Users\user\"�� dmp ���� ������
-- export ��� ���� 1
FILE = expdat.dmp                       -> export dump file name(��� ���� �̸�)
TABLES = (hr.emp, hr.dept)              -> export�� ���̺� ���
GRANTS = y                              -> ��ü�� ���� '����'�� export�Ұ��� ����
INDEXES = y                             -> ���̺�鿡 ���� �ε����� export�� ������ ����
(Additional Parameter)              LOG -> ��� export �޽����� ������ ���� �̸�, ���� ���ϸ� ��� �ȵ�
                                 DIRECT -> ���� ��η� export, �⺻(default) ��κ��� �ӵ��� ������.
-- parameter file method
PROMPT > exp system/manager parfile = exp1.par
-- command-line method(Windows Prompt)
PROMPT > exp system/manager tables=(hr.emp, hr.dept) grants=y indexes=y
------------------------------------������-------------------------------------------
C:\Users\user>exp system/manager tables=(hr.emp, hr.dept) grants=y indexes=y;

Export: Release 11.2.0.2.0 - Production on �� 7�� 6 13:38:13 2022

Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.


Connected to: Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
Export done in KO16MSWIN949 character set and AL16UTF16 NCHAR character set
server uses AL32UTF8 character set (possible charset conversion)

About to export specified tables via Conventional Path ...
Current user changed to HR
. . exporting table                            EMP         17 rows exported
. . exporting table                           DEPT          4 rows exported
EXP-00091: Exporting questionable statistics.
EXP-00091: Exporting questionable statistics.
Export terminated successfully with warnings.
-------------------------------------------------------------------------------------
-- export ��� ���� 2
FILE = hr.dmp                        
TABLES = (emp, dept)             
ROWS = y                                -> ��(������)���� export �� ������ ����
COMPRESS = y                            -> Fragmentation �� ���׸�Ʈ���� ������ �� ����

-- parameter file method
PROMPT > exp hr/hr parfile = exp2.par
-- command-line method
PROMPT > exp hr/hr file=hr.dmp tables=emp,dept rows=y compress=y
--------------------------------------------------------------------------
-- export ��� ���� 3
FILE = hr_all.dmp                   
OWNER = hr        -> ����ڰ�ü�� �ش簴ü ���� ������, (owner��) ��� ����, �ε����� export�ȴ�. 
GRANTS = y           
ROWS = y                            
COMPRESS = y                       

-- parameter file method
PROMPT > exp hr/hr parfile = exp3.par
-- command-line method
PROMPT > exp hr/hr file=hr_all.dmp owner=hr grants=y rows=y compress=y;
--------------------------------------------------------------------------
-- export ��� ���� 4
FILE = dba1.dmp                   
GRANTS = y           
FULL = y                            -> '��ü �����ͺ��̽�'�� export���� ����
ROWS = y 

-- parameter file method
PROMPT > exp system/manager parfile = exp4.par
-- command-line method
PROMPT > exp system/manager full=y file=dba1.dmpgrants=y rows=y
*/
------------------------------------import-----------------------------------------
/*
-- import ��� ���� 1
FILE = expdat.dmp                           -> import �� ���ϸ�          
SHOW = n                                    -> import�� �����ϴ� ��� ȭ�鿡'��' ǥ���� �� ����
IGNORE = n                                  -> import�ϸ鼭 �߻��ϴ� create ������ ������ �� ����
GRANTS = y                                  -> ��ü ���� import�� �� ����
FROMUSER = hr                               -> ���� ��ü���� ������ �ִ� ����� ���
TABLES = (emp, dept)                        -> import �� ���̺� ���

-- parameter file method
PROMPT > imp system/manager parfile = imp1.par
-- command-line method
PROMPT > imp system/manager file=expdat.dmp fromuser=hr tables=(emp, dept)
--------------------------------------- ���� ��� -----------------------------------------
C:\Users\user>imp system/manager file=EXPDAT.dmp fromuser=hr tables=(emp, dept)

Import: Release 11.2.0.2.0 - Production on �� 7�� 6 14:15:04 2022

Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.


Connected to: Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

Export file created by EXPORT:V11.02.00 via conventional path

Warning: the objects were exported by HR, not by you

import done in KO16MSWIN949 character set and AL16UTF16 NCHAR character set
import server uses AL32UTF8 character set (possible charset conversion)
. importing HR's objects into SYSTEM
. importing HR's objects into SYSTEM
. . importing table                          "EMP"         17 rows imported
. . importing table                         "DEPT"          4 rows imported
About to enable constraints...
Import terminated successfully without warnings.

SQL> select * from emp;

     EMPNO ENAME      JOB               MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- ---------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK            7902 80/12/17        800                    20
      7499 ALLEN      SALESMAN         7698 81/02/20       1600        300         30
      7521 WARD       SALESMAN         7698 81/02/22       1250        500         30
      7566 JONES      MANAGER          7839 81/04/02       2975                    20
      7654 MARTIN     SALESMAN         7698 81/09/28       1250       1400         30
      7698 BLAKE      MANAGER          7839 81/05/01       2850                    30
      7782 CLARK      MANAGER          7839 81/06/09       2450                    10
      7788 SCOTT      ANALYST          7566 87/07/13       3000                    20
      7839 KING       PRESIDENT             81/11/17       5000                    10
      7844 TURNER     SALESMAN         7698 81/09/08       1500          0         30
      7876 ADAMS      CLERK            7788 87/07/13       1100                    20

     EMPNO ENAME      JOB               MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- ---------- ---------- -------- ---------- ---------- ----------
      7900 JAMES      CLERK            7698 81/12/03        950                    30
      7902 FORD       ANALYST          7566 81/12/03       3000                    20
      7934 MILLER     CLERK            7782 82/01/23       1300                    10
         1 TEST1      SALESMAN         7698 80/12/17        800                    20
         2 TEST2
         3 TEST3

SQL> select * from dept;

    DEPTNO DNAME                        LOC
---------- ---------------------------- --------------------------
        10 ACCOUNTING                   NEW YORK
        20 RESEARCH                     DALLAS
        30 SALES                        CHICAGO
        40 OPERATIONS                   BOSTON
-- import ��� ���� 2
FILE = hr.dmp                           
FROMUSER = hr                           
TOUSER = tiger                                  -> ���̺��� ����Ʈ �� ����� �̸�
TABLES = (emp, dept) 

-- parameter file method
PROMPT > imp system/manager parfile = imp2.par
-- command-line method
PROMPT > imp system/manager file=hr.dmp fromuser=hr touser=tiger tables=(emp, dept)
--------------------------------------- ���� ��� -----------------------------------------
C:\Users\user>imp system/manager file=hr.dmp fromuser=hr touser=tiger tables=(emp, dept)

Import: Release 11.2.0.2.0 - Production on �� 7�� 6 14:17:43 2022

Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.


Connected to: Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

Export file created by EXPORT:V11.02.00 via conventional path

Warning: the objects were exported by HR, not by you

import done in KO16MSWIN949 character set and AL16UTF16 NCHAR character set
import server uses AL32UTF8 character set (possible charset conversion)
. importing HR's objects into TIGER
. . importing table                          "EMP"         17 rows imported
. . importing table                         "DEPT"          4 rows imported
About to enable constraints...
Import terminated successfully without warnings.

SQL> conn tiger/tiger123
Connected.
SQL> show user
USER is "TIGER"
SQL> select * from emp;

     EMPNO ENAME      JOB               MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- ---------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK            7902 80/12/17        800                    20
      7499 ALLEN      SALESMAN         7698 81/02/20       1600        300         30
      7521 WARD       SALESMAN         7698 81/02/22       1250        500         30
      7566 JONES      MANAGER          7839 81/04/02       2975                    20
      7654 MARTIN     SALESMAN         7698 81/09/28       1250       1400         30
      7698 BLAKE      MANAGER          7839 81/05/01       2850                    30
      7782 CLARK      MANAGER          7839 81/06/09       2450                    10
      7788 SCOTT      ANALYST          7566 87/07/13       3000                    20
      7839 KING       PRESIDENT             81/11/17       5000                    10
      7844 TURNER     SALESMAN         7698 81/09/08       1500          0         30
      7876 ADAMS      CLERK            7788 87/07/13       1100                    20

     EMPNO ENAME      JOB               MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- ---------- ---------- -------- ---------- ---------- ----------
      7900 JAMES      CLERK            7698 81/12/03        950                    30
      7902 FORD       ANALYST          7566 81/12/03       3000                    20
      7934 MILLER     CLERK            7782 82/01/23       1300                    10
         1 TEST1      SALESMAN         7698 80/12/17        800                    20
         2 TEST2
         3 TEST3

17 rows selected.

SQL> select * from dept;

    DEPTNO DNAME                        LOC
---------- ---------------------------- --------------------------
        10 ACCOUNTING                   NEW YORK
        20 RESEARCH                     DALLAS
        30 SALES                        CHICAGO
        40 OPERATIONS                   BOSTON

--------------------------------------- ���� ��� -----------------------------------------

c:\Users\user>imp system/manager file=hr_all.dmp fromuser=hr touser=tiger

Import: Release 11.2.0.2.0 - Production on �� 7�� 6 14:20:45 2022

Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.


Connected to: Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

Export file created by EXPORT:V11.02.00 via conventional path

Warning: the objects were exported by HR, not by you

import done in KO16MSWIN949 character set and AL16UTF16 NCHAR character set
import server uses AL32UTF8 character set (possible charset conversion)
. importing HR's objects into TIGER
. . importing table                      "ADDRESS"          2 rows imported
. . importing table                        "BONUS"          0 rows imported
. . importing table                      "BONUSES"         16 rows imported
. . importing table               "CLIENT_ADDRESS"          0 rows imported
. . importing table                    "COUNTRIES"         25 rows imported
. . importing table                   "DEPARTMENT"         10 rows imported
. . importing table                  "DEPARTMENTS"         27 rows imported
. . importing table                         "DEPT"          4 rows imported
. . importing table                          "EMP"         17 rows imported
. . importing table                    "EMPLOYEE2"         17 rows imported
. . importing table                    "EMPLOYEES"        107 rows imported
. . importing table                      "EX_TIME"          1 rows imported
. . importing table                  "HEIGHT_INFO"          5 rows imported
. . importing table                         "JOBS"         19 rows imported
. . importing table                  "JOB_HISTORY"         10 rows imported
. . importing table                    "LOCATIONS"         23 rows imported
. . importing table                        "PROF1"          5 rows imported
. . importing table                        "PROF2"          5 rows imported
. . importing table                    "PROFESSOR"         11 rows imported
. . importing table               "PROFESSOR_TEMP"          3 rows imported
. . importing table              "PROFESSOR_TEMP2"          3 rows imported
. . importing table                      "REGIONS"          4 rows imported
. . importing table                        "SALES"          2 rows imported
. . importing table                   "SALES_DATA"         10 rows imported
. . importing table                     "SALGRADE"          3 rows imported
. . importing table                      "STUDENT"         16 rows imported
. . importing table                     "STUD_101"          2 rows imported
. . importing table                   "STUD_HEAVY"          2 rows imported
. . importing table                      "SUBJECT"          1 rows imported
. . importing table                       "SUGANG"          0 rows imported
. . importing table                    "T_STUDENT"         17 rows imported
. . importing table                  "WEIGHT_INFO"          0 rows imported
About to enable constraints...
Import terminated successfully without warnings.
*/






































































































































































































































































































































