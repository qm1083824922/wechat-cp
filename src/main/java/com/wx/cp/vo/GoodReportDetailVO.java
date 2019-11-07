package com.wx.cp.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class GoodReportDetailVO {
    private Integer userId;
    private Integer projectId;
    private Integer goodsId;
    private Integer busiUnitId;
    /**
     * 项目名称
     */
    private String projectName;
    /**
     * 经验单位
     */
    private String businessUnitName;
    /**
     * 商品品牌
     */
    private String brand;
    /**
     * 善品名称
     */
    private String goodName;
    /**
     * 商品分类
     */
    private String goodsType;
    /**
     * 商品规格
     */
    private String specification;
    /**
     * 商品编码
     */
    private String number;
    /**
     * 善品国际码
     */
    private String barCode;
    /**
     * 期初数量
     */
    private BigDecimal initialNum;
    /**
     * 期初金额
     */
    private BigDecimal initialAmount;
    /**
     * 期初金额未税
     */
    private BigDecimal initialTaxRateAmount;
    /**
     * 期末金额
     */
    private BigDecimal endNum;
    /**
     *期末金额
     */
    private BigDecimal endAmount;
    /**
     *期末金额未税
     */
    private BigDecimal endTaxRateAmount;
    /**
     *本期入库数量
     */
    private BigDecimal currentInNum;
    /**
     *本期入库金额
     */
    private BigDecimal currentInAmount;
    /**
     *本期入库金额未税
     */
    private BigDecimal currentInTaxRateAmount;
    /**
     *本期其他入库数量
     */
    private BigDecimal currentOtherInNum;
    /**
     *本期其他入库金额
     */
    private BigDecimal currentOtherInAmount;
    /**
     *本期出库数量
     */
    private BigDecimal currentOutNum;
    /**
     *本期出库金额
     */
    private BigDecimal currentOutAmount;
    /**
     *本期出库金额未税
     */
    private BigDecimal currentOutTaxRateAmount;
    /**
     *本期其他出库数量
     */
    private BigDecimal currentOtherOutNum;
    /**
     *本期其他出库金额
     */
    private BigDecimal currentOtherOutAmount;
    /**
     *销售数量
     */
    private BigDecimal saleNum;
    /**
     *销售金额
     */
    private BigDecimal saleAmount;
}
