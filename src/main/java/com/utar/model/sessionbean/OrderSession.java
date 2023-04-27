package com.utar.model.sessionbean;

import com.utar.model.entity.Order;
import com.utar.model.entity.Orderdetail;
import com.utar.model.entity.Product;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Stateless
public class OrderSession implements OrderSessionBean{

    @PersistenceContext(unitName = "SSAssignment")
    EntityManager entityManager;

    @Override
    public List<Order> getAllOrders() throws EJBException {
        Query query = entityManager.createNamedQuery("Order.findAll");
        return query.getResultList();
    }

    @Override
    public Order findOrder(String ordernumber) throws EJBException {
        String sql = "SELECT * FROM classicmodels.orders WHERE ordernumber = " + ordernumber;
        Query query = entityManager.createNativeQuery(sql, Order.class);
        Order result = null;
        try {
            result = (Order) query.getSingleResult();
        } catch (Exception e) {
            System.out.println("Order not found");
        }
        return result;
    }

    @Override
    public Orderdetail findOrderdetail(String ordernumber, String productcode) throws EJBException {
        String sql = "SELECT * FROM classicmodels.orderdetails WHERE ordernumber = " + ordernumber + " AND productcode = '" + productcode + "'";
        Query query = entityManager.createNativeQuery(sql, Orderdetail.class);
        Orderdetail result = null;
        try {
            result = (Orderdetail) query.getSingleResult();
        } catch (Exception e) {
            System.out.println("Order not found");
        }
        return result;
    }


    @Override
    public int getNumberOfRows(String sql) throws EJBException {
        Query query = entityManager.createNativeQuery(sql);
        return ((BigInteger) query.getSingleResult()).intValue();
    }

    @Override
    public int getNextOrderNumber() throws EJBException {
        Query query = entityManager.createNativeQuery("SELECT max(ordernumber)+1 FROM classicmodels.orders");
        return Integer.parseInt(query.getSingleResult().toString());
    }

    @Override
    public int getNextOrderNumber(String customernumber) throws EJBException {
        Query query = entityManager.createNativeQuery("SELECT max(ordernumber) FROM classicmodels.orders WHERE customernumber = " + customernumber);
        int lastOrderNumber = Integer.parseInt(query.getSingleResult().toString());

        query = entityManager.createNativeQuery("SELECT orderdate FROM classicmodels.orders WHERE ordernumber = " + lastOrderNumber);
        String orderDate = query.getSingleResult().toString();
        if (!orderDate.equals(new SimpleDateFormat("yyyy-MM-dd").format(new Date()))){
            return lastOrderNumber + 1;
        }
        else {
            return lastOrderNumber;
        }
    }


