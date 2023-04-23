package com.utar.model.sessionbean;

import com.utar.model.entity.Employee;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

@Stateless
public class EmployeeSessionBean implements EmployeeSessionBeanLocal{

    EntityManager em;

    @Override
    public List<Employee> getAllEmployees() throws EJBException {
        return em.createNamedQuery("getAllEmployees").getResultList();
    }

    @Override
    public List<Employee> getAllEmployeesWithPage(int currentPage, int recordsPerPage, String keyword, String direction) throws EJBException {
        Query q = null;
        int start = 0;
        direction = " " + direction;
        if (keyword.isEmpty()) {
            q = em.createNativeQuery("SELECT * FROM classicmodels.employees order by employeeNumber" + direction, Employee.class);
            start = (currentPage * recordsPerPage) - recordsPerPage;
        } else {
            //Left off here
        }
        return null;
    }

    @Override
    public Employee getEmployee(String employeeId) throws EJBException {
        Query q = em.createNamedQuery("getEmployee");
        q.setParameter("employeeId", Integer.valueOf(employeeId));
        return (Employee) q.getSingleResult();
    }

    @Override
    public Employee createEmployee() throws EJBException {
        return null;
    }

    @Override
    public Employee updateEmployee(String employeeId) throws EJBException {
        return null;
    }

    @Override
    public Employee deleteEmployee(String employeeId) throws EJBException {
        return null;
    }
}
