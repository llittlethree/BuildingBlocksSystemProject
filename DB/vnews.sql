/*
*	每个模块使用不同的数据库进行管理。
	模块命名规则:vue_m_模块名称
	模块表命名规则：t_模块名称_表名
	系统数据库名：vue_sys_数据库
	系统表名：t_sys_表名
*/


-- 新闻管理中心
create database vue_m_news CHARSET utf8 COLLATE utf8_general_ci ;
use vue_m_news;

DROP TABLE IF EXISTS `t_vnew_user`;
create table t_vnew_user(
	id int(11) not null primary key auto_increment COMMENT '用户id',
	ref_sysuser_id int(11) not null comment '关联的系统用户表中用户的id',
	user_status int(2) not null default 1 comment '当前模块中的账号状态 1.正常 0.受限制',
	user_level int(2) not null default 1 comment '当前模块下用户的身份：1普通用户 0管理员用户'
) ENGINE = INNODB COMMENT '新闻模块用户表，关联系统用户表';


DROP TABLE IF EXISTS `t_vnew_types`;
create table t_vnew_types(
	id int(11) not null PRIMARY key auto_increment comment '新闻类型id',
	typename varchar(120) not null comment '新闻类型名称'	
)COMMENT '新闻类型表';

DROP TABLE IF EXISTS `t_vnews`;
create table t_vnews(
	id int(11) not null PRIMARY key auto_increment comment '新闻id',
	title varchar(200) not null COMMENT '新闻标题',
	author varchar(120) not null default '佚名'  comment '新闻作者',
	create_time int(11) not null /*default unix_timestamp(now())*/ comment '记录创建时间',
	update_time int(11) null default 0 comment '最后一次更新时间',
	type_id int(11) not null comment '新闻类型',
	public_time int(11) not null /*default unix_timestamp(now())*/ comment '发布时间，不填写则默认当前时间',
	new_contents text not null COMMent '新闻正文内容',
	pic VARCHAR(500) not null comment '缩略图 base64'
) comment '新闻表';

DROP TABLE IF EXISTS `t_vnew_count`;
create table t_vnew_count(
	id int(11) not null PRIMARY key auto_increment comment 'id',
	new_id int(11) not null comment '新闻id',
 	view_number int(11) not null default 0 comment '阅读量',
	thumbs_up_number int(11) not null default 0 comment '点赞量'
)ENGINE=INNODB comment '新闻实时数据表';




-- 仓库管理
create database vue_m_warehouse CHARSET utf8 COLLATE utf8_general_ci ;
use vue_m_warehouse;

DROP TABLE IF EXISTS `t_vwarehouse_user`;
create table t_vwarehouse_user(
	id int(11) not null primary key auto_increment COMMENT '用户id',
	ref_sysuser_id int(11) not null comment '关联的系统用户表中用户的id',
	user_status int(2) not null default 1 comment '当前模块中的账号状态 1.正常 0.受限制',
	user_level int(2) not null default 1 comment '当前模块下用户的身份：1普通用户 0管理员用户'
) ENGINE = INNODB COMMENT '仓库模块用户表，关联系统用户表';

DROP TABLE IF EXISTS `t_vwarehouse_goods`;
create table t_vwarehouse_goods(
	id int(11) not null primary key auto_increment COMMENT '货物id',
	goods_name varchar(200) not null COMMENT '货物名称',
	goods_code varchar(200) not null comment '货物编码唯一编码，格式：区号-仓号-货架号-货架层号-货物类型-货物id',
	goods_remark varchar(300) null comment '货物备注',
	regionid int(11) null comment '区号id',
	goods_type_id int(11) not null comment '货物的类型id',
	warehouse_id int(11) null comment '仓号id',
	shelves_id int(11) null comment '货架id',
	layer int(2) null default 1 comment '存放的层号',
	save_time int(11) not null /*default unix_timestamp(now())*/ comment "存入时间",
	in_out_status int(2) not null default 1 comment '出入状态，1在库中  0已出库'
) ENGINE = INNODB COMMENT '货物表';

DROP TABLE IF EXISTS `t_vwarehouse_region`;
create table t_vwarehouse_region(
	id int(11) not null primary key auto_increment COMMENT '区号id',
	region_name varchar(200) not null COMMENT '区号名称',
	region_remark varchar(300) null comment '区号备注'
) COMMENT '仓库区号';

DROP TABLE IF EXISTS `t_vwarehouse_warehouse`;
create table t_vwarehouse_warehouse(
	id int(11) not null primary key auto_increment COMMENT '仓库号id',
	warehouse_name varchar(200) not null COMMENT '仓库号名称',
	warehouse_remark varchar(300) null comment '仓库号备注',
	region_id int(11) null comment '区号id'
) COMMENT '仓库号表';

