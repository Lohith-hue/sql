select node_id,changeset_id,version,current_version,visible,current_visibility,display_name,min_v,rn,
case when rn=1 and display_name in ('shradha','sachink','Shamilit','gowthamd','dilshadm','shajahanh','naseemad','mahalakshmir','thrilokeshg','neethuv','prathyusham') then 'create'
else 'modify' end as mod_type
from (
select a.node_id,b.changeset_id,b.version,b.visible,e.version as current_version,e.visible as current_visibility,c.user_id,d.display_name,
	min(b.version) over (partition by a.node_id) as min_v,
	row_number() over (partition by a.node_id order by b.version) as rn
from
(select * from node_tags
where k='highway' and v='traffic_signals'
) as a
left join nodes as b
on a.node_id=b.node_id
and a.version=b.version
left join changesets as c
on b.changeset_id=c.id
left join users as d
on c.user_id=d.id
left join current_nodes as e
on a.node_id=e.id
	group by 1,2,3,4,5,6,7,8
	order by 1,3
) as a
group by 1,2,3,4,5,6,7,8,9,10
order by 1,3
