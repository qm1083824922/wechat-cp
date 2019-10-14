package com.wx.cp.pojo;

import com.wx.cp.pojo.base.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 项目表
 * </p>
 *
 * @author qm
 * @since 2019-07-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class TbBaseProject extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    private String projectNo;

    /**
     * 项目名称（简称）
     */
    private String projectName;

    /**
     * 全称
     */
    private String fullName;

    /**
     * 经营单位
     */
    private Long businessUnitId;

    /**
     * 额度总额
     */
    private BigDecimal totalAmount;

    /**
     * 额度币种
     */
    private Integer amountUnit;

    /**
     * 业务类别
     */
    private String bizType;

    /**
     * 法务主管
     */
    private Long lawId;

    /**
     * 业务专员
     */
    private Long bizSpecialId;

    /**
     * 业务主管
     */
    private Long bizManagerId;

    /**
     * 商务主管
     */
    private Long businessManagerId;

    /**
     * 财务主管
     */
    private Long financeManagerId;

    /**
     * 风控专员
     */
    private Long riskSpecialId;

    /**
     * 风控主管
     */
    private Long riskManagerId;

    /**
     * 状态
     */
    private Integer status;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 作废人
     */
    private String deleter;

    /**
     * 创建时间
     */
    private LocalDateTime createAt;

    /**
     * 修改时间
     */
    private LocalDateTime updateAt;

    /**
     * 作废时间
     */
    private LocalDateTime deleteAt;

    /**
     * 删除标记
     */
    private Integer isDelete;

    /**
     * 行业
     */
    private Integer industrial;

    /**
     * 项目编号类型
     */
    private String projectNoType;

    /**
     * 财务专员
     */
    private Long financeSpecialId;

    /**
     * 部门id
     */
    private Long departmentId;

    /**
     * 是否质押 0-否 1-是
     */
    private Integer isPledge;

    /**
     * 部门主管
     */
    private Long departmentManagerId;

    /**
     * 总经理
     */
    private byte[] bossId;


}