DROP TABLE IF EXISTS `t_vwarehouse_shelves`;
create table t_vwarehouse_shelves(
	id int(11) not null primary key auto_increment COMMENT '货架号id',
	shelves_name varchar(200) not null COMMENT '货架号名称',
	shelves_remark varchar(300) null comment '货架号备注',
	shelves_layer int(2) null default 1 comment '货架层数',
	shelves_save_status int(2) null default 1 comment '存放状态，1未满 0已满',
	warehouse_id int(11) null comment '仓库号id'	
) COMMENT '货架号表';

DROP TABLE IF EXISTS `t_vwarehouse_goods_types`;
create table t_vwarehouse_goods_types(
	id int(11) not null primary key auto_increment COMMENT '货物类型id',
	types_name varchar(200) not null COMMENT '货物类型名称',
	types_remark varchar(300) null comment '货物类型备注'
) COMMENT '货物类型';


DROP TABLE IF EXISTS `t_vwarehouse_goods_in`;
create table t_vwarehouse_goods_in(
	id int(11) not null primary key auto_increment COMMENT '记录id',
	goods_id int(11) not null comment "货物id",
	goods_source varchar(250) null comment '货物来源',
	userid int(11) not null comment '入库者',
	in_time int(11) not null /*default unix_timestamp(now())*/ comment '入库时间'
) COMMENT '入库记录';

DROP TABLE IF EXISTS `t_vwarehouse_goods_out`;
create table t_vwarehouse_goods_out(
	id int(11) not null primary key auto_increment COMMENT '记录id',
	goods_id int(11) not null comment "货物id",
	userid int(11) not null comment '出库者',
	goods_to varchar(250) null comment '货物去向',
	out_time int(11) not null /*default unix_timestamp(now())*/ comment '出库时间'
) COMMENT '出库记录';


-- 博客系统
create database vue_m_blog default CHARSET utf8 collate utf8_general_ci;
use vue_m_blog;

drop table if exists t_blog_articles;
create table t_blog_articles(
	id int(11) not null primary key auto_increment comment '文章id',
	title varchar(500) not null comment '文章标题',
	contents text not null comment '文章内容',
	typeid int(11) null comment '类型id ，只有一个类别',
	signs varchar(500) null comment '标签id列表，一个文章有多个标签',
	classid varchar(500) null comment '专栏id，一个文章只属于一个专栏',
	pic varchar(500) null comment '缩略图',
	create_time int(11) not null comment '创建时间',
	update_time int(11) null comment '修改时间',
	status int(2) not null default 1 comment '状态，1.发布，0未发布',
	is_public int(2) not null default 1 comment '公开状态：1公开，0私密'
) comment '文章表';

drop table if exists t_blog_count;
create table t_blog_count(
	id int(11) not null primary key auto_increment comment '数据统计记录id',
	articles_id int(11) not null comment '文章id表，一个文章对应一条统计数据',
	visit int(11) not null default 0 comment '浏览数',
	praise int(11) not null default 0 comment '点赞数'
)engine=innodb comment '数据统计表';


drop table if exists t_blog_types;
create table t_blog_types(
	id int(11) not null primary key auto_increment comment '文章id',
	typename varchar(100) not null comment '类型名称'
)comment '类型表';

drop table if exists t_blog_signs;
create table t_blog_signs(
	id int(11) not null primary key auto_increment comment '标签id',
	sign_name varchar(100) not null comment '标签名称'
)comment '标签表';

drop table if exists t_blog_class;
create table t_blog_class(
	id int(11) not null primary key auto_increment comment '专栏id',
	class_name varchar(100) not null comment '专栏名称',
	pic varchar(500) null comment '缩略图'
)comment '专栏分类表';


-- 学生信息管理
create database vue_m_students_info_manager default charset utf8 COLLATE utf8_general_ci;
use vue_m_students_info_manager;

drop table if exists t_students_info_manager_school;
create table t_students_info_manager_school(
	id int(11) not null primary key auto_increment comment '学校id',
	school_name varchar(200) not null  comment '学校名称',
	school_address varchar(200) not null  comment '学校地址',
	school_type int(2) not null default 1  comment '学校类型',
	school_introduce text null comment '学校简介',
	create_time int(11) not null comment '创建时间'
)comment '学校表';

drop table if exists t_students_info_manager_school;
create table t_students_info_manager_school(
	id int(11) not null primary key auto_increment comment '学校类型id',
	type_name varchar(150) not null comment '类型名称'
)comment '学校类型';

