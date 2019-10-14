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
public class PayFeeRelationVO {
	/** 付款费用关系id*/
	private Integer id;
	/** 付款ID(tb_pay_order[id])*/
	private Integer payId;
	/** 费用ID */
	private Integer feeId;
	/** 付款金额 */
	private BigDecimal payAmount;
	/** 费用编号 */
	private String feeNo;
	/** 费用类型 */
	private Integer feeType;
	private String feeTypeName;
	/** 费用日期 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date payDate;
	/** 费用金额 */
	private BigDecimal expPayAmount;
	/** 收票金额 */
	private BigDecimal acceptInvoiceAmount;
	/** 已付款金额 */
	private BigDecimal oldPayAmount;
	/** 可付款金额 (总额金额-已付+付款金额) */
	private BigDecimal paymentAmount;
	private String payNo;
	/** 核销状态 0-未核销 1-已核销 */
	private Integer writeOffFlag;
	private String writeOffFlagName;
}
