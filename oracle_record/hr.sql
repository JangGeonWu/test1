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
-- ����
SELECT dname "Department Name", deptno as "Department Num#"
FROM department;

SELECT studno "�й�", name "�л��� �̸�", deptno "�а���ȣNo"
FROM student;

-- �ռ�������
SELECT studno || ' ' || name as Student
FROM student;

/* 1. �μ� department ���̺��� ������ Ȯ���ϼ��� + dname�� ������? = VARCHAR2(30)  */
DESC department;

/* 2. �л� ���̺��� �й�, �̸�, userid�� ����ϼ���. */

SELECT  studno, name, idnum as userid
FROM    student;

/* 3. ���� ���̺��� ���� ��ȣ, �̸�, ����, �μ� ��ȣ�� ����ϼ���(���� No, �̸�, ����, �а� ��ȣ�� �Ӽ��� ��µǵ���). */
SELECT profno as "���� No", name as "�̸�", position as "����", deptno as "�а� ��ȣ"
FROM professor;

/* 4. ��� ���̺�(emp)���� �ߺ��� ������ job�� ����ϼ���. */
SELECT DISTINCT     job
FROM                emp;

/* 5. ��� ���̺��� �� ���̺��� Employee and Title�̰�, �޸��� �������� ���е�
�̸��� ������ ����ǵ��� ����ϼ���. */
SELECT ename || ',' || job as "Employee and Title"
FROM emp;

SELECT  name, weight, weight*2.2 as weight_pound
FROM    student;

/* ------------------------------------------------------- */

/* 1. ��� ���̺��� ��� ��ȣ, �̸�, �޿�, �׸��� 25% ������ �޿��� ��� ����ϼ���.
������ �޿��� �� ���̺��� New Salary�Դϴ�,*/
SELECT  empno, ename, sal, sal * 1.25 as "New Salary"
From    emp;

/* 2. 1�� �߰��Ͽ� ���ο� �޿�(New Salary)���� ������ �޿�(SAL)�� ���� ���� �߰��ϼ���. �� ���̺��� Increase�Դϴ�. */
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

/* �л����̺��� �й�, �̸�, �а� ��ȣ�� ����ϼ���. */
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

/* �л� ���̺��� 1�г� �л��� �˻��Ͽ� �й�, �̸�, �а� ��ȣ�� ����Ͽ��� */
SELECT studno, name, deptno
FROM student
WHERE grade = '1';

/* ���� ���̺��� ���� �������� �˻��Ͽ� �̸�, ����, �޿�, �а� ��ȣ�� ����Ͽ��� */
SELECT name, position, sal, deptno
FROM professor
WHERE position='������';

/* �л� ���̺��� �����԰� 70kg ������ �л��� �˻��Ͽ� �й�, �̸�, �г�, �а���ȣ, �����Ը� ����Ͽ��� */
SELECT studno, name, grade, deptno, weight
FROM student
WHERE weight <= 70;

/* ��� ���̺��� �޿��� 2850�̻��� ����� �̸�, ����, �޿��� ����Ͽ��� */
SELECT ename, job, sal
FROM emp
WHERE sal >= 2850;

/* �л� ���̺��� 1�г��̸鼭 �����԰� 70kg �̻��� �л��� �˻��Ͽ� �̸�, �г�, ������, �а���ȣ�� ����Ͽ��� */
SELECT name, grade, weight, deptno
FROM student
WHERE weight >= 70 and grade = '1';

/* ��� ���̺��� manager�̸鼭 20�� �μ��� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �Ի��ϸ� ����Ͽ��� */
SELECT ename, job, deptno, hiredate
FROM emp
WHERE job = 'MANAGER' AND deptno = '20';

/* �л� ���̺��� 1�г��̰ų� �����԰� 70 �̻��� �л��� �˻��Ͽ� �̸�, �г�, ������, �а���ȣ�� ����Ͽ���. */
SELECT  name, grade, weight, deptno
FROM    student
WHERE   grade='1' OR weight >= 70;

/* ��� ���̺��� ������ MANAGER�̰ų� 20�� �μ��� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �Ի����� ����ϼ���. */
SELECT ename, job, deptno, hiredate
FROM emp
WHERE job = 'MANAGER' OR deptno = '20';

/* ��� ���̺��� �޿��� 1500 ~ 5000 �̰�, ������ PRESIDENT�� ANALYST�� ����� ���� ���, �̸�, ����, �޿��� ����ϼ���*/
SELECT empno, ename, job, sal
FROM emp
WHERE sal BETWEEN 1500 AND 5000
    AND JOB IN ('PRESIDENT', 'ANALYST');
    
/* �л� ���̺��� ���� �达�� �л��� �̸�, �г�, �а� ��ȣ�� ����Ͽ���*/
SELECT name, grade, deptno
FROM student
WHERE name LIKE '��%';

