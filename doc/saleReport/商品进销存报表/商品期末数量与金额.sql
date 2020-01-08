select * from
    (SELECT
         temp3.projectId,
         temp3.busiUnitId,
         temp3.projectName,
         temp3.businessName,
         goodsId,
         number,
         sum( temp3.end_in_num ) end_in_num,
         sum( temp3.end_in_amount ) end_in_amount,
         sum( temp3.end_out_num ) end_out_num,
         sum( temp3.end_out_amount ) end_out_amount,
         ( sum( temp3.end_in_num ) - sum( temp3.end_out_num ) ) end_num,
         ( sum( temp3.end_in_amount ) - sum( temp3.end_out_amount ) ) end_amount
     FROM
         (
             SELECT
                 projectId,
                 busiUnitId,
                 goodsId,
                 number,
                 concat( projectNo, '-', abbreviationProjectName ) projectName,
                 concat( subjectNo, '-', abbreviation ) businessName,
                 IFNULL( SUM( temp.receive_num ), 0 ) end_in_num,
                 IFNULL( SUM( temp.receive_amount ), 0 ) end_in_amount,
                 0 end_out_num,
                 0 end_out_amount
             FROM
                 (
                     SELECT DISTINCT
                         tbis.id,
                         tbisd.receive_num,
                         tbisd.receive_price,
                         ( tbisd.receive_num * tbisd.receive_price ) receive_amount,
                         tbisd.goods_id goodsId,
                         tbg.number,
                         tbis.project_id projectId,
                         tbp.project_no projectNo,
                         tbp.project_name abbreviationProjectName,
                         tbs.subject_no subjectNo,
                         tbs.abbreviation abbreviation,
                         tbp.business_unit_id busiUnitId
                     FROM
                         tb_bill_in_store tbis
                             LEFT JOIN tb_bill_in_store_dtl tbisd ON tbis.id = tbisd.bill_in_store_id
                             LEFT JOIN tb_purchase_order_title tpot ON tbisd.po_id = tpot.id
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
                       AND tbis.receive_date < '2019-12-19 00:00:00'
                       AND tbis.STATUS = 2
                       AND tbp.id = 10
                       AND tbp.business_unit_id = 112
                     -- and tbg.number = 'P100001051'
                 ) temp
             GROUP BY
                 projectId,
                 busiUnitId,
                 goodsId UNION
             SELECT
                 projectId,
                 busiUnitId,
                 goodsId,
                 number,
                 concat( projectNo, '-', abbreviationProjectName ) projectName,
                 concat( subjectNo, '-', abbreviation ) businessName,
                 0 end_in_num,
                 0 end_in_amount,
                 IFNULL( SUM( temp2.send_num ), 0 ) end_out_num,
                 IFNULL( SUM( temp2.send_amount ), 0 ) end_out_amount
             FROM
                 (
                     SELECT DISTINCT
                         tbos.id,
                         tbos.project_id projectId,
                         tbosd.goods_id goodsId,
                         tbg.number,
                         tbp.project_no projectNo,
                         tbp.project_name abbreviationProjectName,
                         tbs.subject_no subjectNo,
                         tbs.abbreviation abbreviation,
                         tbp.business_unit_id busiUnitId,
                         tbosd.send_num,
                         tbosd.cost_amount send_amount
                     FROM
                         tb_bill_out_store tbos
                             LEFT JOIN tb_bill_out_store_dtl tbosd ON tbos.id = tbosd.bill_out_store_id
                             LEFT JOIN tb_bill_delivery tbd ON tbd.id = tbos.bill_delivery_id
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
                       AND tbos.send_date < '2019-12-19 00:00:00'
                       AND tbos.STATUS = 5
                       AND tbp.id = 10
                       AND tbp.business_unit_id = 112
                     -- and tbg.number = 'P100001051'
                 ) temp2 GROUP BY projectId,busiUnitId,goodsId
         ) temp3 GROUP BY projectId,busiUnitId,goodsId ) temp4 where 1 = 1 and end_num>0 and end_amount>0 GROUP BY projectId,busiUnitId,goodsId
