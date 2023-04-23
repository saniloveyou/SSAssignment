package com.utar.model.sessionbean;

import com.utar.model.entity.Employee;

import javax.ejb.EJBException;
import javax.ejb.Local;
import java.util.List;

@Local
public interface EmployeeSessionBeanLocal {

    //Read methods
    public List<Employee> getAllEmployees() throws EJBException;
    public List<Employee> getAllEmployeesWithPage(int currentPage, int recordsPerPage, String keyword, String direction) throws EJBException;
    public Employee getEmployee(String employeeId) throws EJBException;

    //Create method
    public Employee createEmployee() throws EJBException;

    //Update method
    public Employee updateEmployee(String employeeId) throws EJBException;

    //Delete method
    public Employee deleteEmployee(String employeeId) throws EJBException;

}
