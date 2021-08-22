package com.jiayang.crud.pojo;

import org.springframework.stereotype.Component;

import javax.validation.constraints.Pattern;

@Component
public class department {
    private int id;

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{3,15}$)|(^[\u2E80-\u9FFF]{2,10}$)",message = "部门名格式错误")
    private String name;

    public department() {
    }

    public department(int id, String name) {
        this.id = id;
        this.name = name;
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

    @Override
    public String toString() {
        return "department{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
