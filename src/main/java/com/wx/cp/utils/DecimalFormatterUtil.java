package com.wx.cp.utils;

import java.math.BigDecimal;
import java.text.DecimalFormat;

public class DecimalFormatterUtil {

    public String decimalFormat(BigDecimal money){
        DecimalFormat df1 = new DecimalFormat("###,###.##");
        return df1.format(money);
    }
}
