-- auto-generated definition
create table tb_bill_out_store_dtl
(
    id                        bigint auto_increment comment '出库单明细ID'
        primary key,
    bill_out_store_id         bigint                                   null comment '出库单ID',
    bill_delivery_dtl_id      bigint                                   null comment '提货单明细ID',
    goods_id                  bigint                                   null comment '商品ID',
    this_unit                 varchar(50)                              null comment '包装单位',
    this_prate                decimal(20, 8) default 1.00000000        null comment 'po_unit和so_unit的换算值',
    send_num                  decimal(20, 8) default 0.00000000        null comment '发货数量',
    min_send_num              decimal(20, 8) default 0.00000000        null comment '最小包装发货数量',
    send_price                decimal(20, 8) default 0.00000000        null comment '发货单价',
    pickup_num                decimal(20, 8) default 0.00000000        null comment '拣货数量',
    min_pickup_num            decimal(20, 8) default 0.00000000        null comment '最小包装拣货数量',
    stl_id                    bigint                                   null comment '库存ID',
    batch_no                  varchar(50)                              null comment '批次',
    goods_status              tinyint        default 1                 null comment '商品状态 1-常规 2-残次品',
    cost_amount               decimal(20, 8) default 0.00000000        null comment '成本金额',
    po_amount                 decimal(20, 8) default 0.00000000        null comment '订单金额',
    assign_stl_flag           tinyint        default 0                 null comment '是否指定库存 0-不指定 1-指定',
    customs_declare_num       decimal(20, 8) default 0.00000000        null comment '已报关数量',
    remark                    varchar(500)                             null comment '备注',
    creator_id                bigint                                   null comment '创建人ID',
    creator                   varchar(50)                              null comment '创建人',
    create_at                 datetime       default CURRENT_TIMESTAMP null comment '创建时间',
    update_at                 timestamp      default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    pay_price                 decimal(20, 8) default 0.00000000        null comment '付款单价',
    pay_rate                  decimal(20, 8) default 0.00000000        not null comment '付款汇率',
    pay_real_currency         tinyint        default 1                 not null comment '付款实际支付币种',
    pay_time                  datetime                                 null comment '付款时间',
    po_return_id              bigint                                   null comment '关联采购退货单ID',
    po_return_dtl_id          bigint                                   null comment '关联采购退货单明细ID',
    fund_back_dtl_amount      decimal(20, 8) default 0.00000000        not null comment '明细资金归还金额',
    ref_bill_out_store_dtl_id bigint                                   null comment '关联成本调整的出库单明细ID'
)
    comment '出库单明细表';

create index idx_tb_bill_out_store_dtl_bill_out_store_id
    on tb_bill_out_store_dtl (bill_out_store_id);

