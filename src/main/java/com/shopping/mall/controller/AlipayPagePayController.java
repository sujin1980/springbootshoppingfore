package com.shopping.mall.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.domain.AlipayTradePagePayModel;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.shopping.mall.config.AlipayProperties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alipay.api.internal.util.AlipaySignature;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

/**
 * 支付宝-电脑网站支付.
 * <p>
 * 电脑网站支付 https://docs.open.alipay.com/270/105898/
 *
 * @author Mengday Zhang
 * @version 1.0
 * @since 2018/6/14
 */
@Controller
@RequestMapping("/alipay/page")
public class AlipayPagePayController {

    @Autowired
    private AlipayProperties alipayProperties;

    @Autowired
    private AlipayClient alipayClient;

    @Autowired
    private AlipayController alipayController;


    @PostMapping("/gotoPayPage")
    public void gotoPayPage(HttpServletResponse response) throws AlipayApiException, IOException {
        // 订单模型
        String productCode = "FAST_INSTANT_TRADE_PAY";
        AlipayTradePagePayModel model = new AlipayTradePagePayModel();
        model.setOutTradeNo(UUID.randomUUID().toString());
        model.setSubject("支付测试");
        model.setTotalAmount("0.01");
        model.setBody("支付测试，共0.01元");
        model.setProductCode(productCode);

        AlipayTradePagePayRequest pagePayRequest =new AlipayTradePagePayRequest();
        pagePayRequest.setReturnUrl("http://s9v2cw.natappfree.cc/" + "alipay/page/returnUrl");
        pagePayRequest.setNotifyUrl(alipayProperties.getNotifyUrl());
        pagePayRequest.setBizModel(model);

        // 调用SDK生成表单, 并直接将完整的表单html输出到页面
        String form = alipayClient.pageExecute(pagePayRequest).getBody();
        response.setContentType("text/html;charset=" + alipayProperties.getCharset());
        response.getWriter().write(form);
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping("/returnUrl")
    public String returnUrl(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, AlipayApiException {
        response.setContentType("text/html;charset=" + alipayProperties.getCharset());

        
        
        
        Map<String,String> params = new HashMap<String,String>();
    	Map requestParams = request.getParameterMap();
    	for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
    		String name = (String) iter.next();
    		String[] values = (String[]) requestParams.get(name);
    		String valueStr = "";
    		for (int i = 0; i < values.length; i++) {
    			valueStr = (i == values.length - 1) ? valueStr + values[i]
    					: valueStr + values[i] + ",";
    		}
    		//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
    		valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
    		params.put(name, valueStr);
    	}
    	
    	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
    	//商户订单号

    	String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

    	//支付宝交易号

    	String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

    	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
    	//计算得出通知验证结果
    	//boolean AlipaySignature.rsaCheckV1(Map<String, String> params, String publicKey, String charset, String sign_type)
    	boolean verify_result = AlipaySignature.rsaCheckV1(params, alipayProperties.getAlipayPublicKey(), 
    			alipayProperties.getCharset(), "RSA2");
    	
    	if(verify_result){//验证成功
    		//////////////////////////////////////////////////////////////////////////////////////////
    		//请在这里加上商户的业务逻辑程序代码
    		//该页面可做页面美工编辑
    		//System.out.clear();
    		System.out.println("验证成功<br />");
    		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
    		 return "wapPaySuccess";	
    		//////////////////////////////////////////////////////////////////////////////////////////
    	}else{
    		//该页面可做页面美工编辑
    		System.out.println("验证失败");
    		 return "wapPaySuccess";
    	}
    }
}
