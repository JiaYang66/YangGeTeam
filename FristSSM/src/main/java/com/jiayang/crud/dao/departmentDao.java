package com.jiayang.crud.dao;

import com.jiayang.crud.pojo.department;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface departmentDao {

    //查
    department getDepartmentById(int dep_id);

    List<department> getAllDep();

    List<department> getDepsByLikeName(String name);

    //增
    void save(String name);

    int getNameCount(String name);

    //删
    void deleteDepById(int dep_id);

    //改
    void updateDep(department department);

}
