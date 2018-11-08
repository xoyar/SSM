SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Indexes */

DROP INDEX sys_area_del_flag ON pm_sys_area;
DROP INDEX sys_area_parent_id ON pm_sys_area;
DROP INDEX sys_office_del_flag ON pm_sys_dept;
DROP INDEX sys_office_parent_id ON pm_sys_dept;
DROP INDEX sys_dict_del_flag ON pm_sys_dict;
DROP INDEX sys_dict_label ON pm_sys_dict;
DROP INDEX sys_dict_value ON pm_sys_dict;
DROP INDEX sys_menu_del_flag ON pm_sys_menu;
DROP INDEX sys_menu_parent_id ON pm_sys_menu;
DROP INDEX sys_role_del_flag ON pm_sys_role;
DROP INDEX sys_user_del_flag ON pm_sys_user;
DROP INDEX sys_user_login_name ON pm_sys_user;
DROP INDEX sys_user_office_id ON pm_sys_user;
DROP INDEX sys_user_update_date ON pm_sys_user;



/* Drop Tables */

DROP TABLE IF EXISTS pm_sys_role_area;
DROP TABLE IF EXISTS pm_sys_area;
DROP TABLE IF EXISTS pm_sys_role_dept;
DROP TABLE IF EXISTS pm_sys_dept;
DROP TABLE IF EXISTS pm_sys_dict;
DROP TABLE IF EXISTS pm_sys_role_menu;
DROP TABLE IF EXISTS pm_sys_menu;
DROP TABLE IF EXISTS pm_sys_user_role;
DROP TABLE IF EXISTS pm_sys_role;
DROP TABLE IF EXISTS pm_sys_user;




/* Create Tables */

