package com.wx.cp.controller.report;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/report")
public class ReportPortalController {

    @RequestMapping("/inventoryReportList")
    public String inventoryReportList(){ return "report/inventoryReportList"; }

    @RequestMapping("/inventoryReportDetail")
    public String inventoryReportDetail(){ return "report/inventoryReportDetail"; }

    @RequestMapping("/stockReportList")
    public String stockReportList(){ return "report/stockReportList"; }

    @RequestMapping("/stockReportDetail")
    public String stockReportDetail(){ return "report/stockReportListDetail"; }
}
