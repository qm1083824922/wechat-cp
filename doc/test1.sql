SELECT
    userId,
    projectId,
    goodsId,
    busiUnitId,
    concat( projectNo, '-', abbreviationProjectName ) projectName,
    concat( subjectNo, '-', abbreviation ) businessName,
    brand,
    goodName,
    goodsType,
    specification,
    number,
    taxRate,
    barCode,
    ifnull( sum( IFNULL( initial_in.receive_num, 0 ) ), 0 ) initial_in_num,
    ifnull( sum( IFNULL( initial_in.receive_num * initial_in.cost_price, 0 ) ), 0 ) initial_in_amount,
    ifnull( sum( IFNULL( end_in.receive_num, 0 ) ), 0 ) end_in_num,
    ifnull( sum( IFNULL( end_in.receive_num * end_in.cost_price, 0 ) ), 0 ) end_in_amount,
    ifnull(sum(IFNULL(initial_out.send_num, 0)),0) initial_out_num,
    ifnull(sum(IFNULL((initial_out.cost_amount), 0)),0) initial_out_amount,
    ifnull(sum(IFNULL(end_out.send_num, 0)),0) end_out_num,
    ifnull(sum(IFNULL((end_out.cost_amount), 0)),0) end_out_amount,
    ifnull(sum(IFNULL(current_in.receive_num, 0)),0) current_in_num,
    ifnull(sum(IFNULL(current_in.receive_num * current_in.cost_price, 0)),0) current_in_amount,
    ifnull(sum(IFNULL(current_other_in.receive_num, 0)),0) current_other_in_num,
    ifnull(sum(IFNULL(current_other_in.receive_num * current_other_in.cost_price, 0)),0) current_other_in_amount,
    ifnull(sum(IFNULL(( current_out.send_num), 0)),0) current_out_num,
    ifnull(sum(IFNULL(( current_out.cost_amount), 0)),0) current_out_amount,
    ifnull(sum(IFNULL(( current_other_out.send_num), 0)),0) current_other_out_num,
    ifnull(sum(IFNULL(( current_other_out.cost_amount), 0)),0) current_other_out_amount,
    ifnull(sum(IFNULL(sale.send_num, 0)),0) sale_num,
    ifnull(sum(IFNULL(sale.send_num * sale.send_price, 0)),0) sale_amount
