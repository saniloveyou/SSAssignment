package com.utar.model.sessionbean;

import com.utar.model.entity.Order;

import javax.ejb.EJBException;
import javax.ejb.Local;
import java.text.ParseException;
import java.util.List;

@Local
public interface OrderSessionBean {
    public List<Order> getAllOrders() throws EJBException;

    public Order findOrder(String id) throws EJBException;

    public int getNumberOfRows(String sql) throws EJBException;

    int getNextOrderNumber() throws EJBException;

    void addOrder(int customernumber, String requiredDate) throws EJBException, ParseException;

    List<Order> readOrder(int currentPage, int recordsPerPage, String sql) throws EJBException;

    void updateOrder(int ordernumber, String requiredDate, String shippedDate, String status, String comments) throws EJBException;

    public void deleteOrder(String id) throws EJBException; // Delete
}
