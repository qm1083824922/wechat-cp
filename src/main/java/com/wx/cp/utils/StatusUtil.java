package com.wx.cp.utils;

import com.wx.cp.constants.StatusConstant;

import static com.wx.cp.constants.StatusConstant.*;

public class StatusUtil {
    /**
     * 获取审核单据类型
     *
     * @param code
     * @return
     */
    public static String getPoType(Integer code) {
        if (code == StatusConstant.INT_1) {
            return StatusConstant.AUDIT_POTYPE_1;
        }
        if (code == StatusConstant.INT_2) {
            return StatusConstant.AUDIT_POTYPE_2;
        }
        if (code == StatusConstant.INT_3) {
            return StatusConstant.AUDIT_POTYPE_3;
        }
        if (code == StatusConstant.INT_4) {
            return StatusConstant.AUDIT_POTYPE_4;
        }
        if (code == StatusConstant.INT_5) {
            return StatusConstant.AUDIT_POTYPE_5;
        }
        if (code == StatusConstant.INT_6) {
            return StatusConstant.AUDIT_POTYPE_6;
        }
        if (code == StatusConstant.INT_7) {
            return StatusConstant.AUDIT_POTYPE_7;
        }
        if (code == StatusConstant.INT_8) {
            return StatusConstant.AUDIT_POTYPE_8;
        }
        if (code == StatusConstant.INT_9) {
            return StatusConstant.AUDIT_POTYPE_9;
        }
        if (code == StatusConstant.INT_10) {
            return StatusConstant.AUDIT_POTYPE_10;
        }
        if (code == StatusConstant.INT_11) {
            return StatusConstant.AUDIT_POTYPE_11;
        }
        if (code == StatusConstant.INT_12) {
            return StatusConstant.AUDIT_POTYPE_12;
        }
        if (code == StatusConstant.INT_13) {
            return StatusConstant.AUDIT_POTYPE_13;
        }
        if (code == StatusConstant.INT_14) {
            return StatusConstant.AUDIT_POTYPE_14;
        }
        if (code == StatusConstant.INT_15) {
            return StatusConstant.AUDIT_POTYPE_15;
        }
        if (code == StatusConstant.INT_16) {
            return StatusConstant.AUDIT_POTYPE_16;
        }
        if (code == StatusConstant.INT_17) {
            return StatusConstant.AUDIT_POTYPE_17;
        }
        if (code == StatusConstant.INT_18) {
            return StatusConstant.AUDIT_POTYPE_18;
        }
        if (code == StatusConstant.INT_19) {
            return StatusConstant.AUDIT_POTYPE_19;
        }
        if (code == StatusConstant.INT_20) {
            return StatusConstant.AUDIT_POTYPE_20;
        }
        if (code == StatusConstant.INT_21) {
            return StatusConstant.AUDIT_POTYPE_21;
        }
        if (code == StatusConstant.INT_22) {
            return StatusConstant.AUDIT_POTYPE_22;
        }
        if (code == StatusConstant.INT_23) {
            return StatusConstant.AUDIT_POTYPE_23;
        }
        if (code == StatusConstant.INT_24) {
            return StatusConstant.AUDIT_POTYPE_24;
        }
        if (code == StatusConstant.INT_25) {
            return StatusConstant.AUDIT_POTYPE_25;
        }
        if (code == StatusConstant.INT_26) {
            return StatusConstant.AUDIT_POTYPE_26;
        }
        if (code == StatusConstant.INT_27) {
            return StatusConstant.AUDIT_POTYPE_27;
        }
        if (code == StatusConstant.INT_28) {
            return StatusConstant.AUDIT_POTYPE_28;
        }
        if (code == StatusConstant.INT_29) {
            return StatusConstant.AUDIT_POTYPE_29;
        }
        if (code == StatusConstant.INT_30) {
            return StatusConstant.AUDIT_POTYPE_30;
        }
        return null;
    }

    /**
     * 获取审核状态
     *
     * @param code
     * @return
     */
    public static String getAuditStatus(Integer code) {
        if (code == StatusConstant.INT_0) {
            return StatusConstant.AUDIT_STATE_0;
        }
        if (code == StatusConstant.INT_3) {
            return StatusConstant.AUDIT_STATE_3;
        }
        if (code == StatusConstant.INT_4) {
            return StatusConstant.AUDIT_STATE_4;
        }
        if (code == StatusConstant.INT_10) {
            return AUDIT_STATE_10;
        }
        if (code == StatusConstant.INT_11) {
            return StatusConstant.AUDIT_STATE_11;
        }
        if (code == StatusConstant.INT_14) {
            return StatusConstant.AUDIT_STATE_14;
        }
        if (code == StatusConstant.INT_15) {
            return StatusConstant.AUDIT_STATE_15;
        }
        if (code == StatusConstant.INT_16) {
            return StatusConstant.AUDIT_STATE_16;
        }
        if (code == StatusConstant.INT_17) {
            return StatusConstant.AUDIT_STATE_17;
        }
        if (code == StatusConstant.INT_18) {
            return StatusConstant.AUDIT_STATE_18;
        }
        if (code == StatusConstant.INT_20) {
            return AUDIT_STATE_20;
        }
        if (code == StatusConstant.INT_25) {
            return StatusConstant.AUDIT_STATE_25;
        }
        if (code == StatusConstant.INT_30) {
            return StatusConstant.AUDIT_STATE_30;
        }
        if (code == StatusConstant.INT_35) {
            return StatusConstant.AUDIT_STATE_35;
        }
        if (code == StatusConstant.INT_40) {
            return StatusConstant.AUDIT_STATE_40;
        }
        if (code == StatusConstant.INT_45) {
            return StatusConstant.AUDIT_STATE_45;
        }
        if (code == StatusConstant.INT_80) {
            return StatusConstant.AUDIT_STATE_80;
        }
        if (code == StatusConstant.INT_90) {
            return StatusConstant.AUDIT_STATE_90;
        }
        if (code == StatusConstant.INT_99) {
            return StatusConstant.AUDIT_STATE_99;
        }
        return null;
    }


}
