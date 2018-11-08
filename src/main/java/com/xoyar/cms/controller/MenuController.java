package com.xoyar.cms.controller;

import com.xoyar.cms.annotation.Permission;
import com.xoyar.cms.dto.TreeDto;
import com.xoyar.cms.dto.UpdateUser;
import com.xoyar.cms.entity.Menu;
import com.xoyar.cms.entity.User;
import com.xoyar.cms.service.MenuService;
import com.xoyar.cms.utils.TreeUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/menu")
public class MenuController {

    static Logger logger = Logger.getLogger(MenuController.class);
    private static final int editFlag_add = 1;
    private static final int editFlag_update = 2;
    @Autowired
    private MenuService menuService;

    /**
     * 进入到菜单查询列表页面
     */
    @RequestMapping("/menuList")
    public String getMenuList(Model model){

        List<Menu> menus = menuService.getAllMenuList();
        //对treeTable的显示顺序进行排序，解决添加菜单显示在最后一行的问题
        List<Menu> sortMenuList = new ArrayList<>();
        TreeUtils.sortTreeList(sortMenuList,menus,0);
        model.addAttribute("menuList",sortMenuList);
        return "/menu/menuList";
    }
    /**
     * 进入到编辑(修改或添加)菜单页面
     * ModelAttribute("editFlag")可以提前运行，也就是可以提前得到editFlag
     * 修改url：/menu/toMenuEdit? editFlag=2 && menuId=${menu.id}
     * 添加url：/menu/toMenuEdit?editFlag=1
     */
    @RequestMapping("/toMenuEdit")
    public String gotoMenuEdit(@ModelAttribute("editFlag") int editFlag,Integer menuId,Integer parentId,Model model){
        logger.info("***********menuId:*********"+menuId);
        logger.info("***********parentId:*********"+parentId);
        //如果edit==2进入修改页面
        if(editFlag == editFlag_update){
            logger.info("**********方法中*menuId:*********"+menuId);
            Menu menu = menuService.getMenuById(menuId);
            model.addAttribute("menu", menu);
        }
        //如果edit==1进入添加页面
        if (editFlag ==editFlag_add){
            if (parentId != null){
                logger.info("***********方法中parentId:*********"+parentId);
                Menu parentMenu = menuService.getMenuById(parentId);
                Menu menu = new Menu();
                menu.setParentId(parentMenu.getId());
                model.addAttribute("menu",menu);
            }
        }
        return "/menu/menuedit";
    }

    /**
     * 获取所有树形结构的菜单节点信息，点击[菜单 添加]中的搜索符号出现树形菜单，z-tree
     * ResponseBody因为是用ajax获取数据。所以可以用responsebody传到页面上,返回json数据格式
     * @return
     */
    @RequestMapping("/getParentMenuTreeData")
    @ResponseBody
    public List<TreeDto> getParentTreeData(Integer menuId){
        List<TreeDto> treelist = new ArrayList<>();
        List<Menu> menus = menuService.getAllMenuList();
        for (Menu menu:menus){
            TreeDto treeDto = new TreeDto();
            treeDto.setId(menu.getId());
            treeDto.setName(menu.getName());
            treeDto.setParentId(menu.getParentId());
            treelist.add(treeDto);
        }
        // 如果进入修改界面，必须把当前节点以及子节点过滤掉
        if(menuId != null){
            Map<Integer,TreeDto> childrenMap = new HashMap<>();
            //把本节点的所有子节点找出来
            TreeUtils.getAllChildrenMap(childrenMap,treelist,menuId);
            Iterator<TreeDto> treeDtoIterator = treelist.iterator();
            while (treeDtoIterator.hasNext()){
                TreeDto tree = treeDtoIterator.next();
                //找到所有的子节点并删除
                if (childrenMap.get(tree.getId()) != null){
                    treeDtoIterator.remove();
                }
                //删除本节点
                if (tree.getId().equals(menuId)){
                    treeDtoIterator.remove();
                }
            }
        }
        return treelist;
    }

    /**
     * 保存按钮，修改和添加页面的保存按钮做到一个方法里
     * RequestBody把json对象转换为menu对象
     * ResponseBody把对象转换为json格式
     * @return
     */
    @Permission(value = "menu:add")
    @RequestMapping("/saveMenu")
    @ResponseBody
    public Map<String,Object> saveMenu(@RequestBody Menu menu, HttpSession session){

        System.out.println(menu);

        Map<String,Object> resultMap = new HashMap<>();
        //从前台获取用户，用于设置修改人
        User sessionUser = (User) session.getAttribute("user");
        UpdateUser updateUser = new UpdateUser();
        updateUser.setUpdateBy(sessionUser.getUserId().toString());
        updateUser.setUpdateDate(new Date());
        //设置menu的修改人
        menu.setUpdateBy(updateUser.getUpdateBy());
        menu.setUpdateDate(new Date());
        //修改
        if (menu != null && menu.getId()!=null){
            menuService.updateMenu(menu);
            resultMap.put("result","修改菜单成功");
        }else {//添加
            menuService.addMenu(menu);
            resultMap.put("result","添加菜单成功");
        }
        menuService.updateMenu(menu);
        return resultMap;
    }

    @Permission(value = "menu:delete")
    @RequestMapping("/delMenu")
    @ResponseBody
    public Map<String,Object> delMenu(Integer menuId){
        Map<String,Object> resultMap = new HashMap<>();
        //删除菜单时，必须保证此节点无子节点才可以删除
        if (menuService.getChildCount(menuId)>0){
            resultMap.put("result","此菜单下还有子菜单，请先删除子菜单");
        }else {
            menuService.delMenu(menuId);
        }
        return resultMap;
    }

}
