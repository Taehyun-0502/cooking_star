package com.cooking.star.cart;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartService {
	
	@Autowired
	private CartMapper cartMapper;
	
	public List<CartDTO> list(CartDTO cartDTO)throws Exception{
		return cartMapper.list(cartDTO);
	}
	
	public int insert(CartDTO cartDTO)throws Exception{
		return cartMapper.insert(cartDTO);
	}

}
