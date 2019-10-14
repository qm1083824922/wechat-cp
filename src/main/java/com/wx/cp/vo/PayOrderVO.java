package com.wx.cp.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author dell
 */
@Data
public class PayOrderVO {
    /** 付款id */
    private Integer id;
    /** 付款编号 */
    private String payNo;
    /** 经营单位id */
    private Integer busiUnitId;
    /** 经营单位 */
    private String busiUnit;
    /** 项目 */
    private String projectName;
    private Integer projectId;
    /** 付款单位 */
    private Integer payer;
    private String payerName;
    /** 付款类型 */
    private String payTypeName;
    private Integer payType;
    /** 付款方式 */
    private String payWayName;
    private Integer payWay;
    /**
     * 付款金额
     */
    private BigDecimal payAmount;
    /** 付款金额 折扣后金额*/
    private String payAmountString;
    /** 收款单位 */
    private String payeeName;
    private Integer payee;
    /** 收款账号ID */
    private Integer payAccountId;
    /** 要求付款日期 */
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date requestPayTime;
    /** 状态 */
    private String state;
    /** 状态 */
    private Integer stateInt;
    /** 确认时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date confirmorAt;
    /** 确认人 */
    private String confirmor;
    /** 付款备注 */
    private String remark;

    /** 开户行 */
    private String bankName;
    /** 收款银行地址 */
    private String bankAddress;
    /** 收款银行开户人 */
    private String subjectName;
    /** 收款银行账号 */
    private String accountNo;
    /** 收款银行代码 */
    private String bankCode;
    /** 银行iban */
    private String iban;
    /** 地址电话 **/
    private String phoneNumber;
    /** 收款余额 **/
    private BigDecimal blance;
    /** 付款订单总额 */
    private BigDecimal poBlance;
    /** 付款费用总额 */
    private BigDecimal feeBlance;
    /** 预收金额 */
    private BigDecimal advanceAmount;
    /** 实际占用 */
    private BigDecimal payAdvanceAmount;
    /** 占用比例 */
    private BigDecimal payAdvanceAmountRate;
    /** 占用比例 */
    private String payAdvanceAmountRateName;
    /** 预收比例 */
    private BigDecimal advanceAmountRate;
    /** 预收比例 */
    private String advanceAmountRateName;
    /** 银行默认币种 */
    private String defaultCurrency;
    /** 银行账号 */
    private Integer paymentAccount;
    private String paymentAccountName;
    /** 银行手续费 */
    private BigDecimal bankCharge;

    /** 项目额度 */
    private BigDecimal projectTotalAmount;
    private BigDecimal projectBalanceAmount;
    private Integer projectAmountUnit;
    private String projectAmountUnitTypeName;

    /** 付款后项目余额 */
    private BigDecimal payProjectBalanceAmount;

    /** 币种 */
    private Integer currnecyType;
    private String currnecyTypeName;
    /** 开立类型 */
    private Integer openType;

    private String businessUnitNameValue;
    /** 经营单位地址 */
    private String businessUnitAddress;
    /** 系统时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date systemTime;
    /** 附属编号 */
    private String attachedNumbe;
    /** 预计内部打款日期 */
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date innerPayDate;
    /** 销售价 */
    private BigDecimal sumSendPrice;
    /** 总利润率 */
    private String sumProfit;
    /** 实际付款金额*/
    private BigDecimal realPayAmount;
    /** 实际付款币种*/
    private Integer realCurrencyType;
    /** 实际付款币种*/
    private String realCurrencyTypeName;
    /** 汇率*/
    private BigDecimal payRate;

    /** 利润*/
    private BigDecimal profit;

    /** 创建人*/
    private String creator;
    /** 创建时间*/
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createAt;
    private String createAtString;
    private Integer printNum;
    /** 批量确认标示符*/
    private String unionOverIdentifier;
    /** 批量打印标示符*/
    private String unionPrintIdentifier;
    private String mergePayNo;
    private BigDecimal discountAmount;
    /** 折扣前金额 */
    private BigDecimal inDiscountAmount;
    private BigDecimal discountRate;
    private String discountRateStr;
    /** 付款支付类型 0-全部 1-预付 2-尾款 */
    private Integer payWayType;
    /** cms付款人*/
    private String cmsPayer;
    /** cms驳回人*/
    private String cmsRejecter;
    /** 原因*/
    private String reason;
    /** 水单时间*/
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date memoTime;
    /** 是否无订单 0-否 1-是 */
    private Integer noneOrderFlag;
    private String noneOrderFlagName;
    /** 是否核销 0-未核销 1-已核销 */
    private Integer writeOffFlag;
    private String writeOffFlagName;
    private BigDecimal checkAmount;
    /** 可核销金额*/
    private BigDecimal leftCheckAmount;

    private String totalGrossRate;

}
