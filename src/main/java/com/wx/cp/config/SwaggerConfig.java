package com.wx.cp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class SwaggerConfig {

    @Bean
    public Docket api() {
        return new Docket(DocumentationType.SWAGGER_2)
            .apiInfo(apiInfo())
            .select()
            // 自行修改为自己的包路径
            .apis(RequestHandlerSelectors.basePackage("com.wx.cp.controller"))
            .paths(PathSelectors.any())
            .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
            .title("企业微信")
            .description("企业微信 API 1.0 操作文档")
            //服务条款网址
            .termsOfServiceUrl("http://aoc.asters.cn/")
            .version("1.0")
            .contact(new Contact("qm", "http://aoc.asters.cn/", "asters@126.com"))
            .build();
    }
}
