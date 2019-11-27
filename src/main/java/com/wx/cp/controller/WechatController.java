package com.wx.cp.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.wx.cp.common.ResponseCode;
import com.wx.cp.common.ServerResponse;
import com.wx.cp.config.WxCpConfiguration;
import com.wx.cp.config.WxCpProperties;
import com.wx.cp.constants.URLConstant;
import com.wx.cp.utils.DateFormatterUtil;
import com.wx.cp.utils.HttpUtil;
import com.wx.cp.utils.StatusUtil;
import com.wx.cp.utils.TokenUtil;
import com.wx.cp.vo.AuditFlowsVO;
import com.wx.cp.vo.AuditVO;
import com.wx.cp.vo.PayOrderVO;
import com.wx.cp.vo.ResultVO;
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
     * 发送通知文本消息
     * @param applicantId
     * @param poType
     * @return
     */
    @GetMapping("/sendMessage/{applicantId}/{poType}")
    @ResponseBody
    public ServerResponse sendMessageText(@PathVariable("applicantId") String applicantId,
                                          @PathVariable("poType") Integer poType) {
        try {
            if (StringUtils.isNotBlank(applicantId)){
                WxCpProperties.AppConfig appConfig = wxCpProperties.getAppConfigs().get(0);
                Integer agentId = appConfig.getAgentId();
                final WxCpService wxService = WxCpConfiguration.getCpService(agentId);
                WxCpMessage message = WxCpMessage
                    .TEXT()
                    .toUser(applicantId)
                    .content("您提交的" + StatusUtil.getPoType(poType) + "已经审核完成")
                    .build();
                wxService.messageSend(message);
                return ServerResponse.createBySuccess();
            }
        }catch (WxErrorException e){
            e.printStackTrace();
            return ServerResponse.createByErrorCodeMessage(ResponseCode.ERROR.getCode(),"服务器异常,稍后重试");
        }
        return ServerResponse.createBySuccess();

    }

    /**
     * 发送图文消息
     * 确定发送审核的类型
     */
    @GetMapping("/sendMessageTextCard/{userId}/{status}/{poType}")
    @ResponseBody
    public ServerResponse sendMessageTextCard(@PathVariable("userId") String userId,
                                              @PathVariable("status") Integer status,
                                              @PathVariable("poType") Integer poType){
        log.info("userId={},status={},poType={}",userId,status,poType);
        try {
            if (StringUtils.isNotBlank(userId) && Objects.nonNull(status) && Objects.nonNull(poType) ) {
                String url = wxCpProperties.getProjectUrl() + URLConstant.WAITING_ORDER_LIST;
                WxCpProperties.AppConfig appConfig = wxCpProperties.getAppConfigs().get(0);
                Integer agentId = appConfig.getAgentId();
                final WxCpService wxCpService = WxCpConfiguration.getCpService(agentId);
                String auditStatus = StatusUtil.getAuditStatus(status);
                String orderType = StatusUtil.getPoType(poType);
                WxCpMessage message = WxCpMessage
                    .TEXTCARD()
                    .toUser(userId)
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
                            log.info("发送企业微信" + orderType + "通知成功");
                        }else {
                            //发送审核通知失败，通知给自己
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


    /**
     * 审核记录
     */
    @RequestMapping(value = "/auditRecords", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public ServerResponse<ResultVO<AuditFlowsVO>> auditRecords(AuditVO auditVO) {
        ResultVO<AuditFlowsVO> auditFlowsVO = new ResultVO<>();
        try {
            Integer poType = auditVO.getPoType();
            String url = null;
            if (poType == 5){
                url = URLConstant.PAY_ORDER_AUDIT + auditVO.getProjectItemId();
            }
            if (poType == 1 ){
                url = URLConstant.PURCHASE_AUDIT_RECORDS + auditVO.getPoId() + "/" + auditVO.getProjectId();
            }
            log.info("url={}", url);
            String response = restTemplate.getForObject(url, String.class);
            log.info("审核记录,response={}", JSONObject.parseObject(response));
            if (StringUtils.isNotBlank(response)) {
                JSONObject jsonObject = (JSONObject) JSONObject.parse(response);
                String items = jsonObject.getString(URLConstant.RETURN_ITEMS);
                log.info("审核记录,items={}", jsonObject.getString(URLConstant.RETURN_ITEMS));
                List<AuditFlowsVO> auditFlowsVOS = JSON.parseArray(items, AuditFlowsVO.class);
                auditFlowsVO.setItems(auditFlowsVOS);
                return ServerResponse.createBySuccess(auditFlowsVO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ServerResponse.createBySuccess(auditFlowsVO);
    }
}
