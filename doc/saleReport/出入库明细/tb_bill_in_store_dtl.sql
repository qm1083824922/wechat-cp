-- auto-generated definition
create table tb_bill_in_store_dtl
(
    id  bigint auto_increment comment '自增ID' primary key,
    bill_in_store_id         bigint                                   null comment '入库单ID',
    po_dtl_id                bigint                                   null comment 'PO订单明细ID',
    po_id                    bigint                                   null comment 'PO订单ID',
    bill_out_store_id        bigint                                   null comment '关联出库单ID',
    bill_out_store_dtl_id    bigint                                   null comment '关联出库单明细ID',
    goods_id                 bigint                                   null comment '商品ID',
    receive_num              decimal(20, 8) default 0.00000000        null comment '收货数量',
    cost_price               decimal(20, 8) default 0.00000000        null comment '成本单价',
    bill_in_store_dtl_id     bigint                                   null comment '关联入库单明细ID',
    accept_time              datetime                                 null comment '入库时间',
    receive_date             date                                     null comment '收货日期'
)comment '入库单明细表';
create index idx_tb_bill_in_store_dtl_bill_in_store_id on tb_bill_in_store_dtl (bill_in_store_id);

create table in_store_dtl_stl
(
    id             bigint auto_increment comment '自增ID' primary key,
    in_goods_id    bigint                            null comment '入库单ID',
    in_number      varchar(255)                      null comment '入库单商品编号',
    in_receive_num decimal(20, 8) default 0.00000000 null comment '入库数量',
    in_cost_price  decimal(20, 8) default 0.00000000 null comment '入库成本金额',
    stl_goods_id   bigint                            null comment '库存商品id',
    stl_number     varchar(255)                      null comment '库存商品编号',
    stl_sum_store  decimal(20, 8) default 0.00000000 null comment '库存数量',
    stl_cost_price decimal(20, 8) default 0.00000000 null comment '库存金额'
) comment '入库单明细表';
create index idx_tb_bill_in_store_dtl_bill_in_store_id on tb_bill_in_store_dtl (bill_in_store_id);


