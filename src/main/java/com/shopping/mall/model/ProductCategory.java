package com.shopping.mall.model;

import java.io.Serializable;
import java.util.List;

public class ProductCategory implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -6037562154051012451L;
	private int id;
    private String name;
    private String remarks;
    private List<ProductType> productType;
    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public List<ProductType> getProductType() {
		return productType;
	}
	public void setProductType(List<ProductType> productType) {
		this.productType = productType;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((productType == null) ? 0 : productType.hashCode());
		result = prime * result + ((remarks == null) ? 0 : remarks.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductCategory other = (ProductCategory) obj;
		if (id != other.id)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (productType == null) {
			if (other.productType != null)
				return false;
		} else if (!productType.equals(other.productType))
			return false;
		if (remarks == null) {
			if (other.remarks != null)
				return false;
		} else if (!remarks.equals(other.remarks))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "ProductCategory [id=" + id + ", name=" + name + ", remarks=" + remarks + ", productType=" + productType
				+ "]";
	}
	
	
	
}
