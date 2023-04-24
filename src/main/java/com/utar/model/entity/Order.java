package com.utar.model.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "orders", schema = "classicmodels")
@NamedQuery(name = "Order.findbyId", query = "SELECT order FROM Order order WHERE order.id = :id")
@NamedQuery(name = "Order.findAll", query = "SELECT order FROM Order order")
public class Order {
    @Id
    @Column(name = "ordernumber", nullable = false)
    private Integer id;

    @Column(name = "orderdate", nullable = false, length = 10)
    private String orderdate;

    @Column(name = "requireddate", nullable = false, length = 10)
    private String requireddate;

    @Column(name = "shippeddate", length = 10)
    private String shippeddate;

    @Column(name = "status", nullable = false, length = 10)
    private String status;

    @Column(name = "comments", length = 189)
    private String comments;

    @Column(name = "customernumber", nullable = false)
    private Integer customernumber;

    public Integer getCustomernumber() {
        return customernumber;
    }

    public void setCustomernumber(Integer customernumber) {
        this.customernumber = customernumber;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShippeddate() {
        return shippeddate;
    }

    public void setShippeddate(String shippeddate) {
        this.shippeddate = shippeddate;
    }

    public String getRequireddate() {
        return requireddate;
    }

    public void setRequireddate(String requireddate) {
        this.requireddate = requireddate;
    }

    public String getOrderdate() {
        return orderdate;
    }

    public void setOrderdate(String orderdate) {
        this.orderdate = orderdate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}