package com.utar.model.sessionbean;

import com.utar.model.entity.User;
import com.utar.model.entity.UserRole;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Stateless
public class LoginSession implements LoginSessionBean{
    @PersistenceContext(unitName = "SSAssignment")
    EntityManager em;

    @Override
    public boolean authenticate(String username, String password) throws EJBException{
        Query  query = em.createNativeQuery("SELECT * FROM classicmodels.users users WHERE users.username = :username AND users.password = :password");
        query.setParameter("username", username);
        query.setParameter("password", password);
        return !query.getResultList().isEmpty();
    }

    @Override
    public String getUserRole(String username) throws EJBException{
        Query query = em.createNativeQuery("SELECT role FROM classicmodels.user_roles where username = :username");
        query.setParameter("username", username);
        return query.getResultList().toString();
    }

}
