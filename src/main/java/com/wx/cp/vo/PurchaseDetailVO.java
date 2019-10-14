package com.wx.cp.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * @author dell
 */
@Getter
@Setter
@ToString
public class PurchaseDetailVO implements Serializable {
    /**订单编号*/
    private String poNo;
    /**订单日期*/
    private LocalDate orderTime;
    /**项目*/
    private String projectId;
    /**供应商*/
    private String supplierId;
    /**预计到货时间*/
    private LocalDate perdictTime;
    /**收货仓库*/
    private String warehouseId;
    /**备注*/
    private String remark;
    /**订单总金额*/
    private BigDecimal orderTotalAmount;

    /**商品编号*/
    private String goodsNo;
    /**商品条码*/
    private String goodsBarCode;
    /**商品名称*/
    private String goodsName;
    /**商品型号*/
    private String goodsType;
    /**商品规格*/
    private String specification;
    /**商品数量*/
    private Integer goodsNum;
    /**商品单价*/
    private BigDecimal goodsPrice;
}
