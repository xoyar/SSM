package com.xoyar.cms.mapper;

import java.util.List;
import com.xoyar.cms.entity.Menu;

/**
 * 菜单的增删改查的mapper代理接口
 * 
 * @author Administrator
 *
 */
public interface MenuMapper {

	/**
	 * 查询所有菜单列表
	 */
	public List<Menu> getAllMenuList();

	/**
	 * 查询菜单明细
	 */
	public Menu getMenuById(int menuId);

	/**
	 * 增加菜单
	 */
	public boolean addMenu(Menu menu);

	/**
	 * 删除菜单
	 */
	public boolean delMenu(int menuId);

	/**
	 * 修改菜单
	 */
	public boolean updateMenu(Menu menu);

	/**
	 * 获取某个节点的子节点数目
	 * @param menuId
	 * @return
	 */
	public Integer getChildCount(Integer menuId);

	/**
	 * 根据用户id查询当前用户的菜单权限
	 */
	public List<Menu> getMenuListByUserId(int userId);

}
