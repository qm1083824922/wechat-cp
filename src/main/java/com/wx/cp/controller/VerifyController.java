package com.wx.cp.controller;

import com.alibaba.fastjson.JSONObject;
import com.wx.cp.common.ServerResponse;
import com.wx.cp.constants.URLConstant;
import com.wx.cp.utils.TokenUtil;
import com.wx.cp.utils.VerifyUtil;
import com.wx.cp.vo.AuditFlowsVO;
import com.wx.cp.vo.AuditVO;
import com.wx.cp.vo.ResultVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;

@Slf4j
@RequestMapping("/verify/")
@RestController
public class VerifyController {

    @Autowired
    private TokenUtil tokenUtil;
    @Autowired
    private VerifyUtil verifyUtil;

    /**
     * 审核
     *
     * @param request
     * @param auditVO
     * @return
     */
    @PostMapping("pass")
    public ServerResponse<ResultVO<AuditFlowsVO>> verifyPass(HttpServletRequest request, @RequestBody AuditVO auditVO) {
        try {
            String openid = tokenUtil.getToken(request);
//            String openid = "YueYi";
            if (StringUtils.isNotBlank(openid)) {
                auditVO.setOpenid(openid);
                Integer poType = auditVO.getPoType();
                if (Objects.nonNull(poType)){
                    if (1 == auditVO.getOperation()) {
                        log.info("auditVO={}", auditVO);
                        String response = verifyUtil.verify(auditVO);
                        log.info("审核通过,response={}", JSONObject.parseObject(response));
                        if (StringUtils.isNotBlank(response)) {
                            JSONObject jsonObject = (JSONObject) JSONObject.parse(response);
                            String message = jsonObject.getString(URLConstant.RETURN_MSG);
                            return ServerResponse.createBySuccessMessage(message);
                        }
                    } else {
                        String response = verifyUtil.unPass(auditVO);
                        log.info("审核拒绝,response={}", JSONObject.parseObject(response));
                        if (StringUtils.isNotBlank(response)) {
                            JSONObject jsonObject = (JSONObject) JSONObject.parse(response);
                            String message = jsonObject.getString(URLConstant.RETURN_MSG);
                            return ServerResponse.createBySuccessMessage(message);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ServerResponse.createBySuccess();
    }
}
