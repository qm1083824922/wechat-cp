-- 去除期初等金额都为0的记录
select userId,
       projectId,
       goodsId,
       busiUnitId,
       projectName,
       businessName,
       initialNum,
       initialAmount,
       (initialNum + currentNum) endNum,
       (initialAmount + currentAmount) endAmount,
       currentInNum,
       currentInAmount,
       currentOtherInNum,
       currentOtherInAmount,
       currentOutNum,
       currentOutAmount,
       currentOtherOutNum,
       currentOtherOutAmount
from (select userId,
             projectId,
             goodsId,
             busiUnitId,
             projectName,
             businessName,
             SUM(initial_in_num - initial_out_num)       initialNum,
             SUM(initial_in_amount - initial_out_amount) initialAmount,
             current_in_num                              currentInNum,
             current_in_amount                           currentInAmount,
             current_other_in_num                        currentOtherInNum,
             current_other_in_amount                     currentOtherInAmount,
             current_out_num                             currentOutNum,
             current_out_amount                          currentOutAmount,
             current_other_out_num                       currentOtherOutNum,
             current_other_out_amount                    currentOtherOutAmount,
             sum(current_in_num - current_out_num) currentNum,
             sum(current_in_amount - current_out_amount) currentAmount
      from (select userId,
                   projectId,
                   goodsId,
                   busiUnitId,
                   concat(projectNo, '-', abbreviationProjectName) projectName,
                   concat(subjectNo, '-', abbreviation)            businessName,
                   (
                       select IFNULL(SUM(IFNULL(tbisd.receive_num, 0)), 0) initial_in_num
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
                         and tbis.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and tbup.state = 1
                         and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") < '2019-10-01'
                   ) initial_in_num,
                   (
                       select IFNULL(SUM(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)), 0) initial_in_amount
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
                         and tbis.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and tbup.state = 1
                         and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") < '2019-10-01'
                   ) initial_in_amount,
                   (
                       select IFNULL(SUM(IFNULL(tbosd.send_num, 0)), 0) initial_out_num
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
                         and tbos.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and tbos.send_date < '2019-10-01'
                   ) initial_out_num,
                   (
                       select IFNULL(SUM(IFNULL((tbosd.cost_amount), 0)), 0) initial_out_amount
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
                         and tbos.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and tbos.send_date < '2019-10-01'
                   ) initial_out_amount,
                   (
                       select IFNULL(SUM(IFNULL(tbisd.receive_num, 0)), 0) current_in_num
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
                         and tbis.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
                         and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
                   ) current_in_num,
                   (
                       select IFNULL(SUM(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)), 0) current_in_amount
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
                         and tbis.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
                         and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
                   ) current_in_amount,
                   (
                       select IFNULL(SUM(IFNULL(tbisd.receive_num, 0)), 0) current_other_in_num
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
                         and tbis.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
                         and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
                   ) current_other_in_num,
                   (
                       select IFNULL(SUM(IFNULL(tbisd.receive_num * tbisd.cost_price, 0)), 0) current_other_in_amount
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
                         and tbis.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") >= '2019-10-01'
                         and DATE_FORMAT(tbis.receive_date, "%Y-%m-%d") <= '2019-10-31'
                   ) current_other_in_amount,
                   (
                       select IFNULL(SUM(IFNULL((tbosd.send_num), 0)), 0)    current_out_num
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
                         and tbos.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
                         and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
                   ) current_out_num,
                   (
                       select IFNULL(SUM(IFNULL((tbosd.cost_amount), 0)), 0) current_out_amount
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
                         and tbos.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
                         and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
                   ) current_out_amount,
                   (
                       select IFNULL(SUM(IFNULL((tbosd.send_num), 0)), 0)    current_other_out_num
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
                         and tbos.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
                         and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
                   ) current_other_out_num,
                   (
                       select IFNULL(SUM(IFNULL((tbosd.cost_amount), 0)), 0) current_other_out_amount
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
                         and tbos.project_id = tmp.projectId
                         and tbup.user_id = tmp.userId
                         and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") >= '2019-10-01'
                         and DATE_FORMAT(tbos.send_date, "%Y-%m-%d") <= '2019-10-31'
                   )  current_other_out_amount

            from (
                     select tbup.user_id         userId,
                            tbis.project_id      projectId,
                            tbp.project_no       projectNo,
                            tbp.project_name     abbreviationProjectName,
                            tbs.subject_no       subjectNo,
                            tbs.abbreviation     abbreviation,
                            tbisd.goods_id       goodsId,
                            tbp.business_unit_id busiUnitId
                     from tb_bill_in_store_dtl tbisd,
                          tb_bill_in_store tbis,
                          tb_base_project tbp,
                          tb_base_subject tbs,
                          tb_base_user_project tbup
                     where 1 = 1
                       and tbisd.bill_in_store_id = tbis.id
                       and tbis.project_id = tbp.id
                       and tbp.id = tbup.project_id
                       and tbp.business_unit_id = tbs.id
                       and (tbs.subject_type & 1 = 1)
                       and tbis.status = 2
                       and tbis.is_delete = 0
                       and tbup.state = 1
                       and tbup.user_id = 1
                       and tbp.id = 3
                       and DATE_FORMAT(tbis.accept_time, "%Y-%m-%d") <= '2019-10-31'
                     union
                     select tbup.user_id         user_id,
                            tbos.project_id      projectId,
                            tbp.project_no       projectNo,
                            tbp.project_name     abbreviationProjectName,
                            tbs2.subject_no      subjectNo,
                            tbs2.abbreviation    abbreviation,
                            tbosd.goods_id as    goodsId,
                            tbp.business_unit_id busiUnitId
                     from tb_bill_out_store tbos,
                          tb_bill_out_store_dtl tbosd,
                          tb_base_project tbp,
                          tb_base_subject tbs2,
                          tb_base_user_project tbup
                     where 1 = 1
                       and tbos.id = tbosd.bill_out_store_id
                       and tbos.project_id = tbp.id
                       and tbp.id = tbup.project_id
                       and tbp.business_unit_id = tbs2.id
                       and tbos.status = 5
                       and tbup.state = 1
                       and (tbs2.subject_type & 1 = 1)
                       and tbos.is_delete = 0
                       and tbup.user_id = 1
                       and tbp.id = 3
                       and DATE_FORMAT(tbos.deliver_time, "%Y-%m-%d") <= '2019-10-31'
                 ) tmp
            where 1 = 1
            group by tmp.busiUnitId, tmp.projectId
           ) as v_table
      group by v_table.busiUnitId, v_table.projectId
     ) as v_table1
