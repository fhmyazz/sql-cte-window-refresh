--Laporan 1 — Segmentasi user berdasarkan perilaku belanja:
with users_trx as(
	select u.name, u.tier, coalesce(sum(rt.amount), 0) as total_revenue
	from users u
	left join raw_transactions rt on u.id = rt.user_id and rt.status = 'completed'
	group by 1, 2
)
select *,
	case
		when ut.total_revenue > 2000000 then 'high value'
		when ut.total_revenue >= 500000 and ut.total_revenue <= 2000000 then 'medium value'		
		when ut.total_revenue > 0 and ut.total_revenue < 500000 then 'low value'
		else 'no purchase'
	end as segment
from users_trx ut

--Laporan 2 — User yang beli di kategori Electronics dan juga Fashion (pakai set operation, bukan JOIN)
select distinct user_id
from raw_transactions rt
where rt.category = 'Electronics'
and rt.status = 'completed'
intersect
select distinct user_id
from raw_transactions rt
where rt.category = 'Fashion'
and rt.status = 'completed'

--Laporan 3 — User yang beli Electronics tapi tidak pernah beli Fashion:
select distinct user_id
from raw_transactions rt
where rt.category = 'Electronics'
and rt.status = 'completed'
except
select distinct user_id
from raw_transactions rt
where rt.category = 'Fashion'
and rt.status = 'completed'