FROM
    (
        SELECT
            tbup.user_id userId,
            tbis.project_id projectId,
            tbp.project_no projectNo,
            tbp.project_name abbreviationProjectName,
            tbs.subject_no subjectNo,
            tbs.abbreviation abbreviation,
            tbisd.goods_id goodsId,
            tbg.brand brand,
            tbg.NAME goodName,
            tbg.goods_type goodsType,
            tbg.specification specification,
            tbg.number number,
            tbg.tax_rate taxRate,
            tbg.bar_code barCode,
            tbp.business_unit_id busiUnitId
        FROM
            tb_bill_in_store_dtl tbisd,
            tb_bill_in_store tbis,
            tb_base_project tbp,
            tb_base_subject tbs,
            tb_base_user_project tbup,
            tb_base_goods tbg
        WHERE
                1 = 1
          AND tbisd.bill_in_store_id = tbis.id
          AND tbis.project_id = tbp.id
          AND tbp.id = tbup.project_id
          AND tbp.business_unit_id = tbs.id
          AND tbisd.goods_id = tbg.id
          AND ( tbs.subject_type & 1 = 1 )
          AND tbis.STATUS = 2
          AND tbis.is_delete = 0
          AND tbup.state = 1
          AND tbup.user_id = 1
          AND DATE_FORMAT( tbis.accept_time, "%Y-%m-%d" ) <= '2019-10-31' UNION
        SELECT
            tbup.user_id user_id,
            tbos.project_id projectId,
            tbp.project_no projectNo,
            tbp.project_name abbreviationProjectName,
            tbs2.subject_no subjectNo,
            tbs2.abbreviation abbreviation,
            tbosd.goods_id AS goodsId,
            tbg2.brand brand,
            tbg2.NAME goodName,
            tbg2.goods_type goodType,
            tbg2.specification specification,
            tbg2.number number,
            tbg2.tax_rate taxRate,
            tbg2.bar_code barCode,
            tbp.business_unit_id busiUnitId
        FROM
            tb_bill_out_store tbos,
            tb_bill_out_store_dtl tbosd,
            tb_base_project tbp,
            tb_base_subject tbs2,
            tb_base_user_project tbup,
            tb_base_goods tbg2
        WHERE
                1 = 1
          AND tbos.id = tbosd.bill_out_store_id
          AND tbos.project_id = tbp.id
          AND tbp.id = tbup.project_id
          AND tbp.business_unit_id = tbs2.id
          AND tbosd.goods_id = tbg2.id
          AND tbos.STATUS = 5
          AND tbup.state = 1
          AND ( tbs2.subject_type & 1 = 1 )
          AND tbos.is_delete = 0
          AND tbup.user_id = 1
          AND DATE_FORMAT( tbos.deliver_time, "%Y-%m-%d" ) <= '2019-10-31'
    ) tmp
        LEFT JOIN (
        SELECT
            tbisd.goods_id,
            tbis.project_id,
            tbup.user_id,
            tbisd.receive_num,
            tbisd.cost_price
        FROM
            tb_bill_in_store tbis,
            tb_bill_in_store_dtl tbisd,
            tb_base_user_project tbup,
            tb_base_project tbp
        WHERE 1 = 1
          AND tbis.id = tbisd.bill_in_store_id
          AND tbis.project_id = tbup.project_id
          AND tbp.id = tbup.project_id
          AND tbis.is_delete = 0
          AND tbis.STATUS = 2
          AND tbup.state = 1
          AND DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) < '2019-10-01'
    ) initial_in ON ( initial_in.goods_id = tmp.goodsId AND initial_in.project_id = tmp.projectId AND initial_in.user_id = tmp.userId )
        LEFT JOIN (
        SELECT
            tbisd.goods_id,
            tbis.project_id,
            tbup.user_id,
            tbisd.receive_num,
            tbisd.cost_price
        FROM
            tb_bill_in_store tbis,
            tb_bill_in_store_dtl tbisd,
            tb_base_user_project tbup,
            tb_base_project tbp
        WHERE 1 = 1
          and tbis.id = tbisd.bill_in_store_id
          and tbis.project_id = tbup.project_id
          and tbp.id = tbup.project_id
          and tbis.is_delete = 0
          and tbis.STATUS = 2
          and tbup.state = 1
          and DATE_FORMAT( tbis.receive_date, "%Y-%m-%d" ) <= '2019-10-31'
    ) end_in ON ( end_in.goods_id = tmp.goodsId AND end_in.project_id = tmp.projectId AND end_in.user_id = tmp.userId )
        left join (
        select
             tbosd.goods_id,
             tbos.project_id,
             tbup.user_id,
             tbosd.send_num,
             tbosd.cost_amount
        from tb_bill_out_store tbos,
             tb_bill_out_store_dtl tbosd,
             tb_base_user_project tbup,
             tb_base_project tbp
        where 1 = 1
          and tbos.id = tbosd.bill_out_store_id
          and tbos.project_id = tbup.project_id
          and tbp.id = tbup.project_id
          and tbos.is_delete = 0
          and tbos.status = 5
          and tbup.state = 1
          and tbos.send_date < '2019-10-01'
    ) initial_out on ( initial_out.goods_id = tmp.goodsId AND initial_out.project_id = tmp.projectId AND initial_out.user_id = tmp.userId )
    left join (
        select
            tbosd.goods_id,
            tbos.project_id,
            tbup.user_id,
            tbosd.send_num,
            tbosd.cost_amount
        from tb_bill_out_store tbos,
             tb_bill_out_store_dtl tbosd,
             tb_base_user_project tbup,
             tb_base_project tbp
        where 1 = 1
          and tbos.id = tbosd.bill_out_store_id
          and tbos.project_id = tbup.project_id
          and tbp.id = tbup.project_id
          and tbos.is_delete = 0
          and tbos.status = 5
          and tbup.state = 1
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
        ) end_out on ( end_out.goods_id = tmp.goodsId and end_out.project_id = tmp.projectId and end_out.user_id = tmp.userId )
    left join (
        select
             tbisd.goods_id,
             tbis.project_id,
             tbup.user_id,
             tbisd.receive_num,
             tbisd.cost_price
        from tb_bill_in_store tbis,
             tb_bill_in_store_dtl tbisd,
             tb_base_user_project tbup,
             tb_base_project tbp
        where 1 = 1
          and tbis.id = tbisd.bill_in_store_id
          and tbis.project_id = tbup.project_id
          and tbp.id = tbup.project_id
          and tbis.is_delete = 0
          and tbis.status = 2
          and tbup.state = 1
          and (tbis.bill_type = 1 or tbis.bill_type = 3)
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
        ) current_in on ( current_in.goods_id = tmp.goodsId and current_in.project_id = tmp.projectId and current_in.user_id = tmp.userId )
        left join (
        select
            tbisd.goods_id,
            tbis.project_id,
            tbup.user_id,
            tbisd.receive_num,
            tbisd.cost_price
        from tb_bill_in_store tbis,
             tb_bill_in_store_dtl tbisd,
             tb_base_user_project tbup,
             tb_base_project tbp
        where 1 = 1
          and tbis.id = tbisd.bill_in_store_id
          and tbis.project_id = tbup.project_id
          and tbp.id = tbup.project_id
          and tbis.is_delete = 0
          and tbis.status = 2
          and tbup.state = 1
          and (tbis.bill_type = 2 or tbis.bill_type = 4 or tbis.bill_type = 5)
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
        ) current_other_in on ( current_other_in.goods_id = tmp.goodsId and current_other_in.project_id = tmp.projectId and current_other_in.user_id = tmp.userId )
        left join (
        select
            tbosd.goods_id,
            tbos.project_id,
            tbup.user_id,
            tbosd.send_num,
            tbosd.cost_amount
        from tb_bill_out_store tbos,
             tb_bill_out_store_dtl tbosd,
             tb_base_user_project tbup,
             tb_base_project tbp
        where 1 = 1
          and tbos.id = tbosd.bill_out_store_id
          and tbos.project_id = tbup.project_id
          and tbp.id = tbup.project_id
          and tbos.is_delete = 0
          and tbos.status = 5
          and tbup.state = 1
          and (tbos.bill_type = 1 or bill_type = 5)
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
        ) current_out on ( current_out.goods_id = tmp.goodsId and current_out.project_id = tmp.projectId and current_out.user_id = tmp.userId )
    left join (
        select
            tbosd.goods_id,
            tbos.project_id,
            tbup.user_id,
            tbosd.send_num,
            tbosd.cost_amount
        from tb_bill_out_store tbos,
             tb_bill_out_store_dtl tbosd,
             tb_base_goods tbg,
             tb_base_user_project tbup,
             tb_base_project tbp
        where 1 = 1
          and tbos.id = tbosd.bill_out_store_id
          and tbosd.goods_id = tbg.id
          and tbos.project_id = tbup.project_id
          and tbp.id = tbup.project_id
          and tbos.is_delete = 0
          and tbos.status = 5
          and tbup.state = 1
          and (tbos.bill_type = 2 or tbos.bill_type = 3 or tbos.bill_type = 4 or tbos.bill_type = 6 or
               tbos.bill_type = 7 or tbos.bill_type = 8)
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
        ) current_other_out on ( current_other_out.goods_id = tmp.goodsId and current_other_out.project_id = tmp.projectId and current_other_out.user_id = tmp.userId )
        left join (
        select
            tbosd.goods_id,
            tbos.project_id,
            tbup.user_id,
            tbosd.send_num,
            tbosd.send_price
        from tb_bill_out_store tbos,
             tb_bill_out_store_dtl tbosd,
             tb_base_user_project tbup,
             tb_base_project tbp
        where 1 = 1
          and tbos.id = tbosd.bill_out_store_id
          and tbos.project_id = tbup.project_id
          and tbp.id = tbup.project_id
          and tbos.is_delete = 0
          and tbos.status = 5
          and tbos.bill_type = 1
          and tbup.state = 1
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
        ) sale on ( sale.goods_id = tmp.goodsId and sale.project_id = tmp.projectId and sale.user_id = tmp.userId )
where
        1 = 1
group by
    tmp.goodsId,
    tmp.busiUnitId,
    tmp.projectId
