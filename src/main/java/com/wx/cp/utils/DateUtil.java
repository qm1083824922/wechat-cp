package com.wx.cp.utils;

import com.wx.cp.vo.DateVO;

import java.time.LocalDate;
import java.time.Month;

public class DateUtil {
    /**
     * 获取月初日期到当前日期
     * @return
     */
    public static DateVO getMonthStartAndEndDate() {
        DateVO dateVO = new DateVO();
        LocalDate now = LocalDate.now();
        int year = now.getYear();
        int days = now.lengthOfMonth();
        Month month = now.getMonth();
        int nowMonth = now.getMonth().getValue();
        switch (month) {
            case JANUARY:
            case DECEMBER:
            case FEBRUARY:
            case MARCH:
            case APRIL:
            case MAY:
            case JUNE:
            case JULY:
            case AUGUST:
            case SEPTEMBER:
            case OCTOBER:
            case NOVEMBER: {
                dateVO.setStartDate(year + "-" + nowMonth + "-01");
                dateVO.setEndDate(now.toString());
                return dateVO;
            }
        }
        return null;
    }
}
