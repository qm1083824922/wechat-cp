package com.wx.cp.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.wx.cp.constants.URLConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class HttpUtil {

    @Autowired
    private RestTemplate restTemplate;

    public String postByDefault(Object object, String url) {

        JSONObject jsonObj = (JSONObject) JSONObject.toJSON(object);
        //设置请求头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
        headers.add(URLConstant.HEADER_NAME, MediaType.APPLICATION_JSON.toString());

        //请求体
        HttpEntity<String> formEntity = new HttpEntity<>(jsonObj.toString(), headers);

        //发起请求
        return restTemplate.postForObject(url, formEntity, String.class);

        //将Json字符串解析成对象
        //Object object1 = JSON.parseObject(response, new TypeReference<Object>() {
        //});
    }
}
