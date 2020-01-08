-- 期初数量与金额
select v1.projectId,
       v1.busiUnitId,
       v1.projectName,
       v1.businessName,
       v1.initial_in_num,
       v1.initial_in_amount,
       v2.initial_end_num,
       v2.initial_end_amount,
       (v1.initial_in_num - v2.initial_end_num)       initial_num,
       (v1.initial_in_amount - v2.initial_end_amount) initial_amount
from (SELECT projectId,
             busiUnitId,
             concat(projectNo, '-', abbreviationProjectName) projectName,
             concat(subjectNo, '-', abbreviation)            businessName,
             IFNULL(SUM(temp.receive_num), 0)                initial_in_num,
             IFNULL(SUM(temp.receive_amount), 0)             initial_in_amount
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
     ) v1,
     (SELECT projectId,
             busiUnitId,
             concat(projectNo, '-', abbreviationProjectName) projectName,
             concat(subjectNo, '-', abbreviation)            businessName,
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
      GROUP BY projectId) v2
where v1.projectId = v2.projectId
  and v1.busiUnitId = v2.busiUnitId;

-- 本期入库数量与金额
select v1.projectId,
       v1.busiUnitId,
       v1.projectName,
       v1.businessName,
       v1.current_in_num,
       v1.current_in_amount,
       v2.current_other_in_num,
       v2.current_other_in_amount,
       (v1.current_in_num + v2.current_other_in_num)          current_in_num,
       (v1.v1.current_in_amount + v2.current_other_in_amount) current_in_amount
from (
         select projectId,
                busiUnitId,
                concat(projectNo, '-', abbreviationProjectName) projectName,
                concat(subjectNo, '-', abbreviation)            businessName,
                IFNULL(SUM(temp1.receive_num), 0)               current_in_num,
                IFNULL(SUM(temp1.receive_amount), 0)            current_in_amount,
                0               current_other_in_num,
                0            current_other_in_amount
         from (select DISTINCT tbis.id,
                               tbis.receive_num,
                               tbis.receive_amount,
                               tbis.project_id      projectId,
                               tbp.project_no       projectNo,
                               tbp.project_name     abbreviationProjectName,
                               tbs.subject_no       subjectNo,
                               tbs.abbreviation     abbreviation,
                               tbp.business_unit_id busiUnitId
               from tb_bill_in_store tbis
                        left join tb_bill_in_store_dtl tbisd on tbis.id = tbisd.bill_in_store_id
                        left join tb_purchase_order_title tpot on tbisd.po_id = tpot.id
                        left join tb_base_goods tbg on tbisd.goods_id = tbg.id
                        inner join tb_base_user_project bup on tbis.project_id = bup.project_id
                        inner join tb_base_project tbp on tbp.id = bup.project_id
                        INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
               where 1 = 1
                 and tbis.is_delete = 0
                 AND bup.user_id = 1
                 AND bup.state = 1
                 AND (tbs.subject_type & 1 = 1)
                 and (tbis.bill_type = 1 or tbis.bill_type = 3)
                 AND tbis.receive_date >= '2019-12-01 00:00:00'
                 AND tbis.receive_date <= '2019-12-12 00:00:00'
                 AND tbis.status = 2) temp1
         group by projectId
     ) v1
        union
     (
         select projectId,
                busiUnitId,
                concat(projectNo, '-', abbreviationProjectName) projectName,
                concat(subjectNo, '-', abbreviation)            businessName,
                0               current_in_num,
                0            current_in_amount,
                IFNULL(SUM(temp2.receive_num), 0)               current_other_in_num,
                IFNULL(SUM(temp2.receive_amount), 0)            current_other_in_amount
         from (select DISTINCT tbis.id,
                               tbis.receive_num,
                               tbis.receive_amount,
                               tbis.project_id      projectId,
                               tbp.project_no       projectNo,
                               tbp.project_name     abbreviationProjectName,
                               tbs.subject_no       subjectNo,
                               tbs.abbreviation     abbreviation,
                               tbp.business_unit_id busiUnitId
               from tb_bill_in_store tbis
                        left join tb_bill_in_store_dtl tbisd on tbis.id = tbisd.bill_in_store_id
                        left join tb_purchase_order_title tpot on tbisd.po_id = tpot.id
                        left join tb_base_goods tbg on tbisd.goods_id = tbg.id
                        inner join tb_base_user_project bup on tbis.project_id = bup.project_id
                        inner join tb_base_project tbp on tbp.id = bup.project_id
                        INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
               where 1 = 1
                 and tbis.is_delete = 0
                 AND bup.user_id = 1
                 AND bup.state = 1
                 AND (tbs.subject_type & 1 = 1)
                 and (tbis.bill_type = 2 or tbis.bill_type = 4 or tbis.bill_type = 5)
                 AND tbis.receive_date >= '2019-12-01 00:00:00'
                 AND tbis.receive_date <= '2019-12-12 00:00:00'
                 AND tbis.status = 2) temp2
         group by projectId
     ) v2
