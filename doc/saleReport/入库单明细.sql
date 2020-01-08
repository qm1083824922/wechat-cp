select DISTINCT tbisd.id,
#                 tbisd.bill_in_store_id,
#                 tbisd.po_dtl_id,
#                 tbisd.po_id,
#                 tbisd.bill_out_store_dtl_id,
#                 tbisd.bill_out_store_id,
                tbisd.goods_id,
                tbisd.receive_num,
                tbisd.cost_price,
#                 tbisd.bill_in_store_dtl_id,
                tbisd.receive_date
from tb_bill_in_store_dtl tbisd
         left join tb_purchase_order_title tpot on tbisd.po_id = tpot.id
         left join tb_bill_delivery tbd on tbisd.bill_delivery_id = tbd.id
         left join tb_base_goods tbg on tbisd.goods_id = tbg.id
where 1 = 1
  AND tbisd.bill_in_store_id in
      (select id
from (select DISTINCT tbis.id,
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
                      tbis.receive_amount,
                      tbis.tally_num,
                      tbis.tally_amount,
                      tbis.acceptor_id,
                      tbis.acceptor,
                      tbis.accept_time,
                      tbis.bill_out_store_id,
                      tbis.currency_type,
                      tbis.exchange_rate,
                      tbis.wms_status,
                      tbis.remark,
                      tbis.print_num,
                      tbis.creator_id,
                      tbis.creator,
                      tbis.create_at,
                      tbis.update_at,
                      tbis.deleter_id,
                      tbis.deleter,
                      tbis.is_delete,
                      tbis.delete_at,
                      tbis.pay_amount
      from tb_bill_in_store tbis
               left join tb_bill_in_store_dtl tbisd on tbis.id = tbisd.bill_in_store_id
               left join tb_purchase_order_title tpot on tbisd.po_id = tpot.id
               left join tb_base_goods tbg on tbisd.goods_id = tbg.id
               inner join tb_base_user_project bup on tbis.project_id = bup.project_id
               inner join tb_base_project tbp on tbp.id = bup.project_id
      where 1 = 1
        and tbis.is_delete = 0
        AND tbis.warehouse_id in
            (1, 11, 13, 38, 69, 71, 73, 113, 120, 127, 147, 251, 271, 272, 273, 274, 275, 276, 277, 278, 333)
        AND bup.user_id = 1
        AND bup.state = 1
        AND tbp.business_unit_id = 7
        AND tbis.project_id = 4
        AND tbis.receive_date <= '2019-12-19 00:00:00'
        AND tbis.status = 2
    ) temp)
