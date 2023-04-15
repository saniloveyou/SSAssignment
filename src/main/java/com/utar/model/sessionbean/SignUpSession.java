package com.utar.model.sessionbean;

import com.utar.model.entity.User;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigInteger;

@Stateless
public class SignUpSession implements SignUpSessionBean{
    @PersistenceContext(unitName = "SSAssignment")
    EntityManager em;

    @Override
    public int getNumberOfRows() {
        System.out.println("getNumberOfRows");
        Query q = null;
        q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.users");
        BigInteger results = (BigInteger) q.getSingleResult();
        System.out.println("getNumberOfRows");
        int i = results.intValue();
        return i;
    }

    @Override
    public void addSignUp(String[] s) throws EJBException {
    User user = new User();
    user.setId(s[0]);
    user.setPassword(s[1]);
    em.persist(user);
    }
}
