/*----------------------------------------------------------------------------------*/
-- 17. 계층적 질의문: 관계형 DB에서 데이터 간 부모 관계를 표현할 수 있는 칼럼을 지정해 계층적인 관계를 표현한다.
/*
1. 하나의 테이블에서 계층적인 구조를 표현하는 관계를 순환관계라고 함
2. 계층적인 데이터를 저장한 칼럼으로부터 데이터를 검색하여 계층적으로 출력하는 기능을 제공한다.
3. 조직도 등 간단한 계층형을 표시하는 형태에 응용 가능
*/
-- SELECT문에서 START WITH와 CONNECT BY 절을 이용한다.
/*
SELECT [LEVEL], COLs... -- LEVEL: 계층별로 레벨 표시, 루트는 1에서 시작해 1씩 증가
FROM table
WHERE condition
START WITH condition -- 계층적 출력 형식 표현
CONNECT BY PRIOR condition; -- 계층 관계의 데이터를 지정
*/
/*
1. TOP-DOWN 형식
    CONNECT BY PRIOR col1 = col2
    col1 = 자식 키, col2 = 부모 키
2. BOTTOM-UP 형식
    CONNECT BY PRIOR col1 = col2
    col1 = 부모 키, col2 = 자식 키
3. 무한루프 방지
    CONNECT BY NOCYCLE PRIOR col1 = col2 ...
4. SubQuery를 사용할 수 없다.
5. Order siblings by: 트리의 구조를 그대로 유지하면서 동일 레벨 요소만 정렬한다.
6. connect by의 실행 순서: start with ~> connect by ~> where
*/
-- 계층적 질의문을 사용해 부서 테이블에서 학과, 학부, 단과대학을 검색하여 단대-학부-학과 순으로 top-down 형식의 계층 구조로 출력하여라. 시작 데이터는 10번이다.
SELECT  level, deptno, dname, college
FROM    department
START WITH deptno = 10
CONNECT BY PRIOR deptno = college;

-- 계층적 질의문을 사용해 부서 테이블에서 학과, 학부, 단과대학을 검색하여 학과-학부-단대 순으로 bottom-up 형식의 계층 구조로 출력하여라. 시작 데이터는 102번이다.
SELECT  level, deptno, dname, college
FROM    department
START WITH deptno = 102
CONNECT BY PRIOR college = deptno;

-- 계층적 질의문을 사용해 부서 테이블에서 학과, 학부, 단과대학을 검색하여 단대-학부-학과 순으로 top-down 형식의 계층 구조로 출력하여라. 시작 데이터는 공과대학이고 각 레벨별로 우측으로 2칸 이동하여 출력하여라.
SELECT  LEVEL, LPAD(' ',(LEVEL - 1) * 2) || dname as "조직도"
FROM    department
START WITH deptno = 10
CONNECT BY PRIOR deptno = college;

-- 계층적 질의문, DUAL에서 사용하는 방법
SELECT LEVEL-1 AS HOUR -- 계층 레벨에 별명을 붙여 표현
FROM DUAL -- 테이블 DUAL에는 start 지점이 없다.
CONNECT BY LEVEL <= 24; -- 계층 관계가 없으므로 PRIOR가 붙지 않음, 조건절만 수행한다.

-- 계층 구조에서 가지 제거 방법: WHERE절은 임의의 노드를 삭제하고, CONNECT BY절은 임의의 노드와 자식 노드까지 동시에 삭제한다.
SELECT  level, deptno, dname, college
FROM    department
WHERE dname != '정보미디어학부' -- '정보미디어 학부'에 해당하는 row만 제외하고 가져온다.
START WITH deptno = 10
CONNECT BY PRIOR deptno = college;

SELECT  level, deptno, dname, college
FROM    department
START WITH deptno = 10
CONNECT BY PRIOR deptno = college AND dname != '정보미디어학부'; -- '정보미디어 학부'에 해당하는 가지를 제거하고 가져온다.

