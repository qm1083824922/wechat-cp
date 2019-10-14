package com.wx.cp.constants;

/**
 * redis常量
 * Created by qm
 * 2017-08-20 16:22
 */
public interface RedisConstant {

    String TOKEN_PREFIX = "token_%s";
    /**
     *2小时
     */
    Integer EXPIRE = 7200;

    Integer TOKEN_EXPIRE = 2592000;
}
