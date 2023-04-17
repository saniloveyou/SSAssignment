package com.utar.model.sessionbean;

import com.utar.model.entity.Employee;
import com.utar.model.entity.Payment;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
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

        String sql = "select c.customernumber,c.customername,c.phone,pd.amount,pd.paymentdate\n" +
                "from classicmodels.customers c\n" +
                "join classicmodels.payments pd on c.customernumber = pd.customernumber";
        Query q = null;
        q = em.createNativeQuery(sql);


        List<Object[]> results = q.getResultList();

        return results;
    }


    @Override
    public Payment findPayment(String id) throws EJBException {
        return null;
    }

    @Override
    public List<Payment> readPayment(int currentPage, int recordsPerPage) throws EJBException {
        return null;
    }

    @Override
    public int getNumberOfRows() throws EJBException {
        return 0;
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
