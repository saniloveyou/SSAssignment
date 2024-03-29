package com.utar.model.sessionbean;

import com.utar.model.entity.Order;
import com.utar.model.entity.Orderdetail;

import javax.ejb.EJBException;
import javax.ejb.Local;
import java.text.ParseException;
import java.util.List;

@Local
public interface OrderSessionBean {
    public List<Order> getAllOrders() throws EJBException;

    public Order findOrder(String id) throws EJBException;

    public List<Order> findOrders(String customernumber) throws EJBException;

    int cartCount(String customernumber) throws EJBException;

    List<Orderdetail> cartList(String customernumber) throws EJBException;

    public Orderdetail findOrderdetail(String ordernumber, String productcode) throws EJBException;

    public int getNumberOfRows(String sql) throws EJBException;

    public int getNextOrderNumber() throws EJBException;

    public int getNextOrderNumber(String customernumber) throws EJBException;

    public void addOrder(int ordernumber, int customernumber) throws EJBException;

    public void addOrderDetails(int ordernumber, String productcode) throws EJBException;

    public void addOrderDetails(int ordernumber, String productcode, String price) throws EJBException;

    public List<Order> readOrder(int currentPage, int recordsPerPage, String sql) throws EJBException;

    public List<Orderdetail> readOrderdetail(int currentPage, int recordsPerPage, String sql) throws EJBException;

    public void updateOrder(int ordernumber, String requiredDate, String shippedDate, String status, String comments) throws EJBException;

    public void updateOrderdetail(int ordernumber, String productcode, int quantityordered, double priceeach) throws EJBException;

    public void deleteOrder(String id) throws EJBException; // Delete

    public void deleteOrderdetail(String id, String productcode) throws EJBException;

    public void addit(String[] s) throws EJBException;

    public List<Orderdetail> findOrderdetails(String ordernumber) throws EJBException;
}
