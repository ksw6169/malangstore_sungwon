package com.malangstore.service;

import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;

public interface OrderlistService {
    public HashMap<String, Object> insertCart(HashMap<String, String> map);

    public HashMap<String, Object> cartList(HashMap<String, String> map);

    public HashMap<String, Integer> deleteOrder(HashMap<String, Object> map);

    public ModelAndView order(String[] rowCheck);

    public HashMap<String, Object> getOrderlist(HashMap<String, Object> map);

	public ModelAndView directOrder(String[] rowCheck);

	public HashMap<String, Object> orderView(HashMap<String, Object> map);

	public ModelAndView orderCancel(List<Integer> orderlist);
}
