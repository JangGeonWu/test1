SELECT  dname,deptno 
FROM    department;
-- distinct
SELECT DISTINCT     deptno
FROM                student;

SELECT DISTINCT     deptno, grade
FROM                student
ORDER BY            DEPTNO, GRADE;

SELECT DISTINCT     position
FROM                professor;

SELECT dname dept_name, deptno as DN
FROM department;
-- 별명
SELECT dname "Department Name", deptno as "Department Num#"
FROM department;

SELECT studno "학번", name "학생의 이름", deptno "학과번호No"
FROM student;

-- 합성연산자
SELECT studno || ' ' || name as Student
FROM student;

/* 1. 부서 department 테이블의 구조를 확인하세요 + dname의 유형은? = VARCHAR2(30)  */
DESC department;

/* 2. 학생 테이블에서 학번, 이름, userid를 출력하세요. */

SELECT  studno, name, idnum as userid
FROM    student;

/* 3. 교수 테이블에서 교수 번호, 이름, 직급, 부서 번호를 출력하세요(교수 No, 이름, 직급, 학과 번호로 속성이 출력되도록). */
SELECT profno as "교수 No", name as "이름", position as "직급", deptno as "학과 번호"
FROM professor;

/* 4. 사원 테이블(emp)에서 중복을 제외한 job을 출력하세요. */
SELECT DISTINCT     job
FROM                emp;

/* 5. 사원 테이블에서 열 레이블이 Employee and Title이고, 콤마와 공백으로 구분된
이름과 직업이 연결되도록 출력하세요. */
SELECT ename || ',' || job as "Employee and Title"
FROM emp;

SELECT  name, weight, weight*2.2 as weight_pound
FROM    student;

/* ------------------------------------------------------- */

/* 1. 사원 테이블에서 사원 번호, 이름, 급여, 그리고 25% 증가된 급여를 모두 출력하세요.
증가된 급여의 열 레이블은 New Salary입니다,*/
SELECT  empno, ename, sal, sal * 1.25 as "New Salary"
From    emp;

/* 2. 1에 추가하여 새로운 급여(New Salary)에서 예전의 급여(SAL)을 빼는 열을 추가하세요. 열 레이블은 Increase입니다. */
SELECT  empno, ename, sal, sal * 1.25 as "New Salary", sal * 0.25 as "Increase"
From    emp;

CREATE TABLE ex_type(c CHAR(10), v VARCHAR(10));

Insert into ex_type
VALUES ('sql', 'sql');

SELECT *
FROM ex_type
WHERE v=c;

desc ex_type;

drop table ex_type;

/* 학생테이블에서 학번, 이름, 학과 번호를 출력하세요. */
SELECT  rowid, studno, name, deptno
FROM    student;

SELECT * from student where rowid='AAAE56AAEAAAAI9AAA';

SELECT rownum, rowid, dname
FROM dept
ORDER BY dname;

SELECT rownum, ename
FROM emp
WHERE rownum BETWEEN 1 and 3;


SELECT rownum, ename
FROM emp
WHERE rownum BETWEEN 2 and 3;

SELECT t1.rn, t1.ename
FROM ( SELECT rownum rn, ename 
        FROM    emp) t1
WHERE t1.rn BETWEEN 2 and 3;

SELECT rownum rn, ename 
        FROM    emp;
        
CREATE TABLE ex_time
(id     NUMBER(2),
basictime   TIMESTAMP,
standardtime TIMESTAMP WITH TIME ZONE,
localtime TIMESTAMP WITH LOCAL TIME ZONE);

INSERT INTO ex_time
VALUES (1, sysdate, sysdate, sysdate);

SELECT * FROM ex_time;

DESC SYS.DUAL;
SELECT * FROM SYS.DUAL;

SELECT 1 FROM DUAL;

/* 학생 테이블에서 1학년 학생만 검색하여 학번, 이름, 학과 번호를 출력하여라 */
SELECT studno, name, deptno
FROM student
WHERE grade = '1';

/* 교수 테이블에서 직급 조교수만 검색하여 이름, 직급, 급여, 학과 번호를 출력하여라 */
SELECT name, position, sal, deptno
FROM professor
WHERE position='조교수';

/* 학생 테이블에서 몸무게가 70kg 이하인 학생만 검색하여 학번, 이름, 학년, 학과번호, 몸무게를 출력하여라 */
SELECT studno, name, grade, deptno, weight
FROM student
WHERE weight <= 70;

/* 사원 테이블에서 급여가 2850이상인 사원의 이름, 직업, 급여를 출력하여라 */
SELECT ename, job, sal
FROM emp
WHERE sal >= 2850;

/* 학생 테이블에서 1학년이면서 몸무게가 70kg 이상인 학생만 검색하여 이름, 학년, 몸무게, 학과번호를 출력하여라 */
SELECT name, grade, weight, deptno
FROM student
WHERE weight >= 70 and grade = '1';