/* �л� ���̺��� �̸��� 3����, ���� '��'���� ������ ���ڰ� '��'���� ������ �л��� �̸�, �г�, �а� ��ȣ�� ����Ͽ��� */
SELECT  name, grade, deptno
FROM    student
WHERE   name LIKE '��_��';

/* ��� ���̺��� �޿��� 1500 �̻��̰� �̸��� 'L'�ڸ� �����ϰ� ������ SALESMAN�� ����� ���, �̸�, ����, �޿��� ����ϼ���. */
SELECT  empno, ename, job, sal
FROM    emp
WHERE   (sal >= 1500) and (job = 'SALESMAN') and (ename LIKE '%L%');

/* ��� ���̺��� �޿��� 1500 �̻��̰� �̸��� 'L'�� 2���� �����ϰ� ������ SALESMAN�� ����� ���, �̸�, ����, �޿��� ����ϼ���. */
SELECT  empno, ename, job, sal
FROM    emp
WHERE   (sal >= 1500) and (job = 'SALESMAN') and (ename LIKE '%L%L%');

/* �л� ���̺��� ���л��鸸 ����Ͻÿ�. */
SELECT *
FROM student
WHERE idnum LIKE '______1%';

/* ESCAPE '\' �ɼ��� LIKE �����ڿ��� ���ϵ� ���� ��ü�� �����ϴ� ���ڿ��� �˻��� �� ��� */
INSERT INTO student (studno, name)
VALUES  (33333, 'AA_BB');
INSERT INTO student (studno, name)
VALUES  (33333, 'CC_BB');

SELECT name
FROM student
WHERE name LIKE '%\_%' ESCAPE '\';

DELETE FROM student
WHERE name LIKE '%\_%' ESCAPE '\';

/* NULL ���� �����ϴ� ������ ��� ����� NULL ���� ������.*/
SELECT empno, sal, comm, sal + comm
FROM emp;

SELECT nvl(null, 'B') FROM DUAL;
SELECT nvl2(null, 'A', 'B') FROM DUAL;

SELECT  name ,position, comm
FROM    professor;

SELECT name, position, comm
FROM professor
WHERE comm is NULL;

/* ��� ���̺��� ���� ������ ����, 20�� �μ��� �ٹ��ϰ�, �̸��� 'A'�� �����ϴ� ����� ����غ�����. */
SELECT *
FROM emp
WHERE (comm IS NULL) and (deptno = '20') and (ename LIKE 'A%');

/* ���� ���̺��� �޿��� ���������� ���� ���� sal_com�̶�� �������� ����Ͽ���. */
SELECT name, sal, comm, nvl(sal+comm, sal) sal_com
FROM professor;

/* 102 �а� �̰�, 1�г� �Ǵ� 4�г��� �л��� �̸�, �г�, �а� ��ȣ�� ����Ͽ���. */
SELECT name, grade, deptno
FROM student
WHERE (deptno = '102') AND (grade = '4' OR grade = '1');

/* 102 �а��� �л� �߿��� 4�г� �л��̰ų� �Ҽ��а��� ������� 1�г� �л��� �̸�, �г� �а� ��ȣ�� ����Ͽ��� */
SELECT name, grade, deptno
FROM student
WHERE deptno = '102' AND grade = '4' OR grade = '1';

/* ���� ������ ���� ���̺� ���� */
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


/* �л� ���̺�� ���� ���̺� ���� union ������ �����Ͽ� name, userid, sal�� ����غ�����. ��ü �ο����� Ȯ���غ�����.*/
SELECT name, userid, 0 as sal
FROM student
UNION
SELECT name, userid, sal
FROM professor;

/* ���� ���̺��� ��ü ������ �޿��� �λ��ϱ� ���� ���� ����� ����ϰ��� �Ѵ�. ��, ������ ���Ӱ����� ������� ��ܿ��� �����ϼ���.
��, 'MINUS' ���� ������ �̿��� ��*/
SELECT name, position
FROM professor
MINUS
SELECT name, position
FROM professor
WHERE position = '���Ӱ���';

/* �̸����� �������� ���� */
SELECT name, grade, tel
FROM student
ORDER BY name;

/* �̸����� �������� ���� */
SELECT name, grade, tel
FROM student
ORDER BY name DESC;

-- ���� ���� ���� ����
/* ��� ����� �̸��� �޿� �� �μ���ȣ�� ����ϴµ�, �μ� ��ȣ�� ������������ ������ �� �޿��� ���ؼ� ������������ �����϶�. */
SELECT ename, job, deptno, sal
FROM emp
ORDER BY deptno, sal DESC;

-- 06-28 QUIZ
/* 1. ���� ���Ǵ� ������ �����ϰ� �ִ�. �ùٸ��� �����Ͽ� ����Ͻÿ�.*/
/* SELECT name, job, sal*12 AS yearly sal
   FROM emp; */

SELECT ename, job, sal*12 AS "yearly sal"
FROM emp;

