package com.utar.model.sessionbean;

import com.utar.model.entity.Order;

import javax.ejb.EJBException;
import javax.ejb.Local;
import java.util.List;

@Local

public interface OrderSessionBean {

    public List<Order> getAllOrders() throws EJBException;

    public Order findOrder(String id) throws EJBException;

    public int getNumberOfRows(String keyword) throws EJBException;

    public void addOrder(String[] s) throws EJBException; // Create

    public List<Order> readOrder(int currentPage, int recordsPerPage, String keyword, String direction) throws EJBException; // Read

    public void updateOrder(String[] s) throws EJBException; // Update

    public void deleteOrder(String id) throws EJBException; // Delete

    public List<Order> searchOrderAjax(String empid) throws EJBException;

    public List<Order> getOrder(String id);

//    public List<Order> getEmployeeByName(String firstName, String lastName ) ;
}
