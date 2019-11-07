package com.wx.cp.constants;

/**
 * @author dell
 */
public class URLConstant {

    public final static String PAY_DOMAIN = "http://127.0.0.1:8080/scfs/wechat/pay/";

    public final static String USER_DOMAIN = "http://127.0.0.1:8080/scfs/wechat/baseUser/";
    public final static String PROJECT_DOMAIN = "http://127.0.0.1:8080/scfs/wechat/project/";
    public final static String INVENTORY_DOMAIN = "http://127.0.0.1:8080/scfs/wechat/inventoryReport/";
    public final static String PURCHASE_AND_SALE_DOMAIN = "http://127.0.0.1:8080/scfs/wechat/purchaseAndSaleReport/";
    public final static String AUDIT_DOMAIN = "http://127.0.0.1:8080/scfs/wechat/audit/";
    public final static String AUTHROIZE_TEST_DOMAIN = "/wechat/authorize?returnUrl=http://wx.asters.cn/pay/portal/waitingPayOrderList";
    public final static String AUTHROIZE_PRO_DOMAIN = "/wechat/authorize?returnUrl=http://wx.asters.cn/pay/portal/waitingPayOrderList";
    /**查询所有待审核的单据*/
    public final static String AUDIT_QUERY = PAY_DOMAIN + "waiting/audit";
    public final static String PAY_ORDER_DETAIL = PAY_DOMAIN + "payOrderDetail?payId=";
    public final static String PAY_ORDER_AUDIT = PAY_DOMAIN + "payOrder/audit?projectItemId=";
    public final static String PAY_ORDER_QUERY = PAY_DOMAIN + "audit/query";
    //用户相关
    public final static String GET_USER = USER_DOMAIN + "getUser";
    //项目相关
    public final static String GET_PROJECT = PROJECT_DOMAIN + "getProject";
    //审核相关
    public final static String PAY_RESOLVED_VERIFIED = PAY_DOMAIN + "resolved/verified";
    //总经理审核
    public final static String PAY_ORDER_BOSS_AUDIT = PAY_DOMAIN + "payOrder/boss/audit";
    //风控专员
    public final static String PAY_ORDER_RISK_ATTACHE_AUDIT = PAY_DOMAIN + "payOrder/risk/special/audit";
    //风控主管审核
    public final static String PAY_ORDER_RISK_AUDIT = PAY_DOMAIN + "payOrder/risk/audit";
    //财务专员审核
    public final static String PAY_ORDER_FINANCIAL_ATTACHE_AUDIT = PAY_DOMAIN + "payOrder/finance/audit";
    //财务主管审核
    public final static String PAY_ORDER_FINANCE_OFFICER_AUDIT = PAY_DOMAIN + "payOrder/finance2/audit";
    //部门主管审核
    public final static String PAY_ORDER_DEPARTMENT_MANAGER_AUDIT = PAY_DOMAIN + "payOrder/dept/audit";

    //报表相关
    //库存报表list
    public final static String INVENTORY_REPORT_LIST = INVENTORY_DOMAIN + "list";
    //库存报表详情
    public final static String INVENTORY_REPORT_DETAIL = INVENTORY_DOMAIN + "detail";

    //进销存报表
    //商品进销存报表
    public final static String PURCHASE_AND_SALE_REPORT_GOODS_LIST = PURCHASE_AND_SALE_DOMAIN + "goodsList";
    //商品进销存报表详情
    public final static String PURCHASE_AND_SALE_REPORT_GOODS_DETAIL = PURCHASE_AND_SALE_DOMAIN + "goodsDetail";

    public final static String PAY_ORDER_UNPASS_AUDIT = PAY_DOMAIN + "payOrder/unpass/audit";
    public final static String PAY_ORDER_AUDIT_PARAM = "";
    public final static String RETURN_ITEMS = "items";
    public final static String RETURN_MSG = "msg";
    public final static String RETURN_PAYORDERRESDTO = "payOrderResDto";
    public final static String RETURN_PAYPORELATIONRESDTO = "payPoRelationResDto";
    public final static String RETURN_PAYADVANCERELATION = "payAdvanceRelation";
    public final static String HEADER_NAME = "Accept";


}