CREATE TABLE pm_sys_area
(
	-- 编号
	id int NOT NULL AUTO_INCREMENT COMMENT '编号',
	-- 父级编号
	parent_id int NOT NULL COMMENT '父级编号',
	-- 名称
	name varchar(100) NOT NULL COMMENT '名称',
	-- 排序
	sort decimal NOT NULL COMMENT '排序',
	-- 区域编码
	code varchar(100) COMMENT '区域编码',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记
	del_flag char DEFAULT '0' NOT NULL COMMENT '删除标记',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE pm_sys_dept
(
	-- 编号
	id int NOT NULL AUTO_INCREMENT COMMENT '编号',
	-- 父级编号
	parent_id int NOT NULL COMMENT '父级编号',
	-- 名称
	name varchar(100) NOT NULL COMMENT '名称',
	-- 排序
	sort decimal NOT NULL COMMENT '排序',
	-- 区域编码
	code varchar(100) COMMENT '区域编码',
	-- 联系地址
	address varchar(255) COMMENT '联系地址',
	-- 负责人
	master varchar(100) COMMENT '负责人',
	-- 电话
	phone varchar(200) COMMENT '电话',
	-- 传真
	fax varchar(200) COMMENT '传真',
	-- 邮箱
	email varchar(200) COMMENT '邮箱',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记
	del_flag char DEFAULT '0' NOT NULL COMMENT '删除标记',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE pm_sys_dict
(
	-- 编号
	id int NOT NULL AUTO_INCREMENT COMMENT '编号',
	-- 数据值
	value varchar(100) NOT NULL COMMENT '数据值',
	-- 标签名
	label varchar(100) NOT NULL COMMENT '标签名',
	-- 类型
	type varchar(100) NOT NULL COMMENT '类型',
	-- 描述
	description varchar(100) NOT NULL COMMENT '描述',
	-- 排序（升序）
	sort decimal NOT NULL COMMENT '排序（升序）',
	-- 父级编号
	parent_id varchar(64) DEFAULT '0' COMMENT '父级编号',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记
	del_flag char DEFAULT '0' NOT NULL COMMENT '删除标记',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE pm_sys_menu
(
	-- 编号
	id int NOT NULL AUTO_INCREMENT COMMENT '编号',
	-- 父级编号
	parent_id int NOT NULL COMMENT '父级编号',
	-- 名称
	name varchar(100) NOT NULL COMMENT '名称',
	-- 排序
	sort decimal NOT NULL COMMENT '排序',
	-- 链接
	href varchar(2000) COMMENT '链接',
	-- 目标
	target varchar(20) COMMENT '目标',
	-- 图标
	icon varchar(100) COMMENT '图标',
	-- 是否在菜单中显示
	is_show char NOT NULL COMMENT '是否在菜单中显示',
	-- 权限标识
	permission varchar(200) COMMENT '权限标识',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记
	del_flag char DEFAULT '0' NOT NULL COMMENT '删除标记',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE pm_sys_role
(
	-- 编号
	id int NOT NULL AUTO_INCREMENT COMMENT '编号',
	-- 角色名称
	name varchar(100) NOT NULL COMMENT '角色名称',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记
	del_flag char DEFAULT '0' NOT NULL COMMENT '删除标记',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE pm_sys_role_area
(
	-- 编号
	area_id int NOT NULL COMMENT '编号',
	-- 编号
	role_id int NOT NULL COMMENT '编号'
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE pm_sys_role_dept
(
	-- 编号
	role_id int NOT NULL COMMENT '编号',
	-- 编号
	dept_id int NOT NULL COMMENT '编号'
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE pm_sys_role_menu
(
	-- 编号
	role_id int NOT NULL COMMENT '编号',
	-- 编号
	menu_id int NOT NULL COMMENT '编号'
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE pm_sys_user
(
	-- 编号
	user_id int NOT NULL AUTO_INCREMENT COMMENT '编号',
	-- 归属部门
	dept_id int NOT NULL COMMENT '归属部门',
	-- 登录名
	login_name varchar(100) NOT NULL COMMENT '登录名',
	-- 密码
	password varchar(100) NOT NULL COMMENT '密码',
	-- 工号
	user_no varchar(100) COMMENT '工号',
	-- 姓名
	user_name varchar(100) NOT NULL COMMENT '姓名',
	-- 邮箱
	email varchar(200) COMMENT '邮箱',
	-- 电话
	phone varchar(200) COMMENT '电话',
	-- 手机
	mobile varchar(200) COMMENT '手机',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记
	del_flag char DEFAULT '0' NOT NULL COMMENT '删除标记',
	PRIMARY KEY (user_id)
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE pm_sys_user_role
(
	-- 编号
	user_id int NOT NULL COMMENT '编号',
	-- 编号
	role_id int NOT NULL COMMENT '编号'
) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;



/* Create Foreign Keys */

ALTER TABLE pm_sys_role_area
	ADD FOREIGN KEY (area_id)
	REFERENCES pm_sys_area (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pm_sys_role_dept
	ADD FOREIGN KEY (dept_id)
	REFERENCES pm_sys_dept (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pm_sys_role_menu
	ADD FOREIGN KEY (menu_id)
	REFERENCES pm_sys_menu (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pm_sys_role_area
	ADD FOREIGN KEY (role_id)
	REFERENCES pm_sys_role (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pm_sys_role_dept
	ADD FOREIGN KEY (role_id)
	REFERENCES pm_sys_role (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pm_sys_role_menu
	ADD FOREIGN KEY (role_id)
	REFERENCES pm_sys_role (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pm_sys_user_role
	ADD FOREIGN KEY (role_id)
	REFERENCES pm_sys_role (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pm_sys_user_role
	ADD FOREIGN KEY (user_id)
	REFERENCES pm_sys_user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



/* Create Indexes */

CREATE INDEX sys_area_del_flag USING BTREE ON pm_sys_area (del_flag ASC);
CREATE INDEX sys_area_parent_id USING BTREE ON pm_sys_area (parent_id ASC);
CREATE INDEX sys_office_del_flag USING BTREE ON pm_sys_dept (del_flag ASC);
CREATE INDEX sys_office_parent_id USING BTREE ON pm_sys_dept (parent_id ASC);
CREATE INDEX sys_dict_del_flag USING BTREE ON pm_sys_dict (del_flag ASC);
CREATE INDEX sys_dict_label USING BTREE ON pm_sys_dict (label ASC);
CREATE INDEX sys_dict_value USING BTREE ON pm_sys_dict (value ASC);
CREATE INDEX sys_menu_del_flag USING BTREE ON pm_sys_menu (del_flag ASC);
CREATE INDEX sys_menu_parent_id USING BTREE ON pm_sys_menu (parent_id ASC);
CREATE INDEX sys_role_del_flag USING BTREE ON pm_sys_role (del_flag ASC);
CREATE INDEX sys_user_del_flag USING BTREE ON pm_sys_user (del_flag ASC);
CREATE INDEX sys_user_login_name USING BTREE ON pm_sys_user (login_name ASC);
CREATE INDEX sys_user_office_id USING BTREE ON pm_sys_user (dept_id ASC);
CREATE INDEX sys_user_update_date USING BTREE ON pm_sys_user (update_date ASC);