SELECT  level, deptno, dname, college
FROM    department
START WITH deptno = 10
CONNECT BY PRIOR dname != '정보미디어학부' AND deptno = college; 

SELECT  level, deptno, dname, college
FROM    department
START WITH deptno = 10
CONNECT BY dname != '정보미디어학부' AND prior deptno = college; -- PRIOR는 'CONNECT BY'가 아니라 'col1 = col2'에 붙는다는 걸 알 수 있다.

-- connect_by_root: level이 1인 최상위 로우의 정보를 얻어올 수 있다.
SELECT LPAD(' ', 4*(level - 1)) || ename as "사원명",
    empno as "사번",
    CONNECT_BY_ROOT empno "최상위사번",
    LEVEL
FROM emp
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr;

-- connect_by_isleaf: 로우의 최하위레벨 '여부(False/True)'를 반환한다.
SELECT LPAD(' ', 4*(level - 1)) || ename as "사원명",
    empno as "사번",
    CONNECT_BY_ISLEAF Leaf_YN, -- 자신이 단말(leaf)인지 0,1로 표시
    LEVEL
FROM emp
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr;

SELECT LPAD(' ', 4*(level - 1)) || ename as "사원명",
    empno as "사번",
    CONNECT_BY_ISLEAF Leaf_YN, -- 자신이 단말(leaf)인지 0,1로 표시
    LEVEL
FROM emp
WHERE connect_by_isleaf = 1 -- 단말인 row만 표시한다.
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr;

-- SYS_CONNECT_BY_PATH: 로우의 path 정보를 반환한다.
SELECT LPAD(' ', 4*(level - 1)) || ename as "사원명",
    empno as "사번",
    SYS_CONNECT_BY_PATH(ename,'/') e_path, -- sys_connect_by_path는 함수이며, 경로를 칼럼과 입력한 특수문자로 표시한다,
    LEVEL
FROM emp
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr;

-- ORDER 'SIBLINGS' BY: 트리 구조는 그대로 두고, sibling 관계 내에서 정렬한다.
SELECT LPAD(' ', 4*(level - 1)) || ename as "사원명",
    empno as "사번",
    CONNECT_BY_ISLEAF Leaf_YN, -- 자신이 단말(leaf)인지 0,1로 표시
    LEVEL
FROM emp
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr
ORDER SIBLINGS BY ename; -- 트리 유지

SELECT LPAD(' ', 4*(level - 1)) || ename as "사원명",
    empno as "사번",
    CONNECT_BY_ISLEAF Leaf_YN, -- 자신이 단말(leaf)인지 0,1로 표시
    LEVEL
FROM emp
START WITH job = UPPER('President')
CONNECT BY PRIOR empno = mgr
ORDER BY ename; -- 트리 구조 깨짐

-- CONNECT_BY_ISCYCLE: 현재 로우가 자식을 갖고 있는데 동시에 그 자식 로우가 부모 로우이면 1, 아니면 0을 반환한다(루프가 생성되는 곳을 찾기 위해 삽입).
-- 'NOCYCLE PRIOR' 조건으로 '루프'를 무한하게 출력하는 상황을 방지할 수도 있다.

