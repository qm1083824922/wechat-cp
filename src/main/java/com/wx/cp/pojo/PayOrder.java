package com.wx.cp.pojo;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class PayOrder{
    /** 主键ID */
    private Integer id;
    /** 创建人id */
    private Integer creatorId;
    /** 创建人 */
    private String creator;
    /** 创建时间 */
    private Date createAt;
    /** 删除人 */
    private String deleter;
    /** 删除人id */
    private Integer deleterId;
    /** 删除时间 */
    private Date deleteAt;
    /** 逻辑删除 */
    private Integer isDelete;
    /** 更新时间 */
    private Date updateAt;
	/** 付款编号 **/
	private String payNo;
	/** 付款类型 1 订单货款 2 费用 3 借款 4 保证金 **/
	private Integer payType;
	/** 项目ID **/
	private Integer projectId;
	/** 经营单位 **/
	private Integer busiUnit;
	/** 付款单位 **/
	private Integer payer;
	/** 付款方式 **/
	private Integer payWay;
	/** 付款金额 **/
	private BigDecimal payAmount; // 折扣后金额
	/** 收款单位 **/
	private Integer payee;
	/** 收款账号ID **/
	private Integer payAccountId;
	/** 要求付款日期 **/
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date requestPayTime;
	/** 备注 **/
	private String remark;
	/** 状态状态 0 待提交 1待业务审核 2待财务审核 3待风控审核 4待确认 5待开立 6已完成 **/
	private Integer state;

	/** 确认人 **/
	private String confirmor;
	/** 确认人id **/
	private Integer confirmorId;
	/** 确认时间 **/
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date confirmorAt;
	/** 收款余额 **/
	private BigDecimal blance;
	/** 付款订单总额 **/
	private BigDecimal poBlance;
	/** 付款费用总额 **/
	private BigDecimal feeBlance;
	/** 银行账号 **/
	private Integer paymentAccount;
	/** 银行手续费 **/
	private BigDecimal bankCharge;
	/** 币种 **/
	private Integer currnecyType;
	/** 开立类型 **/
	private Integer openType;
	/** 预收总额 **/
	private BigDecimal advanceAmount;
	/** 抵扣费用总额 **/
	private BigDecimal deductionFeeAmount;
	/** 附属编号 **/
	private String attachedNumbe;
	/** 预计内部打款日期 **/
	private Date innerPayDate;
	/** 实际付款金额 **/
	private BigDecimal realPayAmount;
	/** 实际付款币种 **/
	private Integer realCurrencyType;
	/** 汇率 **/
	private BigDecimal payRate;
	/** 打印次数 **/
	private Integer printNum;
	/** 批量确认标示符 **/
	private String unionOverIdentifier;
	/** 批量打印标示符 **/
	private String unionPrintIdentifier;
	/** 合并付款编号 **/
	private String mergePayNo;
	private BigDecimal discountAmount;
	private BigDecimal inDiscountAmount; // 折扣前金额
	/** 付款支付类型 0-全部 1-预付 2-尾款 **/
	private Integer payWayType;
	/** cms付款人 **/
	private String cmsPayer;
	/** cms驳回人 **/
	private String cmsRejecter;
	/** 原因 **/
	private String reason;

	/** 水单日期 **/
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date memoTime;

	/** 是否无订单 0-否 1-是 */
	private Integer noneOrderFlag;
	/** 是否核销 0-未核销 1-已核销 */
	private Integer writeOffFlag;
	private BigDecimal checkAmount;
}
