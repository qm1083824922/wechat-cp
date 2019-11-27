package com.wx.cp.vo;

import lombok.Data;

import java.util.List;

@Data
public class PurchaseAuditIntoVO {
    private PurchaseOrderVO purchaseOrderVO;
    private List<PurchaseOrderDetailVO> purchaseOrderDetailVOList;
}
