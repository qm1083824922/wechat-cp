package com.wx.cp.vo;

import io.swagger.annotations.ApiModelProperty;
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
    @ApiModelProperty(value = "审核人ID")
    private Integer auditId;
    @ApiModelProperty(value = "项目ID")
    private Integer projectItemId;
    @ApiModelProperty(value = "审核意见")
    private String suggestion;
    @ApiModelProperty(value = "微信唯一标识")
    private String openid;
    @ApiModelProperty(value = "付款ID")
    private String payId;
    @ApiModelProperty(value = "审核操作")
    private int operation;
    @ApiModelProperty(value = "状态")
    private Integer state;
    @ApiModelProperty(value = "用户ID")
    private Integer userId;
    @ApiModelProperty(value = "poId")
    private Integer poId;
    @ApiModelProperty(value = "单据类型")
    private Integer poType;
    private Integer projectId;
}
