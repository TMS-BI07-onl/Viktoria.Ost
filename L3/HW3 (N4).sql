use [AdventureWorks2017]
go
/* ���������� ���������� � ����������� � ��� �������:
���� ����� �� ������;
������, ���������� ������ ���(���������� ���������), ����� ����������� ">>" ��������� � �������� ����������. */
select [HireDate],
concat_ws(' >> ',concat_ws(' ',[FirstName],[MiddleName],[LastName]), [JobTitle], [Rate])
'name, position, rate info'
from [HumanResources].[Employee] join [HumanResources].[EmployeePayHistory]
on [HumanResources].[Employee].[BusinessEntityID]=[HumanResources].[EmployeePayHistory].[BusinessEntityID]
join [Person].[Person] on [Person].[Person].[BusinessEntityID]=[HumanResources].[Employee].[BusinessEntityID]
order by [HireDate] desc;

/*���������� �������� � ���� ����� ��������, ������� ����� ������:
���� ������;
���������� ����, ��������� � ���� �������� ������*/
select [ModifiedDate], datediff(dd,lag ([ModifiedDate]) over (order by [ModifiedDate]), [ModifiedDate]) diffrnc
from [Sales].[SalesOrderDetail]
order by diffrnc desc