package com.malangstore.daoimple;

import com.malangstore.beans.Photo;
import com.malangstore.beans.Product;
import com.malangstore.dao.ProductDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("productDao")
public class ProductDaoImple implements ProductDao {

    private final String NAMESPACE = ProductDao.class.getName();

    @Autowired
    SqlSessionTemplate sqlSession;


	/**
	 *  상품 리스트 가져오기
	 */
	@Override
    public List<Product> productList(int subcategory_no, int page) {

    	Map<String, Integer> paramMap = new HashMap<String, Integer>();
        paramMap.put("subcategory_no", subcategory_no);
        paramMap.put("page", page);

        return sqlSession.selectList(NAMESPACE+".productList", paramMap);
    }


	/**
	 *  사진 리스트 가져오기(상품 리스트로)
	 */
	@Override
    public List<Photo> getPhoto(List<Product> productList) {

        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("productList", productList);

        if(productList.size() == 0) {
        	return null;
        }

        return sqlSession.selectList(NAMESPACE+".getPhoto", paramMap);
    }


	/**
	 *  사진 리스트 가져오기(상품 번호로)
	 */
	@Override
    public List<Photo> getPhotoList(int product_no) {

        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("product_no", product_no);

        return sqlSession.selectList(NAMESPACE+".getPhotoList", paramMap);
    }


	/**
	 *  상품 개수 가져오기
	 */
	@Override
    public int productListCount(int subcategory_no) {

        Map<String, Integer> paramMap = new HashMap<String, Integer>();
        paramMap.put("subcategory_no", subcategory_no);

        return sqlSession.selectOne(NAMESPACE+".productListCount", paramMap);
    }


	/**
	 *  사진 등록
	 */
	@Override
    public int insertPhoto(int product_no, HashMap<String, Object> map, int imageLen) {

        List<Photo> list = new ArrayList<Photo>();

        for(int i=1; i<=imageLen; i++) {
            Photo photo = new Photo();
            photo.setProduct_no(product_no);
            photo.setPhoto_name(String.valueOf(map.get("photo_name"+i)));

            list.add(photo);
        }

        return sqlSession.insert(NAMESPACE+".insertPhoto", list);
    }


	/**
	 *  상품 등록
	 */
	@Override
    public HashMap<String, Object> newProduct(HashMap<String, Object> map, int imageLen) {

        // 상품 정보 등록
        Product product = new Product();
        product.setProduct_name(String.valueOf(map.get("product_name")));
        product.setProduct_detail(String.valueOf(map.get("product_detail")));
        product.setProduct_price(Integer.valueOf(String.valueOf(map.get("product_price"))));
        product.setProduct_delivery(Integer.valueOf(String.valueOf(map.get("product_delivery"))));
        product.setSubcategory_no(Integer.valueOf(String.valueOf(map.get("subcategory_no"))));

        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        int success = 0;

        if(sqlSession.insert(NAMESPACE+".newProduct", product) > 0) {   // useGeneratedKey를 이용해 insert 후 product_no 값을 Product 객체에 담음
            // 사진 등록
            if(insertPhoto(product.getProduct_no(), map, imageLen) > 0) {
                success = 1;
                resultMap.put("product_no", product.getProduct_no());
            }
        }

        resultMap.put("success", success);

        return resultMap;
    }


	/**
	 *  상품 정보 가져오기(1개)
	 */
	@Override
    public Product productDetail(int product_no) {

        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("product_no", product_no);

        return sqlSession.selectOne(NAMESPACE+".productDetail", paramMap);
    }
}
