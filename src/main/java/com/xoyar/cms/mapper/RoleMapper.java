package com.xoyar.cms.mapper;

import java.util.List;

import com.xoyar.cms.dto.RoleDto;
import com.xoyar.cms.dto.UpdateUser;
import com.xoyar.cms.entity.Menu;
import com.xoyar.cms.entity.Role;
import com.xoyar.cms.entity.RoleToMenu;

/**
 * 角色的增删改查的mapper代理接口
 * 
 * @author Administrator
 *
 */
public interface RoleMapper {

	/**
	 * 查询所有角色列表
	 */
	public List<Role> getAllRoleList();

	/**
	 * 增加角色对象
	 */
	public boolean addRole(Role role);

	/**
	 * 根据角色id获取角色信息
	 */
	public Role getRoleById(int roleId);
	
	/**
	 * 修改角色信息
	 */
	public boolean updateRole(Role role);
	
	/**
	 * 删除角色
	 */
	public boolean delRole(int roleId);

	/**
	 * 添加角色菜单对应记录
	 */
	public boolean addRoleToMenu(RoleToMenu roleToMenu);

	/**
	 * 删除角色菜单对应记录
	 */
	public boolean delRoleToMenu(int menuId);

	/**
	 * 根据角色Id获取菜单信息,角色菜单对应表
	 */
	public List<RoleToMenu> getMenuListByRoleId(int roleId);

	/**
	 * 修改
	 */
	public boolean updateRole(RoleDto roleDto, UpdateUser uptuser);

	/**
	 * 添加
	 * 添加角色时，需要添加：角色对象、角色对应的菜单、修改时间和修改人
	 */
	public boolean addRole(RoleDto roleDto, UpdateUser uptuser);

	/**
	 * 批量添加到role_menu表中
	 */
	public boolean addRoleToMenuBatch(List<RoleToMenu> roleMenuList);

	/**
	 * 根据角色id删除角色菜单
	 */
	public boolean delRoleMenuByRoleId(Integer roleId);

}
