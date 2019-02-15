package com.shopping.mall.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeWapPayModel;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.shopping.mall.config.AlipayProperties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

/**
 * 支付宝-手机网站支付.
 * <p>
 * 手机网站支付
 *
 * @author Mengday Zhang
 * @version 1.0
 * @since 2018/6/11
 */
@Controller
@RequestMapping("/alipay/wap")
public class AlipayWAPPayController {

    @Autowired
    private AlipayProperties alipayProperties;


    /**
     * 去支付
     *
     * 支付宝返回一个form表单，并自动提交，跳转到支付宝页面
     *
     * @param response
     * @throws Exception
     */
    @PostMapping("/alipage")
    public void gotoPayPage(HttpServletResponse response, @RequestParam String outTradeNo, @RequestParam String subject,
    		@RequestParam String payment, @RequestParam String description) throws AlipayApiException, IOException {
    
        
        // 超时时间 可空
       String timeout_express="5m";
        // 销售产品码 必填
        String product_code="QUICK_WAP_WAY";
        /**********************/
        // SDK 公共请求类，包含公共请求参数，以及封装了签名与验签，开发者无需关注签名与验签     
        //调用RSA签名方式
        AlipayClient client = new DefaultAlipayClient(alipayProperties.getGatewayUrl(), 
        		alipayProperties.getAppid(), alipayProperties.getAppPrivateKey(), alipayProperties.getFormate(), 
        		alipayProperties.getCharset(), alipayProperties.getAlipayPublicKey(),
        		alipayProperties.getSignType());
        AlipayTradeWapPayRequest alipay_request=new AlipayTradeWapPayRequest();
        
        // 封装请求支付信息
        AlipayTradeWapPayModel model=new AlipayTradeWapPayModel();
        model.setOutTradeNo(outTradeNo);
        model.setSubject(subject);
        model.setTotalAmount(payment);
        model.setBody(description);
        model.setTimeoutExpress(timeout_express);
        model.setProductCode(product_code);
        alipay_request.setBizModel(model);
        // 设置异步通知地址
        alipay_request.setNotifyUrl(alipayProperties.getNotifyUrl());
        // 设置同步地址
        alipay_request.setReturnUrl(alipayProperties.getReturnUrl());   
        
        // form表单生产
        String form = "";
    	try {
    		// 调用SDK生成表单
    		form = client.pageExecute(alipay_request).getBody();
    		response.setContentType("text/html;charset=" +  alipayProperties.getCharset()); 
    	    response.getWriter().write(form);//直接将完整的表单html输出到页面 
    	    response.getWriter().flush(); 
    	    response.getWriter().close();
    	} catch (AlipayApiException e) {
    		// TODO Auto-generated catch block
    		System.out.println(e.toString());
    		System.out.println("APPID = " + alipayProperties.getAppid());
    		e.printStackTrace();
    	} 
    }


    /**
     * 支付宝页面跳转同步通知页面
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     * @throws AlipayApiException
     */
    @RequestMapping("/returnUrl")
    public String returnUrl(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, AlipayApiException {
        response.setContentType("text/html;charset=" + alipayProperties.getCharset());

        //获取支付宝GET过来反馈信息
        Map<String,String> params = new HashMap<>();
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

        boolean verifyResult = AlipaySignature.rsaCheckV1(params, alipayProperties.getAlipayPublicKey(), alipayProperties.getCharset(), "RSA2");
        if(verifyResult){
            //验证成功
            //请在这里加上商户的业务逻辑程序代码，如保存支付宝交易号
            //商户订单号
            String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
            //支付宝交易号
            String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

            return "wapPaySuccess";

        }else{
            return "wapPayFail";

        }
    }
}
