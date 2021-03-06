package com.malangstore.controller;

import com.malangstore.service.ProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;

@Controller
public class ProductController {

    private final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Autowired
    ProductService productService;


	/**
	 *  categories 페이지로 이동
	 */
	@RequestMapping(value="/categories")
    public String categories() {
        logger.info("request url : /categories");

        return "categories";
    }


	/**
	 *  상품 리스트 가져오기
	 */
	@RequestMapping(value="/productList")
    public @ResponseBody HashMap<String, Object> productList(@RequestParam HashMap<String, Object> map) {
        logger.info("request url : /productList");

        return productService.productList(map);
    }


	/**
	 *  상품 등록 페이지로 이동
	 */
	@RequestMapping(value="/registProducts")
	public String registProducts() {
		logger.info("request url : /registProducts");

		return "registProducts";
	}


	/**
	 *  상품 등록
	 */
	@RequestMapping(value="/newProduct")
	public @ResponseBody HashMap<String, Object> newProduct(@RequestParam("files") List<MultipartFile> images, @RequestParam HashMap<String, Object> map) {
		logger.info("request url : /newProduct");

		// TODO: 2019-02-08 경로 확인

		return productService.newProduct(images, map);
	}


	/**
	 *  products 페이지로 이동
	 */
    @RequestMapping(value="/products")
    public String products() {
        logger.info("request url : /products");

        return "products";
    }


	/**
	 *  상품 정보 가져오기(1개)
	 */
	@RequestMapping(value="/productDetail")
    public @ResponseBody HashMap<String, Object> productDetail(@RequestParam HashMap<String, Object> map) {
        logger.info("request url : /productDetail");

        return productService.productDetail(map);
    }
}
