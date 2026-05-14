package com.cooking.star.cart;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CartMapper {

	public List<CartDTO> list()throws Exception;
	
	public int insert(CartDTO cartDTO)throws Exception;
	
	public int delete(CartDTO cartDTO) throws Exception;
}
