package com.wx.cp.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class PurchaseOrderVO {
        private String orderNo;
        private String projectName;
        private String supplierName;
        private String warehouseName;
        private String customerName;
        private LocalDate orderTime;
        private LocalDate perdictTime;
        private BigDecimal orderTotalNum;
        private BigDecimal orderTotalAmount;

}
