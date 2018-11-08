package com.xoyar.cms.service;

import com.xoyar.cms.dto.RoleDto;
import com.xoyar.cms.dto.UpdateUser;
import com.xoyar.cms.entity.Role;
import com.xoyar.cms.entity.RoleToMenu;

import java.util.List;

public interface RoleService {

    /**
     * 获取所有角色列表
     * @return
     */
    public List<Role> getAllRoleList();

    /**
     * 根据角色Id获取菜单信息,角色菜单对应表
     */
    public List<RoleToMenu> getMenuListByRoleId(int roleId);

    /**
     * 根据角色id获取角色信息
     */
    public Role getRoleById(int roleId);

    /**
     * 修改
     */
    public boolean updateRole(RoleDto roleDto, UpdateUser updateUser);

    /**
     * 添加
     * 添加角色时，需要添加：角色对象、角色对应的菜单、修改时间和修改人
     */
    public boolean addRole(RoleDto roleDto, UpdateUser updateUser);



}
