package com.utar.model.sessionbean;

import javax.ejb.EJBException;

public interface SignUpSessionBean
{
    public void addSignUp(String[] s) throws EJBException;
    public int getNumberOfRows() throws EJBException ;

}
