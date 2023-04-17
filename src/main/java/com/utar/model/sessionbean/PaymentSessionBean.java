package com.utar.model.sessionbean;

import com.utar.model.entity.Customer;
import com.utar.model.entity.Payment;


import javax.ejb.EJBException;
import java.util.List;

public interface PaymentSessionBean {

    public List<Payment> getAllPayment() throws EJBException;
    public List<Object[]> readpaymentdetails(int currentPage, int recordsPerPage, String direction) throws EJBException;
    public List<Object[]> findPayment(String category) throws EJBException;
    public List<Payment> readPayment(int currentPage, int recordsPerPage) throws EJBException;
    public int getNumberOfRows() throws EJBException ;
    public void updatePayment(String[] s) throws EJBException;
    public void deletePayment(String id) throws EJBException;
    public void addPayment(String[] s) throws EJBException;


}
