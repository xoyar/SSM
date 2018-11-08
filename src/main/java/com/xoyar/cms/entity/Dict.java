package com.xoyar.cms.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * Model class of pm_sys_dict.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
public class Dict implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** id. */
	private Integer id;

	/** value. */
	private String value;

	/** label. */
	private String label;

	/** type. */
	private String type;

	/** description. */
	private String description;

	/** sort. */
	private Integer sort;

	/** parent_id. */
	private String parentId;

	/** update_by. */
	private String updateBy;

	/** update_date. */
	private Date updateDate;

	/** remarks. */
	private String remarks;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	@Override
	public String toString() {
		return "Dict [id=" + id + ", value=" + value + ", label=" + label + ", type=" + type + ", description="
				+ description + ", sort=" + sort + ", parentId=" + parentId + ", updateBy=" + updateBy + ", updateDate="
				+ updateDate + ", remarks=" + remarks + "]";
	}


}