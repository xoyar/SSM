package com.xoyar.cms.mapper;

import java.util.List;

import com.xoyar.cms.entity.Dept;

/**
 * 部门的增删改查的mapper代理接口
 * @author Administrator
 *
 */
public interface DeptMapper {

	/**
	 * 根据用户id查询用户权限内的部门
	 * @param currentUserId
	 * @return
	 */
	public List<Dept> getDeptListByUserId(int currentUserId);
	
	/**
	 * 查询所有部门列表
	 * @return
	 */
	public List<Dept> getAllDeptList();
	
	/**
	 * 获取某个节点的子节点数目,用于删除的特殊判断
	 * @param deptId
	 * @return
	 */
	public Integer getChildCount(int deptId);
	
	/**
	 * 查询部门明细
	 * @return
	 */
	public Dept getDeptById(int deptId);
	/**
	 * 增加部门
	 * @param dept
	 * @return
	 */
	public boolean addDept(Dept dept);
	/**
	 * 删除部门
	 * @param deptId
	 * @return
	 */
	public boolean delDept(int deptId);
	
	/**
	 * 修改部门
	 * @param dept
	 * @return
	 */
	public boolean updateDept(Dept dept);
	
}
