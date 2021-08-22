package com.jiayang.crud.service;
import com.jiayang.crud.pojo.User;
import com.jiayang.crud.pojo.department;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface departmentService {

    List<department> queryLikeName(String name);

    department queryDepartmentById(int dep_id);

    void register(String name);

    void deleteById(int dep_id);

    void updateDep(department department);

    List<department> queryAllDep();

    int queryNameCount(String name);

}
