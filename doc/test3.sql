alter table tb_project_item add purchase_audit_type varchar(50) default  null comment '采购订单审核流，null表示无，有值则与之对应审核流';

-- 江西零售
update tb_project_item set purchase_audit_type = 'AF19080200001' where item_no = 'TK19102100001';
-- 美妆物流
update tb_project_item set purchase_audit_type = 'AF19080200001' where item_no = 'TK19101500003';
