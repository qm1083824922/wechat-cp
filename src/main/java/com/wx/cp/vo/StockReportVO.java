package com.wx.cp.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class StockReportVO {
    private Integer id;
    /** 供应商id **/
    private Integer supplierId;
    /** 项目id **/
    private Integer projectId;
    private String businessUnitName;
    /** 经营单位id **/
    private Integer businessUnitId;
    private String projectName;
    /** 客户id **/
    private Integer customerId;
    private String customerName;
    /** 部门id **/
    private Integer departmentId;
    private String departmentName;
    /** 仓库ID **/
    private Integer warehouseId;
    private String warehouseName;
    /** 商品id **/
    private Integer goodsId;
    /** 商品编号 **/
    private String goodsNo;
    /**
     * 商品国际码
     */
    private String barCode;
    /** 商品描述 **/
    private String goodsName;
    /**
     * 商品类型
     */
    private String goodsType;
    /**
     * 商品品牌
     */
    private String brand;
    /** 总库存 **/
    private BigDecimal sumStore;

    /** 锁定库存 **/
    private BigDecimal sumLock;
    /** 未锁定库存 **/
    private BigDecimal sumNotLock;
    /** 总数量 **/
    private BigDecimal sumNum;
    /** 锁定数量 **/
    private BigDecimal sumLockNum;
    /** 未锁定数量 **/
    private BigDecimal sumNotLockNum;
    /**
     * 库龄(0,20)天
     */
    private BigDecimal inLibraryCount1;
    private BigDecimal inLibraryAmount1;
    /**
     * 库龄[20,60)天
     */
    private BigDecimal inLibraryCount2;
    private BigDecimal inLibraryAmount2;
    /**
     * 库龄[60,+∞)天
     */
    private BigDecimal inLibraryCount3;
    private BigDecimal inLibraryAmount3;
    /**
     * 效期(0,⅓)
     */
    private BigDecimal dateOfExpiryCount1;
    private BigDecimal dateOfExpiryAmount1;
    private BigDecimal dateOfExpirySumAmount1;
    /**
     * 有效期[⅓,½)
     */
    private BigDecimal dateOfExpiryCount2;
    private BigDecimal dateOfExpiryAmount2;
    private BigDecimal dateOfExpirySumAmount2;
    /**
     * 有效期[½,+∞)
     */
    private BigDecimal dateOfExpiryCount3;
    private BigDecimal dateOfExpiryAmount3;
    private BigDecimal dateOfExpirySumAmount3;

    private String dateOfExpiryCount4;
    private String dateOfExpiryAmount4;
}
