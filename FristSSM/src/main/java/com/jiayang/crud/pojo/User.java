package com.jiayang.crud.pojo;

import org.springframework.stereotype.Component;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

@Component
public class User {
    private int id;

    //name 与 email 使用 hibernate-validator支持JSR303数据校验
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{3,15}$)|(^[\u2E80-\u9FFF]{2,10}$)",message = "姓名格式错误")
    private String name;

    @Email(message = "邮箱格式错误")
    private String email;

    private String gender;
    private department dep;

    public User() {
    }

    public User(int id, String name, String email, String gender, department dep) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.gender = gender;
        this.dep = dep;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public department getDep() {
        return dep;
    }

    public void setDep(department dep) {
        this.dep = dep;
    }

    public String toClearString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", gender='" + gender +
                '}';
    }


    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", gender='" + gender + '\'' +
                ", dep=" + dep +
                '}';
    }
}