/* 사원 테이블에서 manager이면서 20번 부서에 근무하는 사원의 이름, 직업, 부서번호, 입사일를 출력하여라 */
SELECT ename, job, deptno, hiredate
FROM emp
WHERE job = 'MANAGER' AND deptno = '20';

/* 학생 테이블에서 1학년이거나 몸무게가 70 이상인 학생만 검색하여 이름, 학년, 몸무게, 학과번호를 출력하여라. */
SELECT  name, grade, weight, deptno
FROM    student
WHERE   grade='1' OR weight >= 70;

/* 사원 테이블에서 직업이 MANAGER이거나 20번 부서에 근무하는 사원의 이름, 직업, 부서번호, 입사일을 출력하세요. */
SELECT ename, job, deptno, hiredate
FROM emp
WHERE job = 'MANAGER' OR deptno = '20';

/* 사원 테이블에서 급여가 1500 ~ 5000 이고, 직업이 PRESIDENT나 ANALYST인 사원에 대해 사번, 이름, 직무, 급여를 출력하세요*/
SELECT empno, ename, job, sal
FROM emp
WHERE sal BETWEEN 1500 AND 5000
    AND JOB IN ('PRESIDENT', 'ANALYST');
    
/* 학생 테이블에서 성이 김씨인 학생의 이름, 학년, 학과 번호를 출력하여라*/
SELECT name, grade, deptno
FROM student
WHERE name LIKE '김%';

/* 학생 테이블에서 이름이 3글자, 성은 '김'씨고 마지막 글자가 '영'으로 끝나는 학생의 이름, 학년, 학과 번호를 출력하여라 */
SELECT  name, grade, deptno
FROM    student
WHERE   name LIKE '김_영';

/* 사원 테이블에서 급여가 1500 이상이고 이름에 'L'자를 포함하고 직업은 SALESMAN인 사원의 사번, 이름, 직업, 급여를 출력하세요. */
SELECT  empno, ename, job, sal
FROM    emp
WHERE   (sal >= 1500) and (job = 'SALESMAN') and (ename LIKE '%L%');

/* 사원 테이블에서 급여가 1500 이상이고 이름에 'L'자 2개를 포함하고 직업은 SALESMAN인 사원의 사번, 이름, 직업, 급여를 출력하세요. */
SELECT  empno, ename, job, sal
FROM    emp
WHERE   (sal >= 1500) and (job = 'SALESMAN') and (ename LIKE '%L%L%');

/* 학생 테이블에서 남학생들만 출력하시오. */
SELECT *
FROM student
WHERE idnum LIKE '______1%';

/* ESCAPE '\' 옵션은 LIKE 연산자에서 와일드 문자 자체를 포함하는 문자열을 검색할 때 사용 */
INSERT INTO student (studno, name)
VALUES  (33333, 'AA_BB');
INSERT INTO student (studno, name)
VALUES  (33333, 'CC_BB');

SELECT name
FROM student
WHERE name LIKE '%\_%' ESCAPE '\';

DELETE FROM student
WHERE name LIKE '%\_%' ESCAPE '\';

/* NULL 값을 포함하는 연산의 경우 결과가 NULL 값을 가진다.*/
SELECT empno, sal, comm, sal + comm
FROM emp;

SELECT nvl(null, 'B') FROM DUAL;
SELECT nvl2(null, 'A', 'B') FROM DUAL;

SELECT  name ,position, comm
FROM    professor;

SELECT name, position, comm
FROM professor
WHERE comm is NULL;

/* 사원 테이블에서 보직 수당이 없고, 20번 부서에 근무하고, 이름은 'A'로 시작하는 사원을 출력해보세요. */
SELECT *
FROM emp
WHERE (comm IS NULL) and (deptno = '20') and (ename LIKE 'A%');

/* 교수 테이블에서 급여에 보직수당을 더한 값은 sal_com이라는 별명으로 출력하여라. */
SELECT name, sal, comm, nvl(sal+comm, sal) sal_com
FROM professor;

/* 102 학과 이고, 1학년 또는 4학년인 학생의 이름, 학년, 학과 번호를 출력하여라. */
SELECT name, grade, deptno
FROM student
WHERE (deptno = '102') AND (grade = '4' OR grade = '1');

/* 102 학과의 학생 중에서 4학년 학생이거나 소속학과에 상관없이 1학년 학생의 이름, 학년 학과 번호를 출력하여라 */
SELECT name, grade, deptno
FROM student
WHERE deptno = '102' AND grade = '4' OR grade = '1';

/* 집합 연산을 위한 테이블 생성 */
CREATE TABLE stud_heavy
AS SELECT *
FROM student
WHERE weight >= 70 AND grade = '1';

CREATE TABLE stud_101
AS SELECT *
FROM student
WHERE deptno = 101 AND grade = '1';

SELECT *
FROM stud_heavy
MINUS
SELECT *
FROM stud_101;