/*----------------------------------------------------------------------------*/
-- 18. PL/SQL(Procedural Language, 절차적 언어를 SQL에 적용): DB 응용에 많이 쓰임
-- 19. PL/SQL Programming
-- 20. Trigger(어떤 사건이 발생했을 때 내부적으로 (자동으로) 실행되도록 데이터베이스에 저장한 프로시저)은 넘길거.
/*----------------------------------------------------------------------------*/
-- 21. 원격 데이터베이스 엑세스
/*
a. Network으로 연결된 Database와의 통신을 위해 SQL*Net 또는 Net8이라는 Network 통신모듈이 제공된다.
b. Network으로 연결된 Database를 Access 하기 위해 Client에는 tnsnames.ora와 sqlnet.ora 파일이 있어야 하며, 서버에는 listener.ora 파일이 있어야 함
c. 서버가 client의 요청을 받기 위해 listener가 구동되어 있어야 한다.
d. Database 간의 통신을 위해 Database link를 사용할 수 있다.
*/
---- 이러한 파일이 있는지 확인해보자. ----
/* 유료버전: Oracle, 무료버전: OracleXE
(현재 컴퓨터의) "C:\oraclexe\app\oracle\product\11.2.0\server\network\ADMIN"에서 listener.ora, sqlnet.ora, tnsnames.ora가 있는 것을 확인할 수 있다.
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
  
 <예시>
 kakao(Network 서비스 이름) = 
  (DESCRIPTION = 
    (ADDRESS_LIST = 
      (ADDRESS = (PROTOCOL = IPC)(HOST = 192.168.64.3(호스트 도메인))(PORT = 1521)) 
    ) 
    (CONNECT_DATA = 
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl(서비스 이름)) 
    ) 
  )
  
*/
/* Transparent Network Substrate NAMES - Database Instance의 물리적 위치가 변경되더라도,
Application은 Net Service Name을 참조하므로 변경할 필요가 없다. 단지, Client 측의 tnsnames.ora 파일의
Host 정보를 변경하면 된다.
*/
----------------------------------------------------------------
-- '실행 -> 서비스 -> OracleXETNSListener'가 실행되어있는 걸 볼 수 있다.