where 1 = 1
  and v1.projectId = v2.projectId
  and v1.busiUnitId = v2.busiUnitId


-- 本期出库数量与金额
select
    v1.projectId,
    v1.busiUnitId,
    v1.projectName,
    v1.businessName,
    v1.current_out_num,
    v1.current_out_amount,
    v2.current_other_out_num,
    v2.current_other_amount,
    (v1.current_out_num + v2.current_other_out_num ) current_num,
    (v1.current_out_amount + v2.current_other_amount) current_amount
from (select projectId,
             busiUnitId,
             concat(projectNo, '-', abbreviationProjectName) projectName,
             concat(subjectNo, '-', abbreviation)            businessName,
             IFNULL(SUM(temp1.send_num), 0)                  current_out_num,
             IFNULL(SUM(temp1.cost_amount), 0)               current_out_amount
      from (SELECT DISTINCT tbos.id,
                            tbos.project_id      projectId,
                            tbp.project_no       projectNo,
                            tbp.project_name     abbreviationProjectName,
                            tbs.subject_no       subjectNo,
                            tbs.abbreviation     abbreviation,
                            tbp.business_unit_id busiUnitId,
                            tbos.send_num,
                            tbos.cost_amount
            from tb_bill_out_store tbos
                     left join tb_bill_out_store_dtl tbosd on tbos.id = tbosd.bill_out_store_id
                     left join tb_bill_delivery tbd on tbd.id = tbos.bill_delivery_id
                     left join tb_base_goods tbg on tbosd.goods_id = tbg.id
                     inner join tb_base_user_project bup on tbos.project_id = bup.project_id
                     inner join tb_base_project tbp on tbp.id = bup.project_id
                     INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
            where 1 = 1
              and tbos.is_delete = 0
              AND bup.user_id = 1
              AND bup.state = 1
              AND (tbs.subject_type & 1 = 1)
              and (tbos.bill_type = 1 or tbos.bill_type = 5)
              AND tbos.send_date >= '2019-12-01 00:00:00'
              AND tbos.send_date <= '2019-12-12 00:00:00'
              AND tbos.status = 5
           ) temp1
      group by projectId
     ) v1,
     (select projectId,
             busiUnitId,
             concat(projectNo, '-', abbreviationProjectName) projectName,
             concat(subjectNo, '-', abbreviation)            businessName,
             IFNULL(SUM(temp1.send_num), 0)                  current_other_out_num,
             IFNULL(SUM(temp1.cost_amount), 0)               current_other_amount
      from (SELECT DISTINCT tbos.id,
                            tbos.project_id      projectId,
                            tbp.project_no       projectNo,
                            tbp.project_name     abbreviationProjectName,
                            tbs.subject_no       subjectNo,
                            tbs.abbreviation     abbreviation,
                            tbp.business_unit_id busiUnitId,
                            tbos.send_num,
                            tbos.cost_amount
            from tb_bill_out_store tbos
                     left join tb_bill_out_store_dtl tbosd on tbos.id = tbosd.bill_out_store_id
                     left join tb_bill_delivery tbd on tbd.id = tbos.bill_delivery_id
                     left join tb_base_goods tbg on tbosd.goods_id = tbg.id
                     inner join tb_base_user_project bup on tbos.project_id = bup.project_id
                     inner join tb_base_project tbp on tbp.id = bup.project_id
                     INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
            where 1 = 1
              and tbos.is_delete = 0
              AND bup.user_id = 1
              AND bup.state = 1
              AND (tbs.subject_type & 1 = 1)
              and (tbos.bill_type = 2 or tbos.bill_type = 3 or tbos.bill_type = 4 or tbos.bill_type = 6 or
                   tbos.bill_type = 7 or tbos.bill_type = 8)
              AND tbos.send_date >= '2019-12-01 00:00:00'
              AND tbos.send_date <= '2019-12-12 00:00:00'
              AND tbos.status = 5
           ) temp1
      group by projectId
     ) v2
where 1 = 1
and v1.projectId = v2.projectId
and v1.busiUnitId = v2.busiUnitId


