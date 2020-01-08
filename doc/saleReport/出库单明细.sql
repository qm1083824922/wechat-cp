select DISTINCT tbosd.id,
                tbosd.goods_id,
                tbosd.send_num,
                tbosd.send_price,
                tbosd.cost_amount
from tb_bill_out_store_dtl tbosd
         left join tb_base_goods tbg on tbosd.goods_id = tbg.id
where 1 = 1
  AND tbosd.bill_out_store_id in
(select id from
    (select DISTINCT tbos.id id,
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
                tbos.pay_amount,
                tbos.received_amount,
                tbos.return_num
from tb_bill_out_store tbos
         left join tb_bill_out_store_dtl tbosd on tbos.id = tbosd.bill_out_store_id
         left join tb_bill_delivery tbd on tbd.id = tbos.bill_delivery_id
         left join tb_base_goods tbg on tbosd.goods_id = tbg.id
         inner join tb_base_user_project bup on tbos.project_id = bup.project_id
         inner join tb_base_project tbp on tbp.id = bup.project_id
where 1 = 1
  and tbos.is_delete = 0
  AND tbos.warehouse_id in
      (1, 11, 13, 38, 69, 71, 73, 113, 120, 127, 147, 251, 271, 272, 273, 274, 275, 276, 277, 278, 333)
  AND bup.user_id = 1
  AND bup.state = 1
  AND tbp.business_unit_id = 7
  AND tbos.project_id = 4
  AND tbos.send_date <= '2019-12-19 00:00:00'
  AND tbos.status = 5) temp)
