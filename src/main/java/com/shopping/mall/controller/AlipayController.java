package com.shopping.mall.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.domain.*;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayDataDataserviceBillDownloadurlQueryRequest;
import com.alipay.api.request.AlipayTradeCloseRequest;
import com.alipay.api.request.AlipayTradeFastpayRefundQueryRequest;
import com.alipay.api.request.AlipayTradeRefundRequest;
import com.alipay.api.response.*;
import com.alipay.demo.trade.model.builder.AlipayTradeQueryRequestBuilder;
import com.alipay.demo.trade.model.result.AlipayF2FQueryResult;
import com.alipay.demo.trade.service.AlipayTradeService;
import com.shopping.mall.config.AlipayProperties;

import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.*;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 * 支付宝通用接口.
 * <p>
 * detailed description
 *
 * @author Mengday Zhang
 * @version 1.0
 * @since 2018/6/13
 */

@RestController
@RequestMapping("/alipay")
public class AlipayController {

    @Autowired
    private AlipayProperties aliPayProperties;

    @Autowired
    private AlipayClient alipayClient;

    @Autowired
    private AlipayTradeService alipayTradeService;

    /**
     * 支付异步通知
     *
     * 接收到异步通知并验签通过后，一定要检查通知内容，包括通知中的app_id、out_trade_no、total_amount是否与请求中的一致，并根据trade_status进行后续业务处理。
     *
     * https://docs.open.alipay.com/194/103296
     */
    @RequestMapping("/notify")
    public String notify(HttpServletRequest request) throws AlipayApiException, UnsupportedEncodingException {
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
    		//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
    		params.put(name, valueStr);
    	}
    	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
    		//商户订单号

		String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
		//支付宝交易号

		String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

		//交易状态
		String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

		//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
		//计算得出通知验证结果
		//boolean AlipaySignature.rsaCheckV1(Map<String, String> params, String publicKey, String charset, String sign_type)
		boolean verify_result = AlipaySignature.rsaCheckV1(params, aliPayProperties.getAlipayPublicKey(), 
				aliPayProperties.getCharset(), "RSA2");
		
