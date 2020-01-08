select temp3.projectId,
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
       sum(temp3.initial_in_num)                                      initial_in_num,
       sum(temp3.initial_in_amount)                                   initial_in_amount,
       sum(temp3.initial_out_num)                                     initial_out_num,
       sum(temp3.initial_out_amount)                                  initial_out_amount,
       (sum(temp3.initial_in_num) - sum(temp3.initial_out_num))       initial_num,
       (sum(temp3.initial_in_amount) - sum(temp3.initial_out_amount)) initial_amount
from (SELECT projectId,
             busiUnitId,
             concat(projectNo, '-', abbreviationProjectName) projectName,
             concat(subjectNo, '-', abbreviation)            businessName,
             IFNULL(SUM(temp.receive_num), 0)                initial_in_num,
             IFNULL(SUM(temp.receive_amount), 0)             initial_in_amount,
             0                                               initial_out_num,
             0                                               initial_out_amount,
             goodsId,
             brand,
             goodName,
             goodsType,
             specification,
             number,
             taxRate,
             barCode
      FROM (
               SELECT tbis.project_id                           projectId,
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
               FROM tb_bill_in_store tbis
                        INNER JOIN tb_bill_in_store_dtl tbisd ON tbis.id = tbisd.bill_in_store_id
                        INNER JOIN tb_base_goods tbg ON tbisd.goods_id = tbg.id
                        INNER JOIN tb_base_user_project bup ON tbis.project_id = bup.project_id
                        INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
                        INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
               WHERE 1 = 1
                 AND tbis.is_delete = 0
                 AND bup.user_id = 1
                 AND bup.state = 1
                 AND (tbs.subject_type & 1 = 1)
                 AND tbis.receive_date <= '2019-12-01 00:00:00'
                 AND tbis.STATUS = 2
           ) temp group by projectId, busiUnitId, goodsId
      union
      SELECT projectId,
             busiUnitId,
             concat(projectNo, '-', abbreviationProjectName) projectName,
             concat(subjectNo, '-', abbreviation)            businessName,
             0                                               initial_in_num,
             0                                               initial_in_amount,
             IFNULL(SUM(temp2.send_num), 0)                  initial_out_num,
             IFNULL(SUM(temp2.send_amount), 0)               initial_out_amount,
             goodsId,
             brand,
             goodName,
             goodsType,
             specification,
             number,
             taxRate,
             barCode
      FROM (
               SELECT tbos.project_id      projectId,
                      tbp.project_no       projectNo,
                      tbp.project_name     abbreviationProjectName,
                      tbs.subject_no       subjectNo,
                      tbs.abbreviation     abbreviation,
                      tbp.business_unit_id busiUnitId,
                      tbosd.send_num,
                      tbosd.cost_amount send_amount,
                      tbosd.goods_id       goodsId,
                      tbg.brand            brand,
                      tbg.name             goodName,
                      tbg.goods_type       goodsType,
                      tbg.specification    specification,
                      tbg.number           number,
                      tbg.tax_rate         taxRate,
                      tbg.bar_code         barCode
               FROM tb_bill_out_store tbos
                        INNER JOIN tb_bill_out_store_dtl tbosd ON tbos.id = tbosd.bill_out_store_id
                        INNER JOIN tb_bill_delivery tbd ON tbd.id = tbos.bill_delivery_id
                        INNER JOIN tb_base_goods tbg ON tbosd.goods_id = tbg.id
                        INNER JOIN tb_base_user_project bup ON tbos.project_id = bup.project_id
                        INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
                        INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
               WHERE 1 = 1
                 AND tbos.is_delete = 0
                 AND bup.user_id = 1
                 AND bup.state = 1
                 AND (tbs.subject_type & 1 = 1)
                 AND tbos.send_date <= '2019-12-01 00:00:00'
                 AND tbos.STATUS = 5
           ) temp2
      GROUP BY projectId, busiUnitId, goodsId
     ) temp3
group by projectId, busiUnitId, goodsId