/* 학생 테이블과 교수 테이블에 대해 union 연산을 수행하여 name, userid, sal을 출력해보세요. 전체 인원수를 확인해보세요.*/
SELECT name, userid, 0 as sal
FROM student
UNION
SELECT name, userid, sal
FROM professor;

/* 교수 테이블에서 전체 교수의 급여를 인상하기 위한 직원 명단을 출력하고자 한다. 단, 직급이 전임강사인 사람들은 명단에서 제외하세요.
단, 'MINUS' 집합 연산을 이용할 것*/
SELECT name, position
FROM professor
MINUS
SELECT name, position
FROM professor
WHERE position = '전임강사';

/* 이름으로 오름차순 정렬 */
SELECT name, grade, tel
FROM student
ORDER BY name;

/* 이름으로 내림차순 정렬 */
SELECT name, grade, tel
FROM student
ORDER BY name DESC;

-- 다중 열에 의한 정렬
/* 모든 사원의 이름과 급여 및 부서번호를 출력하는데, 부서 번호로 오름차순으로 정렬한 후 급여에 대해서 내림차순으로 정렬하라. */
SELECT ename, job, deptno, sal
FROM emp
ORDER BY deptno, sal DESC;

-- 06-28 QUIZ
/* 1. 다음 질의는 오류를 포함하고 있다. 올바르게 수정하여 출력하시오.*/
/* SELECT name, job, sal*12 AS yearly sal
   FROM emp; */

SELECT ename, job, sal*12 AS "yearly sal"
FROM emp;

/* 2. 사원 테이블에서 이름에 A를 포함하고 커미션을 받지 않는 사원의 사번, 이름, 급여, 커미션을 출력하시오.*/
SELECT empno, ename, sal, comm
FROM emp
WHERE ename LIKE '%A%' AND comm IS NULL;

/* 3. $1250~$2800을 받고 부서 20이나 20에 속하는 사원의 이름과 급여를
출력하세요. 열의 레이블을 Employee와 Monthly Salary로 하세요.
(결과는 아래와 같도록) */
SELECT ename AS Employee, sal AS "Monthly Salary"
FROM emp
WHERE (sal BETWEEN 1250 AND 2800) AND deptno IN (20, 30)
ORDER BY sal;

/* 4. 학생 테이블에서 이름이 '진'으로 끝나고, 지도교수가 배정되지 않는
101번 학과 학생의 아이디, 이름, 학년, 학과 번호를 출력하여라. */
SELECT userid, name, grade, deptno
FROM student
WHERE name LIKE '%진' AND deptno = 101 AND profno IS NULL;

/* 5.  101번과 202번 학과에 속하지 않는 모든 교수의 이름과 학과번호를
교수명 순으로 정렬되도록 출력하세요. */
SELECT name, deptno
FROM professor
WHERE deptno NOT IN (101,202)
ORDER BY name;

/* 6. 업무(job)가 MANAGER이거나 SALESMAN이며 급여가 $1500, $3000 또는 5000이 아닌 모든 사원에 대해서
이름, 업무, 그리고 급여를 출력하세요.*/
SELECT ename, job, sal
FROM emp
WHERE job IN ('MANAGER','SALESMAN') AND sal NOT IN (1500, 3000, 5000)
ORDER BY sal DESC;

-- 부서가 10과 30에 속하는 모든 사원의 이름과 부서번호를 이름의 알파벳순, 그 다음 부서번호의 오름차순, 급여의 내림차순으로 정렬되도록 질의문을 형성하여라
SELECT ename, deptno
FROM emp
WHERE deptno IN (10, 30)
ORDER BY ename, deptno, sal DESC;

-- 1982년에 입사한 모든 사원의 이름과 입사일을 구하는 질의문은?
SELECT ename, hiredate
FROM emp
WHERE hiredate LIKE '82%';

-- 보너스를 받는 모든 사원에 대해서 이름, 급여 그리고 보너스를 출력하는 질의문을 형성하라. 단 급여와 보너스에 대해서 내림차순 정렬
SELECT ename, sal, comm
FROM emp
WHERE (comm IS NOT NULL) AND (comm > 0)
ORDER BY sal DESC, comm DESC;

-- 보너스가 급여의 20% 이상이고 부서번호가 30인 많은 모든 사원에 대해서 이름, 급여 그리고 보너스를 출력하는 질의문을 형성하라.
SELECT ename, sal, comm
FROM emp
WHERE deptno = 30 AND (comm >= sal*0.2);

-- INITCAP 함수
SELECT userid, INITCAP(userid)
FROM student
WHERE name = '김영균';

-- LOWER, UPPER 함수
SELECT userid, LOWER(userid), UPPER(userid)
FROM student
WHERE studno = 20101;

/* adams라는 사원이 있으면 사번, 이름, 직업, 부서번호를 출력하세요. */
SELECT empno, ename, job, deptno
FROM emp
WHERE LOWER(ename) = 'adams';


