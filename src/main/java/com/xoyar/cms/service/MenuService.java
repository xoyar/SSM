package com.xoyar.cms.service;

import com.xoyar.cms.entity.Menu;

import java.util.List;

public interface MenuService {

    /**
     * 查询所有菜单列表
     */
    public List<Menu> getAllMenuList();

    /**
     * 通过ID获取Menu对象，用于修改menu
     */
    public Menu getMenuById(Integer menuId);

    /**
     * 获取某个节点的子节点数目
     */
    public Integer getChildCount(Integer menuId);

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
     * 根据用户id查询当前用户的菜单权限
     */
    public List<Menu> getMenuListByUserId(Integer userId);

}
