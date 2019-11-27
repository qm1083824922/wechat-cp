package com.wx.cp.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;

@Getter
@Setter
@ToString
public class AuditResponseVO {

    private Integer id;

    private Integer poId;

    /** 单据类型*/
    private Integer poType;

    /** 单据编号 */
    private String poNo;

    /** 单据日期 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date poDate;

    /** 申请人 */
    private Integer proposerId;

    /** 申请人 */
    private String proposer;

    /** 申请时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime proposerDate;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime auditorPassAt;

    /** 当前审核人 */
    private Integer auditorId;

    /** 当前审核人 */
    private String auditor;

    /** 币种 **/
    private Integer currencyId;
    private String currencyName;

    /** 金额 */
    private BigDecimal amount;

    /** 经营单位ID */
    private Integer businessUnitId;
    /** 项目ID */
    private Integer projectId;
    /** 供应商ID */
    private Integer supplierId;
    /** 客户ID */
    private Integer customerId;
    /** 状态 */
    private Integer state;

    /** 经营单位 */
    private String businessUnitName;

    /** 项目 */
    private String projectName;

    /** 供应商 */
    private String supplierName;

    /** 客户 */
    private String customerName;

    /** 单据类型 */
    private String poTypeName;

    /** 状态 */
    private String stateName;
    /** 截止到目前的申请时间（天数，小时数） */
    private String proposerDayTime;
    /** 是否标红 */
    private boolean Warn;
}
