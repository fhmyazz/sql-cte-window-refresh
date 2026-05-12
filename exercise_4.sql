--GP-1 — Tampilkan semua user beserta total transaksi completed mereka. User yang belum pernah transaksi tetap tampil dengan total_revenue = 0 (bukan NULL).
select u.name, u.tier, count(rt.id) total_trx, coalesce(sum(rt.amount), 0) as total_revenue
from users u
left join raw_transactions rt on u.id = rt.user_id and rt.status = 'completed'
group by 1, 2

--GP-2 — Dari tabel products, tampilkan produk yang belum pernah terjual sama sekali.
select p.name, p.category, p.cost_price
from products p 
left join raw_transactions rt on p.id = rt.product_id
where rt.id is null