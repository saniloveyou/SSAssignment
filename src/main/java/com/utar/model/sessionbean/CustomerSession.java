package com.utar.model.sessionbean;

import com.utar.model.entity.Customer;


import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigDecimal;
import java.util.List;

@Stateless
public class CustomerSession implements CustomerSessionBean{
    @PersistenceContext(unitName = "SSAssignment")
    EntityManager em;

    @Override
    public List<Customer> getAllcustomer() throws EJBException {
        return null;
    }

    @Override
    public List<Object[]> readpaymentdetails(int currentPage, int recordsPerPage, String direction) throws EJBException {
        return null;
    }

    @Override
    public Customer findcustomer(String id) throws EJBException {


        int idInt = Integer.parseInt(id);


        Customer info = em.find(Customer.class, idInt);

        return info;
    }

    @Override
    public List<Customer> readCustomer(int currentPage, int recordsPerPage) throws EJBException {
        return null;
    }

    @Override
    public int getNumberOfRows() throws EJBException {
        return 0;
    }

    @Override
    public int getNextOrderNumber() throws EJBException {
        Query query = em.createNativeQuery("SELECT max(customernumber)+1 FROM classicmodels.customers");
        return Integer.parseInt(query.getSingleResult().toString());
    }

    @Override
    public void updateCustomer(String[] s) throws EJBException {
        String sql = "UPDATE classicmodels.customers SET creditlimit = ? WHERE customernumber = ?";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1,new BigDecimal(s[0]));
        query.setParameter(2, s[1]);
        query.executeUpdate();
    }

    @Override
    public void deleteCustomer(String id) throws EJBException {

    }

    @Override
    public void addCustomer(String[] s) throws EJBException {

    }
}
