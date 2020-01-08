SELECT
    tbp.id project_id,
    tbp.business_unit_id,
    concat(tbp.project_no,'-',tbp.project_name) project_name,
    concat(tbs.subject_no,'-',tbs.abbreviation) subject_name,
    sum(tbisd.receive_num) initial_in_num,
    sum(tbisd.receive_num * tbisd.cost_price) initial_in_amount,
    0 initial_out_num,
    0 initial_out_amount,
    tbg.id goods_id,
    tbg.brand,
    tbg.`name`,
    tbg.goods_type,
    tbg.specification,
    tbg.number,
    tbg.bar_code
FROM
    tb_bill_in_store tbis
        LEFT JOIN tb_bill_in_store_dtl tbisd ON tbis.id = tbisd.bill_in_store_id
        LEFT JOIN tb_base_goods tbg ON tbisd.goods_id = tbg.id
        INNER JOIN tb_base_user_project bup ON tbis.project_id = bup.project_id
        INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
        INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
WHERE
        1 = 1
  AND tbis.is_delete = 0
  AND bup.user_id = 1
  AND bup.state = 1
  AND ( tbs.subject_type & 1 = 1 )
  AND tbis.receive_date <= '2019-12-01 00:00:00'
  AND tbis.STATUS = 2
  and tbp.id = 10
  and tbp.business_unit_id = 112
GROUP BY tbp.id,tbg.id,tbp.business_unit_id
union
SELECT
    tbp.id project_id,
    tbp.business_unit_id,
    concat( tbp.project_no, '-', tbp.project_name ) project_name,
    concat( tbs.subject_no, '-', tbs.abbreviation ) subject_name,
    0 initial_in_num,
    0 initial_in_amount,
    sum(tbosd.send_num) initial_out_num,
    sum(tbosd.cost_amount) initial_out_amount,
    tbg.id goods_id,
    tbg.brand,
    tbg.`name`,
    tbg.goods_type,
    tbg.specification,
    tbg.number,
    tbg.bar_code
FROM
    tb_bill_out_store tbos
        LEFT JOIN tb_bill_out_store_dtl tbosd ON tbos.id = tbosd.bill_out_store_id
        LEFT JOIN tb_base_goods tbg ON tbosd.goods_id = tbg.id
        INNER JOIN tb_base_user_project bup ON tbos.project_id = bup.project_id
        INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
        INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
WHERE
        1 = 1
  AND tbos.is_delete = 0
  AND bup.user_id = 1
  AND bup.state = 1
  AND ( tbs.subject_type & 1 = 1 )
  AND tbos.send_date <= '2019-12-01 00:00:00'
  AND tbos.STATUS = 5
  AND tbp.id = 10
  AND tbp.business_unit_id = 112
GROUP BY tbp.id,tbg.id,tbp.business_unit_id
