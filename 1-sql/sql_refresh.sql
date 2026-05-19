-- window function calculation
select *,
	sum(amount) over(partition by region) total_per_region,
	cast(
		(amount * 1.0 / sum(amount) over(partition by region)) * 100 
	as decimal(10,2)) pct_of_region
from sales

-- window function rank
with total_per_person as (
	select region, salesperson,
		sum(amount) total
	from sales
	group by 1,2
	order by 1
)
select *,
	rank() over(partition by region order by total desc)
from total_per_person

-- contoh rank
select *,
	-- kalau ada gap rank, next value akan skip gap-nya
	rank() over(partition by category order by finish_time) finish_by_category
	-- kalau ada gap rank, next value akan mengisi gap-nya
	dense_rank() over(partition by category order by finish_time) finish_by_category
	-- tidak ada gap rank, hanya ranking berdasarkan urutan
	row_number() over(partition by category order by finish_time) finish_by_category
from runners2

--contoh lag + row_number
with monthly_sales as (
	select 
		date_trunc('month', sale_date) as month,
		sum(amount) as total
	from sales
	group by 1
),
with_lag as (
	select *,
		lag(total) over(order by month) as prev_month
	from monthly_sales
)
select *,
	total - prev_month as growth,
	case 
		when prev_month = 0 or prev_month is null then null
		else round((total - prev_month) * 100.0 / prev_month, 2)
	end as pct_growth,
	sum(total) over(order by month) as running_total,
	row_number() over(order by month) as row_num
from with_lag;