drop table if exists t_students_info_manager_class;
create table t_students_info_manager_class(
	id int(11) not null primary key auto_increment comment '班级id',
	class_name varchar(150) not null comment '班级名称',
	student_num int(11) not null default 0 comment '班级人数',
	school_id int(11) not null  comment '学校id',
	headmaster_id int(11) not null  comment '班主任id'
)comment '班级表';

drop table if exists t_students_info_manager_teacher;
create table t_students_info_manager_teacher(
	id int(11) not null primary key auto_increment comment '老师id',
	school_id int(11) not null  comment '学校id',
	teacher_name varchar(100) not null comment '教师名称',
	life_address varchar(100)  null comment '住址',
	phone varchar(100) not null comment '手机号',
	sex int(2) not null default 1 comment '性别，1男 0女',
	pic varchar(100)  null comment '一寸照',
	dep_name int(11) null comment '部门id',
	zc varchar(100) null comment '职称',
	zw varchar(100) null comment '职位'
)comment '教师表';

-- 社团管理




-- 系统管理数据库
create database vue_sys_SystemManagerCenter default charset utf8 COLLATE utf8_general_ci;
use vue_sys_SystemManagerCenter;

DROP TABLE if EXISTS t_sys_user;
create table t_sys_user(
	id int(11) not null primary key auto_increment COMMENT '用户id',
	nikename  varchar(100) null comment '昵称',
	pwd varchar(200) not null comment '密码,加密',
	phone VARCHAR(100) not null comment '手机号，加密',
	idnumber varchar(100) null comment '身份证号',
	QQ varchar(100) null comment 'QQ号',
	wechar varchar(200) null comment '微信号',
	email varchar(120) null comment '邮箱' ,
	user_type int(2) not null default 1 comment '用户类型，0.系统管理员  1.开发者 2.普通管理员' ,
	userStatus int(2) null default 1 comment '账号状态，1.正常 0.受限制',
	delete_time int(11) null default 0 comment '记录删除的时间,此字段也作为标识记录假删除，存在记录则表示已删除'
) ENGINE = INNODB COMMENT '系统管理员表，主要记录系统管理员经常被查询的信息';

DROP table if EXISTS t_sys_userinfo;
create table t_sys_userinfo(
	id int(11) not null primary key auto_increment COMMENT 'id',
	t_sys_user int(11) not null comment '关联的系统管理员id',
	photo text null comment '图片 base64位',
	sex int(2) null default 1 comment '性别，1男 0女',
	create_time int(11) not null /*default unix_timestamp(now())*/ comment '记录创建的时间，存下时间戳',
	update_time int(11) null default 0 comment '记录最后一次更新的时间，存下时间戳',
	borthday int(11) null  comment '生日,',
	address varchar(200) null comment '地址',
	remark varchar(300) null comment '个性签名'
)ENGINE = INNODB COMMENT '系统管理员表，主要记录系统管理员次要信息';

drop table if exists t_sys_logs;
create table t_sys_logs(
	id int(11) not null primary key auto_increment comment 'id',
	optional varchar(200) not null comment '操作名称',
	model_name varchar(200) not null comment '模块名称',
	optional_time int(11) not null /*default unix_timestamp(now())*/ comment '操作时间',
	optional_ip varchar(100) not null comment '操作ip',
	ref_table varchar(100) null comment '操作的数据表',
	ref_database varchar(100) null comment '操作的数据库',
	userid int(11) not null comment '操作者id',
	effectid int(11) not null comment '操作影响的数据id',
	effect_result int(2) not null default 1 comment '操作结果，1.成功 0.失败'
)ENGINE=INNODB comment '系统日志表';

drop table if exists t_sys_note;
create table t_sys_note(
	id int(11) not null primary key auto_increment comment 'id',
	title varchar(200) not null comment '标题',
	pic varchar(500) null comment '缩略图',
	send_time int(11) not null comment '发送时间',
	send_userid int(11) not null comment '发送者',
	send_file varchar(500) null comment '附带的文件地址列表',
	contants text not null comment '通知内容'
)ENGINE=INNODB comment '系统公告表';

drop table if exists t_sys_resource;
create table t_sys_resource(
	id int(11) not null primary key auto_increment comment '资源id',
	ref_id int(11) null comment '关联的外键id',
	ref_table varchar(100) null comment '关联的表名',
	resource_type_code varchar(100) null comment '资源的类别编号',
	resource_type_name varchar(100) null comment '资源的类别名称',
	resource_status int(2) null default 1 comment '状态，1使用 0未使用',
	resource_file_type varchar(100) null comment '文件后缀名',
	resource_file_path varchar(500) null comment '资源路径',
	create_time int(11) not null comment '创建时间'
)ENGINE=INNODB comment '上传的资源表';





