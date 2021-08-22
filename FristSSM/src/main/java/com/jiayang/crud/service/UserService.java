package com.jiayang.crud.service;

import com.jiayang.crud.pojo.User;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public interface UserService {

    User queryUserById(int user_id);

    List<User> queryUserByDepId(int dep_id);

    List<User> queryAllUser();

    void register(User user,int department_id);

    void updateUser(User user,int department_id);

    void deleteUserById(int user_id);

    int queryNameCount(String name);

    int queryEmailCount(String email);

    List<User> queryUserByLikeName(String name);

}