/* 2. ��� ���̺��� �̸��� A�� �����ϰ� Ŀ�̼��� ���� �ʴ� ����� ���, �̸�, �޿�, Ŀ�̼��� ����Ͻÿ�.*/
SELECT empno, ename, sal, comm
FROM emp
WHERE ename LIKE '%A%' AND comm IS NULL;

/* 3. $1250~$2800�� �ް� �μ� 20�̳� 20�� ���ϴ� ����� �̸��� �޿���
����ϼ���. ���� ���̺��� Employee�� Monthly Salary�� �ϼ���.
(����� �Ʒ��� ������) */
SELECT ename AS Employee, sal AS "Monthly Salary"
FROM emp
WHERE (sal BETWEEN 1250 AND 2800) AND deptno IN (20, 30)
ORDER BY sal;

/* 4. �л� ���̺��� �̸��� '��'���� ������, ���������� �������� �ʴ�
101�� �а� �л��� ���̵�, �̸�, �г�, �а� ��ȣ�� ����Ͽ���. */
SELECT userid, name, grade, deptno
FROM student
WHERE name LIKE '%��' AND deptno = 101 AND profno IS NULL;

/* 5.  101���� 202�� �а��� ������ �ʴ� ��� ������ �̸��� �а���ȣ��
������ ������ ���ĵǵ��� ����ϼ���. */
SELECT name, deptno
FROM professor
WHERE deptno NOT IN (101,202)
ORDER BY name;

/* 6. ����(job)�� MANAGER�̰ų� SALESMAN�̸� �޿��� $1500, $3000 �Ǵ� 5000�� �ƴ� ��� ����� ���ؼ�
�̸�, ����, �׸��� �޿��� ����ϼ���.*/
SELECT ename, job, sal
FROM emp
WHERE job IN ('MANAGER','SALESMAN') AND sal NOT IN (1500, 3000, 5000)
ORDER BY sal DESC;

-- �μ��� 10�� 30�� ���ϴ� ��� ����� �̸��� �μ���ȣ�� �̸��� ���ĺ���, �� ���� �μ���ȣ�� ��������, �޿��� ������������ ���ĵǵ��� ���ǹ��� �����Ͽ���
SELECT ename, deptno
FROM emp
WHERE deptno IN (10, 30)
ORDER BY ename, deptno, sal DESC;

-- 1982�⿡ �Ի��� ��� ����� �̸��� �Ի����� ���ϴ� ���ǹ���?
SELECT ename, hiredate
FROM emp
WHERE hiredate LIKE '82%';

-- ���ʽ��� �޴� ��� ����� ���ؼ� �̸�, �޿� �׸��� ���ʽ��� ����ϴ� ���ǹ��� �����϶�. �� �޿��� ���ʽ��� ���ؼ� �������� ����
SELECT ename, sal, comm
FROM emp
WHERE (comm IS NOT NULL) AND (comm > 0)
ORDER BY sal DESC, comm DESC;

-- ���ʽ��� �޿��� 20% �̻��̰� �μ���ȣ�� 30�� ���� ��� ����� ���ؼ� �̸�, �޿� �׸��� ���ʽ��� ����ϴ� ���ǹ��� �����϶�.
SELECT ename, sal, comm
FROM emp
WHERE deptno = 30 AND (comm >= sal*0.2);

-- INITCAP �Լ�
SELECT userid, INITCAP(userid)
FROM student
WHERE name = '�迵��';

-- LOWER, UPPER �Լ�
SELECT userid, LOWER(userid), UPPER(userid)
FROM student
WHERE studno = 20101;

/* adams��� ����� ������ ���, �̸�, ����, �μ���ȣ�� ����ϼ���. */
SELECT empno, ename, job, deptno
FROM emp
WHERE LOWER(ename) = 'adams';


-- ���ڿ� ���� ��ȯ �Լ� LENGTH, LENGTHB
SELECT LENGTH('ȫ�浿'), LENGTHB('ȫ�浿'), LENGTH('abc'), LENGTHB('abc') FROM DUAL;

SELECT dname, LENGTH(dname), LENGTHB(dname)
FROM department;

SELECT * FROM nls_database_parameters
WHERE parameter = 'NLS_CHARACTERSET';
-- KO16KSC5601 : �ѱ� �ϼ���(���� 2����Ʈ)
-- AL32UTF8 : ���� 3����Ʈ

-- �̸��� J,A,M���� �����ϴ� ��� ����� ���� ù��° ���ڴ� �빮��, �������� ��� �ҹ��ڷ� ����� �̸��� ���̸� ����ϼ���.
-- �̶�, �̸������� �����ϼ���. �׸��� ������ ���� Name, Length��� ���̺��� �ο��ϼ���.
SELECT INITCAP(ename) as "Name" , LENGTH(ename) as "Length"
FROM emp
WHERE (upper(ename) LIKE 'J%') OR (upper(ename) LIKE 'A%') OR (upper(ename) LIKE 'M%')
ORDER BY ename;


