package com.wx.cp.dto;

import lombok.Data;

import java.math.BigDecimal;

/**
 *
 */
@Data
public class StockReportDTO {
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
	/** 业务员 **/
	private Integer bizManagerId;
	/** 部门 **/
	private Integer departmentId;
	/** 合计总库存 **/
	private BigDecimal sumStore;
	/** 商品编号 **/
	private String goodsNumber;
    private Integer userId;
    private boolean wechatFlag;
    private String openid;
    /**第几页*/
    private int page = 0;
    /**每页显示数目*/
    private int per_page = 15;
}
