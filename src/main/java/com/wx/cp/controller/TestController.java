package com.wx.cp.controller;

import com.wx.cp.config.WxCpConfiguration;
import com.wx.cp.config.WxCpProperties;
import com.wx.cp.utils.TokenUtil;
import me.chanjar.weixin.common.error.WxErrorException;
import me.chanjar.weixin.cp.api.WxCpService;
import me.chanjar.weixin.cp.bean.WxCpDepart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

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
