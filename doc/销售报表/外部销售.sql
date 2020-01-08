select DISTINCT tbd.id,
                tbd.bill_no,
                tbd.bill_type,
                tbd.project_id,
                tbd.required_send_num,
                tbd.required_send_amount,
                tbd.cost_amount,
                tbd.po_amount,
                tbd.salesman_id,
                tbd.salesman
from tb_bill_delivery tbd
         left join tb_bill_delivery_dtl tbdd on tbd.id = tbdd.bill_delivery_id
         left join tb_base_goods tbg on tbdd.goods_id = tbg.id
         inner join tb_base_user_project bup on tbd.project_id = bup.project_id
         inner join tb_base_project tbp on tbp.id = bup.project_id
where tbd.is_delete = 0
  AND bup.user_id = 57
  AND bup.state = 1
  AND tbp.business_unit_id = 112
  AND tbd.project_id = 10
  AND tbd.status = 5
  AND tbd.bill_type = 1



select count(*) count
from (select DISTINCT tbd.id,
                      tbd.bill_no,
                      tbd.bill_type,
                      tbd.affiliate_no,
                      tbd.project_id,
                      tbd.warehouse_id,
                      tbd.customer_id,
                      tbd.status,
                      tbd.delivery_date,
                      tbd.required_send_date,
                      tbd.required_send_num,
                      tbd.required_send_amount,
                      tbd.cost_amount,
                      tbd.po_amount,
                      tbd.customer_address_id,
                      tbd.transfer_mode,
                      tbd.currency_type,
                      tbd.exchange_rate,
                      tbd.wms_status,
                      tbd.remark,
                      tbd.print_num,
                      tbd.creator_id,
                      tbd.creator,
                      tbd.create_at,
                      tbd.update_at,
                      tbd.deleter_id,
                      tbd.deleter,
                      tbd.is_delete,
                      tbd.delete_at,
                      tbd.sign_standard,
                      tbd.certificate_id,
                      tbd.certificate_name,
                      tbd.official_seal,
                      tbd.pay_amount,
                      tbd.return_time,
                      tbd.whole_return_time,
                      tbd.submitter_id,
                      tbd.submitter,
                      tbd.submit_time,
                      tbd.is_change_price,
                      tbd.receive_project_id,
                      tbd.receive_warehouse_id,
                      tbd.receive_supplier_id,
                      tbd.fly_order_flag,
                      tbd.salesman_id,
                      tbd.salesman,
                      tbd.top_supplier_id,
                      tbd.ultimate_customer_id,
                      tbd.ultimate_purchaser_id,
                      tbd.top_purchaser_id,
                      tbd.interior_delivery_id,
                      tbd.bank_name,
                      tbd.account_no,
                      tbd.pay_type,
                      tbd.erp_bill_no,
                      tbd.erp_notice_no
      from tb_bill_delivery tbd
               left join tb_bill_delivery_dtl tbdd on tbd.id = tbdd.bill_delivery_id
               left join tb_base_goods tbg on tbdd.goods_id = tbg.id
               inner join tb_base_user_project bup on tbd.project_id = bup.project_id
               inner join tb_base_project tbp on tbp.id = bup.project_id
      where tbd.is_delete = 0
        AND bup.user_id = 57
        AND bup.state = 1
        AND tbp.business_unit_id = 112
        AND tbd.project_id != 9
        AND tbd.project_id = 10
        AND tbd.status = 5
        AND tbd.bill_type = 1) t


select DISTINCT tbd.id,
                tbd.bill_no,
                tbd.bill_type,
                tbd.affiliate_no,
                tbd.project_id,
                tbd.warehouse_id,
                tbd.customer_id,
                tbd.status,
                tbd.delivery_date,
                tbd.required_send_date,
                tbd.required_send_num,
                tbd.required_send_amount,
                tbd.cost_amount,
                tbd.po_amount,
                tbd.customer_address_id,
                tbd.transfer_mode,
                tbd.currency_type,
                tbd.exchange_rate,
                tbd.wms_status,
                tbd.remark,
                tbd.print_num,
                tbd.creator_id,
                tbd.creator,
                tbd.create_at,
                tbd.update_at,
                tbd.deleter_id,
                tbd.deleter,
                tbd.is_delete,
                tbd.delete_at,
                tbd.sign_standard,
                tbd.certificate_id,
                tbd.certificate_name,
                tbd.official_seal,
                tbd.pay_amount,
                tbd.return_time,
                tbd.whole_return_time,
                tbd.submitter_id,
                tbd.submitter,
                tbd.submit_time,
                tbd.is_change_price,
                tbd.receive_project_id,
                tbd.receive_warehouse_id,
                tbd.receive_supplier_id,
                tbd.fly_order_flag,
                tbd.salesman_id,
                tbd.salesman,
                tbd.top_supplier_id,
                tbd.ultimate_customer_id,
                tbd.ultimate_purchaser_id,
                tbd.top_purchaser_id,
                tbd.interior_delivery_id,
                tbd.bank_name,
                tbd.account_no,
                tbd.pay_type,
                tbd.erp_bill_no,
                tbd.erp_notice_no
from tb_bill_delivery tbd
         left join tb_bill_delivery_dtl tbdd on tbd.id = tbdd.bill_delivery_id
         left join tb_base_goods tbg on tbdd.goods_id = tbg.id
         inner join tb_base_user_project bup on tbd.project_id = bup.project_id
         inner join tb_base_project tbp on tbp.id = bup.project_id
where tbd.is_delete = 0
  AND bup.user_id = 57
  AND bup.state = 1
  AND tbp.business_unit_id = 112
  AND tbd.project_id != 9
  AND tbd.project_id = 10
  AND tbd.bill_type = 3
order by id desc
limit 0, 25
