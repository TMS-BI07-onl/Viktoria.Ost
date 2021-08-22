use [AdventureWorks2017]
go
/* Отобразить информацию о сотрудниках в два столбца:
дата приёма на работу;
строка, содержащая полное ФИО(разделённое пробелами), через разделитель ">>" должность и зарплату сотрудника. */
select [HireDate],
concat_ws(' >> ',concat_ws(' ',[FirstName],[MiddleName],[LastName]), [JobTitle], [Rate])
'name, position, rate info'
from [HumanResources].[Employee] join [HumanResources].[EmployeePayHistory]
on [HumanResources].[Employee].[BusinessEntityID]=[HumanResources].[EmployeePayHistory].[BusinessEntityID]
join [Person].[Person] on [Person].[Person].[BusinessEntityID]=[HumanResources].[Employee].[BusinessEntityID]
order by [HireDate] desc;

/*Отобразить перерывы в днях между заказами, начиная самых долгих:
дата заказа;
количество дней, прошедшее с даты прошлого заказа*/
select [ModifiedDate], datediff(dd,lag ([ModifiedDate]) over (order by [ModifiedDate]), [ModifiedDate]) diffrnc
from [Sales].[SalesOrderDetail]
order by diffrnc desc