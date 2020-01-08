select
    id,
    bill_type,
    project_id,
    project_name,
    count(customer_name) customer_quantity,
    count(bill_no) bill_quantity,
    in_sale_num,
    in_sale_amount,
    ROUND(IFNULL(out_sale_amount/count(bill_no),0),2) customer_unit_price,
    out_sale_num,
    out_sale_amount,
    cost_amount,
    profit_amount
from
    (select
         id,
         bill_type,
         project_id,
         project_name,
         count(customer_name) customer_quantity,
         customer_name,
         bill_no,
         sum(in_sale_num) in_sale_num,
         sum(in_sale_amount) in_sale_amount,
-- 		ROUND(IFNULL(in_sale_amount/count(customer_name),0),2) in_customer_unit_price,
-- 		ROUND(IFNULL(out_sale_amount/count(customer_name),0),2) out_customer_unit_price,
         sum(out_sale_num) out_sale_num,
         sum(out_sale_amount) out_sale_amount,
         sum(cost_amount) cost_amount,
         sum(profit_amount) profit_amount,
         creator_id,
         creator,
         salesman_id,
         salesman,
         send_date
     from
         (SELECT
              id,
              bill_type,
              project_id,
              project_name,
              count(customer_name) customer_quantity,
              customer_name,
              bill_no,
              sum(in_sale_num) in_sale_num,
              sum(in_sale_amount) in_sale_amount,
--     round(ifnull(sum(in_sale_amount)/sum(in_sale_num),0),2) in_sale_customer_unit_price,
              sum(out_sale_num) out_sale_num,
              sum(out_sale_amount) out_sale_amount,
--     round(ifnull(sum(out_sale_amount)/sum(out_sale_num),0),2) out_sale_customer_unit_price,
              sum(cost_amount) cost_amount,
              sum(profit_amount) profit_amount,
              creator_id,
              creator,
              salesman_id,
              salesman,
              send_date
          from
              (SELECT DISTINCT
                   tbd.id,
                   tbd.bill_no,
                   tbd.bill_type,
                   tbd.project_id,
                   concat(tbp.project_no,'-',tbp.project_name) project_name,
                   concat(tbs.subject_no,'-',tbs.abbreviation) customer_name,
                   tbd.creator_id,
                   tbd.creator,
                   tbd.salesman_id,
                   tbd.salesman,
                   tbp.biz_type,
                   tbd.required_send_num in_sale_num,
                   tbd.required_send_amount in_sale_amount,
                   0 out_sale_num,
                   0 out_sale_amount,
                   tbd.cost_amount,
                   (tbd.required_send_amount - tbd.cost_amount) profit_amount,
                   tbd.required_send_date send_date
               FROM
                   tb_bill_delivery tbd
                       LEFT JOIN tb_bill_delivery_dtl tbdd ON tbd.id = tbdd.bill_delivery_id
                       LEFT JOIN tb_base_goods tbg ON tbdd.goods_id = tbg.id
                       INNER JOIN tb_base_user_project bup ON tbd.project_id = bup.project_id
                       INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
                       INNER JOIN tb_base_subject tbs ON tbs.id = tbd.customer_id
               WHERE
                       tbd.is_delete = 0
                 AND bup.user_id = 1
                 AND bup.state = 1
                 -- AND tbp.business_unit_id = 112
                 -- AND tbd.project_id = 4
                 AND tbd.STATUS = 5
                 AND tbd.bill_type = 3
                 -- and tbd.salesman_id = 45
               UNION
               SELECT DISTINCT
                   tbd.id,
                   tbd.bill_no,
                   tbd.bill_type,
                   tbd.project_id,
                   concat(tbp.project_no,'-',tbp.project_name) project_name,
                   concat(tbs.subject_no,'-',tbs.abbreviation) customer_name,
                   tbd.creator_id,
                   tbd.creator,
                   tbd.salesman_id,
                   tbd.salesman,
                   tbp.biz_type,
                   0 in_sale_num,
                   0 in_sale_amount,
                   tbd.required_send_num out_sale_num,
                   tbd.required_send_amount out_sale_amount,
                   tbd.cost_amount cost_amount,
                   tbd.required_send_amount - tbd.cost_amount profit_amount,
                   tbd.required_send_date send_date
               FROM
                   tb_bill_delivery tbd
                       LEFT JOIN tb_bill_delivery_dtl tbdd ON tbd.id = tbdd.bill_delivery_id
                       LEFT JOIN tb_base_goods tbg ON tbdd.goods_id = tbg.id
                       INNER JOIN tb_base_user_project bup ON tbd.project_id = bup.project_id
                       INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
                       INNER JOIN tb_base_subject tbs ON tbs.id = tbd.customer_id
               WHERE
                       tbd.is_delete = 0
                 AND bup.user_id = 1
                 AND bup.state = 1
                 -- AND tbp.business_unit_id = 112
                 -- AND tbd.project_id = 4
                 AND tbd.STATUS = 5
                 AND tbd.bill_type = 1
                 -- and tbd.salesman_id = 45
              ) temp GROUP BY project_id,creator_id,customer_name
         )temp2 GROUP BY project_id,bill_type,customer_name
    )temp3 GROUP BY project_id,bill_type;


SELECT
    tf.project_id project_id,
    tbp.biz_type biz_type,
    tbp.business_unit_id,
    IFNULL(SUM(IFNULL(tf.rec_amount,0)), 0) rec_amount,
    IFNULL(SUM(IFNULL(tf.pay_amount,0)), 0) pay_amount
FROM
    tb_fee tf
        INNER JOIN tb_base_user_project tbup ON tf.project_id = tbup.project_id
        INNER JOIN tb_base_project tbp ON tf.project_id = tbp.id
WHERE
        tf.state = 3
  AND tf.is_delete = 0
  AND tbup.user_id = 57
  AND tbup.state = 1
-- 	AND ( tf.book_date >= '2019-12-01' )
-- 	AND ( tf.book_date <= '2019-12-31' )
GROUP BY
    tf.project_id
