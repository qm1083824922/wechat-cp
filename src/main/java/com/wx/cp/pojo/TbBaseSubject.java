package com.wx.cp.pojo;

import com.wx.cp.pojo.base.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 经营单位、仓库、供应商、客户基本信息
 * </p>
 *
 * @author qm
 * @since 2019-07-17
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class TbBaseSubject extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 1:经营单位; 2:仓库; 4:供应商; 8:客户
     */
    private Integer subjectType;

    /**
     * 主类型编号
     */
    private String subjectNo;

    /**
     * 简称
     */
    private String abbreviation;

    /**
     * 中文全称
     */
    private String chineseName;

    /**
     * 英文全称
     */
    private String englishName;

    /**
     * 注册地
     */
    private String regPlace;

    /**
     * 注册号
     */
    private String regNo;

    /**
     * 注册电话
     */
    private String regPhone;

    /**
     * 办公地址
     */
    private String officeAddress;

    /**
     * 1:已有供应商 2:新建供应商
     */
    private Integer supplierType;

    /**
     * OMS供应商编号
     */
    private String omsSupplierNo;

    private Integer nation;

    /**
     * 1:自营仓 2:客户仓 3:虚拟仓   当实体类型为仓库时不能为空
     */
    private Integer warehouseType;

    /**
     * 当实体类型为仓库时不能为空
     */
    private String warehouseNo;

    /**
     * 1 : 已有客户 2 : 新增客户  当实体类型为客户时不能为空
     */
    private Integer custType;

    /**
     * 当客户类型为已有客户时不能为空
     */
    private String pmsCustNo;

    /**
     * 1: 待提交 2: 已完成 3: 已锁定
     */
    private Integer state;

    /**
     * 创建人
     */
    private String creator;

    /**
     * 作废人
     */
    private String deleter;

    /**
     * 锁定人
     */
    private String lockedBy;

    /**
     * 创建时间
     */
    private LocalDateTime createAt;

    /**
     * 作废时间
     */
    private LocalDateTime deleteAt;

    /**
     * 锁定时间
     */
    private LocalDateTime lockAt;

    /**
     * 修改时间
     */
    private LocalDateTime updateAt;

    /**
     * 0 : 有效 1 : 删除
     */
    private Integer isDelete;

    /**
     * 公司法人编号
     */
    private String businessUnitCode;

    /**
     * pms结算对象(供应商编码)
     */
    private String pmsSupplierCode;

    /**
     * 开票限额 千;万;十万;百万;千万
     */
    private BigDecimal invoiceQuotaType;

    /**
     * 财务主管
     */
    private Long financeManagerId;

    /**
     * 部门主管
     */
    private Long departmentManagerId;


}
