package com.wx.cp.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

/**
 * @author dell
 */
@Getter
@Setter
@ToString
public class PayAuditInfoVO {

    /**
     * 付款审核付款信息
     */
    private PayOrderVO payOrderResDto;

    private PayTotalVO payTotalVO;
    /**
     * 付款审核订单信息
     */
    private List<PayPoRelationVO> payPoRelationResDto;

    /**
     * 付款审核费用信息
     */
    private List<PayFeeRelationVO> payFeeRelationResDto;

    /** 付款附件信息 **/
    //private List<PayOrderFileVO> payOrderFileList;

    /** 付款预收信息 **/
    private List<PayAdvanceRelationVO> payAdvanceRelation;
}
