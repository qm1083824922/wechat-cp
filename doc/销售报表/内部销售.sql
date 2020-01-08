select DISTINCT tbd.id,
                tbd.bill_no,
                tbd.bill_type,
                tbd.project_id,
                tbd.required_send_num,
                tbd.required_send_amount,
                tbd.cost_amount,
                tbd.salesman_id,
                tbd.salesman
from tb_bill_delivery tbd
         left join tb_bill_delivery_dtl tbdd on tbd.id = tbdd.bill_delivery_id
         left join tb_base_goods tbg on tbdd.goods_id = tbg.id
         inner join tb_base_user_project bup on tbd.project_id = bup.project_id
         inner join tb_base_project tbp on tbp.id = bup.project_id
where tbd.is_delete = 0
  AND bup.user_id = 1
  AND bup.state = 1
  AND tbp.business_unit_id = 112
#   AND tbd.project_id != 9
  AND tbd.project_id = 10
  AND tbd.status = 5
  AND tbd.bill_type = 3
