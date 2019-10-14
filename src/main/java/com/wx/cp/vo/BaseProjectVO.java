package com.wx.cp.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class BaseProjectVO {
    private Integer id;
    private Object creatorId;
    private String creator;
    private String createAt;
    private Object deleter;
    private Object deleterId;
    private Object deleteAt;
    private Integer isDelete;
    private String updateAt;
    private String projectNo;
    private String projectNoType;
    private String projectName;
    private String fullName;
    private Integer financeSpecialId;
    private Integer businessUnitId;
    private BigDecimal totalAmount;
    private Integer amountUnit;
    private Integer bizType;
    private Integer lawId;
    private Integer bizManagerId;
    private Integer businessManagerId;
    private Integer financeManagerId;
    private Integer riskSpecialId;
    private Integer riskManagerId;
    private Integer industrial;
    private Integer status;
    private Integer departmentId;
    private Integer bizSpecialId;
    private Integer departmentManagerId;
    private Integer bossId;
    private Integer salesmanId;
    private String salesman;
    private String noName;
}
