package com.wx.cp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/pay/portal")
public class PayPortalController {

    /**
     * 进入待审核单据
     * @return
     */
    @RequestMapping("/waitingPayOrderList")
    public String waitingPayOrderList(){ return "pay/waitingPayOrderList"; }
    @RequestMapping("/payDetail")
    public String payDetail(){
        return "pay/payDetail";
    }

    @RequestMapping("/handledOrderDetail")
    public String handledOrderDetail(){
        return "pay/handledOrderDetail";
    }

    @RequestMapping("/paySaleDetail")
    public String paySaleDetail(){
        return "pay/paySaleDetail";
    }

    @RequestMapping("/paySubstituteDetail")
    public String paySubstituteDetail(){
        return "pay/paySubstituteDetail";
    }

    @RequestMapping("/handledSaleOrderDetail")
    public String handledSaleOrderDetail(){
        return "pay/handledSaleOrderDetail";
    }

    @RequestMapping("/handledSubstituteOrderDetail")
    public String handledSubstituteOrderDetail(){
        return "pay/handledSubstituteOrderDetail";
    }
}