		if(verify_result){//验证成功
			//////////////////////////////////////////////////////////////////////////////////////////
			//请在这里加上商户的业务逻辑程序代码

			//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
			
			if(trade_status.equals("TRADE_FINISHED")){
				//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
					//如果有做过处理，不执行商户的业务程序
					
				//注意：
				//如果签约的是可退款协议，退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
				//如果没有签约可退款协议，那么付款完成后，支付宝系统发送该交易状态通知。
			} else if (trade_status.equals("TRADE_SUCCESS")){
				//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
					//如果有做过处理，不执行商户的业务程序
					
				//注意：
				//如果签约的是可退款协议，那么付款完成后，支付宝系统发送该交易状态通知。
			}

			//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
			//System.out.clear();
			return "success";	//请不要修改或删除

			//////////////////////////////////////////////////////////////////////////////////////////
		}else{//验证失败
			System.out.println("fail");
			return "fail";
		}
    }

    /**
     * 订单查询(最主要用于查询订单的支付状态)
     * @param orderNo 商户订单号
     * @return
     */
    @GetMapping("/query")
    public String query(String orderNo){

        AlipayTradeQueryRequestBuilder builder = new AlipayTradeQueryRequestBuilder()
                .setOutTradeNo(orderNo);
        AlipayF2FQueryResult result = alipayTradeService.queryTradeResult(builder);
        switch (result.getTradeStatus()) {
            case SUCCESS:
                System.out.println("查询返回该订单支付成功: ");

                AlipayTradeQueryResponse resp = result.getResponse();
                //log.info(resp.getTradeStatus());
//                log.info(resp.getFundBillList());
                break;

            case FAILED:
            	System.out.println("查询返回该订单支付失败!!!");
                break;

            case UNKNOWN:
            	System.out.println("系统异常，订单支付状态未知!!!");
                break;

            default:
            	System.out.println("不支持的交易状态，交易返回异常!!!");
                break;
        }
        return result.getResponse().getBody();
    }

    /**
     * 退款
     * @param orderNo 商户订单号
     * @return
     */
    @PostMapping("/refund")
    @ResponseBody
    public String refund(String orderNo) throws AlipayApiException {
        AlipayTradeRefundRequest alipayRequest = new AlipayTradeRefundRequest();

        AlipayTradeRefundModel model=new AlipayTradeRefundModel();
        // 商户订单号
        model.setOutTradeNo(orderNo);
        // 退款金额
        model.setRefundAmount("0.01");
        // 退款原因
        model.setRefundReason("无理由退货");
        // 退款订单号(同一个订单可以分多次部分退款，当分多次时必传)
//        model.setOutRequestNo(UUID.randomUUID().toString());
        alipayRequest.setBizModel(model);

        AlipayTradeRefundResponse alipayResponse = alipayClient.execute(alipayRequest);
        System.out.println(alipayResponse.getBody());

        return alipayResponse.getBody();
    }

    /**
     * 退款查询
     * @param orderNo 商户订单号
     * @param refundOrderNo 请求退款接口时，传入的退款请求号，如果在退款请求时未传入，则该值为创建交易时的外部订单号
     * @return
     * @throws AlipayApiException
     */
    @GetMapping("/refundQuery")
    @ResponseBody
    public String refundQuery(String orderNo, String refundOrderNo) throws AlipayApiException {
        AlipayTradeFastpayRefundQueryRequest alipayRequest = new AlipayTradeFastpayRefundQueryRequest();

        AlipayTradeFastpayRefundQueryModel model=new AlipayTradeFastpayRefundQueryModel();
        model.setOutTradeNo(orderNo);
        model.setOutRequestNo(refundOrderNo);
        alipayRequest.setBizModel(model);

        AlipayTradeFastpayRefundQueryResponse alipayResponse = alipayClient.execute(alipayRequest);
        System.out.println(alipayResponse.getBody());

        return alipayResponse.getBody();
    }

    /**
     * 关闭交易
     * @param orderNo
     * @return
     * @throws AlipayApiException
     */
    @PostMapping("/close")
    @ResponseBody
    public String close(String orderNo) throws AlipayApiException {
        AlipayTradeCloseRequest alipayRequest = new AlipayTradeCloseRequest();
        AlipayTradeCloseModel model =new AlipayTradeCloseModel();
        model.setOutTradeNo(orderNo);
        alipayRequest.setBizModel(model);

        AlipayTradeCloseResponse alipayResponse = alipayClient.execute(alipayRequest);
        System.out.println(alipayResponse.getBody());

        return alipayResponse.getBody();
    }


    /**
     * billDate : 账单时间：日账单格式为yyyy-MM-dd，月账单格式为yyyy-MM。
     * 查询对账单下载地址: https://docs.open.alipay.com/api_15/alipay.data.dataservice.bill.downloadurl.query/
     * @param billDate
     */
    @GetMapping("/bill")
    @ResponseBody
    public void queryBill(String billDate) {
        // 1. 查询对账单下载地址
        AlipayDataDataserviceBillDownloadurlQueryRequest request = new AlipayDataDataserviceBillDownloadurlQueryRequest();
        AlipayDataDataserviceBillDownloadurlQueryModel model = new AlipayDataDataserviceBillDownloadurlQueryModel();
        model.setBillType("trade");
        model.setBillDate(billDate);
        request.setBizModel(model);
        try {
            AlipayDataDataserviceBillDownloadurlQueryResponse response = alipayClient.execute(request);
            if (response.isSuccess()) {
                String billDownloadUrl = response.getBillDownloadUrl();
                System.out.println(billDownloadUrl);

                // 2. 下载对账单
                List<String> orderList = this.downloadBill(billDownloadUrl);
                System.out.println(orderList);
                // 3. 先比较支付宝的交易合计/退款合计笔数/实收金额是否和自己数据库中的数据一致，如果不一致证明有异常，再具体找出那些订单有异常
                // 查找支付宝支付成功而自己支付失败的记录和支付宝支付失败而自己认为支付成功的异常订单记录到数据库

            } else {
                // 失败
                String code = response.getCode();
                String msg = response.getMsg();
                String subCode = response.getSubCode();
                String subMsg = response.getSubMsg();
            }
        } catch (AlipayApiException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 校验签名
     * @param request
     * @return
     */
    public boolean rsaCheckV1(HttpServletRequest request){
        // https://docs.open.alipay.com/54/106370
        // 获取支付宝POST过来反馈信息
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
            params.put(name, valueStr);
        }

        try {
            boolean verifyResult = AlipaySignature.rsaCheckV1(params,
                    aliPayProperties.getAlipayPublicKey(),
                    aliPayProperties.getCharset(),
                    aliPayProperties.getSignType());

            return verifyResult;
        } catch (AlipayApiException e) {
        	System.out.println("verify sigin error, exception is:{}" +  e.toString());
            return false;
        }
    }

    /**
     * 下载下来的是一个【账号_日期.csv.zip】文件（zip压缩文件名，里面有多个.csv文件）
     * 账号_日期_业务明细 ： 支付宝业务明细查询
     * 账号_日期_业务明细(汇总)：支付宝业务汇总查询
     *
     * 注意：如果数据量比较大，该方法可能需要更长的执行时间
     * @param billDownLoadUrl
     * @return
     * @throws IOException
     */
    private List<String> downloadBill(String billDownLoadUrl) throws IOException {
        String ordersStr = "";
        CloseableHttpClient httpClient = HttpClients.createDefault();
        RequestConfig config = RequestConfig.custom()
                .setConnectTimeout(60000)
                .setConnectionRequestTimeout(60000)
                .setSocketTimeout(60000)
                .build();
        HttpGet httpRequest = new HttpGet(billDownLoadUrl);
        httpRequest.setConfig(config);
        CloseableHttpResponse response = null;
        byte[] data = null;
        try {
            response = httpClient.execute(httpRequest);
            HttpEntity entity = response.getEntity();
            data = EntityUtils.toByteArray(entity);
        } finally {
            response.close();
            httpClient.close();
        }
        ZipInputStream zipInputStream = new ZipInputStream(new ByteArrayInputStream(data), Charset.forName("GBK"));
        ZipEntry zipEntry = null;
        try{
            while( (zipEntry = zipInputStream.getNextEntry()) != null){
                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                try{
                    String name = zipEntry.getName();
                    // 只要明细不要汇总
                    if(name.contains("汇总")){
                        continue;
                    }
                    byte[] byteBuff = new byte[4096];
                    int bytesRead = 0;
                    while ((bytesRead = zipInputStream.read(byteBuff)) != -1) {
                        byteArrayOutputStream.write(byteBuff, 0, bytesRead);
                    }
                    ordersStr = byteArrayOutputStream.toString("GBK");
                }finally {
                    byteArrayOutputStream.close();
                    zipInputStream.closeEntry();
                }
            }
        } finally {
            zipInputStream.close();
        }

        if (ordersStr.equals("")) {
            return null;
        }
        String[] bills = ordersStr.split("\r\n");
        List<String> billList = Arrays.asList(bills);
        billList = billList.parallelStream().map(item -> item.replace("\t", "")).collect(Collectors.toList());

        return billList;
    }
}
