select *
from (select temp.id,
             temp.goods_id,
             temp.number,
             temp.department_id,
             temp.project_id,
             temp.business_unit_id,
             temp.warehouse_id,
             temp.store_num,
             temp.sum_store_amount,
             IFNULL(temp.sum_store, 0) sum_store,
             IFNULL(temp.store_num, 0) sum_num
      from (SELECT s.id,
                   s.goods_id,
                   b.department_id,
                   s.origin_accept_time,
                   s.customer_id,
                   s.project_id,
                   b.business_unit_id,
                   s.warehouse_id,
                   s.supplier_id,
                   (s.store_num * s.cost_price)                                     sum_store,
                   (s.lock_num * s.cost_price)                                      sum_lock,
                   ((s.store_num - s.lock_num) * s.cost_price)                      sum_not_lock,
                   s.store_num,
                   s.lock_num,
                   (s.store_num - s.lock_num)                                       sum_not_lock_num,
                   s.cost_price,
                   tbg.bar_code,
                   tbg.number,
                   IFNULL(tbg.validity_or_days, NULL)                               validity_or_days,
                   (s.store_num * s.cost_price)                                     sum_store_amount,
                   if(tbg.validity_or_days = null || s.expiring_date = null, null,
                      DATEDIFF(CURDATE(), s.expiring_date) + tbg.validity_or_days)  term_of_validity,
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
              and s.project_id = 10
              and (s.store_num > 0 or s.cost_price > 0)
           ) as temp
     ) temp2
where 1 = 1
  and (store_num > 0 or sum_store_amount)


select DISTINCT ts.id,
                ts.bill_in_store_dtl_tally_id,
                ts.project_id,
                ts.supplier_id,
                ts.warehouse_id,
                ts.customer_id,
                ts.bill_in_store_id,
                ts.bill_in_store_dtl_id,
                ts.po_dtl_id,
                ts.po_id,
                ts.goods_id,
                ts.tally_num,
                ts.batch_no,
                ts.goods_status,
                ts.old_cost_price,
                ts.cost_price,
                ts.po_price,
                ts.in_store_num,
                ts.store_num,
                ts.lock_num,
                ts.sale_lock_num,
                ts.stl_id,
                ts.origin_accept_time,
                ts.accept_time,
                ts.receive_date,
                ts.currency_type,
                ts.exchange_rate,
                ts.remark,
                ts.creator_id,
                ts.creator,
                ts.create_at,
                ts.update_at,
                ts.bill_in_store_no,
                ts.affiliate_no,
                ts.order_no,
                ts.append_no,
                ts.pay_price,
                ts.pay_time,
                ts.pay_rate,
                ts.pay_real_currency,
                ts.fly_order_flag,
                ts.so_unit,
                ts.prate,
                ts.expiring_date
from tb_stl ts
         left join tb_base_goods tbg on ts.goods_id = tbg.id
         inner join tb_base_user_project bup on ts.project_id = bup.project_id
         inner join tb_base_project tbp on tbp.id = bup.project_id
where 1 = 1
  AND bup.user_id = 1
  AND bup.state = 1
  AND tbp.business_unit_id = 112
  AND ts.project_id = 10
