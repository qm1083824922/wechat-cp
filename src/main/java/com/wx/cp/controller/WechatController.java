package com.wx.cp.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.wx.cp.common.ResponseCode;
import com.wx.cp.common.ServerResponse;
import com.wx.cp.config.WxCpConfiguration;
import com.wx.cp.config.WxCpProperties;
import com.wx.cp.constants.URLConstant;
import com.wx.cp.pojo.TbBaseUser;
import com.wx.cp.utils.DateFormatterUtil;
import com.wx.cp.utils.HttpUtil;
import com.wx.cp.utils.StatusUtil;
import com.wx.cp.utils.TokenUtil;
import com.wx.cp.vo.AuditRequestVO;
import com.wx.cp.vo.PayOrderVO;
import lombok.extern.slf4j.Slf4j;
import me.chanjar.weixin.common.api.WxConsts;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.cp.api.WxCpService;
import me.chanjar.weixin.cp.bean.WxCpMessage;
import me.chanjar.weixin.cp.bean.WxCpMessageSendResult;
import me.chanjar.weixin.cp.bean.WxCpOauth2UserInfo;
import me.chanjar.weixin.cp.bean.WxCpUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/wechat")
@Slf4j
public class WechatController {

    @Autowired
    private WxCpProperties wxCpProperties;

    @Autowired
    private TokenUtil tokenUtil;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private HttpUtil httpUtil;

    /**
     * AOC审批认证接口
     * @param returnUrl
     * @return
     */
    @GetMapping("/authorize")
    public String auth(@RequestParam("returnUrl") String returnUrl) {
        Integer agentId = wxCpProperties.getAppConfigs().get(0).getAgentId();
        return getAuthorized(returnUrl, agentId);
    }

    /**
     * 库存报表认证接口
     * @param returnUrl
     * @return
     */
    @GetMapping("/inventoryAuthorized")
    public String inventoryAuth(@RequestParam("returnUrl") String returnUrl) {
        Integer agentId = wxCpProperties.getAppConfigs().get(1).getAgentId();
        return getAuthorized(returnUrl, agentId);
    }

