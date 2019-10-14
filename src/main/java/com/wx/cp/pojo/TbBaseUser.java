package com.wx.cp.pojo;

import com.wx.cp.pojo.base.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

/**
 * <p>
 * 用户表
 * </p>
 *
 * @author qm
 * @since 2019-08-21
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class TbBaseUser extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 工号
     */
    private String employeeNumber;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 密码
     */
    private String password;

    /**
     * 中文名
     */
    private String chineseName;

    /**
     * 英文名
     */
    private String englishName;

    /**
     * 手机
     */
    private String mobilePhone;

    /**
     * 邮箱
     */
    private String email;

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
     * 类型
     */
    private Integer type;

    private Long creatorId;

    /**
     * RTX号码
     */
    private String rtxCode;

    /**
     * 用户类别
     */
    private Integer userProperty;

    /**
     * 部门id
     */
    private Long departmentId;

    /**
     * 企业微信用户身份标识
     */
    private String openid;


}
