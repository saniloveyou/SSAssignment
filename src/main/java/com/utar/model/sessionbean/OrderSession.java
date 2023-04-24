package com.utar.model.sessionbean;

import com.utar.model.entity.Order;
import com.utar.model.entity.Product;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
        Query query = entityManager.createNamedQuery("Order.findbyId");
        return (Order) query.getSingleResult();
    }

    @Override
    public int getNumberOfRows(String sql) throws EJBException {
        Query query = entityManager.createNativeQuery(sql);
        return ((BigInteger) query.getSingleResult()).intValue();
    }

    @Override
    public int getNextOrderNumber(String keyword) throws EJBException {
        Query query = entityManager.createNativeQuery("SELECT max(ordernumber)+1 FROM classicmodels.orders");
        return Integer.parseInt(query.getSingleResult().toString());
    }

    @Override
    public void addOrder(int customernumber, String requiredDate) throws EJBException, ParseException {
        Query query = entityManager.createNativeQuery("INSERT INTO classicmodels.orders VALUES (:ordernumber, :orderdate, :requireddate, :shippeddate, :status, :comments, :customernumber)");
        query.setParameter("ordernumber", getNextOrderNumber("ordernumber"));
        query.setParameter("orderdate", java.sql.Date.valueOf(java.time.LocalDate.now()));
        query.setParameter("requireddate", new SimpleDateFormat("yyyy-MM-dd").parse(requiredDate));
        query.setParameter("shippeddate", null);
        query.setParameter("status", "In Process");
        query.setParameter("comments", "");
        query.setParameter("customernumber", customernumber);
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
