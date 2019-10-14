package com.wx.cp.utils;

import com.wx.cp.constants.CookieConstant;
import com.wx.cp.constants.RedisConstant;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
public class TokenUtil {

    @Autowired
    private StringRedisTemplate redisTemplate;

    public void setToken(String openid, HttpServletResponse response) {
        //2. 设置token至redis
        String token = UUIDUtil.getUUID();
        Integer expire = RedisConstant.TOKEN_EXPIRE ;
        log.info("redisTemplate={}",redisTemplate);
        redisTemplate.opsForValue().set(String.format(RedisConstant.TOKEN_PREFIX, token), openid, expire, TimeUnit.SECONDS);
        //3. 设置token至cookie
        CookieUtil.set(response, CookieConstant.TOKEN, token, expire);
    }

    public  String getToken(HttpServletRequest request) {
        //查询cookie
        Cookie cookie = CookieUtil.get(request, CookieConstant.TOKEN);
        if (cookie == null) {
            log.warn("【登录校验】Cookie中查不到token");
        }

        //去redis里查询
        String token = null;
        if (cookie != null) {
            token = redisTemplate.opsForValue().get(String.format(RedisConstant.TOKEN_PREFIX, cookie.getValue()));
        }
        System.out.println(token);
        return token;
    }


}
