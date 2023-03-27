use db_assignment1
select * from dbo.transactions

--Q1
Select count(customer_id) as rowsofcustomer from customer
Select count(transaction_id) as rowsoftransaction from transactions
Select count(prod_cat_code) as rowsofProduct from prod_cat_info

--Q2
Select count (distinct(transaction_id))as [Total No. of returns] from transactions
where qty<0


--Q3
select convert(date,tran_date,103) as [converted tran_date] from transactions;
select  convert(date,DOB,103) as [Converted DOB] from customer;

--Q4
Select day(convert(date,tran_date,103)) as [days],month(convert(date,tran_date,103)) as Month, Year(convert(date,tran_date,103)) as year from Transactions


--Q5
select top 1 prod_cat as [Product Category] from prod_cat_info
where prod_subcat = 'DIY'

--Data Analysis
--Q1
select top 1 store_type ,count(store_type) as [shopping mode] from transactions
group by store_type
order by [shopping mode] desc 

--Q2- 
Select gender,count(gender) as count_gender from customer
group by gender



--Q3- 
select top 1 city_code, count(city_code) as count_customer from customer
group by city_code
order by count_customer desc

--Q4
Select distinct prod_subcat from prod_cat_info
where prod_cat='Books'

--Q5
select max(qty) as max_ordered_value from transactions

--Q6
select sum(total_amt) as [Total revenue] from transactions
where prod_cat_code in (3 , 5)

--OR

Select sum(total_Amt) as [Total Revenue] from transactions T
inner join prod_cat_info P 
on P.prod_cat_code = T.prod_cat_code and P.prod_sub_cat_code=T.prod_subcat_code
where prod_cat in ('books','Electronics')


--Q7
Select distinct cust_id,count(qty) as count_tran from transactions
where qty>0
Group by cust_id
having count(qty)>10

--Q8
select sum(total_amt) as [Total revenue] from transactions
where prod_cat_code in (1 , 3) and store_type = 'flagship store'

--OR
Select sum(total_amt) as [Total Revenue] from transactions T
inner join prod_cat_info P
on P.prod_cat_code=T.prod_cat_code and P.prod_sub_cat_code=T.prod_subcat_code
where prod_cat ='electronics' or prod_cat = 'clothing' and store_type ='flagship store'

--Q9
Select P.Prod_subcat, Round(sum(total_amt),2) as [Total Revenue] from Transactions T 
inner join Prod_cat_info P  
on T.Prod_cat_code=P.Prod_cat_code and P.prod_sub_cat_code=T.prod_subcat_code
inner join customer C 
on C.customer_id=T.cust_id
where P.prod_cat='Electronics' and C.gender = 'M'
group by P.Prod_subcat


--Q10
select p.prod_subcat,t.[Total Sales] ,t.[Total Returns]from
 (select top 5 ( prod_subcat_Code),
 Concat(round((100-(Abs(sum(case when Qty < 0 then Qty else 0 end)))*100/(cast (sum(case
when Qty > 0 then Qty else 0 end) as Float))),2),'%') as [Total Sales],
 Concat(round((Abs(sum(case when Qty < 0 then Qty else 0 end)))*100/(cast (sum(case when Qty
> 0 then Qty else 0 end) as Float)),2),'%')as [Total Returns],prod_cat_code
 from Transactions
 Group by Prod_subcat_code,prod_cat_code)T
left join prod_cat_info P
on p.prod_cat_code=t.prod_cat_code And P.prod_sub_cat_code=t.prod_subcat_code
Group by p.prod_subcat,t.[Total Returns],t.[Total Sales]
Order by [Total Sales] Desc


--Q11
Select round(sum(total_Amt),2) as [Total Revenue],dateadd(day,-30,max(tran_date)) as [date] from transactions T
inner join customer C 
on T.cust_id  =C.customer_id
where datediff(year,c.DOB,getdate()) between 25 and 35


--Q12
Select  P.prod_cat, sum(total_amt)as [Total Return Revenue] from  Transactions T 
inner join Prod_cat_info P 
on P.prod_cat_code=T.Prod_cat_code and P.prod_sub_cat_code= T.prod_subcat_code
Group by Prod_cat
having Max(tran_date) >= dateadd(month, -3 , Max(tran_date)) 
order by prod_cat desc

--Q13
Select store_type, round(sum(total_Amt),2) as [Total Sales],sum(Qty) as [total quantity sold],
max(total_amt)as [Max Sales], max(qty) as [Max qty] from transactions 
group by store_type

--Q14
select prod_cat, round(avg(Total_amt),2) as [Average Sales] from transactions T
inner join prod_cat_info p
on T.prod_cat_code = p.prod_cat_code and T.prod_subcat_Code= P.prod_Sub_cat_code
group by prod_cat
Having avg(Total_amt)> (select round(avg(Total_amt),2) from transactions)

--Q15
  
Select P.prod_subcat ,sum(total_Amt) as [Total Revenue], round(avg(total_Amt),2) as [Average Revenue] from Transactions T 
inner join Prod_cat_info P 
on T.prod_cat_code = p.prod_cat_code and T.prod_subcat_Code= P.prod_Sub_cat_code
Group by Prod_subcat 
order by sum(qty) desc 









