package com.utar.model.sessionbean;

import com.utar.model.entity.Order;
import com.utar.model.entity.Orderdetail;
import com.utar.model.entity.OrderdetailId;
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

        Query query = entityManager.createNativeQuery("SELECT * FROM classicmodels.orders WHERE ordernumber = :ordernumber", Order.class);
        query.setParameter("ordernumber", ordernumber);

        Order result = null;
        try {
            result = (Order) query.getSingleResult();
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
    public List<Order> readOrder(int currentPage, int recordsPerPage, String sql) throws EJBException {
//        String statement = "SELECT ordernumber, orderdate, requireddate, CASE WHEN shippeddate = '' THEN null ELSE shippeddate END, status, comments, customerNumber FROM classicmodels.orders order by "+orderBy;
        Query query = entityManager.createNativeQuery(sql, Order.class);
        int start = currentPage * recordsPerPage - recordsPerPage;
        return query.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();
    }
//
//    @Override
//    public List<Order> readOrder(int currentPage, int recordsPerPage, String sortBy, String direction, String ordernumber, String customernumber, String fromOrderDate, String toOrderDate, String fromRequiredDate, String toRequiredDate, String fromShippedDate, String toShippedDate) throws EJBException {
//        String orderBy = sortBy + " " + direction;
//        String where = "WHERE ";
//        if (!ordernumber.isEmpty()) where += "ordernumber = " + ordernumber + " AND ";
//        if (!customernumber.isEmpty()) where += "customernumber = " + customernumber + " AND ";
////        if (!fromOrderDate.isEmpty()) where += "orderdate >= '" + fromOrderDate + "' AND ";
////        if (!toOrderDate.isEmpty()) where += "orderdate <= '" + toOrderDate + "' AND ";
////        if (!fromRequiredDate.isEmpty()) where += "requireddate >= '" + fromRequiredDate + "' AND ";
////        if (!toRequiredDate.isEmpty()) where += "requireddate <= '" + toRequiredDate + "' AND ";
////        if (!fromShippedDate.isEmpty()) where += "shippeddate >= '" + fromShippedDate + "' AND ";
////        if (!toShippedDate.isEmpty()) where += "shippeddate <= '" + toShippedDate + "' AND ";
////        if (status.length > 0) {
////            where += " status IN (";
////            for (int i = 0; i < status.length; i++) {
////                where += "'" + status[i] + "'";
////                if (i != status.length - 1) where += ", ";
////            }
////            where += ") AND ";
////        }
//
//        if (where.equals("WHERE ")) where = "";
//        else where = where.substring(0, where.length() - 5);
//
//        String statement = "SELECT ordernumber, orderdate, requireddate, CASE WHEN shippeddate = '' THEN null ELSE shippeddate END, status, comments, customerNumber FROM classicmodels.orders " + where + " order by "+orderBy;
//        Query query = entityManager.createNativeQuery(statement, Order.class);
//        int start = currentPage * recordsPerPage - recordsPerPage;
//        return query.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();
//    }

    @Override
    public void updateOrder(int ordernumber, String requiredDate, String shippedDate, String status, String comments) throws EJBException {
        String sql = "UPDATE classicmodels.orders SET ";
        if (!requiredDate.isEmpty()) {
            sql += "requireddate = :requireddate, ";
        }
        if (!shippedDate.isEmpty()) {
            sql += "shippeddate = :shippeddate, ";
        }
        if (!status.isEmpty()) {
            sql += "status = :status, ";
        }
        if (!comments.isEmpty()) {
            sql += "comments = :comments ";
        }
        sql += "WHERE ordernumber = :ordernumber";
        Query query = entityManager.createNativeQuery(sql);
        query.executeUpdate();
    }

    @Override
    public void deleteOrder(String id) throws EJBException {
        Query query = entityManager.createNativeQuery("DELETE FROM classicmodels.orders WHERE ordernumber = :ordernumber");
        query.setParameter("ordernumber", id);
        query.executeUpdate();
    }


}
