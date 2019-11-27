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
    tbg.tax_rate taxRate,
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
  and (tbs.subject_type & 1 = 1)
  and tbis.status = 2
  and tbis.is_delete = 0
  and tbup.state = 1
  and tbup.user_id = 1
  and DATE_FORMAT(tbis.accept_time, "%Y-%m-%d") <= '2019-10-31'
group by tbg.brand,tbg.name,tbg.goods_type
union all
select
    tbup.user_id user_id,
    tbos.project_id projectId,
    tbp.project_no projectNo,
    tbp.project_name abbreviationProjectName,
    tbs.subject_no subjectNo,
    tbs.abbreviation abbreviation,
    tbosd.goods_id as goodsId,
    tbg.brand brand,
    tbg.name goodName,
    tbg.goods_type goodType,
    tbg.specification specification,
    tbg.number number,
    tbg.tax_rate taxRate,
    tbg.bar_code barCode,
    tbp.business_unit_id busiUnitId
from tb_bill_out_store tbos,
     tb_bill_out_store_dtl tbosd,
     tb_base_user_project tbup,
     tb_base_subject tbs,
     tb_base_project tbp,
     tb_base_goods tbg
where 1 = 1
  and tbos.id = tbosd.bill_out_store_id
  and tbos.project_id = tbup.project_id
  and tbp.id = tbup.project_id
  and tbosd.goods_id = tbg.id
  and tbos.project_id = tbp.id
  and tbos.is_delete = 0
  and tbos.status = 5
  and tbup.state = 1
  and tbup.user_id = 1
  and tbos.send_date < '2019-10-01'
group by tbg.brand,tbg.name,tbg.goods_type

