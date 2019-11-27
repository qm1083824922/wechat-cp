select
    project_id,
    warehouse_id,
    goods_id,
    ifnull(date_of_expiry_count1,0)  date_of_expiry_count1,
    ifnull(date_of_expiry_amount1,0) date_of_expiry_amount1,
    ifnull(date_of_expiry_count2,0) date_of_expiry_count2,
    ifnull(date_of_expiry_amount2,0) date_of_expiry_amount2,
    ifnull(date_of_expiry_count3,0) date_of_expiry_count3,
    ifnull(date_of_expiry_amount3,0) date_of_expiry_amount3,
    '-' date_of_expiry_count4,
    '-' date_of_expiry_amount4
from (
         SELECT v_table.id,
                v_table.project_id,
                v_table.warehouse_id,
                v_table.goods_id,
                v_table.business_unit_id,
                v_table.store_amount,
                IF(v_table.term_of_validity > 0 && ( 3 * v_table.term_of_validity < v_table.validity_or_days ),v_table.store_num, 0) date_of_expiry_count1,
                IF(v_table.term_of_validity > 0 && (3 * v_table.term_of_validity < v_table.validity_or_days ),v_table.store_amount, 0) date_of_expiry_amount1,
                IF((3 * v_table.term_of_validity >= v_table.validity_or_days ) && (2 * term_of_validity < v_table.validity_or_days), v_table.store_num,0) date_of_expiry_count2,
                IF((3 * v_table.term_of_validity >= v_table.validity_or_days ) && (2 * term_of_validity < v_table.validity_or_days), v_table.store_amount,0) date_of_expiry_amount2,
                IF(2 * v_table.term_of_validity >= v_table.validity_or_days, v_table.store_num,0) date_of_expiry_count3,
                IF(2 * v_table.term_of_validity >= v_table.validity_or_days, v_table.store_amount, 0) date_of_expiry_amount3
         from (select
                   s.id,
                   s.project_id,
                   s.warehouse_id,
                   tbg.id goods_id,
                   b.business_unit_id,
                   s.origin_accept_time,
                   s.store_num,
                   s.cost_price,
                   s.expiring_date,
                   IFNULL(tbg.validity_or_days, 0) validity_or_days,
                   (s.store_num * s.cost_price) store_amount,
                   DATEDIFF(CURDATE(),s.expiring_date) + tbg.validity_or_days term_of_validity
               from tb_stl s,
                    tb_project_item p,
                    tb_base_project b,
                    tb_base_user_project bup,
                    tb_base_goods tbg
               where 1 = 1
                 and s.project_id = p.project_id
                 and s.project_id = b.id
                 and s.project_id = bup.project_id
                 and s.goods_id = tbg.id
                 and p.status = 6
                 and bup.user_id = 1
                 and bup.state = 1
                 and s.project_id = 4
                 -- and s.warehouse_id =
                 -- and b.business_unit_id =
                 -- and tbg.number =
                 and (s.store_num > 0 and s.cost_price) > 0
                 and tbg.validity_or_days is not null
                 and s.expiring_date is not null
              ) as v_table
     )as temp
group by temp.project_id,temp.business_unit_id,temp.goods_id
having SUM(temp.store_amount) > 0
union all
select
    project_id,
    warehouse_id,
    goods_id,
    '-' date_of_expiry_count1,
    '-' date_of_expiry_amount1,
    '-' date_of_expiry_count2,
    '-' date_of_expiry_amount2,
    '-' date_of_expiry_count3,
    '-' date_of_expiry_amount3,
    ifnull(v_table.store_num,0) date_of_expiry_count4,
    ifnull(v_table.store_amount,0) date_of_expiry_amount4
from (select
          s.id,
          s.project_id,
          s.warehouse_id,
          tbg.id goods_id,
          b.business_unit_id,
          s.origin_accept_time,
          s.store_num,
          s.cost_price,
          s.expiring_date,
          (s.store_num * s.cost_price) store_amount
      from tb_stl s,
           tb_project_item p,
           tb_base_project b,
           tb_base_user_project bup,
           tb_base_goods tbg
      where 1 = 1
        and s.project_id = p.project_id
        and s.project_id = b.id
        and s.project_id = bup.project_id
        and s.goods_id = tbg.id
        and p.status = 6
        and bup.user_id = 1
        and bup.state = 1
        and s.project_id = 4
        -- and s.warehouse_id =
        -- and b.business_unit_id =
        -- and b.department_id =
        -- and tbg.number =
        and (s.store_num > 0 and s.cost_price) > 0
        and (tbg.validity_or_days is null or s.expiring_date is null)
     ) as v_table
group by v_table.project_id,v_table.business_unit_id,v_table.goods_id
having sum(v_table.store_amount) > 0
