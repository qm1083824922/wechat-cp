SELECT
    tbis.bill_no bill_no,
    tbis.project_id projectId,
    concat(tbp.project_no, '-', tbp.project_name) projectName,
    tbp.business_unit_id busiUnitId,
    concat(tbs.subject_no, '-', tbs.abbreviation) businessName,
    tbisd.goods_id goodsId,
    tbg.brand brand,
    tbg.NAME goodName,
    tbg.goods_type goodsType,
    tbisd.receive_num,
    (tbisd.receive_num * tbisd.receive_price) receive_amount,
    tbisd.receive_num instore_num,
    tbisd.cost_price cost_price,
    tbis.id instore_id,
    tbisd.id instore_detail_id,
    tbg.specification specification,
    tbg.number number,
    tbg.bar_code barCode
FROM
    tb_bill_in_store tbis
        INNER JOIN tb_bill_in_store_dtl tbisd ON tbis.id = tbisd.bill_in_store_id
        INNER JOIN tb_base_goods tbg ON tbisd.goods_id = tbg.id
        INNER JOIN tb_base_user_project bup ON tbis.project_id = bup.project_id
        INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
        INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
WHERE
        1 = 1
  AND tbis.is_delete = 0
  AND bup.user_id = 1
  AND bup.state = 1
  AND ( tbs.subject_type & 1 = 1 )
  AND tbis.STATUS = 2
