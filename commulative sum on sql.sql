with t as (
select rownum a from dual 
connect by rownum < 10
)
select t1.a,sum(t2.a),listagg(t2.a,',') WITHIN GROUP (ORDER BY t2.a),exp(sum(ln(t2.a)))
from t t1,
     t t2
where t1.a >= t2.a
group by t1.a
order by t1.a