where 1 = 1
  and (initialNum > 0
    or initialAmount > 0
    or currentInNum > 0
    or currentInAmount > 0
    or currentOtherInNum > 0
    or currentOtherInAmount > 0
    or currentOutNum > 0
    or currentOutAmount > 0
    or currentOtherOutNum > 0
    or currentOtherOutAmount > 0);


select temp.project_id,
       temp.sale_num - temp.sale_return_num total_sale_num,
       temp.sale_amount - temp.sale_return_amount total_sale_amount
from (
         (select DISTINCT tbos.id,
                          tbos.bill_no,
                          tbos.bill_type,
                          tbos.project_id,
                          tbos.status,
                          tbos.send_num    sale_num,
                          tbos.send_amount sale_amount,
                          0                sale_return_num,
                          0                sale_return_amount
          from tb_bill_out_store tbos,
               tb_bill_out_store_dtl tbosd,
               tb_base_user_project tbup,
               tb_base_project tbp
          where 1 = 1
            and tbos.id = tbosd.bill_out_store_id
            and tbos.project_id = tbup.project_id
            and tbp.id = tbup.project_id
            and tbos.is_delete = 0
            AND tbup.user_id = 1
            AND tbup.state = 1
            AND tbos.required_send_date >= '2019-12-01 00:00:00'
            AND tbos.required_send_date <= '2019-12-31 00:00:00'
            AND tbos.bill_type = 1
          order by id)
         union
         (select DISTINCT tbos.id,
                          tbos.bill_no,
                          tbos.bill_type,
                          tbos.project_id,
                          tbos.status,
                          0                sale_num,
                          0                sale_amount,
                          tbos.send_num    sale_return_num,
                          tbos.send_amount sale_return_amount
          from tb_bill_out_store tbos,
               tb_bill_out_store_dtl tbosd,
               tb_base_user_project tbup,
               tb_base_project tbp
          where 1 = 1
            and tbos.id = tbosd.bill_out_store_id
            and tbos.project_id = tbup.project_id
            and tbp.id = tbup.project_id
            and tbos.is_delete = 0
            AND tbup.user_id = 1
            AND tbup.state = 1
            AND tbos.required_send_date >= '2019-12-01 00:00:00'
            AND tbos.required_send_date <= '2019-12-31 00:00:00'
            AND tbos.bill_type = 5
          order by id)
    ) as temp;
-- 销售
select temp.sale_num - temp.sale_return_num,
       temp.sale_amount - temp.sale_return_amount
from (
(select DISTINCT tbos.id,
                tbos.bill_no,
                tbos.bill_type,
                tbos.project_id,
                tbos.status,
                tbos.send_num sale_num,
                tbos.send_amount sale_amount,
                0 sale_return_num,
                0 sale_return_amount
from tb_bill_out_store tbos,
     tb_bill_out_store_dtl tbosd,
     tb_base_user_project tbup ,
     tb_base_project tbp
where 1 = 1
  and tbos.id = tbosd.bill_out_store_id
  and tbos.project_id = tbup.project_id
  and tbp.id = tbup.project_id
  and tbos.is_delete = 0
  AND tbup.user_id = 1
  AND tbup.state = 1
  AND tbos.required_send_date >= '2019-12-01 00:00:00'
  AND tbos.required_send_date <= '2019-12-31 00:00:00'
  AND tbos.bill_type = 1
order by id)
union
(select DISTINCT tbos.id,
                tbos.bill_no,
                tbos.bill_type,
                tbos.project_id,
                tbos.status,
                0 sale_num,
                0 sale_amount,
                tbos.send_num sale_return_num,
                tbos.send_amount sale_return_amount
from tb_bill_out_store tbos,
     tb_bill_out_store_dtl tbosd,
     tb_base_user_project tbup ,
     tb_base_project tbp
where 1 = 1
  and tbos.id = tbosd.bill_out_store_id
  and tbos.project_id = tbup.project_id
  and tbp.id = tbup.project_id
  and tbos.is_delete = 0
  AND tbup.user_id = 1
  AND tbup.state = 1
  AND tbos.required_send_date >= '2019-12-01 00:00:00'
  AND tbos.required_send_date <= '2019-12-31 00:00:00'
  AND tbos.bill_type = 5
order by id)) as temp