    @Override
    public void addOrder(int ordernumber, int customernumber) throws EJBException {
        Query query = entityManager.createNativeQuery("INSERT INTO classicmodels.orders (ordernumber, orderdate, requireddate, shippeddate, status, comments, customernumber) VALUES (:ordernumber, :orderdate, :requireddate, :shippeddate, :status, :comments, :customernumber)");
        query.setParameter("ordernumber", ordernumber);
        query.setParameter("orderdate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        query.setParameter("requireddate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        query.setParameter("shippeddate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        query.setParameter("status", "In Process");
        query.setParameter("comments", "");
        query.setParameter("customernumber", customernumber);
        query.executeUpdate();

    }

    @Override
    public void addOrderDetails(int ordernumber, String productcode) throws EJBException {
        Query query = entityManager.createNativeQuery("SELECT * FROM classicmodels.orderdetails WHERE ordernumber = :ordernumber AND productcode = :productcode", Orderdetail.class);
        query.setParameter("ordernumber", ordernumber);
        query.setParameter("productcode", productcode);
        Orderdetail result = null;
        try {
            result = (Orderdetail) query.getSingleResult();
        } catch (Exception e) {
            System.out.println("Order not found");
        }

        query = entityManager.createNativeQuery("SELECT * FROM classicmodels.orders WHERE ordernumber = :ordernumber", Order.class);
        query.setParameter("ordernumber", ordernumber);
        Order order = (Order) query.getSingleResult();


        query = entityManager.createNativeQuery("SELECT CASE WHEN MAX(orderlinenumber) IS NULL THEN 1 ELSE MAX(orderlinenumber)+1 END FROM classicmodels.orderdetails WHERE ordernumber = :ordernumber");
        query.setParameter("ordernumber", ordernumber);
        int orderlinenumber = Integer.parseInt(query.getSingleResult().toString());

        query = entityManager.createNativeQuery("SELECT * FROM classicmodels.products WHERE productcode = :productcode", Product.class);
        query.setParameter("productcode", productcode);
        Product product = (Product) query.getSingleResult();

        query = entityManager.createNativeQuery("INSERT INTO classicmodels.orderdetails (ordernumber, productcode, quantityordered, priceeach, orderlinenumber) VALUES (:ordernumber, :productcode, :quantityordered, :priceeach, :orderlinenumber)");
        query.setParameter("ordernumber", ordernumber);
        query.setParameter("productcode", productcode);
        query.setParameter("quantityordered", 1);
        query.setParameter("priceeach", product.getMsrp());
        query.setParameter("orderlinenumber", orderlinenumber);
        query.executeUpdate();



    }
    @Override
    public void addOrderDetails(int ordernumber, String productcode,String price) throws EJBException {
        Query query = entityManager.createNativeQuery("SELECT * FROM classicmodels.orderdetails WHERE ordernumber = :ordernumber AND productcode = :productcode", Orderdetail.class);
        query.setParameter("ordernumber", ordernumber);
        query.setParameter("productcode", productcode);
        Orderdetail result = null;
        try {
            result = (Orderdetail) query.getSingleResult();
        } catch (Exception e) {
            System.out.println("Order not found");
        }

        query = entityManager.createNativeQuery("SELECT * FROM classicmodels.orders WHERE ordernumber = :ordernumber", Order.class);
        query.setParameter("ordernumber", ordernumber);
        Order order = (Order) query.getSingleResult();


        query = entityManager.createNativeQuery("SELECT CASE WHEN MAX(orderlinenumber) IS NULL THEN 1 ELSE MAX(orderlinenumber)+1 END FROM classicmodels.orderdetails WHERE ordernumber = :ordernumber");
        query.setParameter("ordernumber", ordernumber);
        int orderlinenumber = Integer.parseInt(query.getSingleResult().toString());

        query = entityManager.createNativeQuery("SELECT * FROM classicmodels.products WHERE productcode = :productcode", Product.class);
        query.setParameter("productcode", productcode);
        Product product = (Product) query.getSingleResult();

        query = entityManager.createNativeQuery("INSERT INTO classicmodels.orderdetails (ordernumber, productcode, quantityordered, priceeach, orderlinenumber) VALUES (:ordernumber, :productcode, :quantityordered, :priceeach, :orderlinenumber)");
        query.setParameter("ordernumber", ordernumber);
        query.setParameter("productcode", productcode);
        query.setParameter("quantityordered", 1);
        query.setParameter("priceeach", Double.parseDouble(price));
        query.setParameter("orderlinenumber", orderlinenumber);
        query.executeUpdate();

    }



    @Override
    public List<Order> readOrder(int currentPage, int recordsPerPage, String sql) throws EJBException {
        Query query = entityManager.createNativeQuery(sql, Order.class);
        int start = currentPage * recordsPerPage - recordsPerPage;
        return query.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();
    }

    @Override
    public List<Orderdetail> readOrderdetail(int currentPage, int recordsPerPage, String sql) throws EJBException {
        Query query = entityManager.createNativeQuery(sql, Orderdetail.class);
        int start = currentPage * recordsPerPage - recordsPerPage;
        return query.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();
    }


    @Override
    public void updateOrder(int ordernumber, String requireddate, String shippeddate, String status, String comments) throws EJBException {
        String sql = "UPDATE classicmodels.orders SET ";
        if (!requireddate.isEmpty()) {
            sql += "requireddate = '" + requireddate +"', ";
        }
        if (!shippeddate.isEmpty()) {
            sql += "shippeddate = '"+shippeddate+"', ";
        }
        if (!status.isEmpty()) {
            sql += "status = '"+status+"', ";
        }

        sql += "comments = '"+comments+"' ";

        if (sql.endsWith(", ")) {
            sql = sql.substring(0, sql.length() - 2);
        }

        sql += " WHERE ordernumber = "+ordernumber+"";

        System.out.println(sql);
        Query query = entityManager.createNativeQuery(sql);
        query.executeUpdate();
    }

    @Override
    public void updateOrderdetail(int ordernumber, String productcode, int quantityordered, double priceeach) throws EJBException {
        String sql = "UPDATE classicmodels.orderdetails SET ";
        if (quantityordered != 0) {
            sql += "quantityordered = " + quantityordered +", ";
        }
        if (priceeach != 0) {
            sql += "priceeach = "+priceeach+", ";
        }


        if (sql.endsWith(", ")) {
            sql = sql.substring(0, sql.length() - 2);
        }

        sql += " WHERE ordernumber = "+ordernumber+" AND productcode = '"+productcode+"'";

        System.out.println(sql);
        Query query = entityManager.createNativeQuery(sql);
        query.executeUpdate();
    }


    @Override
    public void deleteOrder(String id) throws EJBException {
        // first delete record from orderdetails table since it have the foreign key
        Query query = entityManager.createNativeQuery("DELETE FROM classicmodels.orderdetails WHERE ordernumber = "+id);
        query.executeUpdate();
        query = entityManager.createNativeQuery("DELETE FROM classicmodels.orders WHERE ordernumber = "+id);
        query.executeUpdate();
    }

    @Override
    public void deleteOrderdetail(String id, String productcode) throws EJBException {
        // first delete record from orderdetails table since it have the foreign key
        Query query = entityManager.createNativeQuery("DELETE FROM classicmodels.orderdetails WHERE ordernumber = "+id + " AND productcode = '"+productcode+"'");
        query.executeUpdate();

        // check if there is no more orderdetail with the same ordernumber
        query = entityManager.createNativeQuery("SELECT * FROM classicmodels.orderdetails WHERE ordernumber = "+id);
        List<Orderdetail> result = query.getResultList();
        if (result.isEmpty()) {
            query = entityManager.createNativeQuery("DELETE FROM classicmodels.orders WHERE ordernumber = "+id);
            query.executeUpdate();
        }
    }

    @Override
    public  void addit(String[] s) throws EJBException{
        Query query = entityManager.createNativeQuery("INSERT INTO classicmodels.orders VALUES (:ordernumber, :orderdate, :requireddate, :shippeddate, :status, :comments, :customernumber)");
        query.setParameter("ordernumber",Integer.parseInt(s[0]));
        query.setParameter("orderdate", s[1]);
        query.setParameter("requireddate", s[2]);
        query.setParameter("shippeddate", s[3]);
        query.setParameter("status", s[4]);
        query.setParameter("comments", s[5]);
        query.setParameter("customernumber", Short.parseShort(s[6]));
        query.executeUpdate();
    }

}
