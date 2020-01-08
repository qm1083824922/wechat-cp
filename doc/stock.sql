
-- status = 6 表示条款已完成
SELECT `status` from tb_project_item tpi;
-- 库存数量与成本单价不为0
select store_num,cost_price from tb_stl where 1 = 1 and (store_num >0 and cost_price>0);

-- 查询分配给管理员可用项目的库存商品信息
-- 1.关键条件：
-- 当前用户、条款状态(6：已完成)、分配给用户的项目可用(user_project.state=1)、指定库存中哪个项目
-- 库存数量、成本单价都不为0，商品表商品有效期天数为null或者库存表中到期日为null
select
    ts.id,
    ts.project_id,
    ts.warehouse_id,
    tbg.id goods_id,
    tbp.business_unit_id,
    ts.origin_accept_time,
    ts.store_num,
    ts.cost_price,
    ts.expiring_date,
    (ts.store_num * ts.cost_price) store_amount
from tb_stl ts,
     tb_project_item tpi,
     tb_base_project tbp,
     tb_base_user_project bup,
     tb_base_goods tbg
where 1 = 1
  and ts.project_id = tpi.project_id
  and ts.project_id = tbp.id
  and ts.project_id = bup.project_id
  and ts.goods_id = tbg.id
  and tpi.status = 6
  and bup.user_id = 1
  and bup.state = 1
  and ts.project_id = 4
  -- and s.warehouse_id =
  -- and b.business_unit_id =
  -- and b.department_id =
  -- and tbg.number =
  and (ts.store_num > 0 and ts.cost_price > 0)
  and (tbg.validity_or_days is null or ts.expiring_date is null)

-- union all
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



SELECT v_table.project_id,
       v_table.business_unit_id,
       v_table.department_id,
       v_table.id,
       v_table.goods_id,
       v_table.customer_id,
       v_table.validity_or_days,
       v_table.term_of_validity,
       SUM(v_table.sum_store_amount) sum_store_amount,
       SUM(v_table.sum_lock) sum_lock,
       (SUM(v_table.sum_store_amount) - SUM(v_table.sum_lock)) sum_not_lock,
       SUM(v_table.store_num) sum_num,
       SUM(v_table.lock_num) sum_lock_num,
       (SUM(v_table.store_num) - SUM(v_table.lock_num)) sum_not_lock_num,
       IF(v_table.in_store_time > 0 && v_table.in_store_time < 20, sum(v_table.store_num), 0) in_library_count1,
       IF(v_table.in_store_time > 0 && v_table.in_store_time < 20, sum(v_table.sum_store_amount), 0) in_library_amount1,
       IF(v_table.in_store_time >= 20 && v_table.in_store_time < 60, sum(v_table.store_num), 0) in_library_count2,
       IF(v_table.in_store_time >= 20 && v_table.in_store_time < 60, sum(v_table.sum_store_amount), 0) in_library_amount2,
       IF(v_table.in_store_time > 60, sum(v_table.store_num), 0) in_library_count3,
       IF(v_table.in_store_time > 60, sum(v_table.sum_store_amount), 0) in_library_amount3
from (select s.id,
             s.goods_id,
             b.department_id,
             s.project_id,
             b.business_unit_id,
             s.supplier_id,
             s.warehouse_id,
             s.customer_id,
             (s.lock_num * s.cost_price) sum_lock,
             s.store_num,
             s.lock_num,
             s.cost_price,
             IFNULL(tbg.validity_or_days, NULL) validity_or_days,
             (s.store_num * s.cost_price) sum_store_amount,
             if(tbg.validity_or_days = null || s.expiring_date = null, null, DATEDIFF(CURDATE(), s.expiring_date) + tbg.validity_or_days)  term_of_validity,
             DATEDIFF(CURDATE(), ifnull(s.origin_accept_time, s.accept_time)) in_store_time
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
        ) as v_table
group by v_table.project_id
order by sum_store_amount desc
limit 0, 25
