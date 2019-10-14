package com.wx.cp.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author dell
 */
@Getter
@Setter
@ToString
public class PayPoRelationVO {
	/** 付款订单关系id */
	private Integer id;
	/** 付款id **/
	private Integer payId;
	/** 订单id **/
	private Integer poId;
	/** 本次付款金额 **/
	private BigDecimal payAmount;

    /**销售金额*/
    private BigDecimal saleAmount;
    /**毛利*/
    private BigDecimal grossProfitRate;

    /**毛利率*/
    private String grossProfitRateStr;

    /**国际码*/
	private String barCode;

    /**商品单位*/
	private String unit;

	/** 订单编号 */
	private String orderNo;
	/** 附属编号 */
	private String appendNo;
	/** 订单日期 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date orderTime;
	/** 预计到货日期 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date perdictTime;
	/** 订单总数量 */
	private BigDecimal orderTotalNum;
	/** 订单总金额 */
	private BigDecimal orderTotalAmount;
	/** 订单明细收票金额 */
	private BigDecimal invoiceAmount;
	/** 订单明细到货金额 */
	private BigDecimal arrivalAmount;
	/** 订单明细已付款金额 */
	private BigDecimal paidAmount;
	/** 可付款金额 (总额金额-已付+付款金额) */
	private BigDecimal paymentAmount;
	private Integer currencyId;
	private BigDecimal goodsNum;
	/**商品总数量*/
	private Integer totalGoodsNum;
	private BigDecimal goodsPrice;
    /**
     * 采购价总金额
     */
	private BigDecimal totalGoodsPrice;
	private BigDecimal goodsAmount;
	private String currencyName;

	/** 商品编码 */
	private String goodsNo;

	/** 商品名称 */
	private String goodsName;

	/** 质押比例 */
	private BigDecimal pledge;

	/** 销售价 */
	private BigDecimal requiredSendPrice;
    /**
     * 销售价总金额
     */
	private BigDecimal totalSalePrice;

	/** 利润率 */
	private BigDecimal profitMargin;
	private String payNo;
	private BigDecimal discountAmount;
	/** 折扣前金额*/
	private BigDecimal inDiscountAmount;
	private BigDecimal discountRate;
	private String discountRateStr;
	/** 核销状态 0-未核销 1-已核销*/
	private Integer writeOffFlag;
	private String writeOffFlagName;

}
