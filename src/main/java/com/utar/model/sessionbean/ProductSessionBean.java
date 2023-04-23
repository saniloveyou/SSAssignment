package com.utar.model.sessionbean;

import com.utar.model.entity.Product;
import com.utar.model.entity.Productline;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

@Stateless
public class ProductSessionBean implements ProductSessionBeanLocal {
    @PersistenceContext(unitName = "SSAssignment")
    EntityManager em;

    @Override
    public List<Product> getAllProduct() throws EJBException {
        return em.createNamedQuery("product.findAll").getResultList();
    }

    @Override
    public Product getProduct(String id) throws EJBException {
        Query q = em.createNamedQuery("product.findById");
        q.setParameter("id", String.valueOf(id));
        return (Product) q.getSingleResult();
    }

    @Override
    public List<Product> readSomeProduct() throws EJBException {
        Query q = null;
        q = em.createNativeQuery("SELECT * FROM classicmodels.products order by productcode LIMIT 8", Product.class);
        List<Product> results = q.getResultList();
        return results;
    }

    @Override
    public List<Product> readProduct(int currPage, int recordsPerPage, String keyword, String sort) throws EJBException {
        Query q = null;
        int start = 0;
        sort = " " + sort;

        if(keyword.isEmpty()) {
            q = em.createNativeQuery("SELECT  * FROM classicmodels.products order by productcode" + sort, Product.class);
            start = currPage * recordsPerPage - recordsPerPage;
        }else{
            q = em.createNativeQuery("SELECT  * FROM classicmodels.products WHERE concat(productcode,productname,productline) LIKE ? ORDER by productcode" + sort, Product.class);
            start = currPage * recordsPerPage - recordsPerPage;
            q.setParameter(1,"%" + keyword +"%");

        }
        List<Product> results = q.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();

        return results;
    }

    @Override
    public int getNoOfRows(String keyword) throws EJBException {
        Query q = null;
        if(keyword.isEmpty()){
            q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.products");
        }else{
            q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.products WHERE " +
                    "concat(productcode,productname,productline) LIKE ?");
                    q.setParameter(1, "%" + keyword + "%");
        }

        BigInteger results = (BigInteger)q.getSingleResult();
        int i = results.intValue();
        return i;
    }

    @Override
    public void updateProduct(String[] s, Productline pl) throws EJBException {
        Product p = getProduct(s[0]);
        p.setId(s[0]);
        p.setProductname(s[1]);
        p.setProductline(pl);
        p.setProductscale(s[2]);
        p.setProductvendor(s[3]);
        p.setProductdescription(s[4]);
        p.setQuantityinstock(Integer.valueOf(s[5]));
        BigDecimal buyPrice = BigDecimal.valueOf(Double.valueOf(s[6]));
        p.setBuyprice(buyPrice);
        BigDecimal msrp = BigDecimal.valueOf(Double.valueOf(s[7]));
        p.setMsrp(msrp);
        em.merge(p);
    }

    @Override
    public void deleteProduct(String id) throws EJBException {
        Product p = getProduct(id);
        em.remove(p);
    }

    @Override
    public void addProduct(String[] s, Productline pl) throws EJBException {
        Product p = new Product();
        p.setId(s[0]);
        p.setProductname(s[1]);
        p.setProductline(pl);
        p.setProductscale(s[2]);
        p.setProductvendor(s[3]);
        p.setProductdescription(s[4]);
        p.setQuantityinstock(Integer.valueOf(s[5]));
        BigDecimal buyPrice = BigDecimal.valueOf(Double.valueOf(s[6]));
        p.setBuyprice(buyPrice);
        BigDecimal msrp = BigDecimal.valueOf(Double.valueOf(s[7]));
        p.setMsrp(msrp);
        em.persist(p);

    }
}
