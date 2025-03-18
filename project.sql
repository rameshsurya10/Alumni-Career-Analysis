# Q3 -- Run SQL command to see the structure of six tables

DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

# Q6 --Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values.

create view college_a_hs_v as select * from college_a_hs where RollNo is not null and 
LastUpdate is not null and
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and 
HSDegree is not null and 
EntranceExam is not null and 
Institute is not null and 
Location is not null;


select * from college_a_hs;

# Q7 -- Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.

create view college_a_se_v as select * from college_a_se where RollNo is not null and 
LastUpdate is not null and
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and 
Organization is not null and
Location is not null;

select * from college_a_se_v;

# Q8 -- Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.

create view college_a_sj_v as select * from college_a_sj where RollNo is not null and 
LastUpdate is not null and
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and 
Organization is not null and
Location is not null;

select * from college_a_sj_v;


# Q9 -- Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.

create view college_b_hs_v as select * from college_b_hs where RollNo is not null and 
LastUpdate is not null and
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Branch is not null and
Batch is not null and 
Degree is not null and 
PresentStatus is not null and 
HSDegree is not null and
EntranceExam is not null and
Institute is not null and
Location is not null;

select * from college_b_hs_v;

# Q10 -- Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.

create view college_b_se_v as select * from college_b_se where RollNo is not null and 
LastUpdate is not null and
Name is not null and 
FatherName is not null and 
MotherName is not null and  
Branch is not null and
Batch is not null and 
Degree is not null and 
PresentStatus is not null and 
Organization is not null and
Location is not null;

select * from college_b_se_v;

# Q11 -- Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.

create view college_b_sj_v as select * from college_b_sj where RollNo is not null and 
LastUpdate is not null and
Name is not null and 
FatherName is not null and 
MotherName is not null and  
Branch is not null and
Batch is not null and 
Degree is not null and 
PresentStatus is not null and 
Organization is not null and
Designation is not null and
Location is not null;

select * from college_b_sj_v;

# Q12 -- Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case 
-- for views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V)


DELIMITER $$

CREATE PROCEDURE convert_to_lowercase()
BEGIN
    select  LOWER(Name) name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName from college_a_hs_v;
    select  LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName from college_a_se_v;
    select  LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName from college_a_sj_v;
    select  LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName from college_b_hs_v;
    select  LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName from college_b_se_v;
    select  LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName from college_b_sj_v;
END $$
DELIMITER ; 


call alumni.convert_to_lowercase();


# Q1 4 -- Write a query to create procedure get_name_collegeA using the cursor to fetch names 
-- of all students from college A.


DELIMITER $$

create procedure get_name_collegeA
(
 inout name1 text(24000)
)

begin
declare finished integer default 0 ;
declare namelist varchar(15000) default "" ;
declare college_name_details
        cursor for select name from college_a_hs union 
        select name from college_a_se union 
        select name from college_a_sj ; 
        
declare continue handler for not found set finished = 1;

open college_name_details;
get_name_college : loop
	fetch college_name_details into namelist;
    if finished = 1 then
        leave get_name_college;
	end if ;
       
	set name1 = concat
    (namelist,";",name1);
end loop get_name_college;
close college_name_details;
	
end $$
delimiter ;

set @name1 = '';
call  get_name_collegeA(@name1);
select @name1 as NAME;


# Q15 --Write a query to create procedure get_name_collegeB using the cursor to fetch names of 
-- all students from college B.

DELIMITER $$

create procedure get_name_collegeB
(
 inout name1 text(24000)
)

begin
declare finished integer default 0 ;
declare namelist varchar(15000) default "" ;
declare college_name_details
        cursor for select name from college_b_hs union 
        select name from college_b_se union 
        select name from college_b_sj ; 
        
declare continue handler for not found set finished = 1;

open college_name_details;
get_name_college : loop
	fetch college_name_details into namelist;
    if finished = 1 then
        leave get_name_college;
	end if ;
       
	set name1 = concat
    (namelist,";",name1);
end loop get_name_college;
close college_name_details;
	
end $$
delimiter ;

set @name1 = '';
call  get_name_collegeB(@name1);
select @name1 as NAME;

# Q16 -- 	Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
-- Note: Approximate percentages are considered for career choices.

select count(*) from college_a_hs; -- 1157
select count(*) from college_a_se; -- 724
select count(*) from college_a_sj; -- 4006

select count(*) from college_b_hs; -- 199
select count(*) from college_b_se; -- 201
select count(*) from college_b_sj; -- 1859


  
SELEct "Higher Studies",((SELECT COUNT(*) FROM college_a_hs) / 
((SELECT COUNT(*) FROM college_a_hs)+
(SELECT COUNT(*) FROM college_a_se)+
(SELECT COUNT(*) FROM college_a_sj)))*100 College_A_Percentages,

((SELECT COUNT(*) FROM college_b_hs) /
 ((SELECT COUNT(*) FROM college_b_hs)+
 (SELECT COUNT(*) FROM college_b_se)+
 (SELECT COUNT(*) FROM college_b_sj)))*100 College_B_Percentages UNION
 
 SELEct "Self Empolyment", ((SELECT COUNT(*) FROM college_a_se) / 
((SELECT COUNT(*) FROM college_a_hs)+
(SELECT COUNT(*) FROM college_a_se)+
(SELECT COUNT(*) FROM college_a_sj)))*100,

((SELECT COUNT(*) FROM college_b_se) /
((SELECT COUNT(*) FROM college_b_hs)+
(SELECT COUNT(*) FROM college_b_se)+
(SELECT COUNT(*) FROM college_b_sj)))*100 UNION

SELEct "Service Job",((SELECT COUNT(*) FROM college_a_sj) / 
((SELECT COUNT(*) FROM college_a_hs)+
(SELECT COUNT(*) FROM college_a_se)+
(SELECT COUNT(*) FROM college_a_sj)))*100,

((SELECT COUNT(*) FROM college_b_sj) /
 ((SELECT COUNT(*) FROM college_b_hs)+
 (SELECT COUNT(*) FROM college_b_se)+
 (SELECT COUNT(*) FROM college_b_sj)))*100;