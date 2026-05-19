-- GP-1 — Tampilkan semua transaksi completed beserta cost_price produknya dan profit per transaksi. 
-- Gunakan data yang sudah dideduplikasi.
-- GP-2 — Dari hasil GP-1, tampilkan hanya transaksi yang profitnya di atas rata-rata profit keseluruhan.
-- id | user_id | category | amount | cost_price | profit

with completed_trx as(
	select
		   rt.id trx_id,
		   rt.user_id, p.category, rt.amount, p.cost_price,
		   rt.amount - p.cost_price profit,
		   row_number() over(
		   		partition by rt.user_id, p.category, rt.amount, rt.created_at
		   ) as rownum_unique
	from raw_transactions rt,
		 products p
	where rt.product_id = p.id
	and   rt.status = 'completed'
), with_dedup as(
	select *
	from completed_trx
	where rownum_unique = 1
), with_avg_profit as(
	select trx_id, user_id, category, amount, cost_price, profit,
			round(avg(profit) over(), 1) avg_profit
	from with_dedup
)
select trx_id, user_id, category, amount, cost_price, profit
from with_avg_profit wap
where profit > avg_profit 