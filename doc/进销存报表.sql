-- 商品进销存报表
select
    userId,
    projectId,
    goodsId,
    busiUnitId,
    concat(projectNo, '-' , abbreviationProjectName) projectName,
    concat(subjectNo, '-' , abbreviation) businessName,
    brand,
    goodName,
    goodsType,
    specification,
    number,
    barCode,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num, 0)),0) initial_in_num
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") < '2019-10-01'
    ) initial_in_num,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)),0) initial_in_amount
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") < '2019-10-01'
    ) initial_in_amount,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num, 0)),0) end_in_num
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) end_in_num,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)),0) end_in_amount
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) end_in_amount,
    (
        select
            ifnull(sum(IFNULL(tbosd.send_num, 0)),0) initial_out_num
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbos.send_date < '2019-10-01'
    ) initial_out_num,
    (
        select
            ifnull(sum(IFNULL((tbosd.cost_amount), 0)),0) initial_out_amount
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbos.send_date < '2019-10-01'
    ) initial_out_amount,
    (
        select
            ifnull(sum(IFNULL(tbosd.send_num, 0)),0) end_out_num
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) end_out_num,
    (
        select
            ifnull(sum(IFNULL((tbosd.cost_amount), 0)),0) end_out_amount
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) end_out_amount,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num, 0)),0) current_in_num
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_in_num,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)),0) current_in_amount
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_in_amount,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num, 0)),0) current_other_in_num
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_other_in_num,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)),0) current_other_in_amount
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_other_in_amount,
    (
        select
            ifnull(sum(IFNULL(( tbosd.send_num), 0)),0) current_out_num
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_out_num,
    (
        select
            ifnull(sum(IFNULL(( tbosd.cost_amount), 0)),0) current_out_amount
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_out_amount,
    (
        select
            ifnull(sum(IFNULL(( tbosd.send_num), 0)),0) current_other_out_num
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_other_out_num,
    (
        select
            ifnull(sum(IFNULL(( tbosd.cost_amount), 0)),0) current_other_out_amount
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_other_out_amount,
    (
        select
            ifnull(sum(IFNULL(tbosd.send_num, 0)),0) as sale_num
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    )sale_num,
    (
        select
            ifnull(sum(IFNULL(tbosd.send_num * tbosd.send_price, 0)),0) as sale_amount
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) sale_amount
from (
         select
             tbup.user_id userId,
             tbis.project_id projectId,
             tbp.project_no projectNo,
             tbp.project_name abbreviationProjectName,
             tbs.subject_no subjectNo,
             tbs.abbreviation abbreviation,
             tbisd.goods_id goodsId,
             tbg.brand brand,
             tbg.name goodName,
             tbg.goods_type goodsType,
             tbg.specification specification,
             tbg.number number,
             tbg.bar_code barCode,
             tbp.business_unit_id busiUnitId
         from tb_bill_in_store_dtl tbisd,
              tb_bill_in_store tbis,
              tb_base_project tbp,
              tb_base_subject tbs ,
              tb_base_user_project tbup,
              tb_base_goods tbg
         where 1 = 1
           and tbisd.bill_in_store_id = tbis.id
           and tbis.project_id = tbp.id
           and tbp.id = tbup.project_id
           and tbp.business_unit_id = tbs.id
           and tbisd.goods_id = tbg.id
           and DATE_FORMAT(tbis.accept_time, "%Y-%m-%d") <= '2019-10-31'
           and tbis.status = 2
           and tbis.is_delete = 0
           and tbup.user_id = 1
           and tbup.state = 1
           and (tbs.subject_type & 1 = 1)
         union
         select
             tbup.user_id user_id,
             tbos.project_id projectId,
             tbp.project_no projectNo,
             tbp.project_name abbreviationProjectName,
             tbs2.subject_no subjectNo,
             tbs2.abbreviation abbreviation,
             tbosd.goods_id as goodsId,
             tbg2.brand brand,
             tbg2.name goodName,
             tbg2.goods_type goodType,
             tbg2.specification specification,
             tbg2.number number,
             tbg2.bar_code barCode,
             tbp.business_unit_id busiUnitId

         from tb_bill_out_store tbos,
              tb_bill_out_store_dtl tbosd,
              tb_base_project tbp,
              tb_base_subject tbs2 ,
              tb_base_user_project tbup,
              tb_base_goods tbg2
         where 1 = 1
           and tbos.id = tbosd.bill_out_store_id
           and tbos.project_id = tbp.id
           and tbp.id = tbup.project_id
           and tbp.business_unit_id = tbs2.id
           and tbosd.goods_id = tbg2.id
           and DATE_FORMAT(tbos.deliver_time, "%Y-%m-%d") <= '2019-10-31'
           and tbos.status = 5
           and tbos.is_delete = 0
           and tbup.user_id = 1
           and tbup.state = 1
           and (tbs2.subject_type & 1 = 1)
     )tmp
where 1 = 1
group by tmp.goodsId, tmp.busiUnitId, tmp.projectId;

-- 去除期初等金额都为0的记录
select
    userId,
    projectId,
    goodsId,
    busiUnitId,
    projectName,
    businessName,
    -- brand,
    -- goodName,
    -- goodsType,
    -- specification,
    -- number,
    -- barCode,
    initialNum,
    initialAmount,
    -- round(initialAmount/(1+taxRate),2) initialTaxRateAmount,
    endNum,
    endAmount,
    -- round(endAmount/(1+taxRate),2) endTaxRateAmount,
    currentInNum,
    currentInAmount,
    -- round(currentInAmount/(1+taxRate),2) currentInTaxRateAmount,
    currentOtherInNum,
    currentOtherInAmount,
    currentOutNum,
    currentOutAmount,
    -- round(currentOutAmount/(1+taxRate),2)currentOutTaxRateAmount,
    currentOtherOutNum,
    currentOtherOutAmount,
    saleNum,
    saleAmount
 from
    (select
       userId,
       projectId,
       goodsId,
       busiUnitId,
       projectName,
       businessName,
       -- brand,
       -- goodName,
       -- goodsType,
       -- specification,
       -- number,
       -- taxRate,
       -- barCode,
       sum(initial_in_num - initial_out_num) initialNum,
       sum(initial_in_amount - initial_out_amount) initialAmount,
       sum(end_in_num - end_out_num) endNum,
       sum(end_in_amount - end_out_amount) endAmount,
       current_in_num currentInNum,
       current_in_amount currentInAmount,
       current_other_in_num currentOtherInNum,
       current_other_in_amount currentOtherInAmount,
       current_out_num currentOutNum,
       current_out_amount currentOutAmount,
       current_other_out_num currentOtherOutNum,
       current_other_out_amount currentOtherOutAmount,
       sale_num saleNum,
       sale_amount saleAmount
 from
    (select
    userId,
    projectId,
    goodsId,
    busiUnitId,
    concat(projectNo, '-' , abbreviationProjectName) projectName,
    concat(subjectNo, '-' , abbreviation) businessName,
    -- brand,
    -- goodName,
    -- goodsType,
    -- specification,
    -- number,
    -- taxRate,
    -- barCode,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num, 0)),0) initial_in_num
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") < '2019-10-01'
    ) initial_in_num,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)),0) initial_in_amount
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") < '2019-10-01'
    ) initial_in_amount,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num, 0)),0) end_in_num
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) end_in_num,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)),0) end_in_amount
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) end_in_amount,
    (
        select
            ifnull(sum(IFNULL(tbosd.send_num, 0)),0) initial_out_num
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbos.send_date < '2019-10-01'
    ) initial_out_num,
    (
        select
            ifnull(sum(IFNULL((tbosd.cost_amount), 0)),0) initial_out_amount
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbos.send_date < '2019-10-01'
    ) initial_out_amount,
    (
        select
            ifnull(sum(IFNULL(tbosd.send_num, 0)),0) end_out_num
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) end_out_num,
    (
        select
            ifnull(sum(IFNULL((tbosd.cost_amount), 0)),0) end_out_amount
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) end_out_amount,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num, 0)),0) current_in_num
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_in_num,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)),0) current_in_amount
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_in_amount,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num, 0)),0) current_other_in_num
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_other_in_num,
    (
        select
            ifnull(sum(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)),0) current_other_in_amount
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
          and tbisd.goods_id = tmp.goodsId
          and tbis.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_other_in_amount,
    (
        select
            ifnull(sum(IFNULL(( tbosd.send_num), 0)),0) current_out_num
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_out_num,
    (
        select
            ifnull(sum(IFNULL(( tbosd.cost_amount), 0)),0) current_out_amount
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_out_amount,
    (
        select
            ifnull(sum(IFNULL(( tbosd.send_num), 0)),0) current_other_out_num
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_other_out_num,
    (
        select
            ifnull(sum(IFNULL(( tbosd.cost_amount), 0)),0) current_other_out_amount
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) current_other_out_amount,
    (
        select
            ifnull(sum(IFNULL(tbosd.send_num, 0)),0) as sale_num
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    )sale_num,
    (
        select
            ifnull(sum(IFNULL(tbosd.send_num * tbosd.send_price, 0)),0) as sale_amount
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
          and tbosd.goods_id = tmp.goodsId
          and tbos.project_id = tmp.projectId
          and tbup.user_id = tmp.userId
          and tbup.state = 1
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
          and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
    ) sale_amount
from (
         select
             tbup.user_id userId,
             tbis.project_id projectId,
             tbp.project_no projectNo,
             tbp.project_name abbreviationProjectName,
             tbs.subject_no subjectNo,
             tbs.abbreviation abbreviation,
             tbisd.goods_id goodsId,
             -- tbg.brand brand,
             -- tbg.name goodName,
             -- tbg.goods_type goodsType,
             -- tbg.specification specification,
             -- tbg.number number,
             -- tbg.tax_rate taxRate,
             -- tbg.bar_code barCode,
             tbp.business_unit_id busiUnitId
         from tb_bill_in_store_dtl tbisd,
              tb_bill_in_store tbis,
              tb_base_project tbp,
              tb_base_subject tbs ,
              tb_base_user_project tbup
              -- tb_base_goods tbg
         where 1 = 1
           and tbisd.bill_in_store_id = tbis.id
           and tbis.project_id = tbp.id
           and tbp.id = tbup.project_id
           and tbp.business_unit_id = tbs.id
           -- and tbisd.goods_id = tbg.id
           and (tbs.subject_type & 1 = 1)
           and tbis.status = 2
           and tbis.is_delete = 0
           and tbup.state = 1
           and tbup.user_id = 1
           and tbp.id = 3
           and DATE_FORMAT(tbis.accept_time, "%Y-%m-%d") <= '2019-10-31'
         union
         select
             tbup.user_id user_id,
             tbos.project_id projectId,
             tbp.project_no projectNo,
             tbp.project_name abbreviationProjectName,
             tbs2.subject_no subjectNo,
             tbs2.abbreviation abbreviation,
             tbosd.goods_id as goodsId,
             -- tbg2.brand brand,
             -- tbg2.name goodName,
             -- tbg2.goods_type goodType,
             -- tbg2.specification specification,
             -- tbg2.number number,
             -- tbg2.tax_rate taxRate,
             -- tbg2.bar_code barCode,
             tbp.business_unit_id busiUnitId
         from tb_bill_out_store tbos,
              tb_bill_out_store_dtl tbosd,
              tb_base_project tbp,
              tb_base_subject tbs2 ,
              tb_base_user_project tbup
              -- tb_base_goods tbg2
         where 1 = 1
           and tbos.id = tbosd.bill_out_store_id
           and tbos.project_id = tbp.id
           and tbp.id = tbup.project_id
           and tbp.business_unit_id = tbs2.id
           -- and tbosd.goods_id = tbg2.id
           and tbos.status = 5
           and tbup.state = 1
           and (tbs2.subject_type & 1 = 1)
           and tbos.is_delete = 0
           and tbup.user_id = 1
           and tbp.id =3
           and DATE_FORMAT(tbos.deliver_time, "%Y-%m-%d") <= '2019-10-31'
     )tmp
where 1 = 1
group by tmp.goodsId, tmp.busiUnitId, tmp.projectId
) as v_table group by v_table.goodsId, v_table.busiUnitId, v_table.projectId
)as v_table1
where 1 = 1
and (initialNum > 0
or initialAmount > 0
or endNum > 0
or endAmount > 0
or currentInNum > 0
or currentInAmount > 0
or currentOtherInNum > 0
or currentOtherInAmount > 0
or currentOutNum > 0
or currentOutAmount > 0
or currentOtherOutNum > 0
or currentOtherOutAmount > 0
or saleNum > 0
or saleAmount > 0);


-- 更改
SELECT DISTINCT
    tbos.bill_no,
    tbos.bill_type bill_out_type,
    '-' bill_in_type,
    tbp.project_name,
    tbos.required_send_date receive_send_date,
    tbos.`STATUS` status,
    '已发货' status_name,
    tbos.deliverer deliverer_acceptor ,
    tbos.deliver_time deliver_accept_time ,
    tbos.creator,
    tbos.create_at,
    tbg.number,
    tbg.bar_code,
    tbg.specification,
    tbosd.send_num receive_send_num,
    tbosd.pickup_num pickup_tally_num,
    tbosd.send_price receive_send_price,
    tbos.send_amount receive_send_amount,
    tbosd.po_amount,
    tbosd.cost_amount
FROM
    tb_bill_out_store tbos,
    tb_bill_out_store_dtl tbosd,
    tb_base_project tbp,
    tb_base_goods tbg
WHERE
        1 = 1
  AND tbos.id = tbosd.bill_out_store_id
  AND tbos.project_id = tbp.id
  AND tbosd.goods_id = tbg.id
  and tbos.`STATUS` = 5
  AND goods_id = 682
union
select DISTINCT
    tbis.bill_no,
    tbis.bill_type bill_in_type,
    '-' bill_out_type,
    tbp.project_name,
    tbis.receive_date receive_send_date,
    tbis.status status,
    '已收货' status_name,
    tbis.acceptor deliverer_acceptor,
    tbis.accept_time deliver_accept_time,
    tbis.creator,
    tbis.create_at,
    tbg.number,
    tbg.bar_code,
    tbg.specification,
    tbisd.receive_num receive_send_num,
    tbisd.tally_num pickup_tally_num,
    tbisd.receive_price receive_send_price,
    tbis.receive_amount receive_send_amount,
    tbisd.receive_num * tbisd.receive_price po_amount,
    tbisd.receive_num * tbisd.cost_price cost_amount
from
     tb_bill_in_store tbis,
     tb_bill_in_store_dtl tbisd,
     tb_base_project tbp,
     tb_base_goods tbg
where 1 = 1
    and tbis.id = tbisd.bill_in_store_id
    and tbis.project_id = tbp.id
    and tbisd.goods_id = tbg.id
    and tbis.status = 2
    and tbisd.goods_id = 682





