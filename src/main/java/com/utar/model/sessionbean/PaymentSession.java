package com.utar.model.sessionbean;

import com.utar.model.entity.Payment;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
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
    public List<Object[]>  findPaymentCustomer(String category) throws EJBException {

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
    public List<Object[]>  findpayment(String id) throws EJBException {
        String sql = "Select * from classicmodels.payments where checknumber = '"+id+"'";
        Query q = null;
        q = em.createNativeQuery(sql);
        List<Object[]>  results = q.getResultList();
        return results;
    }

    public int getNextPaymentNumber() throws EJBException {
        Query query = em.createNativeQuery("SELECT COUNT(*)+1 AS totalrow FROM classicmodels.payments");
        return Integer.parseInt(query.getSingleResult().toString());
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
        String sql = "UPDATE classicmodels.payments SET paymentdate = ?, amount = ? WHERE checknumber = ?";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1, s[2]);
        query.setParameter(2,new BigDecimal(s[1]));
        query.setParameter(3, s[0]);
        query.executeUpdate();

        String sql1 = "UPDATE classicmodels.customers SET creditlimit = ? WHERE customernumber = ?";
        Query query1 = em.createNativeQuery(sql1);
//        cast the s[3] to be small int
        query1.setParameter(1, new BigDecimal(s[3]));
        query1.setParameter(2, Short.parseShort(s[4]));
        query1.executeUpdate();

    }

    @Override
    public void deletePayment(String id) throws EJBException {
        String sql = "DELETE FROM classicmodels.payments WHERE checknumber = ?";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1, id);
        query.executeUpdate();
    }

    @Override
    public void addPayment(String[] s) throws EJBException {
        Query query = em.createNativeQuery("INSERT INTO classicmodels.payments VALUES (?, ?, ?, ?)");

        query.setParameter(1,Short.parseShort(s[0]) );
        query.setParameter(2,s[1]);
        query.setParameter(3,s[2] );
        query.setParameter(4,new BigDecimal(s[3]) );

        query.executeUpdate();
    }
}
