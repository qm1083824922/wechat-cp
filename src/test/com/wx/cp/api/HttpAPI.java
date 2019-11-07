package com.wx.cp.api;
import org.junit.Test;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.List;

public class HttpAPI {

    @Test
    public void test() {
        LocalDate now = LocalDate.now();
        now.getMonth().toString();
        //判断当前年份是平年还是闰年
        int i = now.lengthOfMonth();
        System.out.println(i);
        Month month = now.getMonth();
        if (now.isLeapYear()) {
            System.out.println("111");
        }
        System.out.println(now.getMonth());
        System.out.println(now.toString());
        System.out.println(now.minusDays(1));
        System.out.println(now.minusMonths(1));
//        CurrentMonth date = getDate(now.getMonth());
//        System.out.println(date);
        System.out.println(now.plusDays(9));
        CurrentDateTime date = getDay();
        System.out.println(date);

        CurrentDateTime currentWeek = getCurrentWeek();
        System.out.println(currentWeek);
    }

    public CurrentDateTime getMonthStartAndEndDate() {
        CurrentDateTime currentDateTime = new CurrentDateTime();
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
                currentDateTime.setStartDate(year + "-" + nowMonth + "-01");
                currentDateTime.setEndDate(now.toString());
                return currentDateTime;
            }
        }
        return null;
    }

    public CurrentDateTime getDay(){
        LocalDate now = LocalDate.now();
        CurrentDateTime currentDateTime = new CurrentDateTime();
        currentDateTime.setStartDate(now.minusDays(1).toString());
        currentDateTime.setEndDate(now.toString());
        return currentDateTime;
    }

    public CurrentDateTime getCurrentWeek(){
        LocalDate now = LocalDate.now();
        CurrentDateTime currentDateTime = new CurrentDateTime();
        currentDateTime.setStartDate(now.minusDays(6).toString());
        currentDateTime.setEndDate(now.toString());
        return currentDateTime;
    }

    @Test
    public void test1(){
        LocalDate now = LocalDate.now();
        String strDate = "2019-07-31";
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startDate = LocalDate.parse(strDate, dateTimeFormatter);
        long period = now.toEpochDay() - startDate.toEpochDay();
        System.out.println(now.plusDays(120));
        System.out.println(period);

        BigDecimal bigDecimal = new BigDecimal("-1");
        BigDecimal bigDecima1l = new BigDecimal("0");
        BigDecimal bigDecimal2 = new BigDecimal("1");
        int i1 = bigDecimal.compareTo(BigDecimal.ZERO);
        int i2 = bigDecima1l.compareTo(BigDecimal.ZERO);
        int i3 = bigDecimal2.compareTo(BigDecimal.ZERO);
        System.out.println(i1);
        System.out.println(i2);
        System.out.println(i3);
    }

    @Test
    public void test2(){
        List<Product> productList = new ArrayList<>();
        productList.add(new Product(1, new BigDecimal(60), 50));
        productList.add(new Product(2, new BigDecimal(70), 30));
        productList.add(new Product(3, new BigDecimal(80), 10));
        productList.add(new Product(4, new BigDecimal(75), 55));
        productList.add(new Product(5, new BigDecimal(30), 70));
        productList.add(new Product(5, new BigDecimal(75), 60));
        //按照价格从小到大排序，如果价格相等，则按照剩余数量从小到大排序
        productList.sort((o1, o2) -> {
            if (o1.getPrice().compareTo(o2.getPrice()) == 0) {
                if (o1.getNum() >= o2.getNum()) {
                    return 1;
                }
                return -1;
            }
            return o1.getPrice().compareTo(o2.getPrice());
        });
        for (Product product : productList) {
            System.out.println(product.toString());
        }

        BigDecimal bigDecimal = new BigDecimal("1.00");
        System.out.println(bigDecimal.toString());

    }

    @Test
    public void testMoney(){
        BigDecimal bigDecimal = new BigDecimal("0.130266");
        BigDecimal bigDecimal1 = new BigDecimal("2422198");
        BigDecimal bigDecimal2 = bigDecimal1.divide(bigDecimal,2,RoundingMode.HALF_UP);
        System.out.println(bigDecimal2);
        LocalDateTime date = LocalDateTime.now();
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime firstday = date.with(TemporalAdjusters.firstDayOfMonth());
        System.out.println(firstday.format(dateTimeFormatter));
        LocalDateTime lastDay = date.with(TemporalAdjusters.lastDayOfMonth());
        CurrentDateTime date1 = getMonthStartAndEndDate();
        System.out.println(date1.getStartDate());
        System.out.println(date1.getEndDate());
        System.out.println(lastDay.format(dateTimeFormatter));

        CurrentDateTime currentDateTime = new CurrentDateTime();
        boolean wechatFlag = currentDateTime.isIswechatFlag();
        System.out.println(wechatFlag);
    }

    @Test
    public void testString(){
        String  str = "农夫|迪奥|魅可";
        String[] split = str.split("\\|");
//        for (String s : split) {
//            System.out.println(s);
//        }
        StringBuilder stringBuilder = new StringBuilder();
        for (String st : split) {
            stringBuilder.append("'");
            stringBuilder.append(st);
            stringBuilder.append("',");
        }
        String substring=stringBuilder.toString();
        substring=substring.substring(0,substring.lastIndexOf(","));
        System.out.println("substring = "+substring);
//        System.out.println(testStr1(str));
//        List<String> strList = new ArrayList<>();
//        strList.add("111");
//        strList.add("222");
//        strList.add("333");
//        ArrayList<Object> objects = new ArrayList<>(strList);
//        for (Object object : objects) {
//            System.out.println(object);
//        }
    }

    public boolean testStr1(String str){
        return str.contains("|");
    }


}
