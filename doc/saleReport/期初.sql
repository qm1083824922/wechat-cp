-- 查询期初入库数量与金额
select SUM(IFNULL(tbis.receive_num)),
       SUM(ifnull(tbis.receive_amount, 0))
from tb_bill_in_store tbis,
     tb_bill_in_store_dtl tbisd,
     tb_purchase_order_title tpot,
     tb_base_goods tbg,
     tb_base_user_project bup,
     tb_base_project tbp
where 1 = 1
  and tbis.id = tbisd.bill_in_store_id
  and tbisd.po_id = tpot.id
  and tbisd.goods_id = tbg.id
  and tbis.project_id = bup.project_id
  and tbp.id = bup.project_id
  and tbis.is_delete = 0
  AND bup.user_id = 1
  AND bup.state = 1
  AND tbp.business_unit_id = 112
  AND tbis.project_id = 10
  AND tbis.receive_date <= '2019-12-01 00:00:00'
  AND tbis.status = 2
  AND tbg.number like CONCAT('%', 'P100001003', '%')


-- 查询期初出库数量与金额
select SUM(IFNULL(tbos.send_num, 0)),
       SUM(IFNULL(tbos.send_amount, 0))
from tb_bill_out_store tbos,
     tb_bill_out_store_dtl tbosd,
     tb_bill_delivery tbd,
     tb_base_goods tbg,
     tb_base_user_project bup,
     tb_base_project tbp
where 1 = 1
  and tbos.id = tbosd.bill_out_store_id
  and tbd.id = tbos.bill_delivery_id
  and tbosd.goods_id = tbg.id
  and tbos.project_id = bup.project_id
  and tbp.id = bup.project_id
  and tbos.is_delete = 0
  AND bup.user_id = 1
  AND bup.state = 1
  AND tbp.business_unit_id = 112
  AND tbos.project_id = 10
  AND tbos.send_date <= '2019-12-01 00:00:00'
  AND tbos.status = 5
  AND tbg.number like CONCAT('%', 'P100001003', '%')

--
SELECT (v1.initial_in_num - v2.initial_end_num)       initial_num,
       (v1.initial_in_amount - v2.initial_end_amount) initial_amount
FROM (
         SELECT project_id,
                IFNULL(SUM(temp.receive_num), 0)    initial_in_num,
                IFNULL(SUM(temp.receive_amount), 0) initial_in_amount
         FROM (
                  select DISTINCT tbis.id,
                                  tbis.bill_no,
                                  tbis.bill_type,
                                  tbis.affiliate_no,
                                  tbis.project_id,
                                  tbis.supplier_id,
                                  tbis.warehouse_id,
                                  tbis.customer_id,
                                  tbis.status,
                                  tbis.receive_date,
                                  tbis.receive_num,
                                  tbis.receive_amount
                  from tb_bill_in_store tbis
                           left join tb_bill_in_store_dtl tbisd on tbis.id = tbisd.bill_in_store_id
                           left join tb_purchase_order_title tpot on tbisd.po_id = tpot.id
                           left join tb_base_goods tbg on tbisd.goods_id = tbg.id
                           inner join tb_base_user_project bup on tbis.project_id = bup.project_id
                           inner join tb_base_project tbp on tbp.id = bup.project_id
                  where 1 = 1
                    and tbis.is_delete = 0
                    AND bup.user_id = 1
                    AND bup.state = 1
                    AND tbis.receive_date <= '2019-12-01 00:00:00'
                    AND tbis.status = 2
              ) temp
     ) v1,
     (
         SELECT project_id,
                IFNULL(SUM(temp2.send_num), 0)    initial_end_num,
                IFNULL(SUM(temp2.send_amount), 0) initial_end_amount
         FROM (
                  select DISTINCT tbos.id,
                                  tbos.bill_no,
                                  tbos.bill_type,
                                  tbos.affiliate_no,
                                  tbos.project_id,
                                  tbos.warehouse_id,
                                  tbos.customer_id,
                                  tbos.ar_customer_id,
                                  tbos.receive_warehouse_id,
                                  tbos.status,
                                  tbos.required_send_date,
                                  tbos.send_date,
                                  tbos.bill_delivery_id,
                                  tbos.send_num,
                                  tbos.send_amount,
                                  tbos.pickup_num,
                                  tbos.pickup_amount,
                                  tbos.cost_amount,
                                  tbos.po_amount,
                                  tbos.customer_address_id,
                                  tbos.transfer_mode,
                                  tbos.deliver_id,
                                  tbos.deliverer,
                                  tbos.deliver_time,
                                  tbos.system_deliver_time,
                                  tbos.currency_type,
                                  tbos.exchange_rate,
                                  tbos.reason_type,
                                  tbos.wms_status,
                                  tbos.remark,
                                  tbos.print_num,
                                  tbos.creator_id,
                                  tbos.creator,
                                  tbos.create_at,
                                  tbos.update_at,
                                  tbos.deleter_id,
                                  tbos.deleter,
                                  tbos.is_delete,
                                  tbos.delete_at,
                                  tbos.sign_standard,
                                  tbos.certificate_id,
                                  tbos.certificate_name,
                                  tbos.official_seal,
                                  tbos.pay_amount,
                                  tbos.received_amount,
                                  tbos.fund_back_amount,
                                  tbos.return_num,
                                  tbos.po_return_id,
                                  tbos.fly_order_flag,
                                  tbos.ref_bill_out_store_id,
                                  tbos.pl_export_count,
                                  tbos.pl_export_data
                  from tb_bill_out_store tbos
                           left join tb_bill_out_store_dtl tbosd on tbos.id = tbosd.bill_out_store_id
                           left join tb_bill_delivery tbd on tbd.id = tbos.bill_delivery_id
                           left join tb_base_goods tbg on tbosd.goods_id = tbg.id
                           inner join tb_base_user_project bup on tbos.project_id = bup.project_id
                           inner join tb_base_project tbp on tbp.id = bup.project_id
                  where 1 = 1
                    and tbos.is_delete = 0
                    AND bup.user_id = 1
                    AND bup.state = 1
                    AND tbos.send_date <= '2019-12-01 00:00:00'
                    AND tbos.status = 5
              ) temp2
     ) v2