-- 문자열 길이 반환 함수 LENGTH, LENGTHB
SELECT LENGTH('홍길동'), LENGTHB('홍길동'), LENGTH('abc'), LENGTHB('abc') FROM DUAL;

SELECT dname, LENGTH(dname), LENGTHB(dname)
FROM department;

SELECT * FROM nls_database_parameters
WHERE parameter = 'NLS_CHARACTERSET';
-- KO16KSC5601 : 한글 완성형(개당 2바이트)
-- AL32UTF8 : 개당 3바이트

-- 이름이 J,A,M으로 시작하는 모든 사원에 대해 첫번째 문자는 대문자, 나머지는 모두 소문자로 사원의 이름과 길이를 출력하세요.
-- 이때, 이름순으로 정렬하세요. 그리고 각각의 열에 Name, Length라는 레이블을 부여하세요.
SELECT INITCAP(ename) as "Name" , LENGTH(ename) as "Length"
FROM emp
WHERE (upper(ename) LIKE 'J%') OR (upper(ename) LIKE 'A%') OR (upper(ename) LIKE 'M%')
ORDER BY ename;


-- 1. concat 함수 : 첫번째 문자와 두번째 문자를 연결
SELECT concat(concat(name, '의 직책은 '), position)
FROM professor;

-- 2. substr 함수 : 문자열의 일부를 추출한다.
/*학생 테이블에서 1학년 '남' 학생의 이름, 주민번호, 생년월일, 태어난 달을 출력하여라. */
SELECT name, idnum, SUBSTR(idnum, 1, 6) as "BIRTHDAY_date", SUBSTR(idnum, 3, 2) as "BIRTHDAY_month"
FROM student
WHERE grade='1' and SUBSTR(idnum, 7, 1) = '1';
/*이름이 J,A,M으로 시작하는 모든 사원에 대해 첫번째 문자는 대문자, 나머지는 모두 소문자로 사원의 이름과 길이를 출력하세요.
이때, 이름순으로 정렬하세요. 그리고 각각의 열에 Name, Length라는 레이블을 부여하세요. SUBSTR을 이용하세요. */
SELECT INITCAP(ename) as "Name" , LENGTH(ename) as "Length"
FROM emp
WHERE UPPER(SUBSTR(ename, 1, 1)) IN ('J','A','M')
ORDER BY ename; 

-- 3. instr 함수 : 문자열 중 사용자가 지정한 특정 문자가 포함된 위치를 반환하는 함수
-- INSTR { ---, char, n, m): n번째 위치부터 m번째 char의 위치를 찾음, 위치는 첫번째 글자가 1인 기준을 적용.
/* 부서 테이블의 부서 이름 칼럼에서 '과'글자의 위치를 출력하여라 */
SELECT dname, INSTR(dname, '과')
FROM department;

-- 4. lpad, rpad 함수 : 왼쪽*오른쪽으로 지정문자를 규정된 만큼 삽입
/* 교수 테이블에서 직급 칼럼의 왼쪽에 '*' 문자를 삽입하여 10바이트로 출력하고 교수 아이디 칼럼은 오른쪽에 '+' 문자를
삽입하여 12바이트로 출력하여라.*/
SELECT LPAD(position, 10, '*'), RPAD(userid, 12, '+')
FROM professor;

-- 5. ltrim, rtrim 함수 : 왼쪽*오른쪽에 있는 지정문자를 모두 삭제, 다른 문자가 껴있으면 안지워짐( LTRIM('*a*b*c*', '*') -> 'ab*c*')
SELECT LTRIM('xxxyyyyxyxXxyLAST WORD', 'xy') FROM dual; -- char에 여러 글자가 있어도 한글자씩 비교하여 TRIM하는 것을 볼 수 있다.
/* 부서 테이블에서 부서 이름의 마지막 글자인 '과'를 삭제하여 출력하여라. */
SELECT RTRIM(dname, '과')
FROM department;

-- 2022-06-29 QUIZ
/* 1. 사원테이블에서 사원명 칼럼의 별명은 Name, 급여*12는 Annual Salary로 부여하여 출력해보세요.*/
SELECT ename as "Name", sal*12 as "Annual Salary"
FROM emp;

/* 2. 사원테이블의 사원명과 급여를 아래와 같은 포맷으로 출력해 보세요. */
SELECT CONCAT(CONCAT(ename, ': 1 Month Salary = '),sal) as "Monthly"
FROM emp;

/* 3. 사원테이블에서 급여가 $1500 ~ 5000 이고 직무가 PRESIDENT나 ANALYST가 아닌 모든 사원에 대해
사번, 이름, 직무, 급여를 직무, 급여의 오름차순으로 정렬하세요. */
SELECT empno, ename, job, sal
FROM emp
WHERE job NOT IN ('PRESIDENT', 'ANALYST') AND sal BETWEEN 1500 AND 5000
ORDER BY job, sal;

