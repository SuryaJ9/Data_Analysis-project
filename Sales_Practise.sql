# SQL Example
# 1 - see all shipments.
select * from shipments;
 # 2 - All shipments by SP02
 select * from shipments 
 where SPID = 'SP02';
 # 3 - All shipments by SP02 to G03
 select * from shipments 
 where GeoID = 'G3' and  SPID = 'SP02';
 
 select * from shipments s 
 where s.SaleDate between '2021-1-1' and '2023-1-31';
 
 select * from shipments s 
 where extract(year_month from s.SaleDate) = 202201;
 
 # 5 All shipments by SP02, SP03, SP12, SP15;
 select s.SPID,sum(s.amount) from shipments s 
 where s.SPID IN ('SP01','SP02','SP15')
 group by s.SPID 
 order by s.SPID DESC;
 
 # 6 Sales per box of chocolates in Feb 2023
 select * from shipments s 
 where extract(year_month from s.SaleDate) = 202302;
 
 # 7 Select sales person whose name begin with S
 select * from people where Salesperson like '%s';
 
 # 8 All shipments data for Barr Faughny  by month.
 select p.Salesperson,s.SaleDate from 
 people p 
 join shipments s
 on p.SPID = s.SPID where p.Salesperson = 'Barr Faughny';
 
 # 9 All shipment data for Barr Faughny to USA
SELECT 
    p.Salesperson, s.SaleDate
FROM
    people p
        JOIN
    shipments s ON p.SPID = s.SPID
WHERE
    p.Salesperson = 'Barr Faughny'
        AND p.location = 'USA';
        
# 10 what is the maximum amount in each month?

SELECT 
    DATE_FORMAT(SaleDate, '%Y-%m') AS month,
    MAX(Amount) AS max_amount
FROM
    shipments
GROUP BY DATE_FORMAT(SaleDate, '%Y-%m')
ORDER BY month;

# 11 How many shipments we do by each country in the month of march 2023
select p.Location,DATE_FORMAT(s.SaleDate,'%Y-%m') as month,
count(s.SPID) as cnt 
from shipments s 
join people p on s.SPID = p.SPID
where DATE_FORMAT(s.SaleDate,'%Y-%m') = '202102'
group by p.Location,month
order by month;

 
 