2019-12-01(String),
2019-12-01(String),
2019-12-01(String), 2019-12-30(String),
2019-12-01(String), 2019-12-30(String),
2019-12-01(String), 2019-12-30(String),
2019-12-01(String), 2019-12-30(String)

select project_id,
       business_unit_id,
       project_name,
       businessUnitName,
       initial_num,
       initial_amount,
       initial_in_num,
       initial_in_amount,
       initial_out_num,
       initial_out_amount,
       current_in_num,
       current_in_amount,
       current_normal_in_num,
       current_normal_in_amount,
       current_other_in_num,
       current_other_in_amount,
       current_out_num,
       current_out_amount,
       current_normal_out_num,
       current_normal_out_amount,
       current_other_out_num,
       current_other_out_amount,
       end_num,
       end_amount,
       round(IFNULL((DATEDIFF(curdate(), DATE_ADD(curdate(), interval -day(curdate()) + 1 day)) * 0.5 * (initial_num + end_num)) / current_normal_out_num, 0), 2)              inventory_turnover_days,
       round(IFNULL(360/((DATEDIFF(curdate(), DATE_ADD(curdate(), interval -day(curdate()) + 1 day)) * 0.5 * (initial_num + end_num)) / sum(current_normal_out_num)), 0), 2) inventory_turnover
