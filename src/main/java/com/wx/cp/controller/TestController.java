package com.wx.cp.controller;

import com.wx.cp.config.WxCpConfiguration;
import com.wx.cp.config.WxCpProperties;
import com.wx.cp.utils.TokenUtil;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.cp.api.WxCpService;
import me.chanjar.weixin.cp.bean.WxCpDepart;
import me.chanjar.weixin.cp.bean.WxCpMessage;
import me.chanjar.weixin.cp.bean.WxCpUser;
import me.chanjar.weixin.cp.bean.article.NewArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/wechat")
public class TestController {
    @Autowired
    private WxCpProperties wxCpProperties;

    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private TokenUtil tokenUtil;

    @GetMapping("/hello")
    @ResponseBody
    public String hello(HttpServletRequest request){
        String token = tokenUtil.getToken(request);
        System.out.println(token);
        return token;
    }

    /**
     * 发送helloword消息
     */
//    @GetMapping("/helloWord")
//    public void helloWord() {
//        WxCpInMemoryConfigStorage config = new WxCpInMemoryConfigStorage();
//        WxCpProperties.AppConfig appConfig = wxCpProperties.getAppConfigs().get(0);
//        // 设置微信企业号的appid
//        config.setCorpId(wxCpProperties.getCorpId());
//        // 设置微信企业号的app corpSecret
//        config.setCorpSecret(appConfig.getSecret());
//        // 设置微信企业号应用ID
//        config.setAgentId(appConfig.getAgentId());
//        WxCpServiceImpl wxCpService = new WxCpServiceImpl();
//        wxCpService.setWxCpConfigStorage(config);
//
//        String userId = "YueYi";
//        WxCpMessage message = WxCpMessage.TEXT()
//            .agentId(appConfig.getAgentId())
//            .toUser(userId)
//            .content("Hello World")
//            .build();
//        try {
//            wxCpService.messageSend(message);
//        } catch (WxErrorException e) {
//            e.printStackTrace();
//        }
//    }

    /**
     * 发送图文消息
     * @param agentId
     * @param article
     */
    @GetMapping("/sendImageTextMessage")
    public void sendImageTextMessage(Integer agentId,NewArticle article) {
        final WxCpService wxCpService = WxCpConfiguration.getCpService(agentId);
        article.setUrl(article.getUrl());
        article.setPicUrl(article.getPicUrl());
        article.setDescription(article.getDescription());
        article.setTitle(article.getTitle());

        WxCpMessage wxCpMessage = WxCpMessage.NEWS()
            // 企业号应用ID
            .agentId(agentId)
            .toUser("YueYi")
            .addArticle(article)
            .build();
        try {
            wxCpService.messageSend(wxCpMessage);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取部门下所有用户信息
     * @return
     * @throws WxErrorException
     */
    @GetMapping("/getDepartmentMemberInfoList")
    public List<WxCpUser>  getDepartmentMemberList() throws WxErrorException {
        Integer agentId = wxCpProperties.getAppConfigs().get(0).getAgentId();
        final WxCpService wxCpService = WxCpConfiguration.getCpService(agentId);
        return wxCpService.getUserService().listByDepartment(2L, true, 0);
    }

    /**
     * 获取用户所在部门
     * 参数id可以为null，当它为null时将获取所有部门，
     * 当它有值时将获取该id对应的部门及其子部门
     * 1.应用access_token仅能指定可见范围配置的成员，以及部门/标签包含的成员（递归展开）
     * 2.应用access_token仅能指定可见范围配置的部门id(创建或移动部门，
     * 还需要具有父部门的管理权限)，标签包括的部门id，以及上述部门的子部门id
     * @return
     * @throws WxErrorException
     */
    @GetMapping("/getDepartmentInfo")
    public List<WxCpDepart>  getDepartmentInfo(@RequestParam(value = "departmentId",defaultValue = "") Long departmentId) throws WxErrorException {
        Integer agentId = wxCpProperties.getAppConfigs().get(0).getAgentId();
        final WxCpService wxCpService = WxCpConfiguration.getCpService(agentId);
        if (departmentId == null){
            return wxCpService.getDepartmentService().list(null);
        }else {
            return wxCpService.getDepartmentService().list(departmentId);
        }
    }



}
