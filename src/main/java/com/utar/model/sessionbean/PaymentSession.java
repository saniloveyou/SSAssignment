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
        System.out.println("this line is here");
        List<Payment> results = q.getResultList();
        System.out.println("this line is here"+ results);
//        q = em.createNativeQuery("select p.productname, o.ordernumber, cd.customernumber,c.customername,cd.checknumber,cd.paymentdate,cd.amount from classicmodels.payments cd join classicmodels.customers c on cd.customernumber = c.customernumber join classicmodels.orders o on c.customernumber = o.customernumber join classicmodels.orderdetails od on o.ordernumber = od.ordernumber join classicmodels.products p on od.productcode = p.productcode order by cd.customernumber ");

    return results;

    }

    @Override
    public List<Object[]> getpaymentdetails() throws EJBException {

        String sql = "SELECT c.customernumber, c.customername,pd.checknumber,pd.paymentdate,pd.amount\n" +
                "                            from classicmodels.customers c\n" +
                "                            join classicmodels.payments pd on c.customernumber = pd.customernumber\n" +
                "                                join classicmodels.orders o on c.customernumber = o.customernumber\n" +
                "                                where o.status = 'Shipped' group by c.customernumber,pd.checknumber,pd.paymentdate,pd.amount,o.status order by c.customernumber,pd.checknumber,pd.paymentdate,pd.amount DESC";
        Query q = null;
        q = em.createNativeQuery(sql);

        List<Object[]> results = q.getResultList();

        return results;
    }

//this is for search function in payment
    @Override
    public List<Object[]>  findPayment(String category) throws EJBException {

        String sql = "SELECT c.customernumber, c.customername,pd.checknumber,pd.paymentdate,pd.amount\n" +
                "                            from classicmodels.customers c\n" +
                "                            join classicmodels.payments pd on c.customernumber = pd.customernumber\n" +
                "                                join classicmodels.orders o on c.customernumber = o.customernumber\n" +
                "                                where o.status = 'Shipped' AND pd.paymentdate "+ "BETWEEN '05/06/2003' AND '05/06/2010'" +" group by c.customernumber,pd.checknumber,pd.paymentdate,pd.amount,o.status " +
                "order by c.customernumber,pd.checknumber,pd.paymentdate,pd.amount DESC";
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
