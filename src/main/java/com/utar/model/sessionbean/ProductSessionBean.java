package com.utar.model.sessionbean;

import com.utar.model.entity.Product;

import javax.ejb.EJBException;
import java.util.List;

public interface ProductSessionBean {
    public List<Product> getAllProducts() throws EJBException;
    public Product findProduct(String id) throws EJBException;
    public List<Product> readProduct(int currentPage, int recordsPerPage) throws EJBException;
    public int getNumberOfRows() throws EJBException ;
    public void updateProduct(String[] s) throws EJBException;
    public void deleteProduct(String id) throws EJBException;
    public void addProduct(String[] s) throws EJBException;
}
