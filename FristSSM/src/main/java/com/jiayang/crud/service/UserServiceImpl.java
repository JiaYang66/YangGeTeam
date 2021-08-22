package com.jiayang.crud.service;

import com.jiayang.crud.dao.UserDao;
import com.jiayang.crud.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class UserServiceImpl implements UserService {

    private UserDao dao;

    @Autowired
    public void setDao(UserDao dao) {
        this.dao = dao;
    }

    @Override
    public User queryUserById(int user_id) {
        return dao.getUserById(user_id);
    }

    @Override
    public List<User> queryUserByDepId(int dep_id) {
        return dao.getListByDepId(dep_id);
    }

    @Override
    public List<User> queryAllUser() {
        return dao.getAllUser();
    }

    @Override
    public void register(User user,int department_id) {
        dao.save(user.getName(),user.getEmail(),user.getGender(),department_id);
    }

    @Override
    public void updateUser(User user,int department_id) {
        dao.updateHasWay(user.getId(),user.getName(),user.getEmail(),user.getGender(),department_id);
    }

    @Override
    public void deleteUserById(int user_id) {
        dao.deleteUserById(user_id);
    }

    @Override
    public int queryNameCount(String name) {
        return dao.getNameCount(name);
    }

    @Override
    public int queryEmailCount(String email) {
        return dao.getEmailCount(email);
    }

    @Override
    public List<User> queryUserByLikeName(String name) {
        return dao.getUserByLikeName(name);
    }
}
