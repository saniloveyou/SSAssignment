package com.utar.model.sessionbean;

import com.utar.model.entity.Order;

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
    public int getNumberOfRows() throws EJBException {
        Query query = entityManager.createNativeQuery("SELECT COUNT(*) FROM classicmodels.orders");
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
    public List<Order> readOrder(int currentPage, int recordsPerPage, String sortBy, String direction) throws EJBException {
        String orderBy = sortBy + " " + direction;
        String statement = "SELECT ordernumber, orderdate, requireddate, CASE WHEN shippeddate = '' THEN null ELSE shippeddate END, status, comments, customerNumber FROM classicmodels.orders order by "+orderBy;
        Query query = entityManager.createNativeQuery(statement, Order.class);
        int start = currentPage * recordsPerPage - recordsPerPage;
        return query.setFirstResult(start).setMaxResults(recordsPerPage).getResultList();
    }

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
