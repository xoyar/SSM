package com.xoyar.cms.service.Impl;

import com.xoyar.cms.entity.Menu;
import com.xoyar.cms.entity.RoleToMenu;
import com.xoyar.cms.mapper.MenuMapper;
import com.xoyar.cms.mapper.RoleMapper;
import com.xoyar.cms.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("menuService")
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Menu> getAllMenuList() {
        List<Menu> menus = menuMapper.getAllMenuList();
        return menus;
    }

    @Override
    public Menu getMenuById(Integer menuId) {

        return menuMapper.getMenuById(menuId);
    }

    /**
     * 方法中调用多个sql，需要用到事务
     * @param menu
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addMenu(Menu menu) {
        boolean flag = false;
        flag = menuMapper.addMenu(menu);
        //在添加菜单时，同时给超级管理员一个权限，也就是sys_role_menu加一条记录
        RoleToMenu roleToMenu = new RoleToMenu();
        roleToMenu.setRoleId(1);
        roleToMenu.setMenuId(menu.getId());
        roleMapper.addRoleToMenu(roleToMenu);
        return flag;
    }

    /**
     * 删除菜单，同样要先删除role_menu对应表
     * @param menuId
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean delMenu(int menuId) {
        //删除时候同时也要把role_menu对应关系删除掉
        boolean flag = false;
        roleMapper.delRoleToMenu(menuId);
        menuMapper.delMenu(menuId);
        return flag;
    }

    @Override
    public boolean updateMenu(Menu menu) {
        return menuMapper.updateMenu(menu);
    }

    /**
     * 获取某个节点的子节点数目
     * @param menuId
     * @return
     */
    @Override
    public Integer getChildCount(Integer menuId) {
        return menuMapper.getChildCount(menuId);
    }

    /**
     * 根据用户id查询当前用户的菜单权限
     */
    @Override
    public List<Menu> getMenuListByUserId(Integer userId) {
        return menuMapper.getMenuListByUserId(userId);
    }
}