    private String getAuthorized(String returnUrl, Integer agentId) {
        final WxCpService wxCpService = WxCpConfiguration.getCpService(agentId);
        String url = wxCpProperties.getUserInfoUrl();
        String redirectUrl = null;
        try {
            log.info("回调地址={}", returnUrl);
            redirectUrl = wxCpService.getOauth2Service().buildAuthorizationUrl(url, URLEncoder.encode(returnUrl, "UTF-8"), WxConsts.OAuth2Scope.SNSAPI_BASE);

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        log.info("redirectUrl={}", redirectUrl);
        return "redirect:" + redirectUrl;
    }

    /**
     * 获取用户userId
     * @param code
     * @return
     */
    @GetMapping("/userInfo")
    public String userInfo(@RequestParam("code") String code,
                           @RequestParam("state") String returnUrl,
                           HttpServletResponse response, HttpServletRequest request){
        Integer agentId = wxCpProperties.getAppConfigs().get(0).getAgentId();
        final WxCpService wxCpService = WxCpConfiguration.getCpService(agentId);
        String userId = null;
        try {
            WxCpOauth2UserInfo userInfo = wxCpService.getOauth2Service().getUserInfo(code);
            userId = userInfo.getUserId();
            log.info("userId={}",userId);
            if (StringUtils.isBlank(tokenUtil.getToken(request))){
                tokenUtil.setToken(userId,response);
            }
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
        log.info("returnUrl={}",returnUrl);
        System.out.println("redirect:" + returnUrl + "?userId=" + userId);
        return "redirect:" + returnUrl;
    }

    /**
     * 获得用户
     * @return
     * @throws WxErrorException
     */
    @GetMapping("/getUser")
    @ResponseBody
    public WxCpUser getUser() throws WxErrorException {
        Integer agentId = wxCpProperties.getAppConfigs().get(0).getAgentId();
        final WxCpService wxCpService = WxCpConfiguration.getCpService(agentId);
        return wxCpService.getUserService().getById("");
    }

    /**
     * 获取部门下用户
     * @return
     * @throws WxErrorException
     */
    @GetMapping("/getDepartmentMemberInfo")
    @ResponseBody
    public List<WxCpUser> getDepartmentMembers() throws WxErrorException {
        Integer agentId = wxCpProperties.getAppConfigs().get(0).getAgentId();
        final WxCpService wxCpService = WxCpConfiguration.getCpService(agentId);
        return wxCpService.getUserService().listByDepartment(10L, true, 0);
    }

    /**
     * 发送图文消息
     * 确定发送审核的类型
     */
    @GetMapping("/sendMessageTextCard/{userId}/{status}/{poType}")
    @ResponseBody
    public ServerResponse sendMessageTextCard(@PathVariable("userId") Integer userId,
                                              @PathVariable("status") Integer status,
                                              @PathVariable("poType") Integer poType){
        log.info("userId={},status={},poType={}",userId,status,poType);
        try {
            AuditRequestVO auditRequestVO = new AuditRequestVO();
            auditRequestVO.setId(userId);
            String response = httpUtil.postByDefault(auditRequestVO,URLConstant.GET_USER);
            TbBaseUser tbBaseUser = JSON.parseObject(response, TbBaseUser.class);
            String openid = null;
            if (tbBaseUser != null) {
                openid = tbBaseUser.getOpenid();
            }
            if (StringUtils.isNotBlank(openid)) {
                String url = wxCpProperties.getProjectUrl() + URLConstant.AUTHROIZE_TEST_DOMAIN;
                WxCpProperties.AppConfig appConfig = wxCpProperties.getAppConfigs().get(0);
                Integer agentId = appConfig.getAgentId();
                final WxCpService wxCpService = WxCpConfiguration.getCpService(agentId);
                String auditStatus = StatusUtil.getAuditStatus(status);
                String orderType = StatusUtil.getPoType(poType);
                WxCpMessage message = WxCpMessage
                    .TEXTCARD()
                    .toUser(openid)
                    .btnTxt("更多")
                    .description("<div class=\"gray\">" + DateFormatterUtil.dateFormat() + "</div> <div class=\"normal\">" + auditStatus + "通知</div>")
                    .url(url)
                    .title(orderType + "审核通知")
                    .build();
                try {
                    WxCpMessageSendResult messageSendResult = wxCpService.messageSend(message);
                    if (Objects.nonNull(messageSendResult)) {
                        JSONObject jsonObject = JSONObject.parseObject(String.valueOf(messageSendResult));
                        int errcode = Integer.parseInt(jsonObject.getString("errcode"));
                        //发送成功
                        if (errcode == 0) {
                            log.info("发送企业微信通知成功");
                        }
                    }
                } catch (WxErrorException e) {
                    e.printStackTrace();
                    return ServerResponse.createByErrorCodeMessage(ResponseCode.ERROR.getCode(),"服务器异常，请稍后再试");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ServerResponse.createBySuccess();
    }

    /**
     * 付款单审核通过发送微信通知给出纳
     */
    @RequestMapping("/SendMessageMarkdown")
    @ResponseBody
    public void SendMessageMarkdown(@RequestBody PayOrderVO payOrderVO){
        try {
            WxCpMessage message = WxCpMessage
                .MARKDOWN()
                .toUser("marsJing")
                .content("付款单："+ payOrderVO.getPayNo() +",已审核完成  \n" +
                    "                >**付款单详情** \n" +
                    "                >申请人：<font color=\\\"info\\\">"+payOrderVO.getCreator()+"</font> \n" +
                    "                >申请日期："+payOrderVO.getCreateAtString()+" \n" +
                    "                >付款金额：`"+payOrderVO.getPayAmountString()+"` \n" +
                    "                > \n" +
                    "                >开户行：<font color=\\\"info\\\">"+payOrderVO.getBankName()+"</font> \n" +
                    "                >收款银行开户人：<font color=\\\"warning\\\">"+payOrderVO.getSubjectName()+"</font> \n" +
                    "                >收款银行账号：<font color=\\\"comment\\\">"+payOrderVO.getAccountNo()+"</font> \n" +
                    "                >收款单位：<font color=\\\"comment\\\">"+payOrderVO.getPayeeName()+"</font> \n" +
                    "                > \n" +
                    "                >请去阿斯特运营作业中心打印付款单据。")
                .build();
            WxCpProperties.AppConfig appConfig = wxCpProperties.getAppConfigs().get(0);
            final WxCpService wxCpService = WxCpConfiguration.getCpService(appConfig.getAgentId());
            wxCpService.messageSend(message);
        } catch (WxErrorException e) {
            e.printStackTrace();
        }
    }
}
