package com.xoyar.cms.utils;

import java.util.List;
import java.util.Map;

import com.xoyar.cms.dto.TreeDto;

public class TreeUtils {

	/**
	 * 对于菜单列表进行一个父子结构的排序
	 * 
	 * @param sortTreeList
	 * @param treeList
	 * @param parentId
	 * 
	 *            1:轮询待排序列表,找到当前父节点的下一级某个节点 2:将当前节点放入指定的列表 3:轮询待排序列表,找到当前菜单 4:重复
	 *            1,2,3 5:break;
	 */
	public static <T> void sortTreeList(List<T> sortTreeList, List<T> treeList, 
			Integer parentId) {
		/**
		 * 1:轮询待排序列表,找到当前父节点的下一级某个节点 2:将当前节点放入指定的列表 3:轮询待排序列表,找到当前菜单 4:重复 1,2,3
		 * 5:break;
		 */
		for (int i = 0; i < treeList.size(); i++) {
			TreeDto m = (TreeDto) treeList.get(i);
			// 找到第一级
			if (m.getParentId() != null && m.getParentId().equals(parentId)) {
				sortTreeList.add((T) m);
				// 递归
				sortTreeList(sortTreeList, treeList, m.getId());
			}
		}
	}

	/**
	 * 获取指定父节点下面的所有子节点(儿子,孙子,包括自己)
	 * 
	 * @param childrenMap
	 * @param treeList
	 * @param parentId
	 * @return
	 */
	public static Map<Integer, TreeDto> getAllChildrenMap(Map<Integer, TreeDto> childrenMap, 
			List<TreeDto> treeList, long parentId) {

		for (TreeDto tree : treeList) {
			if (tree.getParentId().intValue() == parentId) {
				childrenMap.put(tree.getId(), tree);
				getAllChildrenMap(childrenMap, treeList, tree.getId());
			}
		}
		return childrenMap;

	}

}
