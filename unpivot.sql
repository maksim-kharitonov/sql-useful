/*
create table tmp_pivot_table as
          select d.id, d.bso_num, d.order_id, getmaincode(i.psl_id) psl,getmaincode(sr.dts_id) dts,getmaincode(sr.ag_id) ag
            from a_dealops d, a_salereports sr, a_incoming_srep i
           where sr.id = d.srep_id
             and i.id = sr.incoming_id
             and d.id in (40711897,40711898,40712249,40712250,40712251,40710602,40710603,40710388,40710381)
*/

select * 
 from (
      select d.id, /*d.bso_num, d.order_id,*/ getmaincode(i.psl_id) psl,getmaincode(sr.dts_id) dts,getmaincode(sr.ag_id) ag
            from a_dealops d, a_salereports sr, a_incoming_srep i
           where sr.id = d.srep_id
             and i.id = sr.incoming_id
             and d.id in (40711897,40711898,40712249,40712250,40712251,40710602,40710603,40710388,40710381)
      )
UNPIVOT (
         param_value                              --<-- unpivot_clause
          FOR param_code                              --<-- unpivot_for_clause
             IN  (psl, dts, ag) --<-- unpivot_in_clause
            );