-- 1. concat �Լ� : ù��° ���ڿ� �ι�° ���ڸ� ����
SELECT concat(concat(name, '�� ��å�� '), position)
FROM professor;

-- 2. substr �Լ� : ���ڿ��� �Ϻθ� �����Ѵ�.
/*�л� ���̺��� 1�г� '��' �л��� �̸�, �ֹι�ȣ, �������, �¾ ���� ����Ͽ���. */
SELECT name, idnum, SUBSTR(idnum, 1, 6) as "BIRTHDAY_date", SUBSTR(idnum, 3, 2) as "BIRTHDAY_month"
FROM student
WHERE grade='1' and SUBSTR(idnum, 7, 1) = '1';
/*�̸��� J,A,M���� �����ϴ� ��� ����� ���� ù��° ���ڴ� �빮��, �������� ��� �ҹ��ڷ� ����� �̸��� ���̸� ����ϼ���.
�̶�, �̸������� �����ϼ���. �׸��� ������ ���� Name, Length��� ���̺��� �ο��ϼ���. SUBSTR�� �̿��ϼ���. */
SELECT INITCAP(ename) as "Name" , LENGTH(ename) as "Length"
FROM emp
WHERE UPPER(SUBSTR(ename, 1, 1)) IN ('J','A','M')
ORDER BY ename; 

-- 3. instr �Լ� : ���ڿ� �� ����ڰ� ������ Ư�� ���ڰ� ���Ե� ��ġ�� ��ȯ�ϴ� �Լ�
-- INSTR { ---, char, n, m): n��° ��ġ���� m��° char�� ��ġ�� ã��, ��ġ�� ù��° ���ڰ� 1�� ������ ����.
/* �μ� ���̺��� �μ� �̸� Į������ '��'������ ��ġ�� ����Ͽ��� */
SELECT dname, INSTR(dname, '��')
FROM department;

-- 4. lpad, rpad �Լ� : ����*���������� �������ڸ� ������ ��ŭ ����
/* ���� ���̺��� ���� Į���� ���ʿ� '*' ���ڸ� �����Ͽ� 10����Ʈ�� ����ϰ� ���� ���̵� Į���� �����ʿ� '+' ���ڸ�
�����Ͽ� 12����Ʈ�� ����Ͽ���.*/
SELECT LPAD(position, 10, '*'), RPAD(userid, 12, '+')
FROM professor;

-- 5. ltrim, rtrim �Լ� : ����*�����ʿ� �ִ� �������ڸ� ��� ����, �ٸ� ���ڰ� �������� ��������( LTRIM('*a*b*c*', '*') -> 'ab*c*')
SELECT LTRIM('xxxyyyyxyxXxyLAST WORD', 'xy') FROM dual; -- char�� ���� ���ڰ� �־ �ѱ��ھ� ���Ͽ� TRIM�ϴ� ���� �� �� �ִ�.
/* �μ� ���̺��� �μ� �̸��� ������ ������ '��'�� �����Ͽ� ����Ͽ���. */
SELECT RTRIM(dname, '��')
FROM department;

-- 2022-06-29 QUIZ
/* 1. ������̺��� ����� Į���� ������ Name, �޿�*12�� Annual Salary�� �ο��Ͽ� ����غ�����.*/
SELECT ename as "Name", sal*12 as "Annual Salary"
FROM emp;

/* 2. ������̺��� ������ �޿��� �Ʒ��� ���� �������� ����� ������. */
SELECT CONCAT(CONCAT(ename, ': 1 Month Salary = '),sal) as "Monthly"
FROM emp;

/* 3. ������̺��� �޿��� $1500 ~ 5000 �̰� ������ PRESIDENT�� ANALYST�� �ƴ� ��� ����� ����
���, �̸�, ����, �޿��� ����, �޿��� ������������ �����ϼ���. */
SELECT empno, ename, job, sal
FROM emp
WHERE job NOT IN ('PRESIDENT', 'ANALYST') AND sal BETWEEN 1500 AND 5000
ORDER BY job, sal;

/* 4. ������̺��� 2���� �Ի��� ����� ����غ�����(SUBSTR ���)*/
SELECT *
FROM emp
WHERE SUBSTR(hiredate,4,2) = '02';

/* 5. ������̺��� 20���̳� 30�� �μ��� ���ϰ� �̸��� ������ ���ڿ� 'S'�ڸ� ������ ����� �߿��� ������ 'S'�� �����غ�����.*/
SELECT ename, RTRIM(ename, 'S') as "RTRIM"
FROM emp
WHERE deptno IN (20, 30) AND ename LIKE '%S';

/* ��� ���̺��� ��� �޿��� 2300 �̻��� �μ��� �μ� ��ȣ, �μ��� ��� �޿��� ����ϼ���. */
SELECT      deptno, ROUND(AVG(sal),1)
FROM        emp
GROUP BY    deptno
HAVING      AVG(sal) >= 1900;

