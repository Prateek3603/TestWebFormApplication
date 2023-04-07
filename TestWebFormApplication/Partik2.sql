Create database PartikData
use PartikData

Create table Employee
(
Emp_Id int primary key identity,
Emp_Name varchar(50),
Emp_Email varchar(50),
Contact_Number bigint,
Emp_Address varchar(100),
Experience float,
Genderid int references Gender(Gen_id),
Departmentid int references Department(Did),
Educationid int references Education(Eid),
Hobby varchar(50)
)

drop table Employee

truncate table Employee

select * from Employee

Create table Gender
(
Gen_id int primary key identity,
Gender_Name varchar(50)
)

insert into Gender (Gender_Name)values('Male')
insert into Gender (Gender_Name)values('Female')
insert into Gender (Gender_Name)values('Others')


create table Department
(
Did int primary key identity,
Dname varchar(500)
)
insert into Department (Dname)values('Android')
insert into Department (Dname)values('Asp.net')
insert into Department (Dname)values('IOS')
insert into Department (Dname)values('php')


create table Education
(
Eid int primary key identity(1,1),
Education_Name varchar(100),
)
insert into Education (Education_Name)values('BCA')
insert into Education (Education_Name)values('BE')
insert into Education (Education_Name)values('MBA')
insert into Education (Education_Name)values('MCA')



Create table Hobby
(
Hobby_id int primary key identity,
Hobby_Name varchar(100),
)
insert into Hobby(Hobby_Name)values('Acting')
insert into Hobby(Hobby_Name)values('Cricket')
insert into Hobby(Hobby_Name)values('Coocking')
insert into Hobby(Hobby_Name)values('Panting')

------------------------------------------AddUpdateEmployeeProcedure-----------------------

alter procedure AddUpdateEmployee
@Emp_Id int =null,
@Emp_Name varchar(50),
@Emp_Email varchar(50),
@Contact_Number bigint,
@Emp_Address varchar(100),
@Experience float,
@Genderid int =null,
@Departmentid int =null,
@Educationid int =null,
@Hobby varchar(50) =null
as
begin

if (@Emp_Id < 0)
begin
insert into Employee (Emp_Name, Emp_Email, Contact_Number,Emp_Address,Experience,Genderid,Departmentid,Educationid,Hobby)
values(@Emp_Name, @Emp_Email, @Contact_Number,@Emp_Address,@Experience,@Genderid,@Departmentid,@Educationid,@Hobby) 
end

else
begin
update Employee set Emp_Name=@Emp_Name, Emp_Email=@Emp_Email, Contact_Number=@Contact_Number,Emp_Address=@Emp_Address,Experience=@Experience,Genderid=@Genderid,Departmentid=@Departmentid,Educationid=@Educationid,Hobby=@Hobby
where Emp_id=@Emp_id
end
end

-------------------------------------GetEmployee----------------------------------------------------
alter Procedure GetEmployee_Record 
as
begin
select A.Emp_id, A.Emp_Name,A.Emp_Email,A.Contact_Number,A.Emp_Address,
CASE WHEN (A.Experience = 1) THEN (CONVERT(VARCHAR, A.Experience) + ' Year') ELSE (CONVERT(VARCHAR,A.Experience) + ' Years') end as Experience,
A.Hobby,B.Gender_Name,C.Dname,d.Education_Name from Employee A 
LEFT OUTER JOIN Gender B on A.Genderid = B.Gen_id
LEFT OUTER JOIN Department c on c.Did = a.Departmentid
LEFT OUTER JOIN Education d on A.Educationid = d.eid

end
-----------------------------------GetEmployeeEditRecord---------------------------------------------


Create procedure GetEmployeeEditRecord
@Emp_id int
as
begin
select * from Employee where Emp_id=@Emp_id
end




--------------------------------------GetGenderRecord--------------------------------------------------

create procedure GetGender
as
begin
select * from Gender
end

-------------------------------------------GetDepaertmentRecord-------------------------------------------
create procedure GetDepartment
as
begin
select * from Department
end

------------------------------------------------GetEducationRecord----------------------------------------
create procedure GetEducation
as
begin
select * from Education
end

-------------------------------------------GetHobbyRecord-------------------------------------------------
create procedure GetHobby
as
begin
select * from Hobby
end


------------------------------------Delete---------------------------------------------------------------
Create Procedure DeleteEmployee 
@DeleteEmp int
as
begin
delete from Employee where Emp_id=@DeleteEmp
end

---------------------------------------------------------------------------------------------------------

