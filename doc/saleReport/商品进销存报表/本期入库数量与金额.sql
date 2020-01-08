select
        temp3.projectId,
        temp3.busiUnitId,
        temp3.projectName,
        temp3.businessName,
        goodsId,
        brand,
        goodName,
        goodsType,
        specification,
        number,
        taxRate,
        barCode,
        sum(temp3.current_normal_in_num) current_normal_in_num,
        sum(temp3.current_normal_in_amount) current_normal_in_amount,
        sum(temp3.current_other_in_num) current_other_in_num,
        sum(temp3.current_other_in_amount) current_other_in_amount,
        (sum(temp3.current_normal_in_num) + sum(temp3.current_other_in_num)) current_in_num,
        (sum(temp3.current_normal_in_amount) + sum(temp3.current_other_in_amount)) current_in_amount
from
(select projectId,
       busiUnitId,
       concat(projectNo, '-', abbreviationProjectName) projectName,
       concat(subjectNo, '-', abbreviation)            businessName,
        goodsId,
        brand,
        goodName,
        goodsType,
        specification,
        number,
        taxRate,
        barCode,
       IFNULL(SUM(temp1.receive_num), 0)               current_normal_in_num,
       IFNULL(SUM(temp1.receive_amount), 0)            current_normal_in_amount,
       0 current_other_in_num,
       0 current_other_in_amount
from (select tbis.project_id                           projectId,
             tbp.project_no                            projectNo,
             tbp.project_name                          abbreviationProjectName,
             tbs.subject_no                            subjectNo,
             tbs.abbreviation                          abbreviation,
             tbp.business_unit_id                      busiUnitId,
             tbisd.goods_id                            goodsId,
             tbg.brand                                 brand,
             tbg.name                                  goodName,
             tbg.goods_type                            goodsType,
             tbisd.receive_num,
             (tbisd.receive_num * tbisd.receive_price) receive_amount,
             tbg.specification                         specification,
             tbg.number                                number,
             tbg.tax_rate                              taxRate,
             tbg.bar_code                              barCode
      from tb_bill_in_store tbis
               inner join tb_bill_in_store_dtl tbisd on tbis.id = tbisd.bill_in_store_id
               inner join tb_base_goods tbg on tbisd.goods_id = tbg.id
               inner join tb_base_user_project bup on tbis.project_id = bup.project_id
               inner join tb_base_project tbp on tbp.id = bup.project_id
               inner join tb_base_subject tbs ON tbp.business_unit_id = tbs.id
      where 1 = 1
        and tbis.is_delete = 0
        AND bup.user_id = 1
        AND bup.state = 1
        AND (tbs.subject_type & 1 = 1)
        and (tbis.bill_type = 1 or tbis.bill_type = 3)
        AND tbis.receive_date >= '2019-12-01 00:00:00'
        AND tbis.receive_date <= '2019-12-12 00:00:00'
        AND tbis.status = 2
    ) temp1 group by projectId,busiUnitId,goodsId
union
select
    projectId,
    busiUnitId,
    concat(projectNo, '-', abbreviationProjectName) projectName,
    concat(subjectNo, '-', abbreviation)            businessName,
    goodsId,
    brand,
    goodName,
    goodsType,
    specification,
    number,
    taxRate,
    barCode,
    0 current_normal_in_num,
    0 current_normal_in_amount,
    IFNULL(SUM(temp2.receive_num), 0)               current_other_in_num,
    IFNULL(SUM(temp2.receive_amount), 0)            current_other_in_amount
from (select
          tbis.project_id                           projectId,
          tbp.project_no                            projectNo,
          tbp.project_name                          abbreviationProjectName,
          tbs.subject_no                            subjectNo,
          tbs.abbreviation                          abbreviation,
          tbp.business_unit_id                      busiUnitId,
          tbisd.goods_id                            goodsId,
          tbg.brand                                 brand,
          tbg.name                                  goodName,
          tbg.goods_type                            goodsType,
          tbisd.receive_num receive_num,
          (tbisd.receive_num * tbisd.receive_price) receive_amount,
          tbg.specification                         specification,
          tbg.number                                number,
          tbg.tax_rate                              taxRate,
          tbg.bar_code                              barCode
    from tb_bill_in_store tbis
    inner join tb_bill_in_store_dtl tbisd on tbis.id = tbisd.bill_in_store_id
    inner join tb_base_goods tbg on tbisd.goods_id = tbg.id
    inner join tb_base_user_project bup on tbis.project_id = bup.project_id
    inner join tb_base_project tbp on tbp.id = bup.project_id
    inner join tb_base_subject tbs ON tbp.business_unit_id = tbs.id
    where 1 = 1
    and tbis.is_delete = 0
    AND bup.user_id = 1
    AND bup.state = 1
    AND (tbs.subject_type & 1 = 1)
    and (tbis.bill_type = 2 or tbis.bill_type = 4 or tbis.bill_type = 5)
    AND tbis.receive_date >= '2019-12-01 00:00:00'
    AND tbis.receive_date <= '2019-12-12 00:00:00'
    AND tbis.status = 2
    ) temp2 group by projectId,busiUnitId,goodsId
) temp3 group by projectId,busiUnitId,goodsId

