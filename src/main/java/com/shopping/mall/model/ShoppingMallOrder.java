package com.shopping.mall.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

public class ShoppingMallOrder  implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -344918765006398270L;
	private long        id;
    private BigDecimal  payment;
    private int         clientId;
    private String      clientName;
    private String      clientChineseName;
    
    private String      paymentType;
    private String      postFee;
    private String      status;
    private String      createTime;
    private String      updateTime;
    private String      paymentTime;
    private String      consignTime;
    private String      endTime;
    private String      closeTime;
    private String      shippingName;
    private int         shippingNo;
    
    private String      buyerMessage;
    private String      buyerNick;
    private String      buyerRate;
    private String      receiverAreaName;
    private String      receiverMobile;
    private String      receiverZipcode;
    private String      receiver;
    private String      expire;
    private String      invoiceType;
    private String      sourceType;
    private String      sellerId;
    private String      remarks;
    List<Product>       productList;
    
	public List<Product> getProductList() {
		return productList;
	}
	public void setProductList(List<Product> productList) {
		this.productList = productList;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public BigDecimal getPayment() {
		return payment;
	}
	public void setPayment(BigDecimal payment) {
		this.payment = payment;
	}

	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public String getPostFee() {
		return postFee;
	}
	public void setPostFee(String postFee) {
		this.postFee = postFee;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getPaymentTime() {
		return paymentTime;
	}
	public void setPaymentTime(String paymentTime) {
		this.paymentTime = paymentTime;
	}
	public String getConsignTime() {
		return consignTime;
	}
	public void setConsignTime(String consignTime) {
		this.consignTime = consignTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getCloseTime() {
		return closeTime;
	}
	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}
	public String getShippingName() {
		return shippingName;
	}
	public void setShippingName(String shippingName) {
		this.shippingName = shippingName;
	}
	public int getShippingNo() {
		return shippingNo;
	}
	public void setShippingNo(int shippingNo) {
		this.shippingNo = shippingNo;
	}
	
	public String getBuyerMessage() {
		return buyerMessage;
	}
	public void setBuyerMessage(String buyerMessage) {
		this.buyerMessage = buyerMessage;
	}
	public String getBuyerNick() {
		return buyerNick;
	}
	public void setBuyerNick(String buyerNick) {
		this.buyerNick = buyerNick;
	}
	public String getBuyerRate() {
		return buyerRate;
	}
	public void setBuyerRate(String buyerRate) {
		this.buyerRate = buyerRate;
	}
	
	public String getReceiverAreaName() {
		return receiverAreaName;
	}
	public void setReceiverAreaName(String receiverAreaName) {
		this.receiverAreaName = receiverAreaName;
	}
	public String getReceiverMobile() {
		return receiverMobile;
	}
	public void setReceiverMobile(String receiverMobile) {
		this.receiverMobile = receiverMobile;
	}
	public String getReceiverZipcode() {
		return receiverZipcode;
	}
	public void setReceiverZipcode(String receiverZipcode) {
		this.receiverZipcode = receiverZipcode;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getExpire() {
		return expire;
	}
	public void setExpire(String expire) {
		this.expire = expire;
	}
	public String getInvoiceType() {
		return invoiceType;
	}
	public void setInvoiceType(String invoiceType) {
		this.invoiceType = invoiceType;
	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getClientId() {
		return clientId;
	}
	public void setClientId(int clientId) {
		this.clientId = clientId;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getClientChineseName() {
		return clientChineseName;
	}
	public void setClientChineseName(String clientChineseName) {
		this.clientChineseName = clientChineseName;
	}

	@Override
	public String toString() {
		return "ShoppingMallOrder [id=" + id + ", payment=" + payment + ", clientId=" + clientId + ", clientName="
				+ clientName + ", clientChineseName=" + clientChineseName + ", paymentType=" + paymentType
				+ ", postFee=" + postFee + ", status=" + status + ", createTime=" + createTime + ", updateTime="
				+ updateTime + ", paymentTime=" + paymentTime + ", consignTime=" + consignTime + ", endTime=" + endTime
				+ ", closeTime=" + closeTime + ", shippingName=" + shippingName + ", shippingNo=" + shippingNo
				+ ", buyerMessage=" + buyerMessage + ", buyerNick=" + buyerNick + ", buyerRate=" + buyerRate
				+ ", receiverAreaName=" + receiverAreaName + ", receiverMobile=" + receiverMobile + ", receiverZipcode="
				+ receiverZipcode + ", receiver=" + receiver + ", expire=" + expire + ", invoiceType=" + invoiceType
				+ ", sourceType=" + sourceType + ", sellerId=" + sellerId + ", remarks=" + remarks + ", productList="
				+ productList + "]";
	}

	
}