/* 1000�̻� �޿��� �޴� ����鿡 ���� �μ��� ��� �޿��� ���� ��, �μ��� ��� �޿��� 1900�̻��� �μ���
�μ���ȣ, �μ��� ��� �޿��� ����ϼ���. (�Ҽ��� 1�ڸ�����)*/
SELECT      deptno, ROUND(AVG(sal),1)
FROM        emp
WHERE       sal >= 1000
GROUP BY    deptno
HAVING      AVG(sal) >= 1900;

-- WHERE ������ �׷��Լ��� ����ؼ��� �ȵȴ�. ����) WHERE count(*) > 4;

-- �������� SQL �Լ��� ��ø�� ����� ��, �� ���� �Լ����� ó���� �� ó�� ����� ���� ����� �ٱ��� �Լ��� �ѱ��.
/* �а��� �л��� ��� ������ �� �ִ� ��� �����Ը� ����϶�. */
SELECT MAX(avg(weight))
FROM student
GROUP BY deptno;

/* �а� �� �л� ���� �ִ�, �ּ��� �а��� �л� ���� ����Ͽ���.*/
SELECT MAX(count(studno)) as max_count, MIN(count(studno)) as min_count
FROM student
GROUP BY deptno;

-- ����
SELECT studno, name, student.deptno, dname, loc
FROM student, department
WHERE student.deptno = department.deptno;


SELECT a.studno, a.name, b.deptno, b.dname, b.loc
FROM student a, department b
WHERE a.deptno = b.deptno;

/* 1. ���� �̸�, �޿�, �а� ��ȣ, �а� �̸�, �а� ��ġ�� ����ϼ���. */
SELECT p.name, p.sal, p.deptno, d.dname, d.loc
FROM professor p, department d
WHERE p.deptno = d.deptno;

/* '������' �л��� �й�, �̸�, �Ҽ� �а� �̸�, �׸��� �а� ��ġ�� ����Ͽ���.*/
SELECT studno, name, dname, loc
FROM student, department
WHERE student.deptno = department.deptno
    AND name = '������';

/* �����԰� 80kg �̻��� �л��� �й�, �̸�, ü��, �а� �̸�, �а� ��ġ�� ����Ͽ���. */
SELECT s.studno, s.name, s.weight, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno 
    AND s.weight >= 80;

/* 2. ��� ���̺��� 'DALLAS'�� �ٹ��ϴ� ����� ���, �̸�, �μ���ȣ, �ٹ����� ����ϼ���. */
SELECT  e.empno, e.ename, e.deptno, d.loc
FROM    emp e, dept d
WHERE   e.deptno = d.deptno
    AND loc = 'DALLAS';

/* 3. �л��� �̸�, �й�, �а���ȣ, �������� ��ȣ, ���� �̸��� ����ϼ���. */
SELECT s.name as "student name", s.studno, s.deptno, s.profno, p.name as "professor name"
FROM student s, professor p
WHERE s.profno = p.profno;

/* 4. �����԰� 70kg �̻��� �л��� �̸�, �й�, �а���ȣ, �������� ��ȣ, �����̸�, �а� �̸�, �а� ��ġ�� ����ϼ���. */
SELECT s.name �̸�, s.studno �й�, s.deptno �а���ȣ, s.profno as "��������No", p.name ����������, d.dname �а��̸�, d.loc �а���ġ
FROM student s, professor p, department d
WHERE s.deptno = d.deptno AND s.profno = p.profno AND s.weight >= 70;

-- īƼ�� ��(CROSS JOIN, �����ص� ��) : WHERE student (CROSS JOIN | ,) department
SELECT * FROM student, department; -- �� 144���� ���� �����(student's cardinarlity 16, department's cardinality 9, 16X9=144)
SELECT * FROM student CROSS JOIN department; -- ���� ��ɹ��� �Ȱ���.

-- ���� ����(EQUI JOIN) : WHERE student.deptno = department.deptno, �����(��Ȯ�ϰ� ��ġ�ϴ�) column�� ã�� join�Ѵ�.
SELECT  s.studno, s.name, s.deptno, d.dname, d.loc
FROM    student s, department d
WHERE   s.deptno = d.deptno;

-- �ڿ� ����(NATURAL JOIN) : FROM student NATURAL JOIN department; �̶�, ���̺� ������ ������� ���ƾ� �Ѵ�.
SELECT  studno, name, deptno, dname, loc
FROM    student NATURAL JOIN department;
/* NATURAL JOIN�� �̿��Ͽ� ���� ��ȣ, �̸�, �а� ��ȣ, �а� �̸��� ����Ͽ���. */
SELECT profno, name, deptno, dname
FROM professor NATURAL JOIN department;
/* NATURAL JOIN�� �̿��Ͽ� 4�г� �л��� �̸�, �а� ��ȣ, �а� �̸��� ����Ͽ���. */
SELECT name, deptno, dname
FROM student NATURAL JOIN department
WHERE grade = '4';
-- JOIN ~~ USING: FROM table1 JOIN table2 USING (col); -> col�� ��ȣ �� �ٿ��� �Ѵ�.
SELECT name, deptno, dname
FROM student JOIN department USING (deptno)
WHERE grade = '4';
-- ��, WHERE ���� '='(Oracle Join)�� �̿��ϰų�, FROM ���� 'NATURAL JOIN'�̳� '~ JOIN ~ USING (~)'�� ����Ͽ� EQUI JOIN�� ������ �� �ִ�.

