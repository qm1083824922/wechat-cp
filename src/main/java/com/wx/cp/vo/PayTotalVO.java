package com.wx.cp.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class PayTotalVO {
    //总个数
    private BigDecimal totalGoodsNumber;
    //采购价总金额
    private BigDecimal totalGoodsPrice;
    //销售价总金额
    private BigDecimal totalSalePrice;
    //采购总金额
    private BigDecimal totalPurchaseAmount;
    //销售总金额
    private BigDecimal totalSaleAmount;
    //本次付款总金额
    private BigDecimal totalPayAmount;
}
