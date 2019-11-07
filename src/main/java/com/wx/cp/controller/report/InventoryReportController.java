package com.wx.cp.controller.report;

import com.alibaba.fastjson.JSONObject;
import com.wx.cp.common.ServerResponse;
import com.wx.cp.constants.URLConstant;
import com.wx.cp.dto.StockReportDTO;
import com.wx.cp.utils.HttpUtil;
import com.wx.cp.utils.TokenUtil;
import com.wx.cp.vo.StockReportVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 库存报表
 */
@RestController
@RequestMapping("/inventoryReport")
@Slf4j
public class InventoryReportController {

    @Autowired
    private TokenUtil tokenUtil;
    @Autowired
    private HttpUtil httpUtil;

    /**
     * 显示所有库存记录
     */
    @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
    public ServerResponse<List<StockReportVO>> list(HttpServletRequest request, StockReportDTO stockReportDTO){

        String openid = tokenUtil.getToken(request);
//        stockReportDTO.setOpenid("YueYi");
        stockReportDTO.setWechatFlag(true);
        stockReportDTO.setOpenid(openid );
        String response = httpUtil.postByDefault(stockReportDTO, URLConstant.INVENTORY_REPORT_LIST);
        log.info("response={}",response);
        JSONObject jsonObject = JSONObject.parseObject(response);
        String items = jsonObject.getString(URLConstant.RETURN_ITEMS);
        List<StockReportVO> stockReportVOList = JSONObject.parseArray(items, StockReportVO.class);
        return ServerResponse.createBySuccess(stockReportVOList);

    }

    /**
     * 显示所有库存记录
     */
    @RequestMapping(value = "detail", method = {RequestMethod.GET, RequestMethod.POST})
    public ServerResponse<List<StockReportVO>> detail(HttpServletRequest request,StockReportDTO stockReportDTO){
        String openid = tokenUtil.getToken(request);
//        stockReportDTO.setOpenid("YueYi");
        stockReportDTO.setWechatFlag(true);
        stockReportDTO.setOpenid(openid);
        String response = httpUtil.postByDefault(stockReportDTO, URLConstant.INVENTORY_REPORT_DETAIL);
        JSONObject jsonObject = JSONObject.parseObject(response);
        String items = jsonObject.getString(URLConstant.RETURN_ITEMS);
        List<StockReportVO> stockReportVOList = JSONObject.parseArray(items, StockReportVO.class);
        return ServerResponse.createBySuccess(stockReportVOList);
    }
}
