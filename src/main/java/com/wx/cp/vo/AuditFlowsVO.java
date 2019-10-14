package com.wx.cp.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class AuditFlowsVO {
    /** id */
    private Integer id;

    private Integer projectId;

    /** 单据类型 */
    private Integer poType;

    /** 状态 */
    private Integer state;
    /** 状态名称 */
    private String stateName;

    /** 节点状态 */
    private Integer auditState;
    /** 节点状态名称 */
    private String auditStateName;

    /** 处理人 */
    private String dealName;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    /** 处理时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date dealTime;

    /** 建议 */
    private String suggestion;

    /** 节点类型 */
    private Integer auditType;

    /** 节点 */
    private Integer pauditId;

    private String backcolor;

    private String fontcolor;

    /**
     * 经营单位
     */
    private Integer busiUnit;
}
