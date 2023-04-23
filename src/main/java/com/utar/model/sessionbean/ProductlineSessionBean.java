package com.utar.model.sessionbean;

import com.utar.model.entity.Productline;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigInteger;
import java.util.List;

@Stateless
public class ProductlineSessionBean implements ProductlineSessionBeanLocal{
    @PersistenceContext(unitName = "SSAssignment")
    EntityManager em;


    @Override
    public List<Productline> readProductline(int currPage, int recordsPerPage, String keyword, String sort) throws EJBException {
        Query q = null;
        int start = 0;
        sort = " " + sort;

        if(keyword.isEmpty()) {
            q = em.createNativeQuery("SELECT * FROM classicmodels.productlines order by productline" + sort, Productline.class);
            start = currPage * recordsPerPage - recordsPerPage;
        }else{
            q = em.createNativeQuery("SELECT * FROM classicmodels.productlines WHERE productline LIKE ? ORDER by productline" + sort, Productline.class);
            start = currPage * recordsPerPage - recordsPerPage;
            q.setParameter(1,"%" + keyword +"%");

        }
        List<Productline> results = q.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();
        return results;
    }

    @Override
    public int getNoOfRows(String keyword) throws EJBException {
        Query q = null;
        if(keyword.isEmpty()){
            q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.productlines");
        }else{
            q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.productlines WHERE " +
                    "productline LIKE ?");
            q.setParameter(1, "%" + keyword + "%");
        }

        BigInteger results = (BigInteger)q.getSingleResult();
        int i = results.intValue();
        return i;
    }

    @Override
    public Productline getProductline(String id) throws EJBException {
        Query q = em.createNamedQuery("productlines.findById");
        q.setParameter("id",id);
        return (Productline) q.getSingleResult();
    }

    @Override
    public void updateProductline(String[] s) throws EJBException {
        Productline pl = getProductline(s[0]);
//        pl.setId(s[0]);
        pl.setTextdescription(s[1]);
        pl.setHtmldescription(s[2]);
        pl.setImage(s[3]);
        em.merge(pl);
    }

    @Override
    public void deleteProductline(String id) throws EJBException {
        Productline pl = getProductline(id);
        em.remove(pl);
    }

    @Override
    public void addProductline(String[] s) throws EJBException {
        Productline pl = new Productline();
        pl.setId(s[0]);
        pl.setTextdescription(s[1]);
        pl.setHtmldescription(s[2]);
        pl.setImage(s[3]);
        em.persist(pl);
    }
}
