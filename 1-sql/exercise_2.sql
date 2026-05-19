--GP-2 — Dari data yang sudah dideduplikasi, buat summary per kategori khusus transaksi completed:
--category | total_revenue | total_trx | avg_trx | pct_of_total_revenue

--pct_of_total_revenue — kontribusi revenue kategori terhadap total keseluruhan, bulatkan 1 desimal
--Urutkan dari revenue tertinggi

with rownum_trx as (
	select *,
		row_number() over(
			partition by product_id, user_id, amount, created_at 
			order by id
		) as rownum_unique
	from raw_transactions
	where status = 'completed'
),
with_dedup as (
	select id, user_id, product_id, category, amount, status, created_at,
		sum(amount) over() as total_revenue
	from rownum_trx
	where rownum_unique = 1
),
with_category_revenue as(
	select category, total_revenue,
		sum(amount) as category_revenue,
		count(amount) as total_trx,
		avg(amount) as avg_trx
	from with_dedup
	group by 1, 2
)
select category, category_revenue, total_trx, avg_trx,
	round((100.0 * category_revenue / total_revenue), 1)
from with_category_revenue
order by category_revenue desc