package com.utar.model.sessionbean;

import com.utar.model.entity.User;

public interface LoginSessionBean {
    boolean authenticate(String username, String password);

    String getUserRole(String username);
}
