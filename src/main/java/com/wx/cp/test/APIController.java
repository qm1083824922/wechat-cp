package com.wx.cp.test;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import org.springframework.http.*;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/wechat/api")
@RestController
public class APIController {

    @RequestMapping("/get")
    public String getForObject (String url){
        RestTemplate restTemplate = getRestTemplate();
        //HttpHeaders实现了MultiValueMap接口
        HttpHeaders httpHeaders = new HttpHeaders();
        //给请求头header添加数据
        MediaType type = MediaType.parseMediaType("application/json; charset=UTF-8");
        httpHeaders.setContentType(type);
        httpHeaders.add("Accept", MediaType.APPLICATION_JSON.toString());
        //请求体的类型任意即可，只要保证请求体的类型与HttpEntity泛型保持一致
        Gson gson = new Gson();
        //字符数据最好encoding一下，某些字符才能传过去（如flag参数值是“&”&，不进行encoding不能传递）
        StringBuilder paramsURL = new StringBuilder(url);
        //拼接需要传递的参数
//        paramsURL.append("?");

        GoodsDtl goodsDtl = new GoodsDtl();
        goodsDtl.setCostPrice(10);
        goodsDtl.setStockQty(200);
        goodsDtl.setGoodsID(22);
        DataList dataList = new DataList();
        dataList.setAgentContractNO("600022001");
        dataList.setAgentID(22);
        dataList.setWarehouseNO("002");
        dataList.setGoodsDtl(goodsDtl);
        Data data = new Data();
        data.setDataList(dataList);

        String dataStr = JSON.toJSONString(data);
        Map<String,String> map = new HashMap<>();//建立简单的String，String的map
        map.put("ServerTypeID", "3");
        map.put("ServerID", "ThirdAgentOnStockAdd");
        map.put("AppID", "201909230001");
        map.put("timestamp", "1569296276045");
        map.put("sign", "EB0B3BEA3E1CE5EBD741DD9CC72928B6");
        map.put("data", dataStr);
        HttpEntity<Map<String,String>> httpEntity = new HttpEntity<>(map, httpHeaders);

        //此处泛型对应响应体数据类型，这里指定响应体数据类型为String
        ResponseEntity<String> response = restTemplate.exchange(paramsURL.toString(), HttpMethod.POST, httpEntity, String.class);
        //响应体
        if (response.hasBody()){
            return response.getBody();
        }
        return "";
    }

    public String postForObject (Object object, String url){
        RestTemplate restTemplate = getRestTemplate();
        HttpEntity<String> httpEntity = getStringHttpEntity(object);
        //此处泛型对应响应体数据类型，这里指定响应体数据类型为String
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
        //响应体
        if (response.hasBody()){
            return response.getBody();
        }
        return "";
    }

    private HttpEntity<String> getStringHttpEntity(Object object) {
        //HttpHeaders实现了MultiValueMap接口
        HttpHeaders httpHeaders = new HttpHeaders();
        //给请求头header添加数据
        MediaType type = MediaType.parseMediaType("application/json; charset=UTF-8");
        httpHeaders.setContentType(type);
        httpHeaders.add("Accept", MediaType.APPLICATION_JSON.toString());
        //请求体的类型任意即可，只要保证请求体的类型与HttpEntity泛型保持一致
        Gson gson = new Gson();
        return new HttpEntity<>(gson.toJson(object), httpHeaders);
    }

    private RestTemplate getRestTemplate() {
        RestTemplate restTemplate = new RestTemplate(new HttpsClientRequestFactory());
        //解决相应数据可能出现乱码问题
        List<HttpMessageConverter<?>> messageConverters = restTemplate.getMessageConverters();
        //移除原来的转换器
        messageConverters.remove(1);
        //设置字符编码为utf-8
        HttpMessageConverter<?> converter = new StringHttpMessageConverter(StandardCharsets.UTF_8);
        //添加新的转换器(注意：converter顺序错误会导致失败)
        messageConverters.add(converter);
        restTemplate.setMessageConverters(messageConverters);
        return restTemplate;
    }
}
