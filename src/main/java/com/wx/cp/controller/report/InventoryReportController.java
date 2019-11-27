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
import java.math.BigDecimal;
import java.util.ArrayList;
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
        List<StockReportVO> stockReportVOS = new ArrayList<>();
        for (StockReportVO stockReportVO : stockReportVOList) {
            stockReportVO.setSumStore(stockReportVO.getSumStore().setScale(0, BigDecimal.ROUND_UP));
            stockReportVO.setSumLock(stockReportVO.getSumStore().setScale(0, BigDecimal.ROUND_UP));
            stockReportVO.setSumNotLock(stockReportVO.getSumNotLock().setScale(0, BigDecimal.ROUND_UP));
            stockReportVO.setInLibraryAmount1(stockReportVO.getInLibraryAmount1().setScale(0, BigDecimal.ROUND_UP));
            stockReportVO.setInLibraryAmount2(stockReportVO.getInLibraryAmount2().setScale(0, BigDecimal.ROUND_UP));
            stockReportVO.setInLibraryAmount3(stockReportVO.getInLibraryAmount3().setScale(0, BigDecimal.ROUND_UP));
            stockReportVO.setDateOfExpiryAmount1(stockReportVO.getDateOfExpiryAmount1().setScale(0, BigDecimal.ROUND_UP));
            stockReportVO.setDateOfExpiryAmount2(stockReportVO.getDateOfExpiryAmount2().setScale(0, BigDecimal.ROUND_UP));
            stockReportVO.setDateOfExpiryAmount3(stockReportVO.getDateOfExpiryAmount3().setScale(0, BigDecimal.ROUND_UP));
            stockReportVOS.add(stockReportVO);
        }
        return ServerResponse.createBySuccess(stockReportVOS);

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
