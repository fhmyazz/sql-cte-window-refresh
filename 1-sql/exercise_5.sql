-- Soal 1 — Medium
-- Dari tabel raw_transactions dan users, tampilkan user dengan tier = 'gold' 
-- yang total transaksi completed-nya di bawah rata-rata semua gold user.
with user_revenue as(
  select u.name, u.tier, 
    coalesce(sum(amount), 0)  total_revenue,
    avg(sum(amount)) over() avg_revenue
  from users u
  left join raw_transactions rt on u.id = rt.user_id and rt.status = 'completed'
  where u.tier = 'gold'
  group by 1, 2
)select *
from user_revenue ur
where ur.total_revenue < avg_revenue

-- Soal 2 — Medium-Hard
-- Setiap bulan, tampilkan top 1 salesperson berdasarkan total revenue — hanya 1 per bulan, 
-- kalau ada tie ambil yang user_id terkecil.
with monthly_sales as(
  select date_trunc('month', s.sale_date) as "month", 
    u.id as user_id, s.salesperson name, sum(amount) monthly_revenue
  from sales s
  inner join users u on s.salesperson = u.name
  group by 1, 2, 3
), ranked_sales as(
  select month, user_id, name, monthly_revenue,
    row_number() over(partition by month order by monthly_revenue)
  from monthly_sales
)
select *
from ranked_sales rs
where rs.row_number = 1


-- Soal 3 — Hard
-- Tampilkan user yang bulan pertama mereka transaksi adalah di bulan Januari 2024,
-- dan hitung berapa revenue mereka di bulan pertama vs bulan kedua.
-- Kalau tidak ada transaksi di bulan kedua, tetap tampilkan dengan second_month_revenue = 0.
-- name | first_month_revenue | second_month_revenue | growth_pct

with first_month as(
	select user_id, min(date_trunc('month', created_at)) as "month"
	from raw_transactions rt 
	where rt.status = 'completed'
	group by 1
), jan_users as(
	--user yang pertama kali mulai transaksi di januari
	select user_id
	from first_month
	where month = '2024-01-01'
), monthly_revenue as(
	select rt.user_id, u."name",
		date_trunc('month', rt.created_at) "month",
		sum(amount) revenue
	from raw_transactions rt
	join jan_users j on rt.user_id = j.user_id
	join users u on rt.user_id = u.id 
	where rt.status = 'completed'
	group by 1, 2, 3
), pivoted as (
	select name,
		sum(case when month = '2024-01-01' then revenue else 0 end) as first_month_revenue,
		sum(case when month = '2024-02-01' then revenue else 0 end) as second_month_revenue
	from monthly_revenue
	group by 1
)
select *,
	case
		when first_month_revenue = 0 and second_month_revenue > 0 then 100.0
		when first_month_revenue = 0 and second_month_revenue = 0 then 0.0
		else round(((second_month_revenue - first_month_revenue) * 100.0) / first_month_revenue, 1)
	end as "growth_pct (%)"
from pivoted
