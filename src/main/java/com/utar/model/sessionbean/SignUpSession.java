package com.utar.model.sessionbean;

import com.utar.model.entity.User;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigInteger;

@Stateless
public class SignUpSession implements SignUpSessionBean {
    @PersistenceContext(unitName = "SSAssignment")
    EntityManager em;

    @Override
    public int getNumberOfRows() {

        Query q = null;
        q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.users");
        BigInteger results = (BigInteger) q.getSingleResult();

        int i = results.intValue();
        return i;
    }

    @Override
    public User findUser(String id) throws EJBException {
        User info = em.find(User.class,id);

        return info;
    }


    @Override
    public boolean addSignUp(String[] s) throws EJBException {
    User user = new User();
    user.setId(s[0]);
    user.setPassword(s[1]);

    User info = findUser(s[0]);
        System.out.println((info));
        if (info == null) {

            //this function is for adding new user into database
            String sql = "INSERT INTO classicmodels.users VALUES (?, ?)";
            Query query = em.createNativeQuery(sql);
            query.setParameter(1, s[0]);
            query.setParameter(2, s[1]);
            query.executeUpdate();

            //this function os for adding new role into database
            String sql1 = "INSERT INTO classicmodels.user_roles VALUES (?, ?)";
            Query query1 = em.createNativeQuery(sql1);
            query1.setParameter(1, s[0]);
            query1.setParameter(2, "user");
            query1.executeUpdate();


        } else {
            return false;
        }
        return true;

    }
}
