package com.wx.cp.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;

@Getter
@Setter
@ToString
public class OrderVO {
    private Integer id ;
    private Integer poId ;
    private Integer poNo ;
    private String poDate ;
    private Integer proposerId ;
    private String proposer ;
    private String proposerAt ;
    private Integer auditorId ;
    private String auditor ;
    private Integer currencyId ;
    private String currencyName ;
    private BigDecimal amount ;
    private Integer businessUnitId ;
    private Integer projectId ;
    private Integer supplierId ;
    private Integer state ;
    private String businessUnitName ;
    private String projectName ;
    private String supplierName ;
    private String customerName ;
    private String poTypeName ;
    private String stateName ;
    private String proposerDayTime ;
    private Boolean warn ;

}