/* 4. 사원테이블에서 2월에 입사한 사원을 출력해보세요(SUBSTR 사용)*/
SELECT *
FROM emp
WHERE SUBSTR(hiredate,4,2) = '02';

/* 5. 사원테이블에서 20번이나 30번 부서에 속하고 이름의 마지막 글자에 'S'자를 포함한 사원들 중에서 마지막 'S'를 제거해보세요.*/
SELECT ename, RTRIM(ename, 'S') as "RTRIM"
FROM emp
WHERE deptno IN (20, 30) AND ename LIKE '%S';

/* 사원 테이블에서 평균 급여가 2300 이상인 부서의 부서 번호, 부서별 평균 급여를 출력하세요. */
SELECT      deptno, ROUND(AVG(sal),1)
FROM        emp
GROUP BY    deptno
HAVING      AVG(sal) >= 1900;

/* 1000이상 급여를 받는 사원들에 대해 부서별 평균 급여를 구한 후, 부서별 평균 급여가 1900이상인 부서의
부서번호, 부서별 평균 급여를 출력하세요. (소수점 1자리까지)*/
SELECT      deptno, ROUND(AVG(sal),1)
FROM        emp
WHERE       sal >= 1000
GROUP BY    deptno
HAVING      AVG(sal) >= 1900;

-- WHERE 절에는 그룹함수를 사용해서는 안된다. 예시) WHERE count(*) > 4;

-- 여러개의 SQL 함수를 중첩해 사용할 시, 맨 안쪽 함수부터 처리한 후 처리 결과를 가장 가까운 바깥쪽 함수에 넘긴다.
/* 학과별 학생의 평균 몸무게 중 최대 평균 몸무게를 출력하라. */
SELECT MAX(avg(weight))
FROM student
GROUP BY deptno;

/* 학과 별 학생 수가 최대, 최소인 학과의 학생 수를 출력하여라.*/
SELECT MAX(count(studno)) as max_count, MIN(count(studno)) as min_count
FROM student
GROUP BY deptno;

-- 조인
SELECT studno, name, student.deptno, dname, loc
FROM student, department
WHERE student.deptno = department.deptno;


SELECT a.studno, a.name, b.deptno, b.dname, b.loc
FROM student a, department b
WHERE a.deptno = b.deptno;

/* 1. 교수 이름, 급여, 학과 번호, 학과 이름, 학과 위치를 출력하세요. */
SELECT p.name, p.sal, p.deptno, d.dname, d.loc
FROM professor p, department d
WHERE p.deptno = d.deptno;

/* '전인하' 학생의 학번, 이름, 소속 학과 이름, 그리고 학과 위치를 출력하여라.*/
SELECT studno, name, dname, loc
FROM student, department
WHERE student.deptno = department.deptno
    AND name = '전인하';

/* 몸무게가 80kg 이상인 학생의 학번, 이름, 체중, 학과 이름, 학과 위치를 출력하여라. */
SELECT s.studno, s.name, s.weight, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno 
    AND s.weight >= 80;

/* 2. 사원 테이블에서 'DALLAS'에 근무하는 사원의 사번, 이름, 부서번호, 근무지를 출력하세요. */
SELECT  e.empno, e.ename, e.deptno, d.loc
FROM    emp e, dept d
WHERE   e.deptno = d.deptno
    AND loc = 'DALLAS';

/* 3. 학생의 이름, 학번, 학과번호, 지도교수 번호, 교수 이름을 출력하세요. */
SELECT s.name as "student name", s.studno, s.deptno, s.profno, p.name as "professor name"
FROM student s, professor p
WHERE s.profno = p.profno;

/* 4. 몸무게가 70kg 이상인 학생의 이름, 학번, 학과번호, 지도교수 번호, 교수이름, 학과 이름, 학과 위치를 출려하세요. */
SELECT s.name 이름, s.studno 학번, s.deptno 학과번호, s.profno as "지도교수No", p.name 지도교수명, d.dname 학과이름, d.loc 학과위치
FROM student s, professor p, department d
WHERE s.deptno = d.deptno AND s.profno = p.profno AND s.weight >= 70;

-- 카티션 곱(CROSS JOIN, 생략해도 됨) : WHERE student (CROSS JOIN | ,) department
SELECT * FROM student, department; -- 총 144개의 행이 인출됨(student's cardinarlity 16, department's cardinality 9, 16X9=144)
SELECT * FROM student CROSS JOIN department; -- 위의 명령문과 똑같다.

-- 동등 조인(EQUI JOIN) : WHERE student.deptno = department.deptno, 공통된(정확하게 일치하는) column을 찾아 join한다.
SELECT  s.studno, s.name, s.deptno, d.dname, d.loc
FROM    student s, department d
WHERE   s.deptno = d.deptno;