-- NON EQUI join : '<', '>', BETWEEN a AND bó�� '=' ������ �ƴ� ������ ����ϴ� ���
SELECT p.profno, p.name, p.sal, s.grade
FROM professor p, salgrade s
WHERE p.sal BETWEEN s.losal AND s.hisal;
-- salgrade��� ���̺��� ����
SELECT * FROM salgrade;

-- OUTER JOIN : ���� Į�� �� �� �ϳ��� NULL������, ���� ����� ����� �ʿ䰡 �ִ� ���, null�� ��µǴ� ���̺��� Į���� (+) ��ȣ�� �߰�.
/* �л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, ���������� �̸�, ������ ����ϼ���. 
��, ���������� �������� ���� �л��� ����϶�. */
SELECT s.name as "student name", s.grade, p.name as "professor name", p.position
FROM professor p, student s
WHERE s.profno = p.profno(+) -- p.name�� p.position�� null�� ���� ���̹Ƿ�
ORDER BY p.profno;

-- select * from student;

/* �л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, ���������� �̸�, ������ ����ϼ���. 
��, �����л��� �������� ���� ������ ����϶�. */
SELECT s.name as "student name", s.grade, p.name as "professor name", p.position
FROM professor p, student s
WHERE s.profno(+) = p.profno
ORDER BY p.profno;

/* �л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, ���������� �̸�, ������ ����ϼ���. 
��, ���������� ���� �л��� �����л��� �������� ���� ���� ��θ� ����϶�. */
(SELECT s.name as "student name", s.grade, p.name as "professor name", p.position
FROM professor p, student s
WHERE s.profno(+) = p.profno)
UNION
(SELECT s.name as "student name", s.grade, p.name as "professor name", p.position
FROM professor p, student s
WHERE s.profno = p.profno(+))
ORDER BY 1; -- '1 = s.name'

-- '~ [align] OUTER JOIN ~ ON (����)' ���� �̿��Ͽ� OUTER JOIN�� �����Ѵ�.
-- FROM table1 [RIGHT | LEFT | FULL] OUTER JOIN table2 ON table1.col = table2.col;
/* �л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, ���������� �̸�, ������ ����ϼ���. 
��, ���������� ���� �л��� �����л��� �������� ���� ���� ��θ� ����϶�. */
SELECT s.name as "student name", s.grade, p.name as "professor name", p.position
FROM professor p FULL OUTER JOIN student s ON s.profno = p.profno
ORDER BY 1;

-- �ϳ��� ���̺�(�ڱ� �ڽ�)���� �ִ� Į������ �����ϴ� ������ �ʿ��� ���, SELF JOIN�� ����Ѵ�.
SELECT c.deptno, c.dname, c.college, d.dname college_name, c.loc
FROM department c, department d
WHERE c.college = d.deptno;
-- JOIN ~ ON ��� : FROM table1 c JOIN table1 d ON c.col1 = d.col2; 
SELECT dept.dname || '�� �Ҽ��� ' || org.dname
FROM department dept, department org
WHERE dept.college = org.deptno AND dept.deptno >= 201;

SELECT dept.dname || '�� �Ҽ��� ' || org.dname
FROM department dept JOIN department org ON dept.college = org.deptno
WHERE dept.deptno >= 201;

-- 0701 Quiz
/* 1. �� �޿��� $5,000�� �Ѵ� �� JOB�� ���� JOB�� ���� �Ѿ���
����ϼ���. (��, PRESIDENT�� ���ܽ�Ű��, ���� �Ѿ׺����� ����) */
SELECT job, sum(sal) as payroll
FROM emp
WHERE job != 'PRESIDENT'
GROUP BY job
HAVING sum(sal) >= 5000
ORDER BY 2;

-- 2,3�� employees, departments, locations
/* 2. Shipping�μ��� �ٹ��ϴ� ����� ���� last_name, job_id,
�μ���ȣ, �μ��̸��� last_name ������ ����ϼ���. (���-45��) */
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e, departments d, locations l
WHERE d.department_name = 'Shipping' AND
        d.department_id = e.department_id AND 
        l.location_id = d.location_id;

/* 3. south san francisco���� �ٹ��ϴ� ��� ����� ����
last_name, job, �μ���ȣ, �μ��̸�, �μ���ġ(city)��
����ϼ���. (���-45��) */
SELECT e.last_name, e.job_id, e.department_id, d.department_name, l.city
FROM employees e, departments d, locations l
WHERE l.city = 'South San Francisco' AND
        d.department_id = e.department_id AND 
        l.location_id = d.location_id;

