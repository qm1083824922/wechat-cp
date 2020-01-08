SELECT tbos.project_id projectId,
       tbos.customer_id customerId,
       tbos.id billId,
       1 billType,
       '销售出库单' billTypeName,
       tbos.bill_no billNo,
       tbos.send_date accountDate,
       IFNULL(tbos.send_amount, 0) saleAmount,
       IFNULL(tbos.cost_amount, 0) costAmount,
       IFNULL(tbos.received_amount, 0) returnedAmount
FROM tb_bill_out_store tbos
         INNER join tb_base_user_project tbup on tbos.project_id = tbup.project_id
         INNER join tb_base_project tbp on tbos.project_id = tbp.id
         LEFT JOIN tb_base_subject tbs ON tbos.customer_id = tbs.id
WHERE tbos.bill_type = 1
  AND tbos.status = 5
  AND tbup.user_id = 57
  AND tbup.state = 1
  AND tbos.send_date >= '2019-12-01'
  AND tbos.send_date <= '2020-01-03'
  AND tbp.biz_special_id = 54
  AND tbp.department_id in (3)
  AND tbos.project_id = 10
  AND (tbs.subject_type & 1) != 1
limit 0, 25
