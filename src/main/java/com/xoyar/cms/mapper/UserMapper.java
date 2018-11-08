package com.xoyar.cms.mapper;

import com.xoyar.cms.entity.Role;
import com.xoyar.cms.entity.User;
import com.xoyar.cms.entity.UserToRole;

import java.util.List;

public interface UserMapper {

    /**
     * 通过用户ID查询用户信息
     */
    public User getUserById(Integer userId);

    /**
     * 通过登录名查询用户
     */
    public User checkUser(String loginName);

    /**
     * 增加用户
     */
    public boolean addUser(User user);

    /**
     * 更新用户个人信息
     */
    public boolean updateUser(User user);

    /**
     * 删除用户信息
     */
    public boolean delUser(int userId);

    /**
     * 根据条件查询用户
     */
    public List<User> getUserList(User user);

    /**
     * 分页查询用户，获取所有用户，用于service层分页
     */
    public List<User> pageUserList();

    /**
     * 软删除用户信息
     */
    public void updateDelFlag(int userId);

    /**
     * 修改用户密码
     */
    public void updateUserPassword(int userId, String password);

    /**
     *  通过用户id获取用户角色信息
     */
    public List<Role> getRoleListByUserId(Integer userId);

    /**
     * 根据用户id查询用户角色对应表
     */
    public List<UserToRole> getUserRoleByUserId(int userId);

    /**
     * 批量将前台获取到的roleid信息写入到数据库
     */
    public boolean addUserRoleBatch(List<UserToRole> userRoleList);


    /**
     * 删除用户角色对应关系表
     * @param userId
     * @return
     */
    public boolean delUserRoleByUserId(int userId);

}
