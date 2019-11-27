package com.wx.cp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/purchase/portal/")
public class PurchasePortalController {

    @GetMapping("purchaseOrderDetail")
    public String purchaseOrderDetail(){
        return "purchase/orderDetail";
    }

    @GetMapping("purchaseHandledOrderDetail")
    public String purchaseHandledOrderDetail(){
        return "purchase/handledOrderDetail";
    }
}
