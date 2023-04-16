package com.utar.model.sessionbean;

import com.utar.model.entity.Product;
import com.utar.model.entity.Productline;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

@Stateless
public class ProductSession implements ProductSessionBean{
    @PersistenceContext(unitName = "SSAssignment")
    EntityManager em;

    @Override
    public Product findProduct(String id) {
       Query q = em.createNamedQuery("Product.findbyId");
         q.setParameter("id", id);
        return (Product) q.getSingleResult();
    }

    @Override
    public List<Product> getAllProducts() {
        return em.createNamedQuery("Product.findAll").getResultList();
    }

    @Override
    public int getNumberOfRows() {
        Query q = null;
        q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.products");
        BigInteger results = (BigInteger) q.getSingleResult();
        int i = results.intValue();
        return i;

    }

    @Override
    public List<Product> readProduct(int currentPage, int recordsPerPage) {
        Query q = null;
        q = em.createNativeQuery("SELECT * FROM classicmodels.products order by productcode" , Product.class);
        int start = currentPage * recordsPerPage - recordsPerPage;
        List<Product> results = q.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();
        return results;
    }

    @Override
    public void updateProduct(String[] s) {
//        update product set productname = 'test', productline = 'test', productscale = 'test', productvendor = 'test', productdescription = 'test', quantityinstock = 1, buyprice = 1, msrp = 1 where productcode = 'S10_1678';
        Product p = findProduct(s[0]);
        p.setProductname(s[1]);
//        p.setProductline(s[2]);
        p.setProductscale(s[3]);
        p.setProductvendor(s[4]);
        p.setProductdescription(s[5]);
        p.setQuantityinstock(Integer.parseInt(s[6]));
        p.setBuyprice(new BigDecimal(s[7]));
        p.setMsrp(new BigDecimal(s[8]));
        em.merge(p);

    }

    @Override
    public void addProduct(String[] s) {
        Product p = new Product();
        p.setId(s[0]);
        p.setProductname(s[1]);
//        p.setProductline(s[2]);
        p.setProductscale(s[3]);
        p.setProductvendor(s[4]);
        p.setProductdescription(s[5]);
        p.setQuantityinstock(Integer.parseInt(s[6]));
        p.setBuyprice(new BigDecimal(s[7]));
        p.setMsrp(new BigDecimal(s[8]));
        em.persist(p);

    }

    @Override
    public void deleteProduct(String id) {
        Product p = findProduct(id);
        em.remove(p);
    }


}
