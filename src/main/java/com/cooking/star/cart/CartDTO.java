package com.cooking.star.cart;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartDTO {
	
	private Long cartNum;
	private String username;
	private String productName;
	private Long productPrice;
	private Long productEa;
	private Long totalPrice;
	private String productImg;
}
