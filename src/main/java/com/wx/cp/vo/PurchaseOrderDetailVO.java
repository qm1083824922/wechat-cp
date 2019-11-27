package com.wx.cp.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class PurchaseOrderDetailVO {
    private String goodsNo;
    private String barCode;
    private String brand;
    private String goodsName;
    private String unit;
    private BigDecimal goodsNum;
    private BigDecimal goodsPrice;
    private BigDecimal arrivalNum;
    private BigDecimal arrivalAmount;
    private BigDecimal batchNum;
    private BigDecimal goodsAmount;
}
