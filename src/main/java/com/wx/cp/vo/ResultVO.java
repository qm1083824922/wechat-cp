package com.wx.cp.vo;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author dell
 */
@Getter
@Setter
public class ResultVO<T> {

    private String msg;
    private String redirectURL;
    private String successMsg;
    private Integer total;
    private Integer currentPage;
    private Integer perPage;
    private Integer lastPage;
    private BigDecimal totalAmount;
    private Integer totalNum;
    private BigDecimal feeTotalAmount;
    private BigDecimal exRateTotalAmount;
    private BigDecimal rateTotalAmount;
    private String totalStr;
    private String footer;
    private Boolean success;
    private Boolean login;
    private Boolean permission;
    private List<T> items;
}
