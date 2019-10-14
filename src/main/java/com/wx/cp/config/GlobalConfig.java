package com.wx.cp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Configuration
@Component
public class GlobalConfig {

    @Bean
    public RestTemplate restTemplate(){
        return new RestTemplate();
    }

}