-- 자연 조인(NATURAL JOIN) : FROM student NATURAL JOIN department; 이때, 테이블 별명을 사용하지 말아야 한다.
SELECT  studno, name, deptno, dname, loc
FROM    student NATURAL JOIN department;
/* NATURAL JOIN을 이용하여 교수 번호, 이름, 학과 번호, 학과 이름을 출력하여라. */
SELECT profno, name, deptno, dname
FROM professor NATURAL JOIN department;
/* NATURAL JOIN을 이용하여 4학년 학생의 이름, 학과 번호, 학과 이름을 출력하여라. */
SELECT name, deptno, dname
FROM student NATURAL JOIN department
WHERE grade = '4';
-- JOIN ~~ USING: FROM table1 JOIN table2 USING (col); -> col에 괄호 꼭 붙여야 한다.
SELECT name, deptno, dname
FROM student JOIN department USING (deptno)
WHERE grade = '4';
-- 즉, WHERE 절의 '='(Oracle Join)을 이용하거나, FROM 절의 'NATURAL JOIN'이나 '~ JOIN ~ USING (~)'을 사용하여 EQUI JOIN을 적용할 수 있다.

-- NON EQUI join : '<', '>', BETWEEN a AND b처럼 '=' 조건이 아닌 연산자 사용하는 경우
SELECT p.profno, p.name, p.sal, s.grade
FROM professor p, salgrade s
WHERE p.sal BETWEEN s.losal AND s.hisal;
-- salgrade라는 테이블의 형태
SELECT * FROM salgrade;

-- OUTER JOIN : 양측 칼럼 값 중 하나가 NULL이지만, 조인 결과로 출력할 필요가 있는 경우, null이 출력되는 테이블의 칼럼에 (+) 기호를 추가.
/* 학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수의 이름, 직급을 출력하세요. 
단, 지도교수를 배정받지 않은 학생도 출력하라. */
SELECT s.name as "student name", s.grade, p.name as "professor name", p.position
FROM professor p, student s
WHERE s.profno = p.profno(+) -- p.name과 p.position에 null이 있을 것이므로
ORDER BY p.profno;

-- select * from student;

/* 학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수의 이름, 직급을 출력하세요. 
단, 지도학생을 배정받지 않은 교수도 출력하라. */
SELECT s.name as "student name", s.grade, p.name as "professor name", p.position
FROM professor p, student s
WHERE s.profno(+) = p.profno
ORDER BY p.profno;

/* 학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수의 이름, 직급을 출력하세요. 
단, 지도교수가 없는 학생과 지도학생을 배정받지 않은 교수 모두를 출력하라. */
(SELECT s.name as "student name", s.grade, p.name as "professor name", p.position
FROM professor p, student s
WHERE s.profno(+) = p.profno)
UNION
(SELECT s.name as "student name", s.grade, p.name as "professor name", p.position
FROM professor p, student s
WHERE s.profno = p.profno(+))
ORDER BY 1; -- '1 = s.name'

-- '~ [align] OUTER JOIN ~ ON (조건)' 절을 이용하여 OUTER JOIN을 수행한다.
-- FROM table1 [RIGHT | LEFT | FULL] OUTER JOIN table2 ON table1.col = table2.col;
/* 학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수의 이름, 직급을 출력하세요. 
단, 지도교수가 없는 학생과 지도학생을 배정받지 않은 교수 모두를 출력하라. */
SELECT s.name as "student name", s.grade, p.name as "professor name", p.position
FROM professor p FULL OUTER JOIN student s ON s.profno = p.profno
ORDER BY 1;

-- 하나의 테이블(자기 자신)내에 있는 칼럼끼리 연결하는 조인이 필요한 경우, SELF JOIN을 사용한다.
SELECT c.deptno, c.dname, c.college, d.dname college_name, c.loc
FROM department c, department d
WHERE c.college = d.deptno;
-- JOIN ~ ON 방법 : FROM table1 c JOIN table1 d ON c.col1 = d.col2; 
SELECT dept.dname || '의 소속은 ' || org.dname
FROM department dept, department org
WHERE dept.college = org.deptno AND dept.deptno >= 201;

SELECT dept.dname || '의 소속은 ' || org.dname
FROM department dept JOIN department org ON dept.college = org.deptno
WHERE dept.deptno >= 201;

-- 0701 Quiz
/* 1. 총 급여가 $5,000이 넘는 각 JOB에 대해 JOB과 월급 총액을
출력하세요. (단, PRESIDENT를 제외시키고, 월급 총액별으로 정렬) */
SELECT job, sum(sal) as payroll
FROM emp
WHERE job != 'PRESIDENT'
GROUP BY job
HAVING sum(sal) >= 5000
ORDER BY 2;

-- 2,3번 employees, departments, locations
/* 2. Shipping부서에 근무하는 사원에 대해 last_name, job_id,
부서번호, 부서이름을 last_name 순으로 출력하세요. (결과-45건) */
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e, departments d, locations l
WHERE d.department_name = 'Shipping' AND
        d.department_id = e.department_id AND 
        l.location_id = d.location_id;

