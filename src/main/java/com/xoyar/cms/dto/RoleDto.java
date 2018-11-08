package com.xoyar.cms.dto;

import com.xoyar.cms.entity.Role;

import java.io.Serializable;
import java.util.Map;


/**
 * var roleDto = {};
 * roleDto["role"]=formObject;
 *     //获取菜单树被选中的节点
 *     var menuObj = {};
 *     var menuNodes = menuTree.getCheckedNodes(true);
 *     $.each(menuNodes, function(i, item){
 *          menuObj[item.id]=item.id;
 *      });
 * roleDto["menuIds"]=menuObj;
 */
public class RoleDto implements Serializable {

    private Role role;
    /**
     * 存放role_id和menu_id的map,角色对应的所有菜单
     */
    private Map<Integer,Integer> menuIds;

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Map<Integer, Integer> getMenuIds() {
        return menuIds;
    }

    public void setMenuIds(Map<Integer, Integer> menuIds) {
        this.menuIds = menuIds;
    }
}
