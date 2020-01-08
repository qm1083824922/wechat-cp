SELECT v_table.project_id,
       v_table.business_unit_id,
       v_table.department_id,
       v_table.id,
       v_table.goods_id,
       v_table.customer_id,
       v_table.validity_or_days,
       v_table.term_of_validity,
       SUM(v_table.sum_store_amount) sum_store,
       (SUM(v_table.sum_lock_amount) + SUM(v_table.sum_sale_lock_amount)) sum_lock,
       (SUM(v_table.sum_store_amount) - SUM(v_table.sum_lock_amount) - SUM(v_table.sum_sale_lock_amount)) sum_not_lock,
       SUM(v_table.store_num) sum_num,
       (SUM(v_table.lock_num) + SUM(v_table.sale_lock_num)) sum_lock_num,
       (SUM(v_table.store_num) - SUM(v_table.lock_num) + SUM(v_table.sale_lock_num)) sum_not_lock_num,
       IF(v_table.in_store_time > 0 && v_table.in_store_time < 20, sum(v_table.store_num),0)  in_library_count1,
       IF(v_table.in_store_time > 0 && v_table.in_store_time < 20, sum(v_table.sum_store_amount), 0) in_library_amount1,
       IF(v_table.in_store_time >= 20 && v_table.in_store_time < 60, sum(v_table.store_num),0) in_library_count2,
       IF(v_table.in_store_time >= 20 && v_table.in_store_time < 60, sum(v_table.sum_store_amount),0) in_library_amount2,
       IF(v_table.in_store_time > 60, sum(v_table.store_num),0) in_library_count3,
       IF(v_table.in_store_time > 60, sum(v_table.sum_store_amount),0) in_library_amount3
from (select s.id,
             s.goods_id,
             b.department_id,
             s.project_id,
             b.business_unit_id,
             s.supplier_id,
             s.warehouse_id,
             s.customer_id,
             (s.store_num * s.cost_price) sum_store_amount,
             (s.lock_num * s.cost_price) sum_lock_amount,
             (s.sale_lock_num * s.cost_price) sum_sale_lock_amount,
             s.store_num,
             s.lock_num,
             s.sale_lock_num,
             s.cost_price,
             IFNULL(tbg.validity_or_days, NULL) validity_or_days,
             if(tbg.validity_or_days = null || s.expiring_date = null, null, DATEDIFF(CURDATE(), s.expiring_date) + tbg.validity_or_days)  term_of_validity,
             DATEDIFF(CURDATE(), ifnull(s.origin_accept_time, s.accept_time)) in_store_time
      from tb_stl s,
           tb_base_project b,
           tb_base_user_project bup,
           tb_base_goods tbg
      where 1 = 1
        and s.project_id = b.id
        and s.project_id = bup.project_id
        and s.goods_id = tbg.id
        and bup.user_id = 47
        and bup.state = 1
        and (s.store_num > 0)) as v_table
group by v_table.project_id
order by sum_store desc
limit 0, 25