/* 3. south san francisco에서 근무하는 모든 사원에 대해
last_name, job, 부서번호, 부서이름, 부서위치(city)를
출력하세요. (결과-45건) */
SELECT e.last_name, e.job_id, e.department_id, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE l.city = 'South San Francisco' AND
        d.department_id = e.department_id AND 
        l.location_id = d.location_id;

/* 4. 사원의 이름과 사원 번호 그리고 관리자 이름과
관리자 번호를 출력하세요.(열 레이블 Employee,
Emp#, Manager 그리고 Mgr#)
Employee Emp# Manager Mgr# */
SELECT e.ename Employee, e.empno as "Emp#", m.ename Manager, m.empno as "Mgr#"
FROM emp e, emp m
WHERE e.mgr = m.empno;

select * from emp;

-- 서브쿼리: 파악할 때는 전체를 본 뒤 세부적으로 들어가고, 실행할 때는 서브쿼리를 먼저 확인한 뒤 전체 쿼리로 실행하는 습관을 들이자.
SELECT name, position
FROM professor
WHERE position = (SELECT position
                  FROM professor
                  WHERE name = '전은지');

-- 사용자 아이디가 'jun123'인 학생과 같은 학년인 학생의 학번, 이름, 학년을 출력하여라.
SELECT  studno, name, grade
FROM    student
WHERE   grade = (SELECT grade
                 FROM student
                 WHERE userid = 'jun123');
                 
-- 101번 학과 학생들의 평균 몸무게보다 몸무게가 적은 학생의 이름, 학과번호, 몸무게를 출력하여라.
SELECT  name, deptno, weight
FROM    student
WHERE   weight < (SELECT avg(weight)
                  FROM student
                  WHERE deptno = 101)                
ORDER BY deptno;
                
-- 20101번 학생과 학년이 같고, 키는 20101번 학생보다 큰 학생의 이름, 학년, 키를 출력하여라. + 학과이름도 추가하여라.
SELECT  name, grade, height, deptno, dname
FROM    student NATURAL JOIN department
WHERE   grade = (SELECT grade
                 FROM student
                 WHERE studno = 20101)
AND     height > (SELECT height
                 FROM student
                 WHERE studno = 20101);

-- 다중행 서브쿼리, IN, ANY, SOM, ALL(모든 값이 일치하면 참), EXISTS(만족하는 값이 하나라도 '존재하면' 참)

-- x in (a, b, ...)는 x = a OR x = b OR ...와 같다.
-- 정보미디어학부(부서번호 100)에 소속된 모든 학생의 학번, 이름, 학과 번호를 출력하여라.
SELECT studno, name, deptno
FROM student
WHERE deptno IN (SELECT deptno
                FROM department
                WHERE college = 100);

-- ANY(SOM)은 '<', '>'와 같은 범위 비교도 가능하다. 주로 ANY를 사용한다.
SELECT studno, name, height
FROM student
WHERE height > ANY (SELECT height
                    FROM student
                    WHERE grade = '4');          

-- ALL : 범위 비교 시, 모든 값과 비교
SELECT studno, name, height
FROM student
WHERE height > ALL (SELECT height
                    FROM student
                    WHERE grade = '4'); 

-- EXISTS : 서브쿼리에서 검색된 결과가 하나라도 존재하면 메인쿼리 조건절이 참이 되는 연산자.
-- 반대로 서브쿼리에서 검색된 결과가 존재하지 않으면 메인쿼리의 조건절은 거짓('선택된 레코드가 없습니다')
-- NOT EXISTS : EXISTS의 반대
SELECT profno, name, sal, comm, SAL+NVL(comm, 0)
FROM professor
WHERE EXISTS (SELECT profno
                FROM professor
                WHERE comm IS NOT NULL); 
-- 서브쿼리가 존재하므로 메인쿼리가 동작함. 출력되는 값 9901, 9903, 9905, 9908은 의미 없고, 값이 출력되는 것이 중요함

-- 학생 중에서 goodstudent라는 사용자 아이디가 없으면 1을 출력하라,
SELECT 1 userid_exist
FROM dual
WHERE not exists (  select userid
                    from student 
                    where userid = 'goodstudent'); -- 존재하지 않으므로 레코드(1)를 출력함

SELECT 1 userid_exist
FROM dual
WHERE not exists (  select userid
                    from student 
                    where userid = 'jun123'); -- 존재하므로 레코드(1)를 출력하지 않음

SELECT 1 userid_exist
FROM dual
WHERE exists (  select userid
                from student 
                where userid = 'goodstudent'); -- 존재하지 않으므로 레코드(1)를 출력하지 않음

SELECT 1 userid_exist
FROM dual
WHERE exists (  select userid
                from student 
                where userid = 'jun123'); -- 존재하므로 레코드(1)를 출력함

