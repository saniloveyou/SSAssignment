package com.utar.model.sessionbean;

import com.utar.model.entity.Customer;


import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigDecimal;
import java.math.BigInteger;
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
        String sql = "SELECT * \n" +
                "                            from classicmodels.customers c\n" +
                "                            order by c.customernumber "+direction;
        Query q = null;
        q = em.createNativeQuery(sql);
        int start = currentPage * recordsPerPage - recordsPerPage;

        List<Object[]> results = q.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();

        return results;
    }

    @Override
    public Customer findcustomer(String id) throws EJBException {


        int idInt = Integer.parseInt(id);


        Customer info = em.find(Customer.class, idInt);

        return info;
    }

    @Override
    public List<Object[]> filterpayment(String category) throws EJBException {
        String sql = "SELECT * \n" +
                "                            from classicmodels.customers c\n" +
                "                             where "+ category +" order by c.customernumber ";
        Query q = null;
        q = em.createNativeQuery(sql);
        List<Object[]> results = q.getResultList();
        return results;
    }

    @Override
    public List<Customer> readCustomer(int currentPage, int recordsPerPage) throws EJBException {
        return null;
    }

    @Override
    public int getNumberOfRows() throws EJBException {
        Query q = null;
        q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.customers");
        BigInteger results = (BigInteger) q.getSingleResult();
        int i = results.intValue();
        return i;
    }

    @Override
    public int getNextOrderNumber() throws EJBException {
        Query query = em.createNativeQuery("SELECT max(customernumber)+1 FROM classicmodels.customers");
        return Integer.parseInt(query.getSingleResult().toString());
    }

    @Override
    public void updateCustomer(String[] s) throws EJBException {
        String sql = "UPDATE classicmodels.customers SET customername = ? , contactlastname = ? , contactfirstname = ? , phone = ? , addressline1 = ? , addressline2 = ? , city = ? , state = ? , postalcode = ? , country = ? , creditlimit = ? WHERE customernumber = ?";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1,s[1]);
        query.setParameter(2, s[2]);
        query.setParameter(3, s[3]);
        query.setParameter(4, s[4]);
        query.setParameter(5, s[5]);
        query.setParameter(6, s[6]);
        query.setParameter(7, s[7]);
        query.setParameter(8, s[8]);
        query.setParameter(9, s[9]);
        query.setParameter(10, s[10]);
        query.setParameter(11, new BigDecimal(s[12]));
        query.setParameter(12, Short.parseShort(s[0]));
        query.executeUpdate();
    }

    @Override
    public void deleteCustomer(String id) throws EJBException {

//        delete in payment with same id in payment db
        String sql = "DELETE FROM classicmodels.payments WHERE customernumber = ?";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1,Short.parseShort(id));
        query.executeUpdate();

        String sql1 = "DELETE FROM classicmodels.customers WHERE customernumber = ?";
        Query query1 = em.createNativeQuery(sql1);
        query1.setParameter(1,Short.parseShort(id));
        query1.executeUpdate();

        sql1 = "DELETE FROM classicmodels.users WHERE username  = ?";
        query1 = em.createNativeQuery(sql1);
        query1.setParameter(1,id);
        query1.executeUpdate();

        sql1  = "DELETE FROM classicmodels.user_roles WHERE username = ?";
        query1 = em.createNativeQuery(sql1);
        query1.setParameter(1,id);
        query1.executeUpdate();

    }

    @Override
    public void addCustomer(String[] s) throws EJBException {

    }
}
