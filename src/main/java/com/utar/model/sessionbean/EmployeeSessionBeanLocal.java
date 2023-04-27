package com.utar.model.sessionbean;

import com.utar.model.entity.Employee;
import com.utar.model.entity.Office;

import javax.ejb.EJBException;
import javax.ejb.Local;
import java.util.List;

@Local
public interface EmployeeSessionBeanLocal {

    //Read methods
    public List<Employee> getAllEmployees() throws EJBException;

    public List<Employee> getAllEmployeesWithPage(int currentPage, int recordsPerPage, String keyword, String direction) throws EJBException;

    public Employee getEmployee(int employeeId) throws EJBException;

    //Create method
    public int createEmployee(String firstName, String lastName, String email, String extension, Office officeObj, String reportsTo, String jobTitle) throws EJBException;

    //Update method
    public Employee updateEmployee(int employeeId, String firstName, String lastName, String email, String extension, String reportsTo, String jobTitle, Office officeObj) throws EJBException;

    //Delete method
    public int deleteEmployee(int employeeId) throws EJBException;
}
