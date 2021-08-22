package com.jiayang.crud.service;

import com.jiayang.crud.pojo.department;
import com.jiayang.crud.dao.departmentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class departmentServiceImpl implements departmentService {

    @Autowired
    private departmentDao dao;

    @Override
    public List<department> queryLikeName(String name) {
        return dao.getDepsByLikeName(name);
    }

    @Override
    public department queryDepartmentById(int dep_id) {
        return dao.getDepartmentById(dep_id);
    }

    @Override
    public void register(String name) {
        dao.save(name);
    }

    @Override
    public void deleteById(int dep_id) {
        dao.deleteDepById(dep_id);
    }

    @Override
    public void updateDep(department department) {
        dao.updateDep(department);
    }

    @Override
    public List<department> queryAllDep() {
        return dao.getAllDep();
    }

    @Override
    public int queryNameCount(String name) {
        return dao.getNameCount(name);
    }
}
