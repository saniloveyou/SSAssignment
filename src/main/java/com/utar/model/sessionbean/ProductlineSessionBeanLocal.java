package com.utar.model.sessionbean;

import com.utar.model.entity.Productline;

import javax.ejb.EJBException;
import java.util.List;

public interface ProductlineSessionBeanLocal {

    public List<Productline> readProductline(int currPage, int recordsPerpage, String keyword, String sort) throws EJBException;
    public int getNoOfRows(String keyword) throws EJBException;
    public Productline getProductline(String id) throws EJBException;
    public void updateProductline(String[] s) throws EJBException;
    public void deleteProductline(String id) throws EJBException;
    public void addProductline(String[] s) throws EJBException;
}
