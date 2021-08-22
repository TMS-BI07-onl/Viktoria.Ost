use [AdventureWorks2017]
go
/* Display information about employees in 2 columns:
hire date;
line containing their full name(with spaces), position and pay rate info, separated by >>'s. */
select [HireDate],
concat_ws(' >> ',concat_ws(' ',[FirstName],[MiddleName],[LastName]), [JobTitle], [Rate])
'name, position, rate info'
from [HumanResources].[Employee] join [HumanResources].[EmployeePayHistory]
on [HumanResources].[Employee].[BusinessEntityID]=[HumanResources].[EmployeePayHistory].[BusinessEntityID]
join [Person].[Person] on [Person].[Person].[BusinessEntityID]=[HumanResources].[Employee].[BusinessEntityID]
order by [HireDate] desc;

/* Display intervals in days between orders, longest on top:
order date;
number of days since the previous order*/
select [ModifiedDate], datediff(dd,lag ([ModifiedDate]) over (order by [ModifiedDate]), [ModifiedDate]) diffrnc
from [Sales].[SalesOrderDetail]
order by diffrnc desc