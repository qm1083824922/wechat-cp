select
    project_id,
    business_unit_id,
    project_name,
    subject_name,
    goods_id,
    brand,
    goods_name,
    goods_type,
    specification,
    number,
    bar_code,
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
    round(IFNULL((DATEDIFF(curdate(),DATE_ADD(curdate(), interval -day(curdate()) + 1 day)) * 0.5 *(initial_num + end_num))/current_normal_out_num,0),2) inventory_turnover_days,
    round(IFNULL(360/((DATEDIFF(curdate(),DATE_ADD(curdate(), interval -day(curdate()) + 1 day)) * 0.5 * (initial_num+end_num))/sum(current_normal_out_num)),0),2) inventory_turnover
from
    (select
    project_id,
    business_unit_id,
    project_name,
    subject_name,
    goods_id,
    brand,
    good_name goods_name,
    goods_type,
    specification,
    number,
    bar_code,
    initial_in_num - initial_out_num initial_num,
    initial_in_amount - initial_out_amount initial_amount,
    initial_in_num,
    initial_in_amount,
    initial_out_num,
    initial_out_amount,
    current_normal_in_num + current_other_in_num current_in_num,
    current_normal_in_amount + current_other_in_amount current_in_amount,
    current_normal_in_num,
    current_normal_in_amount,
    current_other_in_num,
    current_other_in_amount,
    current_normal_out_num + current_other_out_num current_out_num,
    current_normal_out_amount + current_other_out_amount current_out_amount,
    current_normal_out_num,
    current_normal_out_amount,
    current_other_out_num,
    current_other_out_amount,
    (initial_in_num - initial_out_num) + (current_normal_in_num + current_other_in_num) - (current_normal_out_num + current_other_out_num) end_num,
    (initial_in_amount - initial_out_amount) + (current_normal_in_amount + current_other_in_amount) - (current_normal_out_amount + current_other_out_amount) end_amount
from
    (select project_id,
       business_unit_id,
       project_name,
       subject_name,
       goods_id,
       brand,
       good_name,
       goods_type,
       specification,
       number,
       bar_code,
       sum(initial_in_num) initial_in_num,
       sum(initial_in_amount) initial_in_amount,
       sum(initial_out_num) initial_out_num,
       sum(initial_out_amount) initial_out_amount,
       sum(current_normal_in_num) current_normal_in_num,
       sum(current_normal_in_amount) current_normal_in_amount,
       sum(current_other_in_num) current_other_in_num,
       sum(current_other_in_amount) current_other_in_amount,
       sum(current_normal_out_num) current_normal_out_num,
       sum(current_normal_out_amount) current_normal_out_amount,
       sum(current_other_out_num) current_other_out_num,
       sum(current_other_out_amount) current_other_out_amount
from (SELECT tbp.id project_id,
             tbp.business_unit_id,
             concat(tbp.project_no, '-', tbp.project_name) project_name,
             concat(tbs.subject_no, '-', tbs.abbreviation) subject_name,
             tbg.id goods_id,
             tbg.brand,
             tbg.`name` good_name,
             tbg.goods_type,
             tbg.specification,
             tbg.number,
             tbg.bar_code,
             sum(tbisd.receive_num) initial_in_num,
             sum(tbisd.receive_num * tbisd.cost_price) initial_in_amount,
             0 initial_out_num,
             0 initial_out_amount,
             0 current_normal_in_num,
             0 current_normal_in_amount,
             0 current_other_in_num,
             0 current_other_in_amount,
             0 current_normal_out_num,
             0 current_normal_out_amount,
             0 current_other_out_num,
             0 current_other_out_amount
      FROM tb_bill_in_store tbis
               LEFT JOIN tb_bill_in_store_dtl tbisd ON tbis.id = tbisd.bill_in_store_id
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
      GROUP BY tbp.id, tbp.business_unit_id, tbg.id
      union
      SELECT tbp.id project_id,
             tbp.business_unit_id,
             concat(tbp.project_no, '-', tbp.project_name) project_name,
             concat(tbs.subject_no, '-', tbs.abbreviation) subject_name,
             tbg.id goods_id,
             tbg.brand,
             tbg.`name` good_name,
             tbg.goods_type,
             tbg.specification,
             tbg.number,
             tbg.bar_code,
             0 initial_in_num,
             0 initial_in_amount,
             sum(tbosd.send_num) initial_out_num,
             sum(tbosd.cost_amount) initial_out_amount,
             0 current_normal_in_num,
             0 current_normal_in_amount,
             0 current_other_in_num,
             0 current_other_in_amount,
             0 current_normal_out_num,
             0 current_normal_out_amount,
             0 current_other_out_num,
             0 current_other_out_amount
      FROM tb_bill_out_store tbos
               LEFT JOIN tb_bill_out_store_dtl tbosd ON tbos.id = tbosd.bill_out_store_id
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
      GROUP BY tbp.id, tbp.business_unit_id, tbg.id
    union
      SELECT
          tbp.id project_id,
          tbp.business_unit_id,
          concat(tbp.project_no,'-',tbp.project_name) project_name,
          concat(tbs.subject_no,'-',tbs.abbreviation) subject_name,
          tbg.id goods_id,
          tbg.brand,
          tbg.`name` good_name,
          tbg.goods_type,
          tbg.specification,
          tbg.number,
          tbg.bar_code,
          0 initial_in_num,
          0 initial_in_amount,
          0 initial_out_num,
          0 initial_out_amount,
          sum(tbisd.receive_num) current_normal_in_num,
          sum(tbisd.receive_num * tbisd.cost_price) current_normal_in_amount,
          0 current_other_in_num,
          0 current_other_in_amount,
          0 current_normal_out_num,
          0 current_normal_out_amount,
          0 current_other_out_num,
          0 current_other_out_amount
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
        AND tbis.receive_date >= '2019-12-01 00:00:00'
        AND tbis.receive_date <= '2020-01-04 00:00:00'
        and (tbis.bill_type = 1 or tbis.bill_type = 3)
        AND tbis.STATUS = 2
      group by tbp.id,tbp.business_unit_id,tbg.id
    union
      SELECT
          tbp.id project_id,
          tbp.business_unit_id,
          concat(tbp.project_no,'-',tbp.project_name) project_name,
          concat(tbs.subject_no,'-',tbs.abbreviation) subject_name,
          tbg.id goods_id,
          tbg.brand,
          tbg.`name` good_name,
          tbg.goods_type,
          tbg.specification,
          tbg.number,
          tbg.bar_code,
          0 initial_in_num,
          0 initial_in_amount,
          0 initial_out_num,
          0 initial_out_amount,
          0 current_normal_in_num,
          0 current_normal_in_amount,
          sum(tbisd.receive_num) current_other_in_num,
          sum(tbisd.receive_num * tbisd.cost_price) current_other_in_amount,
          0 current_normal_out_num,
          0 current_normal_out_amount,
          0 current_other_out_num,
          0 current_other_out_amount
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
        AND tbis.receive_date >= '2019-12-01 00:00:00'
        AND tbis.receive_date <= '2020-01-04 00:00:00'
        and (tbis.bill_type = 2 or tbis.bill_type = 4 or tbis.bill_type = 5)
        AND tbis.STATUS = 2
      group by tbp.id,tbp.business_unit_id,tbg.id
    union
      SELECT
          tbp.id project_id,
          tbp.business_unit_id,
          concat(tbp.project_no,'-',tbp.project_name) project_name,
          concat(tbs.subject_no,'-',tbs.abbreviation) subject_name,
          tbg.id goods_id,
          tbg.brand,
          tbg.`name` good_name,
          tbg.goods_type,
          tbg.specification,
          tbg.number,
          tbg.bar_code,
          0 initial_in_num,
          0 initial_in_amount,
          0 initial_out_num,
          0 initial_out_amount,
          0 current_normal_in_num,
          0 current_normal_in_amount,
          0 current_other_in_num,
          0 current_other_in_amount,
          sum(tbosd.send_num) current_normal_out_num,
          sum(tbosd.cost_amount) current_normal_out_amount,
          0 current_other_out_num,
          0 current_other_out_amount
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
        AND tbos.send_date >= '2019-12-01 00:00:00'
        AND tbos.send_date <= '2020-01-04 00:00:00'
        and (tbos.bill_type = 1 or tbos.bill_type = 5)
        AND tbos.STATUS = 5
      group by tbp.id,tbp.business_unit_id,tbg.id
    union
      SELECT
          tbp.id project_id,
          tbp.business_unit_id,
          concat(tbp.project_no,'-',tbp.project_name) project_name,
          concat(tbs.subject_no,'-',tbs.abbreviation) subject_name,
          tbg.id goods_id,
          tbg.brand,
          tbg.`name` good_name,
          tbg.goods_type,
          tbg.specification,
          tbg.number,
          tbg.bar_code,
          0 initial_in_num,
          0 initial_in_amount,
          0 initial_out_num,
          0 initial_out_amount,
          0 current_normal_in_num,
          0 current_normal_in_amount,
          0 current_other_in_num,
          0 current_other_in_amount,
          0 current_normal_out_num,
          0 current_normal_out_amount,
          sum(tbosd.send_num) current_other_out_num,
          sum(tbosd.cost_amount) current_other_out_amount
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
        AND tbos.send_date >= '2019-12-01 00:00:00'
        AND tbos.send_date <= '2020-01-04 00:00:00'
        and (tbos.bill_type = 2 or tbos.bill_type = 3 or tbos.bill_type = 4 or tbos.bill_type = 6 or
             tbos.bill_type = 7 or tbos.bill_type = 8)
        AND tbos.STATUS = 5
      group by tbp.id,tbp.business_unit_id,tbg.id
    ) temp group by project_id, business_unit_id, goods_id
    ) temp2 group by project_id, business_unit_id, goods_id
    )temp3 group by project_id, business_unit_id, goods_id
