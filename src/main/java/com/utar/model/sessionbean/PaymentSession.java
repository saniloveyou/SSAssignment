package com.utar.model.sessionbean;

import com.utar.model.entity.Employee;
import com.utar.model.entity.Payment;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigInteger;
import java.util.List;

@Stateless
public class PaymentSession implements PaymentSessionBean {

    @PersistenceContext(unitName = "SSAssignment")
    EntityManager em;

    @Override
    public List<Payment> getAllPayment() throws EJBException {
        Query q = null;
        q = em.createNativeQuery("SELECT * FROM classicmodels.payments order by customernumber", Payment.class);
        List<Payment> results = q.getResultList();

    return results;

    }

    @Override
    public List<Object[]> readpaymentdetails(int currentPage, int recordsPerPage, String direction) throws EJBException {

        String sql = "SELECT c.customernumber, c.customername,c.phone,c.creditlimit,pd.checknumber,pd.paymentdate,pd.amount\n" +
                "                            from classicmodels.customers c\n" +
                "                            join classicmodels.payments pd on c.customernumber = pd.customernumber\n" +
                "                                join classicmodels.orders o on c.customernumber = o.customernumber\n" +
                "                                where c.creditlimit IS NOT NULL  AND o.status = 'Shipped' group by c.customernumber,pd.checknumber,pd.paymentdate,pd.amount,o.status order by c.customernumber "+direction;
        Query q = null;
        q = em.createNativeQuery(sql);
        int start = currentPage * recordsPerPage - recordsPerPage;

        List<Object[]> results = q.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();

        return results;
    }

//this is for search function in payment
    @Override
    public List<Object[]>  findPayment(String category) throws EJBException {

        String sql = "SELECT c.customernumber, c.customername,c.phone,c.creditlimit,pd.checknumber,pd.paymentdate,pd.amount\n" +
                "                            from classicmodels.customers c\n" +
                "                            join classicmodels.payments pd on c.customernumber = pd.customernumber\n" +
                "                                join classicmodels.orders o on c.customernumber = o.customernumber\n" +
                "                                where c.creditlimit IS NOT NULL  AND o.status = 'Shipped' AND "+ category +" group by c.customernumber,pd.checknumber,pd.paymentdate,pd.amount,o.status " +
                "order by c.customernumber ";
        Query q = null;
        q = em.createNativeQuery(sql);
        List<Object[]> results = q.getResultList();
        return results;
    }

    @Override
    public List<Payment> readPayment(int currentPage, int recordsPerPage) throws EJBException {
        return null;
    }

    @Override
    public int getNumberOfRows() throws EJBException {
        Query q = null;
        q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.payments");
        BigInteger results = (BigInteger) q.getSingleResult();
        int i = results.intValue();
        return i;
    }

    @Override
    public void updatePayment(String[] s) throws EJBException {

    }

    @Override
    public void deletePayment(String id) throws EJBException {

    }

    @Override
    public void addPayment(String[] s) throws EJBException {

    }
}
