package com.xoyar.cms.service.Impl;

import com.xoyar.cms.dto.RoleDto;
import com.xoyar.cms.dto.UpdateUser;
import com.xoyar.cms.entity.Role;
import com.xoyar.cms.entity.RoleToMenu;
import com.xoyar.cms.mapper.RoleMapper;
import com.xoyar.cms.service.RoleService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("roleService")
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Role> getAllRoleList() {
        return roleMapper.getAllRoleList();
    }

    @Override
    public List<RoleToMenu> getMenuListByRoleId(int roleId) {
        return roleMapper.getMenuListByRoleId(roleId);
    }

    @Override
    public Role getRoleById(int roleId) {
        return roleMapper.getRoleById(roleId);
    }

    /**
     * 添加角色时，需要添加：角色对象、角色对应的菜单、修改时间和修改人
     * @param roleDto
     * 保存角色信息，返回角色信息
     * 根据角色ID、菜单ID批量插入到pm_sys_role_menu
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addRole(RoleDto roleDto, UpdateUser updateUser) {
        boolean flag = false;
        //添加角色
        Role role = roleDto.getRole();
        role.setUpdateBy(updateUser.getUpdateBy());
        role.setUpdateDate(updateUser.getUpdateDate());
        flag = roleMapper.addRole(role);
        /**
         * 如果在mapper中的addRole方法中不加下面的语句
         * <selectKey keyProperty="id" resultType="int" order="AFTER">
         * 			select last_insert_id()as id
         * </selectKey>
         * 则获取不到roleId，报空指针异常
         */
        Integer roleId = role.getId();
        List<RoleToMenu> roleMenuList = new ArrayList<>();
        RoleToMenu roleToMenu;
        for (Integer menuId : roleDto.getMenuIds().values()){
            roleToMenu = new RoleToMenu();
            System.out.println("menuId : "+menuId);
            roleToMenu.setRoleId(roleId);
            roleToMenu.setMenuId(menuId);
            roleMenuList.add(roleToMenu);
        }
        //批量插入pm_sys_role_menu
        flag = roleMapper.addRoleToMenuBatch(roleMenuList);
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateRole(RoleDto roleDto, UpdateUser updateUser) {
        boolean flag = false;
        //添加角色
        Role role = roleDto.getRole();
        role.setUpdateBy(updateUser.getUpdateBy());
        role.setUpdateDate(updateUser.getUpdateDate());
        flag = roleMapper.updateRole(role);

        //根据角色id删除pm_sys_role_menu
        Integer roleId = role.getId();
        flag = roleMapper.delRoleMenuByRoleId(roleId);

        //根据角色id，菜单id，批量插入到pm_sys_role_menu中
        List<RoleToMenu> roleMenuList = new ArrayList<>();
        RoleToMenu roleToMenu;
        for (Integer menuId : roleDto.getMenuIds().values()){
            roleToMenu = new RoleToMenu();
            System.out.println("menuId : "+menuId);
            roleToMenu.setRoleId(roleId);
            roleToMenu.setMenuId(menuId);
            roleMenuList.add(roleToMenu);
        }
        //批量插入pm_sys_role_menu
        flag = roleMapper.addRoleToMenuBatch(roleMenuList);
        return flag;
    }

}
