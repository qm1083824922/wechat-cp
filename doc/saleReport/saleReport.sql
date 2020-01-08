-- 内部销售 bill_type = 6
SELECT
    SUM( IFNULL( tbos.send_amount, 0 ) )
FROM
    tb_bill_out_store tbos,
    tb_base_user_project tbup,
    tb_base_project tbp,
    tb_base_subject tbs
WHERE 1 = 1
  and tbos.project_id = tbup.project_id
  and tbos.project_id = tbp.id
  and tbos.customer_id = tbs.id
  and tbos.bill_type = 1
  AND tbos.STATUS = 5
  AND tbup.user_id = 1
  AND tbup.state = 1
  AND tbos.send_date >= '2019-11-01'
  AND tbos.send_date <= '2019-11-29'
  AND tbos.project_id = tmp.project_id
  AND ( tbs.subject_type & 1 ) = 1;

-- 外部销售 bill_type = 6
SELECT
    SUM( IFNULL( tbos.send_amount, 0 ) )
FROM
    tb_bill_out_store tbos,
    tb_base_user_project tbup,
    tb_base_project tbp,
    tb_base_subject tbs
WHERE 1 = 1
  and tbos.project_id = tbup.project_id
  and tbos.project_id = tbp.id
  and tbos.customer_id = tbs.id
  and tbos.bill_type = 6
  AND tbos.STATUS = 5
  AND tbup.user_id = 1
  AND tbup.state = 1
  AND tbos.send_date >= '2019-11-01'
  AND tbos.send_date <= '2019-11-29'
  AND tbos.project_id = tmp.project_id
  AND ( tbs.subject_type & 1 ) != 1;


SELECT
    tmp.project_id project_id,
    tmp.biz_manager_id biz_manager_id,
    tmp.department_id department_id,
    tmp.biz_type biz_type,
    SUM( tmp.sale_amount ) sale_amount,
    SUM( tmp.cost_amount ) cost_amount,
    SUM( tmp.profit_amount ) profit_amount,
    (
        SELECT
            SUM( IFNULL( tbos.send_amount, 0 ) )
        FROM
            tb_bill_out_store tbos,
            tb_base_user_project tbup,
            tb_base_project tbp,
            tb_base_subject tbs
        WHERE 1 = 1
          and tbos.project_id = tbup.project_id
          and tbos.project_id = tbp.id
          and tbos.customer_id = tbs.id
          and tbos.bill_type = 1
          AND tbos.STATUS = 5
          AND tbup.user_id = 1
          AND tbup.state = 1
          AND tbos.send_date >= '2019-11-01'
          AND tbos.send_date <= '2019-11-29'
          AND tbos.project_id = tmp.project_id
          AND ( tbs.subject_type & 1 ) = 1
    ) inner_sale_amount,
    (
        SELECT
            SUM( IFNULL( tbos.send_amount, 0 ) )
        FROM
            tb_bill_out_store tbos,
            tb_base_user_project tbup,
            tb_base_project tbp,
            tb_base_subject tbs
        WHERE 1 = 1
          and tbos.project_id = tbup.project_id
          and tbos.project_id = tbp.id
          and tbos.customer_id = tbs.id
          and tbos.bill_type = 6
          AND tbos.STATUS = 5
          AND tbup.user_id = 1
          AND tbup.state = 1
          AND tbos.send_date >= '2019-11-01'
          AND tbos.send_date <= '2019-11-29'
          AND tbos.project_id = tmp.project_id
          AND ( tbs.subject_type & 1 ) != 1
    ) outer_sale_amount,
    SUM( tmp.rec_amount ) rec_amount,
    SUM( tmp.pay_amount ) pay_amount
from
    (SELECT
    tbos.project_id project_id,
    tbp.biz_special_id biz_manager_id,
    tbp.department_id department_id,
    tbp.biz_type biz_type,
    SUM( IFNULL( tbos.send_amount, 0 ) ) sale_amount,
    SUM( IFNULL( tbos.cost_amount, 0 ) ) cost_amount,
    SUM( IFNULL( tbos.send_amount, 0 ) - IFNULL( tbos.cost_amount, 0 ) ) profit_amount,
    0 AS rec_amount,
    0 AS pay_amount
FROM
    tb_bill_out_store tbos,
    tb_base_user_project tbup,
    tb_base_project tbp,
    tb_base_subject tbs
WHERE 1 = 1
    and tbos.project_id = tbup.project_id
    and tbos.project_id = tbp.id
    and tbos.customer_id = tbs.id
    and tbos.bill_type = 1
    AND tbos.STATUS = 5
    AND tbup.user_id = 1
    AND tbup.state = 1
    AND tbos.send_date >= '2019-11-01'
    AND tbos.send_date <= '2019-11-29'
GROUP BY
    tbos.project_id
UNION ALL
SELECT
    tf.project_id project_id,
    tbp.biz_special_id biz_manager_id,
    tbp.department_id department_id,
    tbp.biz_type biz_type,
    0 sale_amount,
    0 cost_amount,
    0 profit_amount,
    IFNULL( SUM( IFNULL( tf.rec_amount, 0 ) ), 0 ) rec_amount,
    IFNULL( SUM( IFNULL( tf.pay_amount, 0 ) ), 0 ) pay_amount
FROM
    tb_fee tf,
    tb_base_user_project tbup,
    tb_base_project tbp
WHERE 1 = 1
  and tf.project_id = tbup.project_id
  and tf.project_id = tbp.id
  and tf.state = 3
  AND tf.is_delete = 0
  AND tbup.user_id = 1
  AND tbup.state = 1
  AND ( tf.book_date >= '2019-11-01' )
  AND ( tf.book_date <= '2019-11-29' )
GROUP BY
    tf.project_id) as tmp
group by tmp.project_id
