package com.wx.cp.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author dell
 */
@Getter
@Setter
@ToString
public class PayAdvanceRelationVO {
	/** 付款订单关系id*/
	private Integer id;
	/** 付款id*/
	private Integer payId;
	/** 预收id 关联预收定金类型水单*/
	private Integer advanceId;
	/** 金额*/
	private BigDecimal payAmount;
	/** 已付款金额 */
	private BigDecimal paidAmount;
	/** 余额 = 预收总额 - 已付款金额 */
	private BigDecimal blance;
	/** 项目名称 **/
	private String projectName;
	/** 经营单位 **/
	private String busiUnit;
	/** 客户名称 **/
	private String custName;
	/** 币种 **/
	private Integer currencyType;
	private String currencyTypeName;
	private String payNo;
	/** 水单日期 **/
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")	private Date receiptDate;
}
