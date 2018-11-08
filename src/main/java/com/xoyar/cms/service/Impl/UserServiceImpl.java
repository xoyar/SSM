package com.xoyar.cms.service.Impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xoyar.cms.dto.UpdateUser;
import com.xoyar.cms.entity.User;
import com.xoyar.cms.entity.UserToRole;
import com.xoyar.cms.mapper.UserMapper;
import com.xoyar.cms.service.UserService;
import com.xoyar.cms.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User getUserById(Integer userId) {

        return userMapper.getUserById(userId);
    }

    @Override
    public User loginUser(String loginName,String password) {
//    1、根据loginName找到对应的user对象
//    2、比对密码
        User user = new User();
        user.setLoginName(loginName);
        List<User> userList = userMapper.getUserList(user);

        if (userList.isEmpty()){
            return null;
        }else {
//            获取数据库中的密码
            String pwd = userList.get(0).getPassword();
            if (MD5Utils.getMD5Str(password).equals(pwd)){
                return userList.get(0);
            }else {
                return null;
            }
        }
    }

    /**
     *  用户分页列表，实现具体分页
     *  传入页码和页面大小（每页user数量）
     *
     */
    @Override
    public PageInfo<User> getUserPage(Integer pageNum, Integer pageSize) {
        //开始分页
        PageHelper.startPage(pageNum,pageSize);
        //获取所有列表
        List<User> users = userMapper.pageUserList();
        //构建PageInfo，传入所有users进行分页
        PageInfo<User> pageInfo = new PageInfo(users);
        return pageInfo;
    }


    /**
     * 填加用户的同时要获取！更新者和！更新时间 和！角色信息
     * 此时需要新建一个数据传输包，将需要传输的属性建立一个对象进行传输
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean addUser(User user, UpdateUser updateUser){

        boolean flag = false;
        Integer[] roleIds  = user.getRoleIdList();
        user.setDeptId(1);
        user.setUpdateBy(updateUser.getUpdateBy());
        user.setUpdateDate(updateUser.getUpdateDate());
//         对密码进行加密，再保存到数据库
        user.setPassword(MD5Utils.getMD5Str(user.getPassword()));
        System.out.println("user=========="+user);
        flag = userMapper.addUser(user);

        int userId = user.getUserId();

        //不仅要添加用户，还要添加用户角色关系表
        List<UserToRole> userRoleList = new ArrayList<>();
        UserToRole userRole;
        for (Integer roleId : roleIds){
            userRole = new UserToRole();
            userRole.setUserId(userId);
            userRole.setRoleId(roleId);
            userRoleList.add(userRole);
        }
        flag = this.userMapper.addUserRoleBatch(userRoleList);

        return flag;
    }

    /**
     * 硬删除用户信息
     */
    @Override
    public boolean delUser(int userId) {

        return userMapper.delUser(userId);
    }

    /**
     * 软删除用户信息
     */
    @Override
    public void updateDelFlag(int userId) {

        userMapper.updateDelFlag(userId);
    }

    /**
     * 更新用户个人信息,,有点问题
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean updateUser(User user,UpdateUser updateUser) {
        boolean flag = false;

        Integer[] roleIds  = user.getRoleIdList();
        user.setDeptId(1);
        user.setUpdateBy(updateUser.getUpdateBy());
        user.setUpdateDate(updateUser.getUpdateDate());
        System.out.println("修改user  "+user);
        //User [userId=null, deptId=1, loginName=cccUA, password=null, userNo=004, userName=cccUA, email=ccc@163.com, phone=12344556677,
        // mobile=12345678, updateBy=1, updateDate=Sun Oct 21 12:27:50 CST 2018, remarks=]
        //获取不到userId
        int userId = user.getUserId();
        flag = userMapper.delUserRoleByUserId(userId);

        List<UserToRole> userRoleList = new ArrayList<>();
        UserToRole userRole;
        for (Integer roleId : roleIds){
            userRole = new UserToRole();
            userRole.setUserId(userId);
            userRole.setRoleId(roleId);
            userRoleList.add(userRole);
        }

        flag = userMapper.addUserRoleBatch(userRoleList);
        userMapper.updateUser(user);
        return flag;
    }

    @Override
    public void updateUserPassword(int userId, String password) {
        userMapper.updateUserPassword(userId,password);
    }

    /**
     * 验证登录名是否已经存在
     * @param loginName
     * @return
     */
    @Override
    public User checkUser(String loginName) {

        return userMapper.checkUser(loginName);
    }

    /**
     * 根据用户id查询用户角色对应表
     */
    @Override
    public List<UserToRole> getUserRoleByUserId(int userId) {

        return userMapper.getUserRoleByUserId(userId);
    }
}
