package com.wx.cp.service.impl;

import com.wx.cp.ApplicationTests;
import com.wx.cp.utils.HttpUtil;
import com.wx.cp.utils.StatusUtil;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.client.RestTemplate;

import java.math.BigDecimal;

import static com.wx.cp.constants.StatusConstant.*;

public class WechatUserServiceImplTest extends ApplicationTests {

    @Autowired
    private BaseUserServiceImpl baseUserService;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private HttpUtil httpUtil;

    @Before
    public void setUp() throws Exception {
    }

    public void test() {
//        String url = "http://localhost:9090/wechat/getDepartmentMemberInfo";
//        String response = restTemplate.getForObject(url, String.class);
//        JSONArray array = JSONObject.parseArray(response);
//        List<User> users = JSONObject.parseArray(array.toJSONString(), User.class);
//        List<TbBaseUser> list = baseUserService.list();
//        for (User user : users) {
//            String name = user.getName();
//            String mobile = user.getMobile();
//            String userId = user.getUserId();
//            System.out.println("姓名-->" + name + " userId-->" + userId);
//            for (TbBaseUser baseUser : list) {
//                String chineseName = baseUser.getChineseName();
//                if (name.equals(chineseName)) {
//                    System.out.println("mobile-->" + mobile + " userId-->" + userId);
//                    TbBaseUser baseUser1 = new TbBaseUser();
//                    baseUser1.setOpenid(userId);
//                    UpdateWrapper<TbBaseUser> baseUserUpdateWrapper = new UpdateWrapper<>();
//                    System.out.println("id=" + baseUser.getId());
//                    System.out.println("openid=" + user.getUserId());
//                    baseUserUpdateWrapper.eq("id", baseUser.getId());
//                    baseUserUpdateWrapper.set("openid", user.getUserId());
//                    baseUserService.update(baseUserUpdateWrapper);
//                }
//            }
//        }
    }

    public void verify(Integer state){
        String auditStatus = StatusUtil.getAuditStatus(state);
        //商务审核
        assert auditStatus != null;
        switch (auditStatus) {
            case AUDIT_STATE_10:
                //总经理审核
            case AUDIT_STATE_90:
                //部门主管审核
            case AUDIT_STATE_80:
                //商务专员审核
            case AUDIT_STATE_45:
                //风控主管审核
            case AUDIT_STATE_40:
                //风控专员审核
            case AUDIT_STATE_35:
                //财务主管审核
            case AUDIT_STATE_30:
                //财务专员审核
            case AUDIT_STATE_25:
                //业务审核
            case AUDIT_STATE_20:
                //法务审核
            case AUDIT_STATE_11: {
                System.out.println("aaa");
//                httpUtil.postByDefault(auditVO, url);
                break;
            }
        }
    }

    @Test
    public void test1(){
        BigDecimal bigDecimal = new BigDecimal("0.23");
        String s = bigDecimal.multiply(new BigDecimal("100")).setScale(0).toString()+ '%';
        System.out.println(s);
    }

}
