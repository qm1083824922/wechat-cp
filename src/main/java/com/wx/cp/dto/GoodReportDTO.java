package com.wx.cp.dto;

import lombok.Data;

@Data
public class GoodReportDTO {
    /** id **/
    private Integer id;
    /** 项目 **/
    private Integer projectId;
    /** 经营单位 **/
    private Integer businessUnitId;
    /** 客户 **/
    private Integer customerId;
    /** 仓库 **/
    private Integer warehouseId;
    /** 统计维度 **/
    private Integer statisticsDimensionType;
    /** 部门 **/
    private Integer departmentId;
    /** 商品编号 **/
    private String goodsNumber;
    /** 日期开始时间 */
    private String startBusinessDate;
    /** 日期结束时间 */
    private String endBusinessDate;
    private Integer userId;
    private boolean wechatFlag;
    private String openid;
}
