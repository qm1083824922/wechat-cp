package com.wx.cp.controller;

import com.wx.cp.service.IAuditFlowService;
import com.wx.cp.service.IAuditService;
import com.wx.cp.service.IBaseProjectService;
import com.wx.cp.service.IBaseSubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

@RequestMapping("/wechat/portal")
@Controller
public class WechatPortalController {

    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private IAuditService auditService;
    @Autowired
    private IAuditFlowService auditFlowService;
    @Autowired
    private StringRedisTemplate redisTemplate;
    @Autowired
    private IBaseSubjectService baseSubjectService;
    @Autowired
    private IBaseProjectService baseProjectService;

    /**
     * 查看以已审核采购订单详情
     * @return
     */
    @RequestMapping("/purchaseVerifiedDetailPage")
    public String purchaseDetailPage(){
        return "purchaseVerifiedDetailPage";
    }

    /**
     * 查看未审核采购订单详情
     * @return
     */
    @RequestMapping("/purchaseUnVerifiedDetailPage")
    public String purchaseUnVerifiedDetailPage(){
        return "purchaseUnVerifiedDetailPage";
    }

}
