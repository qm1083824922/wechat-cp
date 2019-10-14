package com.wx.cp.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * @author dell
 */

@Getter
@NoArgsConstructor
@AllArgsConstructor
public enum  CodeEnum {
    /**
     *
     */
    PURCHASE_ORDER(0, "采购订单"),
    PAY_ORDER(1, "付款"),
    ;

    private Integer code;

    private String message;


}

