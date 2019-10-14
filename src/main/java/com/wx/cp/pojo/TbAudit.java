package com.wx.cp.pojo;

import com.wx.cp.pojo.base.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 审核表
 * </p>
 *
 * @author qm
 * @since 2019-07-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class TbAudit extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 单据ID
     */
    private Integer poId;

    /**
     * 单据类型
     */
    private Integer poType;

    /**
     * 单据日期
     */
    private LocalDateTime poDate;

    /**
     * 审核类型：1正常，2转交，3加签
     */
    private Integer auditType;

    /**
     * 单据编号
     */
    private String poNo;

    /**
     * 经营单位ID
     */
    private Integer businessUnitId;

    /**
     * 项目ID
     */
    private Integer projectId;

    /**
     * 供应商ID
     */
    private Integer supplierId;

    /**
     * 客户ID
     */
    private Integer customerId;

    /**
     * 币种
     */
    private Integer currencyId;

    /**
     * 金额
     */
    private BigDecimal amount;

    /**
     * 当前审核人ID
     */
    private Integer auditorId;

    /**
     * 当前审核人
     */
    private String auditor;

    /**
     * 审核通过人ID
     */
    private Integer auditorPassId;

    /**
     * 审核通过人
     */
    private String auditorPass;

    /**
     * 审核通过时间
     */
    private LocalDateTime auditorPassAt;

    /**
     * 订单状态
     */
    private Integer state;

    /**
     * 申请人ID
     */
    private Integer proposerId;

    /**
     * 申请人
     */
    private String proposer;

    /**
     * 申请时间
     */
    private LocalDateTime proposerAt;

    /**
     * 创建人ID
     */
    private Integer creatorId;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 创建时间
     */
    private LocalDateTime createAt;

    /**
     * 审核状态
     */
    private Integer auditState;

    /**
     * 审核意见
     */
    private String suggestion;

    /**
     * 是否删除
     */
    private Integer isDelete;

    /**
     * 转交或加签给当前审核人ID的原始审核数据的ID
     */
    private Integer pauditId;

    /**
     * 转交或加签给当前审核人ID的ID
     */
    private Integer pauditorId;

    /**
     * 转交或加签给当前审核人的人
     */
    private String pauditor;


}