/* 4. ����� �̸��� ��� ��ȣ �׸��� ������ �̸���
������ ��ȣ�� ����ϼ���.(�� ���̺� Employee,
Emp#, Manager �׸��� Mgr#)
Employee Emp# Manager Mgr# */
SELECT e.ename Employee, e.empno as "Emp#", m.ename Manager, m.empno as "Mgr#"
FROM emp e, emp m
WHERE e.mgr = m.empno;

select * from emp;

-- ��������: �ľ��� ���� ��ü�� �� �� ���������� ����, ������ ���� ���������� ���� Ȯ���� �� ��ü ������ �����ϴ� ������ ������.
SELECT name, position
FROM professor
WHERE position = (SELECT position
                  FROM professor
                  WHERE name = '������');

-- ����� ���̵� 'jun123'�� �л��� ���� �г��� �л��� �й�, �̸�, �г��� ����Ͽ���.
SELECT  studno, name, grade
FROM    student
WHERE   grade = (SELECT grade
                 FROM student
                 WHERE userid = 'jun123');
                 
-- 101�� �а� �л����� ��� �����Ժ��� �����԰� ���� �л��� �̸�, �а���ȣ, �����Ը� ����Ͽ���.
SELECT  name, deptno, weight
FROM    student
WHERE   weight < (SELECT avg(weight)
                  FROM student
                  WHERE deptno = 101)                
ORDER BY deptno;
                
-- 20101�� �л��� �г��� ����, Ű�� 20101�� �л����� ū �л��� �̸�, �г�, Ű�� ����Ͽ���. + �а��̸��� �߰��Ͽ���.
SELECT  name, grade, height, deptno, dname
FROM    student NATURAL JOIN department
WHERE   grade = (SELECT grade
                 FROM student
                 WHERE studno = 20101)
AND     height > (SELECT height
                 FROM student
                 WHERE studno = 20101);

-- ������ ��������, IN, ANY, SOM, ALL(��� ���� ��ġ�ϸ� ��), EXISTS(�����ϴ� ���� �ϳ��� '�����ϸ�' ��)

-- x in (a, b, ...)�� x = a OR x = b OR ...�� ����.
-- �����̵���к�(�μ���ȣ 100)�� �Ҽӵ� ��� �л��� �й�, �̸�, �а� ��ȣ�� ����Ͽ���.
SELECT studno, name, deptno
FROM student
WHERE deptno IN (SELECT deptno
                FROM department
                WHERE college = 100);

-- ANY(SOM)�� '<', '>'�� ���� ���� �񱳵� �����ϴ�. �ַ� ANY�� ����Ѵ�.
SELECT studno, name, height
FROM student
WHERE height > ANY (SELECT height
                    FROM student
                    WHERE grade = '4');          

-- ALL : ���� �� ��, ��� ���� ��
SELECT studno, name, height
FROM student
WHERE height > ALL (SELECT height
                    FROM student
                    WHERE grade = '4'); 

-- EXISTS : ������������ �˻��� ����� �ϳ��� �����ϸ� �������� �������� ���� �Ǵ� ������.
-- �ݴ�� ������������ �˻��� ����� �������� ������ ���������� �������� ����('���õ� ���ڵ尡 �����ϴ�')
-- NOT EXISTS : EXISTS�� �ݴ�
SELECT profno, name, sal, comm, SAL+NVL(comm, 0)
FROM professor
WHERE EXISTS (SELECT profno
                FROM professor
                WHERE comm IS NOT NULL); 
-- ���������� �����ϹǷ� ���������� ������. ��µǴ� �� 9901, 9903, 9905, 9908�� �ǹ� ����, ���� ��µǴ� ���� �߿���

-- �л� �߿��� goodstudent��� ����� ���̵� ������ 1�� ����϶�,
SELECT 1 userid_exist
FROM dual
WHERE not exists (  select userid
                    from student 
                    where userid = 'goodstudent'); -- �������� �����Ƿ� ���ڵ�(1)�� �����

SELECT 1 userid_exist
FROM dual
WHERE not exists (  select userid
                    from student 
                    where userid = 'jun123'); -- �����ϹǷ� ���ڵ�(1)�� ������� ����

SELECT 1 userid_exist
FROM dual
WHERE exists (  select userid
                from student 
                where userid = 'goodstudent'); -- �������� �����Ƿ� ���ڵ�(1)�� ������� ����

SELECT 1 userid_exist
FROM dual
WHERE exists (  select userid
                from student 
                where userid = 'jun123'); -- �����ϹǷ� ���ڵ�(1)�� �����

-- �а��� �л����� �ִ��� �а���ȣ�� �л� ���� ����ϼ���.
SELECT deptno as "�а���ȣ", count(*) as "�л���"
FROM student
GROUP BY deptno
HAVING count(*) =  (SELECT max(count(*))
                    FROM student
                    GROUP BY deptno);

