--1.Найти ProductSubcategoryID из Production.Product, где мин вес такого ProductSubcategoryID больше 150. 
select ProductSubcategoryID from Production.Product
group by ProductSubcategoryID
having min([Weight])>150


--2. Найти самый дорогой продукт (поле StandardCost) из Production.Product. (4 способа)
Select distinct [ProductID], [Name] from [Production].[Product]
where StandardCost in (Select  max(StandardCost) max_weight  from Production.Product);

Select top 1 with ties ProductID,[Name], rank() over (order by [StandardCost] desc) maxcost
from [Production].[Product]
order by maxcost;

Select ProductID,[Name]
from (Select ProductID,[Name], StandardCost, first_value([StandardCost]) over(order by [StandardCost] desc) maxcost
from [Production].[Product]) t
where StandardCost=maxcost;

Select ProductID,[Name]
from (Select ProductID,[Name], StandardCost, max([StandardCost]) over(order by [StandardCost] desc) maxcost
from [Production].[Product]) t
where StandardCost=maxcost;

Select t1.ProductID, t1.[Name] from [Production].[Product] t1
join 
(select max(StandardCost) maxcost from [Production].[Product]) t2
on [StandardCost]=maxcost;


--3. Найти заплывы, для которых не указан бассейн
Use SWIMMING_Comp
go
Select [CompID] from [dbo].[Competitions] comp
left join [dbo].[SwimPools] pools on comp.[PoolID]=pools.[PoolID]
where pools.[PoolID] is null;


--4. Найти для каждого судьи кол-во проведенных судейств за последние 15 лет.  (схема GROUP1)
Select FirstName, Lastname, count(competitionid) from Judges
join bridge on Judges.judgeid=bridge.judgeid
join competition on competitionid=competition_id
where data between year(getdate)-4 and year(getdate)
group by FirstName, Lastname;

--5.
Select category  from Notifications join Users on Users.id=user_id
where 
group by  Users.id
having count(