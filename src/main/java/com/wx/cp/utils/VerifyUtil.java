package com.wx.cp.utils;

import com.wx.cp.vo.AuditVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import static com.wx.cp.constants.StatusConstant.*;
import static com.wx.cp.constants.URLConstant.*;

@Component
@Slf4j
public class VerifyUtil {

    @Autowired
    private HttpUtil httpUtil;

    public String verify(AuditVO auditVO) {
        String auditStatus = StatusUtil.getAuditStatus(auditVO.getState());
        Integer poType = auditVO.getPoType();
        log.info("auditStatus={}",auditStatus);
        if (auditStatus != null) {
            switch (auditStatus) {
                //商务审核
                case AUDIT_STATE_10:{
                    if (poType == 1){
                        log.info("采购专员审核url={}", PURCHASE_COMMERCIAL_AUDIT);
                        return httpUtil.postByDefault(auditVO, PURCHASE_COMMERCIAL_AUDIT);
                    }
                }
                //财务专员审核
                case AUDIT_STATE_25: {
                    if (poType == 5){
                        log.info("付款财务专员审核url={}",PAY_ORDER_FINANCIAL_ATTACHE_AUDIT);
                        return httpUtil.postByDefault(auditVO, PAY_ORDER_FINANCIAL_ATTACHE_AUDIT);
                    }
                    if (poType == 1){
                        log.info("采购财务专员审核url={}",PURCHASE_FINANCE_AUDIT);
                        return httpUtil.postByDefault(auditVO, PURCHASE_FINANCE_AUDIT);
                    }

                }
                //财务主管审核
                case AUDIT_STATE_30: {
                    if (poType == 5){
                        log.info("付款财务主管审核url={}",PAY_ORDER_FINANCE_OFFICER_AUDIT);
                        return httpUtil.postByDefault(auditVO, PAY_ORDER_FINANCE_OFFICER_AUDIT);
                    }
                    if (poType ==1){
                        log.info("采购财务主管审核url={}",PURCHASE_FINANCE_MANAGER_AUDIT);
                        return httpUtil.postByDefault(auditVO, PURCHASE_FINANCE_MANAGER_AUDIT);
                    }
                }
                //风控专员审核
                case AUDIT_STATE_35: {
                    if (poType == 5){
                        log.info("风控专员审核url={}",PAY_ORDER_RISK_ATTACHE_AUDIT);
                        return httpUtil.postByDefault(auditVO, PAY_ORDER_RISK_ATTACHE_AUDIT);
                    }
                    if (poType == 1){
                        log.info("风控专员审核url={}", PURCHASE_RISK_AUDIT);
                        return httpUtil.postByDefault(auditVO, PURCHASE_RISK_AUDIT);
                    }

                }
                //风控主管审核
                case AUDIT_STATE_40: {
                    if (poType == 5){
                        log.info("付款风控主管审核url={}",PAY_ORDER_RISK_AUDIT);
                        return httpUtil.postByDefault(auditVO, PAY_ORDER_RISK_AUDIT);
                    }
                    if (poType == 1){
                        log.info("采购风控专员审核url={}",PURCHASE_RISK_MANAGER_AUDIT);
                        return httpUtil.postByDefault(auditVO, PURCHASE_RISK_MANAGER_AUDIT);
                    }
                }
                //部门主管审核
                case AUDIT_STATE_80: {
                    if (poType == 5){
                        log.info("部门主管审核url={}",PAY_ORDER_DEPARTMENT_MANAGER_AUDIT);
                        return httpUtil.postByDefault(auditVO, PAY_ORDER_DEPARTMENT_MANAGER_AUDIT);
                    }

                }
                //总经理审核
                case AUDIT_STATE_90: {
                    if (poType == 5){
                        log.info("付款总经理审核url={}",PAY_ORDER_BOSS_AUDIT);
                        return httpUtil.postByDefault(auditVO,PAY_ORDER_BOSS_AUDIT);
                    }
                    if (poType == 1){
                        log.info("采购部门主管审核url={}",PURCHASE_BOSS_AUDIT);
                        return httpUtil.postByDefault(auditVO, PURCHASE_BOSS_AUDIT);
                    }
                }
            }
        }
        return null;
    }

    /**
     * 流程审核驳回
     * @param auditVO
     * @return
     */
    public String unPass(AuditVO auditVO){
        Integer poType = auditVO.getPoType();
        if (poType == 5){
            log.info("付款驳回,url= {}",PAY_ORDER_UNPASS_AUDIT);
            httpUtil.postByDefault(auditVO, PAY_ORDER_UNPASS_AUDIT);
        }
        if (poType == 1){
            log.info("采购订单驳回,url={}", PURCHASE_UNPASS_AUDIT);
            httpUtil.postByDefault(auditVO, PURCHASE_UNPASS_AUDIT);
        }
        return "";
    }
}
