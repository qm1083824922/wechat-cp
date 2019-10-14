package com.wx.cp.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author dell
 */
@Getter
@Setter
@ToString
public class AuditVO{

    private Integer auditId;
    private Integer projectItemId;
    private String suggestion;
    private String openid;
    private String payId;
    private int operation;
    private Integer state;
    private Integer userId;
    private Integer poType;


}
