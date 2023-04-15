package com.utar.model.sessionbean;

import com.utar.model.entity.User;

import javax.ejb.EJBException;

public interface SignUpSessionBean
{
    User findUser(String id) throws EJBException;
    public boolean addSignUp(String[] s) throws EJBException;
    public int getNumberOfRows() throws EJBException ;

}
