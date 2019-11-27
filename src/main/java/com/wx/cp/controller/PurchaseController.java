package com.wx.cp.controller;
import com.alibaba.fastjson.JSONObject;
import com.wx.cp.common.ResponseCode;
import com.wx.cp.common.ServerResponse;
import com.wx.cp.constants.URLConstant;
import com.wx.cp.vo.PurchaseAuditIntoVO;
import com.wx.cp.vo.PurchaseOrderDetailVO;
import com.wx.cp.vo.PurchaseOrderVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@RestController
@RequestMapping("/purchase")
@Slf4j
public class PurchaseController {

    @Autowired
    private RestTemplate restTemplate;

    @RequestMapping(value = "/purchaseOrder", method = {RequestMethod.GET, RequestMethod.POST})
    public ServerResponse<PurchaseAuditIntoVO> purchaseOrder(@RequestParam("poId") String poId) {
        try {
            String url = URLConstant.PURCHASE_ORDER + poId;
            log.info("url={}", url);
            String response = restTemplate.getForObject(url, String.class);
            PurchaseAuditIntoVO purchaseAuditIntoVO = new PurchaseAuditIntoVO();
            if (StringUtils.isNotBlank(response)) {
                JSONObject jsonObject = JSONObject.parseObject(response);
                log.info("返回响应体,jsonObject={}", jsonObject);
                JSONObject items = jsonObject.getJSONObject(URLConstant.RETURN_ITEMS);
                PurchaseOrderVO purchaseOrderVO = items.getObject("poTitleRespDto", PurchaseOrderVO.class);
                log.info("采购订单头信息,purchaseOrderVO={}",purchaseOrderVO);
                List<PurchaseOrderDetailVO> purchaseDetailList = JSONObject.parseArray(items.getString("poLineDetailList"), PurchaseOrderDetailVO.class);
                log.info("采购订单行信息,purchaseDetailList={}",purchaseDetailList);
                purchaseAuditIntoVO.setPurchaseOrderVO(purchaseOrderVO);
                purchaseAuditIntoVO.setPurchaseOrderDetailVOList(purchaseDetailList);
                return ServerResponse.createBySuccess(purchaseAuditIntoVO);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.createByErrorCodeMessage(ResponseCode.ERROR.getCode(),"服务器异常,稍后重试");
        }
        return ServerResponse.createBySuccess();
    }
}
