-- month — format DATE (pakai DATE_TRUNC)
-- monthly_total — total penjualan per salesperson per bulan
-- running_total — akumulasi per salesperson dari bulan pertama sampai bulan tersebut
-- prev_month — penjualan bulan sebelumnya, salesperson yang sama
-- mom_growth_pct — growth persen bulatkan 1 desimal, NULL kalau tidak ada bulan sebelumnya
-- rank_in_region — ranking salesperson di regionnya berdasarkan monthly_total, bulan tersebut


with monthly_sales as(
	select region, salesperson,
		date_trunc('month', sale_date) as "month",
		sum(amount) as monthly_total
	from sales
	group by 1,2,3
),
with_running_prev as(
	select *,
		sum(monthly_total) over(partition by salesperson order by month) as running_total,
		lag(monthly_total) over(partition by salesperson order by month) as prev_month
	from monthly_sales
)
select *,
	case
		when prev_month = 0 or prev_month is null then null
		else round((monthly_total - prev_month) * 100.0 / prev_month, 1)
	end as mom_growth_pct,
	rank() over(partition by region, month order by monthly_total asc) as rank_in_region
from with_running_prev 