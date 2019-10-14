package com.wx.cp.utils;

import com.wx.cp.vo.AuditVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import static com.wx.cp.constants.StatusConstant.*;
import static com.wx.cp.constants.URLConstant.*;

@Component
@Slf4j
public class PayUtil {

    @Autowired
    private HttpUtil httpUtil;

    public String verify(AuditVO auditVO) {
        String auditStatus = StatusUtil.getAuditStatus(auditVO.getState());
        log.info("auditStatus={}",auditStatus);
        if (auditStatus != null) {
            switch (auditStatus) {
                //财务专员审核
                case AUDIT_STATE_25: {
                    log.info("财务专员审核url={}",PAY_ORDER_FINANCIAL_ATTACHE_AUDIT);
                    return httpUtil.postByDefault(auditVO, PAY_ORDER_FINANCIAL_ATTACHE_AUDIT);
                }
                //财务主管审核
                case AUDIT_STATE_30: {
                    log.info("财务主管审核url={}",PAY_ORDER_FINANCE_OFFICER_AUDIT);
                    return httpUtil.postByDefault(auditVO, PAY_ORDER_FINANCE_OFFICER_AUDIT);
                }
                //风控专员审核
                case AUDIT_STATE_35: {
                    log.info("风控专员审核url={}",PAY_ORDER_RISK_ATTACHE_AUDIT);
                    return httpUtil.postByDefault(auditVO, PAY_ORDER_RISK_ATTACHE_AUDIT);
                }
                //风控主管审核
                case AUDIT_STATE_40: {
                    log.info("风控主管审核url={}",PAY_ORDER_RISK_AUDIT);
                    return httpUtil.postByDefault(auditVO, PAY_ORDER_RISK_AUDIT);
                }
                //部门主管审核
                case AUDIT_STATE_80: {
                    log.info("部门主管审核url={}",PAY_ORDER_DEPARTMENT_MANAGER_AUDIT);
                    return httpUtil.postByDefault(auditVO, PAY_ORDER_DEPARTMENT_MANAGER_AUDIT);
                }
                //总经理审核
                case AUDIT_STATE_90: {
                    log.info("总经理审核url={}",PAY_ORDER_BOSS_AUDIT);
                    return httpUtil.postByDefault(auditVO,PAY_ORDER_BOSS_AUDIT);
                }
            }
        }
        return null;
    }
}
