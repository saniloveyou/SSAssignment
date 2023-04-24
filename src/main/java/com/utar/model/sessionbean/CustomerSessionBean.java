package com.utar.model.sessionbean;

import com.utar.model.entity.Customer;


import javax.ejb.EJBException;
import java.util.List;

public interface CustomerSessionBean {

    public List<Customer> getAllcustomer() throws EJBException;
    public List<Object[]> readpaymentdetails(int currentPage, int recordsPerPage, String direction) throws EJBException;
    public List<Object[]> findcustomer(String id) throws EJBException;
    public List<Customer> readCustomer(int currentPage, int recordsPerPage) throws EJBException;
    public int getNextOrderNumber() throws EJBException;
    public int getNumberOfRows() throws EJBException ;
    public void updateCustomer(String[] s) throws EJBException;
    public void deleteCustomer(String id) throws EJBException;
    public void addCustomer(String[] s) throws EJBException;
}
