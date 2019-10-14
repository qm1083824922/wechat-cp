package com.wx.cp.api;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    /**
     * ID
     */
    private Integer id;
    /**
     * 价格
     */
    private BigDecimal price;
    /**
     * 数量
     */
    private Integer num;
}