-- 학과별 학생수가 최대인 학과번호와 학생 수를 출력하세요.
SELECT deptno as "학과번호", count(*) as "학생수"
FROM student
GROUP BY deptno
HAVING count(*) =  (SELECT max(count(*))
                    FROM student
                    GROUP BY deptno);

-- 다중 컬럼 서브쿼리 : PAIRWISE(col을 쌍으로 묶어 동시에 비교), UNPAIRWISE(col마다 나누어 비교, AND 연산 수행)
-- PAIRWISE : 예시)... WHERE (col1, col2) IN (SELECT col1, col2 FROM ...) : col1-col1, col2-col2를 동시에 비교해 둘 다 일치해야 된다.
-- 학년별로 몸무게가 최소인 학생의 이름, 학년, 몸무게를 출력하여라.
SELECT name, grade, weight
FROM student
WHERE (grade, weight) IN (SELECT grade, MIN(weight)
                        FROM student
                        GROUP BY grade)
ORDER BY grade;

-- 사원 테이블을 조회하여 각 부서별로 최대 급여를 받는 사원들의 부서번호, 이름, 급여를 출력하세요.
SELECT deptno, ename, sal
FROM emp
WHERE (deptno, sal) IN (SELECT deptno, MAX(sal)
                        FROM emp
                        GROUP BY deptno)
ORDER BY deptno;

-- UNPAIRWISE : 예시) ... WHERE col1 IN (SELECT col1 FROM ...) AND col2 IN (SELECT col2 FROM ...) ... : col1-col1 따로, col2-col2 따로 비교한다.
-- UNPAIRWISE 방법을 이용, 학년별로 몸무게가 최소인 학생의 이름, 학년, 몸무게를 출력하여라.
SELECT name, grade, weight
FROM student
WHERE (weight) IN   (SELECT MIN(weight)
                     FROM student
                     GROUP BY grade)
AND   (grade) IN    (SELECT grade
                     FROM student
                     GROUP BY grade)
ORDER BY grade; -- 값이 완전 달라지므로, 비교 방법에 따라서 출력 결과가 달라질 수 있다는 점에 유의.

/* 상호연산 서브쿼리 : 메인쿼리절과 서브쿼리간 검색 결과를 교환하는 서브쿼리로, 결과를 교환하기 위해
서브쿼리의 WHERE 조건절에서 메인쿼리의 테이블과 연결한다. 단, 성능저하의 원인이 되므로 주의할 것(안쓰는게 좋다).
SELECT column list
FROM table1
WHERE [col | expr] operator (SELECT [col | expr] FROM table2 WHERE table2.col operator table1.col);
*/
-- 각 학과 학생의 평균 키보다 키가 큰 학생의 이름, 학과 번호, 키를 출력하여라.
SELECT name, deptno, height
FROM student s1
WHERE height > (SELECT avg(height)
                FROM student s2
                WHERE s2.deptno = s1.deptno)
ORDER BY deptno;

-- 실무에서 서브쿼리 사용시 주의사항
-- 1. 단일행 서브쿼리에서 오류가 발생하는 경우(서브쿼리에서 복수 행일 때 '='쓰지 말고 IN, ANY, ALL 쓰라는 뜻)
-- 2. 메인쿼리와 서브쿼리 칼럼의 수가 일치하지 않는 경우.
-- 3. 서브쿼리 내에서 ORDER BY 절 사용하면 오류 발생
-- 4. 서브쿼리의 결과가 NULL(출력되는 레코드 없음)인 경우

-- 실습
/* Blake와 같은 부서에 있는 모든 사원에 대해서 사원 이름과 입사일을 디스플레이 하라. */
SELECT ename, hiredate
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE INITCAP(ename) = 'Blake')
ORDER BY ename;

/* 평균 급여 이상을 받는 모든 사원에 대해서 사원 번호와 이름을 디스플레이하는 질의문 + 급여 내림차순 정렬 */
SELECT empno, ename, sal
FROM emp
WHERE sal >= (SELECT AVG(sal)
              FROM emp)
ORDER BY sal desc;

/* 부서번호와 급여가 보너스를 받는 어떤 사원의 부서 번호와 급여에 일치하는 사원의 이름, 부서번호, 그리고 급여를 디스플레이하라. */
SELECT ename, deptno, sal
FROM emp
WHERE (deptno, sal) IN (SELECT deptno, sal
                        FROM emp
                        WHERE comm is not null AND comm <> 0);

-- Scalar Subquery : 질의 수식으로부터 유도된 Scalar 값을 지정하기 위해서 사용한다.
-- 오직 하나의 값만 반환하며, 소량의 데이터를 다룰 때만 사용하는 것이 좋다.
-- 1. Select List에서의 Scalar Subquery
-- 2. Where 절에서의 Scalar Subquery
-- 3. Order By 절에서의 Scalar Subquery
-- 4. CASE 수식에서의 Scalar Subquery
-- 5. 함수에서의 Scalar Subquery
-- 이런거를 쓸 수도 있다는 거지 굳이 외우거나 할 필요는 X

