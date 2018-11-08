package com.xoyar.cms.service;

import com.github.pagehelper.PageInfo;
import com.xoyar.cms.dto.UpdateUser;
import com.xoyar.cms.entity.User;
import com.xoyar.cms.entity.UserToRole;

import java.util.List;

public interface UserService {

    /**
     * 通过用户ID查询用户信息
     */
    public User getUserById(Integer userId);

    /**
     *  登录验证
     */
    public User loginUser(String loginName,String password);

    /**
     *  用户分页列表，在impl中进行具体的分页
     * 返回pageInfo，包含每页中的userlist
     */
    public PageInfo<User> getUserPage(Integer pageNum,Integer pageSize);

    /**
     * 增加用户
     */
    public boolean addUser(User user, UpdateUser updateUser);

    /**
     * 硬删除用户信息
     */
    public boolean delUser(int userId);

    /**
     * 软删除用户信息
     */
    public void updateDelFlag(int userId);

    /**
     * 更新用户个人信息
     */
    public boolean updateUser(User user,UpdateUser updateUser);

    /**
     * 修改用户密码
     */
    public void updateUserPassword(int userId,String password);

    /**
     * 通过登录名查询用户
     */
    public User checkUser(String loginName);

    /**
     * 根据用户id查询用户角色对应表
     */
    public List<UserToRole> getUserRoleByUserId(int userId);



}
