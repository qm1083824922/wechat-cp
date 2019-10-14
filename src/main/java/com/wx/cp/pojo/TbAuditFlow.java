package com.wx.cp.pojo;

import com.wx.cp.pojo.base.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

/**
 * <p>
 * 审核流表
 * </p>
 *
 * @author qm
 * @since 2019-07-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class TbAuditFlow extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 审核流编号
     */
    private String auditFlowNo;

    /**
     * 审核流类型
     */
    private Integer auditFlowType;

    /**
     * 审核流名称
     */
    private String auditFlowName;

    /**
     * 待法务审核
     */
    private String lawAudit;

    /**
     * 待商务审核
     */
    private String bizAudit;

    /**
     * 待事业部审核
     */
    private String careerAudit;

    /**
     * 待采购审核
     */
    private String purchaseAudit;

    /**
     * 待供应链小组审核
     */
    private String supplyChainGroupAudit;

    /**
     * 待供应链服务部审核
     */
    private String supplyChainServiceAudit;

    /**
     * 待商品风控审核
     */
    private String goodsRiskAudit;

    /**
     * 待业务审核
     */
    private String busiAudit;

    /**
     * 待财务专员审核
     */
    private String financeAudit;

    /**
     * 待财务主管审核
     */
    private String finance2Audit;

    /**
     * 待风控专员审核
     */
    private String riskSpecialAudit;

    /**
     * 待风控主管审核
     */
    private String riskAudit;

    /**
     * 待部门主管审核
     */
    private String deptManageAudit;

    /**
     * 待总经理审核
     */
    private String bossAudit;

    /**
     * 风控是否首单 0-否 1-是
     */
    private Integer isFirstRisk;

    /**
     * 法务是否首单 0-否 1-是
     */
    private Integer isFirstLaw;

    /**
     * 删除标记 0 : 有效 1 : 删除
     */
    private Integer isDelete;

    /**
     * 创建时间
     */
    private LocalDateTime createAt;

    /**
     * 更新时间
     */
    private LocalDateTime updateAt;


}