from (select project_id,
             business_unit_id,
             project_name,
             subject_name businessUnitName,
             initial_num,
             initial_amount,
             initial_in_num,
             initial_in_amount,
             initial_out_num,
             initial_out_amount,
             current_in_num,
             current_in_amount,
             current_normal_in_num,
             current_normal_in_amount,
             current_other_in_num,
             current_other_in_amount,
             current_out_num,
             current_out_amount,
             current_normal_out_num,
             current_normal_out_amount,
             current_other_out_num,
             current_other_out_amount,
             (initial_num + current_in_num - current_out_num)        end_num,
             initial_amount + current_in_amount - current_out_amount end_amount
      from (select project_id,
                   business_unit_id,
                   project_name,
                   subject_name,
                   sum(initial_in_num) - sum(initial_out_num)                     initial_num,
                   sum(initial_in_amount) - sum(initial_out_amount)               initial_amount,
                   sum(initial_in_num)                                            initial_in_num,
                   sum(initial_in_amount)                                         initial_in_amount,
                   sum(initial_out_num)                                           initial_out_num,
                   sum(initial_out_amount)                                        initial_out_amount,
                   sum(current_normal_in_num) + sum(current_other_in_num)         current_in_num,
                   sum(current_normal_in_amount) + sum(current_other_in_amount)   current_in_amount,
                   sum(current_normal_in_num)                                     current_normal_in_num,
                   sum(current_normal_in_amount)                                  current_normal_in_amount,
                   sum(current_other_in_num)                                      current_other_in_num,
                   sum(current_other_in_amount)                                   current_other_in_amount,
                   sum(current_normal_out_num) + sum(current_other_out_num)       current_out_num,
                   sum(current_normal_out_amount) + sum(current_other_out_amount) current_out_amount,
                   sum(current_normal_out_num)                                    current_normal_out_num,
                   sum(current_normal_out_amount)                                 current_normal_out_amount,
                   sum(current_other_out_num)                                     current_other_out_num,
                   sum(current_other_out_amount)                                  current_other_out_amount
            from (SELECT tbp.id                                        project_id,
                         tbp.business_unit_id,
                         concat(tbp.project_no, '-', tbp.project_name) project_name,
                         concat(tbs.subject_no, '-', tbs.abbreviation) subject_name,
                         sum(tbisd.receive_num)                        initial_in_num,
                         sum(tbisd.receive_num * tbisd.cost_price)     initial_in_amount,
                         0                                             initial_out_num,
                         0                                             initial_out_amount,
                         0                                             current_normal_in_num,
                         0                                             current_normal_in_amount,
                         0                                             current_other_in_num,
                         0                                             current_other_in_amount,
                         0                                             current_normal_out_num,
                         0                                             current_normal_out_amount,
                         0                                             current_other_out_num,
                         0                                             current_other_out_amount
                  FROM tb_bill_in_store tbis
                           LEFT JOIN tb_bill_in_store_dtl tbisd ON tbis.id = tbisd.bill_in_store_id
                           LEFT JOIN tb_base_goods tbg ON tbisd.goods_id = tbg.id
                           INNER JOIN tb_base_user_project bup ON tbis.project_id = bup.project_id
                           INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
                           INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
                  WHERE 1 = 1
                    AND tbis.is_delete = 0
                    AND (tbs.subject_type & 1 = 1)
                    and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-12-01'
                    AND tbis.STATUS = 2
                  group by tbp.id, tbp.business_unit_id
                  union
                  SELECT tbp.id                                        project_id,
                         tbp.business_unit_id,
                         concat(tbp.project_no, '-', tbp.project_name) project_name,
                         concat(tbs.subject_no, '-', tbs.abbreviation) subject_name,
                         0                                             initial_in_num,
                         0                                             initial_in_amount,
                         sum(tbosd.send_num)                           initial_out_num,
                         sum(tbosd.cost_amount)                        initial_out_amount,
                         0                                             current_normal_in_num,
                         0                                             current_normal_in_amount,
                         0                                             current_other_in_num,
                         0                                             current_other_in_amount,
                         0                                             current_normal_out_num,
                         0                                             current_normal_out_amount,
                         0                                             current_other_out_num,
                         0                                             current_other_out_amount
                  FROM tb_bill_out_store tbos
                           LEFT JOIN tb_bill_out_store_dtl tbosd ON tbos.id = tbosd.bill_out_store_id
                           LEFT JOIN tb_base_goods tbg ON tbosd.goods_id = tbg.id
                           INNER JOIN tb_base_user_project bup ON tbos.project_id = bup.project_id
                           INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
                           INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
                  WHERE 1 = 1
                    AND tbos.is_delete = 0
                    AND (tbs.subject_type & 1 = 1)
                    and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-12-01'
                    AND tbos.STATUS = 5
                  group by tbp.id, tbp.business_unit_id
                  union
                  SELECT tbp.id                                        project_id,
                         tbp.business_unit_id,
                         concat(tbp.project_no, '-', tbp.project_name) project_name,
                         concat(tbs.subject_no, '-', tbs.abbreviation) subject_name,
                         0                                             initial_in_num,
                         0                                             initial_in_amount,
                         0                                             initial_out_num,
                         0                                             initial_out_amount,
                         sum(tbisd.receive_num)                        current_normal_in_num,
                         sum(tbisd.receive_num * tbisd.cost_price)     current_normal_in_amount,
                         0                                             current_other_in_num,
                         0                                             current_other_in_amount,
                         0                                             current_normal_out_num,
                         0                                             current_normal_out_amount,
                         0                                             current_other_out_num,
                         0                                             current_other_out_amount
                  FROM tb_bill_in_store tbis
                           LEFT JOIN tb_bill_in_store_dtl tbisd ON tbis.id = tbisd.bill_in_store_id
                           LEFT JOIN tb_base_goods tbg ON tbisd.goods_id = tbg.id
                           INNER JOIN tb_base_user_project bup ON tbis.project_id = bup.project_id
                           INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
                           INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
                  WHERE 1 = 1
                    AND tbis.is_delete = 0
                    AND (tbs.subject_type & 1 = 1)
                    and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-12-01'
                    and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-12-30'
                    and (tbis.bill_type = 1 or tbis.bill_type = 3)
                    AND tbis.STATUS = 2
                  group by tbp.id, tbp.business_unit_id
                  union
                  SELECT tbp.id                                        project_id,
                         tbp.business_unit_id,
                         concat(tbp.project_no, '-', tbp.project_name) project_name,
                         concat(tbs.subject_no, '-', tbs.abbreviation) subject_name,
                         0                                             initial_in_num,
                         0                                             initial_in_amount,
                         0                                             initial_out_num,
                         0                                             initial_out_amount,
                         0                                             current_normal_in_num,
                         0                                             current_normal_in_amount,
                         sum(tbisd.receive_num)                        current_other_in_num,
                         sum(tbisd.receive_num * tbisd.cost_price)     current_other_in_amount,
                         0                                             current_normal_out_num,
                         0                                             current_normal_out_amount,
                         0                                             current_other_out_num,
                         0                                             current_other_out_amount
                  FROM tb_bill_in_store tbis
                           LEFT JOIN tb_bill_in_store_dtl tbisd ON tbis.id = tbisd.bill_in_store_id
                           LEFT JOIN tb_base_goods tbg ON tbisd.goods_id = tbg.id
                           INNER JOIN tb_base_user_project bup ON tbis.project_id = bup.project_id
                           INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
                           INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
                  WHERE 1 = 1
                    AND tbis.is_delete = 0
                    AND (tbs.subject_type & 1 = 1)
                    and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-12-01'
                    and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-12-30'
                    and (tbis.bill_type = 2 or tbis.bill_type = 4 or tbis.bill_type = 5)
                    AND tbis.STATUS = 2
                  group by tbp.id, tbp.business_unit_id
                  union
                  SELECT tbp.id                                        project_id,
                         tbp.business_unit_id,
                         concat(tbp.project_no, '-', tbp.project_name) project_name,
                         concat(tbs.subject_no, '-', tbs.abbreviation) subject_name,
                         0                                             initial_in_num,
                         0                                             initial_in_amount,
                         0                                             initial_out_num,
                         0                                             initial_out_amount,
                         0                                             current_normal_in_num,
                         0                                             current_normal_in_amount,
                         0                                             current_other_in_num,
                         0                                             current_other_in_amount,
                         sum(tbosd.send_num)                           current_normal_out_num,
                         sum(tbosd.cost_amount)                        current_normal_out_amount,
                         0                                             current_other_out_num,
                         0                                             current_other_out_amount
                  FROM tb_bill_out_store tbos
                           LEFT JOIN tb_bill_out_store_dtl tbosd ON tbos.id = tbosd.bill_out_store_id
                           LEFT JOIN tb_base_goods tbg ON tbosd.goods_id = tbg.id
                           INNER JOIN tb_base_user_project bup ON tbos.project_id = bup.project_id
                           INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
                           INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
                  WHERE 1 = 1
                    AND tbos.is_delete = 0
                    AND (tbs.subject_type & 1 = 1)
                    and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-12-01'
                    and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-12-30'
                    and (tbos.bill_type = 1 or tbos.bill_type = 5)
                    AND tbos.STATUS = 5
                  group by tbp.id, tbp.business_unit_id
                  union
                  SELECT tbp.id                                        project_id,
                         tbp.business_unit_id,
                         concat(tbp.project_no, '-', tbp.project_name) project_name,
                         concat(tbs.subject_no, '-', tbs.abbreviation) subject_name,
                         0                                             initial_in_num,
                         0                                             initial_in_amount,
                         0                                             initial_out_num,
                         0                                             initial_out_amount,
                         0                                             current_normal_in_num,
                         0                                             current_normal_in_amount,
                         0                                             current_other_in_num,
                         0                                             current_other_in_amount,
                         0                                             current_normal_out_num,
                         0                                             current_normal_out_amount,
                         sum(tbosd.send_num)                           current_other_out_num,
                         sum(tbosd.cost_amount)                        current_other_out_amount
                  FROM tb_bill_out_store tbos
                           LEFT JOIN tb_bill_out_store_dtl tbosd ON tbos.id = tbosd.bill_out_store_id
                           LEFT JOIN tb_base_goods tbg ON tbosd.goods_id = tbg.id
                           INNER JOIN tb_base_user_project bup ON tbos.project_id = bup.project_id
                           INNER JOIN tb_base_project tbp ON tbp.id = bup.project_id
                           INNER JOIN tb_base_subject tbs ON tbp.business_unit_id = tbs.id
                  WHERE 1 = 1
                    AND tbos.is_delete = 0
                    AND (tbs.subject_type & 1 = 1)
                    and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-12-01'
                    and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-12-30'
                    and (tbos.bill_type = 2 or tbos.bill_type = 3 or tbos.bill_type = 4 or tbos.bill_type = 6 or tbos.bill_type = 7 or tbos.bill_type = 8)
                    AND tbos.STATUS = 5
                  group by tbp.id, tbp.business_unit_id) temp
            group by project_id, business_unit_id) temp2
      group by project_id, business_unit_id) temp3
group by project_id, business_unit_id