-- ���� �÷� �������� : PAIRWISE(col�� ������ ���� ���ÿ� ��), UNPAIRWISE(col���� ������ ��, AND ���� ����)
-- PAIRWISE : ����)... WHERE (col1, col2) IN (SELECT col1, col2 FROM ...) : col1-col1, col2-col2�� ���ÿ� ���� �� �� ��ġ�ؾ� �ȴ�.
-- �г⺰�� �����԰� �ּ��� �л��� �̸�, �г�, �����Ը� ����Ͽ���.
SELECT name, grade, weight
FROM student
WHERE (grade, weight) IN (SELECT grade, MIN(weight)
                        FROM student
                        GROUP BY grade)
ORDER BY grade;

-- ��� ���̺��� ��ȸ�Ͽ� �� �μ����� �ִ� �޿��� �޴� ������� �μ���ȣ, �̸�, �޿��� ����ϼ���.
SELECT deptno, ename, sal
FROM emp
WHERE (deptno, sal) IN (SELECT deptno, MAX(sal)
                        FROM emp
                        GROUP BY deptno)
ORDER BY deptno;

-- UNPAIRWISE : ����) ... WHERE col1 IN (SELECT col1 FROM ...) AND col2 IN (SELECT col2 FROM ...) ... : col1-col1 ����, col2-col2 ���� ���Ѵ�.
-- UNPAIRWISE ����� �̿�, �г⺰�� �����԰� �ּ��� �л��� �̸�, �г�, �����Ը� ����Ͽ���.
SELECT name, grade, weight
FROM student
WHERE (weight) IN   (SELECT MIN(weight)
                     FROM student
                     GROUP BY grade)
AND   (grade) IN    (SELECT grade
                     FROM student
                     GROUP BY grade)
ORDER BY grade; -- ���� ���� �޶����Ƿ�, �� ����� ���� ��� ����� �޶��� �� �ִٴ� ���� ����.

/* ��ȣ���� �������� : ������������ ���������� �˻� ����� ��ȯ�ϴ� ����������, ����� ��ȯ�ϱ� ����
���������� WHERE ���������� ���������� ���̺�� �����Ѵ�. ��, ���������� ������ �ǹǷ� ������ ��(�Ⱦ��°� ����).
SELECT column list
FROM table1
WHERE [col | expr] operator (SELECT [col | expr] FROM table2 WHERE table2.col operator table1.col);
*/
-- �� �а� �л��� ��� Ű���� Ű�� ū �л��� �̸�, �а� ��ȣ, Ű�� ����Ͽ���.
SELECT name, deptno, height
FROM student s1
WHERE height > (SELECT avg(height)
                FROM student s2
                WHERE s2.deptno = s1.deptno)
ORDER BY deptno;

-- �ǹ����� �������� ���� ���ǻ���
-- 1. ������ ������������ ������ �߻��ϴ� ���(������������ ���� ���� �� '='���� ���� IN, ANY, ALL ����� ��)
-- 2. ���������� �������� Į���� ���� ��ġ���� �ʴ� ���.
-- 3. �������� ������ ORDER BY �� ����ϸ� ���� �߻�
-- 4. ���������� ����� NULL(��µǴ� ���ڵ� ����)�� ���

-- �ǽ�
/* Blake�� ���� �μ��� �ִ� ��� ����� ���ؼ� ��� �̸��� �Ի����� ���÷��� �϶�. */
SELECT ename, hiredate
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE INITCAP(ename) = 'Blake')
ORDER BY ename;

/* ��� �޿� �̻��� �޴� ��� ����� ���ؼ� ��� ��ȣ�� �̸��� ���÷����ϴ� ���ǹ� + �޿� �������� ���� */
SELECT empno, ename, sal
FROM emp
WHERE sal >= (SELECT AVG(sal)
              FROM emp)
ORDER BY sal desc;

/* �μ���ȣ�� �޿��� ���ʽ��� �޴� � ����� �μ� ��ȣ�� �޿��� ��ġ�ϴ� ����� �̸�, �μ���ȣ, �׸��� �޿��� ���÷����϶�. */
SELECT ename, deptno, sal
FROM emp
WHERE (deptno, sal) IN (SELECT deptno, sal
                        FROM emp
                        WHERE comm is not null AND comm <> 0);

-- Scalar Subquery : ���� �������κ��� ������ Scalar ���� �����ϱ� ���ؼ� ����Ѵ�.
-- ���� �ϳ��� ���� ��ȯ�ϸ�, �ҷ��� �����͸� �ٷ� ���� ����ϴ� ���� ����.
-- 1. Select List������ Scalar Subquery
-- 2. Where �������� Scalar Subquery
-- 3. Order By �������� Scalar Subquery
-- 4. CASE ���Ŀ����� Scalar Subquery
-- 5. �Լ������� Scalar Subquery
-- �̷��Ÿ� �� ���� �ִٴ� ���� ���� �ܿ�ų� �� �ʿ�� X

