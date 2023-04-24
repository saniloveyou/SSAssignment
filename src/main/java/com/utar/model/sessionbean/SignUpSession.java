package com.utar.model.sessionbean;

import com.utar.model.entity.User;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigDecimal;
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
            query.setParameter(2, s[2]);
            query.executeUpdate();

            //this function os for adding new role into database
            String sql1 = "INSERT INTO classicmodels.user_roles VALUES (?, ?)";
            Query query1 = em.createNativeQuery(sql1);
            query1.setParameter(1, s[0]);
            query1.setParameter(2, "user");
            query1.executeUpdate();

            String sql2 = "INSERT INTO classicmodels.customers VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
            Query query2 = em.createNativeQuery(sql2);
            query2.setParameter(1, Short.parseShort(s[0]));
            query2.setParameter(2, s[1]);
            query2.setParameter(3, s[3]);
            query2.setParameter(4, s[4]);
            query2.setParameter(5, s[5]);
            query2.setParameter(6, s[6]);
            query2.setParameter(7, s[7]);
            query2.setParameter(8, s[8]);
            query2.setParameter(9, s[9]);
            query2.setParameter(10, s[10]);
            query2.setParameter(11, s[11]);
            query2.setParameter(12, Short.parseShort("0"));
            query2.setParameter(13, new BigDecimal(s[12]));
            query2.executeUpdate();

        } else {
            return false;
        }
        return true;

    }
}