group by v1.project_id


select IFNULL(SUM(temp3.receive_num), 0)    current_in_num,
       IFNULL(SUM(temp3.receive_amount), 0) current_in_amount
from (
         select DISTINCT tbis.id,
                         tbis.receive_num,
                         tbis.receive_amount
         from tb_bill_in_store tbis
                  left join tb_bill_in_store_dtl tbisd on tbis.id = tbisd.bill_in_store_id
                  left join tb_purchase_order_title tpot on tbisd.po_id = tpot.id
                  left join tb_base_goods tbg on tbisd.goods_id = tbg.id
                  inner join tb_base_user_project bup on tbis.project_id = bup.project_id
                  inner join tb_base_project tbp on tbp.id = bup.project_id
         where 1 = 1
           and tbis.is_delete = 0
           AND bup.user_id = 1
           AND bup.state = 1
           AND tbis.project_id = 10
           AND tbis.receive_date >= '2019-12-01 00:00:00'
           AND tbis.receive_date <= '2019-12-12 00:00:00'
           AND tbis.status = 2) temp3

select IFNULL(SUM(temp4.send_num), 0)    current_out_num,
       IFNULL(SUM(temp4.send_amount), 0) current_out_amount
from (
         select DISTINCT tbos.id,
                         tbos.send_num,
                         tbos.send_amount
         from tb_bill_out_store tbos
                  left join tb_bill_out_store_dtl tbosd on tbos.id = tbosd.bill_out_store_id
                  left join tb_bill_delivery tbd on tbd.id = tbos.bill_delivery_id
                  left join tb_base_goods tbg on tbosd.goods_id = tbg.id
                  inner join tb_base_user_project bup on tbos.project_id = bup.project_id
                  inner join tb_base_project tbp on tbp.id = bup.project_id
         where 1 = 1
           and tbos.is_delete = 0
           AND bup.user_id = 1
           AND bup.state = 1
           AND tbos.project_id = 10
           AND tbos.send_date >= '2019-12-01 00:00:00'
           AND tbos.send_date <= '2019-12-12 00:00:00'
           AND tbos.status = 5
     ) temp4


select curdate();
select last_day(curdate());
select DATE_ADD(curdate(), interval -day(curdate()) + 1 day);
select date_add(curdate() - day(curdate()) + 1, interval 1 month);
select DATEDIFF(date_add(curdate() - day(curdate()) + 1, interval 1 month),
                DATE_ADD(curdate(), interval -day(curdate()) + 1 day))
from dual;

