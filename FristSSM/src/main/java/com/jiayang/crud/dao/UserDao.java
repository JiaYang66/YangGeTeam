package com.jiayang.crud.dao;

import com.jiayang.crud.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {

    //查
    List<User> getListByDepId(int dep_id);

    User getUserById(int user_id);

    List<User> getAllUser();

    int getNameCount(String name);

    int getEmailCount(String email);

    List<User> getUserByLikeName(String name);

    //增
    void save(@Param("name")String name,@Param("email")String email,@Param("gender")String gender,@Param("department_id") int department_id);

    //改
    void updateHasWay(@Param("id")int id,@Param("name")String name,@Param("email")String email,@Param("gender")String gender,@Param("department_id") int department_id);

    //删
    void deleteUserById(int user_id);




}
