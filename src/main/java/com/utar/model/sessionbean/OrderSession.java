package com.utar.model.sessionbean;

import com.utar.model.entity.Order;

import javax.ejb.EJBException;
import java.util.List;

public class OrderSession implements OrderSessionBean{



    @Override
    public List<Order> getAllOrders() throws EJBException {
        return null;
    }

    @Override
    public Order findOrder(String id) throws EJBException {
        return null;
    }

    @Override
    public int getNumberOfRows(String keyword) throws EJBException {
        return 0;
    }

    @Override
    public void addOrder(String[] s) throws EJBException {

    }

    @Override
    public List<Order> readOrder(int currentPage, int recordsPerPage, String keyword, String direction) throws EJBException {
        return null;
    }

    @Override
    public void updateOrder(String[] s) throws EJBException {

    }

    @Override
    public void deleteOrder(String id) throws EJBException {

    }

    @Override
    public List<Order> searchOrderAjax(String empid) throws EJBException {
        return null;
    }

    @Override
    public List<Order> getOrder(String id) {
        return null;
    }
}