/* (외부에서) 원격으로 실행되는지 확인
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
ORACLE instance shut down. -- DB 내리기

SQL> conn hr/hr
ERROR:
ORA-01034: ORACLE not available
ORA-27101: shared memory realm does not exist
Process ID: 0
Session ID: 0 Serial number: 0


Warning: You are no longer connected to ORACLE. -- DB를 내려서 아무도 접속 불가능

SQL> conn /as sysdba
Connected to an idle instance.
-- DB 살리기
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
SQL> conn hr/hr@xe -- 원격으로도 연결되는 지 확인 필요
Connected.
*/
----------------------------------------------------------
-- 22. EXPORT , IMPORT: Database 간 데이터 및 정보를 쉽게 이동시킬 수 있는 간단한 방법을 제공함.
/* export-import 사용 예시
테이블 재구성 - Row Migration이 많이 발생한 경우, 빈 Block이 많은 경우, Fragmentation이 많이 발생한 경우, 경합의 최소
화 등의 이유로 테이블을 재구성해야 하는 경우 사용.
사용자간의 데이터 이동 - 사용자 계정을 제거하거나 정보 분배 시 사용
데이터베이스 간의 데이터 이동 - 개발 DB에서 실제 서비스 DB로 데이터를 이전할 때 사용
다른 플랫폼 또는 다른 버전으로의 데이터 이동, Locigal Backup(백업)의 경우에 사용
--------------------------------------------------------------------------
1. catexp.sql은 export-import를 위한 뷰를 생성. 일반적으로 database 생성 시 catalog.sql이 생성되는데, 이 안에 포함되어있음.
2. export-import는 command line, interactive mode, graphic interface에서 실행된다.
3. 공통적으로 사용되는 파라미터는 Parameter 파일에 지정한다.
4. Export 작업을 하기 전에 Disk 공간이 충분한지 확인한다.
----------------------------export-------------------------------------
Run SQL Command Line에서 Host입력 후 "C:\Users\user"로 이동해서 실행 -> "C:\Users\user\"에 dmp 파일 생성됨
-- export 사용 예시 1
FILE = expdat.dmp                       -> export dump file name(출력 파일 이름)
TABLES = (hr.emp, hr.dept)              -> export될 테이블 목록
GRANTS = y                              -> 객체에 대한 '권한'을 export할건지 여부
INDEXES = y                             -> 테이블들에 대한 인덱스를 export할 것인지 여부
(Additional Parameter)              LOG -> 모든 export 메시지를 저장할 파일 이름, 지정 안하면 기록 안됨
                                 DIRECT -> 직접 경로로 export, 기본(default) 경로보다 속도가 빠르다.
-- parameter file method
PROMPT > exp system/manager parfile = exp1.par
-- command-line method(Windows Prompt)
PROMPT > exp system/manager tables=(hr.emp, hr.dept) grants=y indexes=y
------------------------------------실행결과-------------------------------------------
C:\Users\user>exp system/manager tables=(hr.emp, hr.dept) grants=y indexes=y;

Export: Release 11.2.0.2.0 - Production on 수 7월 6 13:38:13 2022

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
-- export 사용 예시 2
FILE = hr.dmp                        
TABLES = (emp, dept)             
ROWS = y                                -> 행(데이터)들이 export 될 것인지 여부
COMPRESS = y                            -> Fragmentation 된 세그먼트들을 압축할 지 여부

-- parameter file method
PROMPT > exp hr/hr parfile = exp2.par
-- command-line method
PROMPT > exp hr/hr file=hr.dmp tables=emp,dept rows=y compress=y
--------------------------------------------------------------------------
-- export 사용 예시 3
FILE = hr_all.dmp                   
OWNER = hr        -> 사용자객체와 해당객체 내의 데이터, (owner의) 모든 권한, 인덱스가 export된다. 
GRANTS = y           
ROWS = y                            
COMPRESS = y                       

-- parameter file method
PROMPT > exp hr/hr parfile = exp3.par
-- command-line method
PROMPT > exp hr/hr file=hr_all.dmp owner=hr grants=y rows=y compress=y;
--------------------------------------------------------------------------
-- export 사용 예시 4
FILE = dba1.dmp                   
GRANTS = y           
FULL = y                            -> '전체 데이터베이스'를 export할지 여부
ROWS = y 

-- parameter file method
PROMPT > exp system/manager parfile = exp4.par
-- command-line method
PROMPT > exp system/manager full=y file=dba1.dmpgrants=y rows=y
*/
------------------------------------import-----------------------------------------
/*
-- import 사용 예시 1
FILE = expdat.dmp                           -> import 될 파일명          
SHOW = n                                    -> import를 실행하는 대신 화면에'만' 표시할 지 여부
IGNORE = n                                  -> import하면서 발생하는 create 에러를 무시할 지 여부
GRANTS = y                                  -> 객체 권한 import할 지 여부
FROMUSER = hr                               -> 읽을 객체들을 가지고 있는 사용자 목록
TABLES = (emp, dept)                        -> import 될 테이블 목록

-- parameter file method
PROMPT > imp system/manager parfile = imp1.par
-- command-line method
PROMPT > imp system/manager file=expdat.dmp fromuser=hr tables=(emp, dept)
--------------------------------------- 실행 결과 -----------------------------------------
C:\Users\user>imp system/manager file=EXPDAT.dmp fromuser=hr tables=(emp, dept)

Import: Release 11.2.0.2.0 - Production on 수 7월 6 14:15:04 2022

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
-- import 사용 예시 2
FILE = hr.dmp                           
FROMUSER = hr                           
TOUSER = tiger                                  -> 테이블을 임포트 할 사용자 이름
TABLES = (emp, dept) 

-- parameter file method
PROMPT > imp system/manager parfile = imp2.par
-- command-line method
PROMPT > imp system/manager file=hr.dmp fromuser=hr touser=tiger tables=(emp, dept)
--------------------------------------- 실행 결과 -----------------------------------------
C:\Users\user>imp system/manager file=hr.dmp fromuser=hr touser=tiger tables=(emp, dept)

Import: Release 11.2.0.2.0 - Production on 수 7월 6 14:17:43 2022

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

--------------------------------------- 실행 결과 -----------------------------------------

c:\Users\user>imp system/manager file=hr_all.dmp fromuser=hr touser=tiger

Import: Release 11.2.0.2.0 - Production on 수 7월 6 14:20:45 2022

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






































































































































































































































































































































