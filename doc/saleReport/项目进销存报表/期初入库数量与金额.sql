select temp3.projectId,
       temp3.busiUnitId,
       temp3.projectName,
       temp3.businessName,
       sum(temp3.initial_in_num) initial_in_num,
       sum(temp3.initial_in_amount) initial_in_amount,
       sum(temp3.initial_end_num) initial_end_num,
       sum(temp3.initial_end_amount) initial_end_amount,
       (sum(temp3.initial_in_num) - sum(temp3.initial_end_num))       initial_num,
       (sum(temp3.initial_in_amount) - sum(temp3.initial_end_amount)) initial_amount
from (SELECT projectId,
             busiUnitId,
             concat(projectNo, '-', abbreviationProjectName) projectName,
             concat(subjectNo, '-', abbreviation)            businessName,
             IFNULL(SUM(temp.receive_num), 0)                initial_in_num,
             IFNULL(SUM(temp.receive_amount), 0)             initial_in_amount,
             0 initial_end_num,
             0 initial_end_amount
      FROM (
               SELECT DISTINCT tbis.id,
                               tbis.receive_num,
                               tbis.receive_amount,
                               tbis.project_id      projectId,
                               tbp.project_no       projectNo,
                               tbp.project_name     abbreviationProjectName,
                               tbs.subject_no       subjectNo,
                               tbs.abbreviation     abbreviation,
                               tbp.business_unit_id busiUnitId
               FROM tb_bill_in_store tbis
                        LEFT JOIN tb_bill_in_store_dtl tbisd ON tbis.id = tbisd.bill_in_store_id
                        LEFT JOIN tb_purchase_order_title tpot ON tbisd.po_id = tpot.id
                        LEFT JOIN tb_base_goods tbg ON tbisd.goods_id = tbg.id
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
           ) temp
      group by projectId
     union
     SELECT projectId,
             busiUnitId,
             concat(projectNo, '-', abbreviationProjectName) projectName,
             concat(subjectNo, '-', abbreviation)            businessName,
             0 initial_in_num,
             0 initial_in_amount,
             IFNULL(SUM(temp2.send_num), 0)                  initial_end_num,
             IFNULL(SUM(temp2.cost_amount), 0)               initial_end_amount
      FROM (
               SELECT DISTINCT tbos.id,
                               tbos.project_id      projectId,
                               tbp.project_no       projectNo,
                               tbp.project_name     abbreviationProjectName,
                               tbs.subject_no       subjectNo,
                               tbs.abbreviation     abbreviation,
                               tbp.business_unit_id busiUnitId,
                               tbos.send_num,
                               tbos.cost_amount
               FROM tb_bill_out_store tbos
                        LEFT JOIN tb_bill_out_store_dtl tbosd ON tbos.id = tbosd.bill_out_store_id
                        LEFT JOIN tb_bill_delivery tbd ON tbd.id = tbos.bill_delivery_id
                        LEFT JOIN tb_base_goods tbg ON tbosd.goods_id = tbg.id
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
      GROUP BY projectId
    ) temp3 group by projectId,busiUnitId
