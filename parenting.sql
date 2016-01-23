/*
Navicat MySQL Data Transfer

Source Server         : fcs
Source Server Version : 50621
Source Host           : 127.0.0.1:3306
Source Database       : parenting

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2015-04-02 08:47:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_menutree
-- ----------------------------
DROP TABLE IF EXISTS `t_menutree`;
CREATE TABLE `t_menutree` (
  `f_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `f_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_isforder` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `f_url` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `f_node_grade` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `f_parent_node` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_node_img` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_status` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `f_order` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_type` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '资源类型(1菜单，2功能)',
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_menutree
-- ----------------------------
INSERT INTO `t_menutree` VALUES ('047b1ab137304af78b07120fd4086501', '文章列表', 'N', 'admin/article/listArticle', '3', 'fa118caea1f940638235444ece23d896', null, '1', '2', '1');
INSERT INTO `t_menutree` VALUES ('1', '系统设置', 'Y', null, '1', '0', null, '1', '1', '1');
INSERT INTO `t_menutree` VALUES ('10', '角色列表', null, 'role/listRoleJSON', null, null, null, null, '10', '2');
INSERT INTO `t_menutree` VALUES ('11', '菜单管理列表', null, 'treeMenu/listAllTreeJSON', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('117e716619b64b2896945ad395aacc95', '系统参数', 'N', 'listConfig', '2', '1', null, '1', '5', '1');
INSERT INTO `t_menutree` VALUES ('12', '后台用户列表', null, 'oper/listOperJSON', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('13', '前台用户列表', null, 'userCon/listUserJSON', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('14', '菜单添加页面', null, 'treeMenu/toAdd', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('15', '菜单添加', null, 'treeMenu/add', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('16', '菜单删除', null, 'treeMenu/delete', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('17', '角色添加页面', null, 'role/toAdd', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('18', '角色添加', null, 'role/add', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('19', '角色编辑', null, 'role/toEdit', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('2', '前台管理', 'Y', null, '1', '0', null, '1', '2', '1');
INSERT INTO `t_menutree` VALUES ('20', '后台用户去添加', null, 'oper/toAdd', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('21', '前台用户去添加', null, 'userCon/toAdd', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('22', '文件上传', null, 'file/ajaxSub', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('23', '修改后台用户', null, 'oper/toEdit', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('24', '修改前台用户', null, 'userCon/toAdd', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('25', '后台用户添加', null, 'oper/add', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('26', '加载菜单树', null, 'treeMenu/treeJSON', null, null, null, null, null, '2');
INSERT INTO `t_menutree` VALUES ('2b3b38859d03428c897e2a00b0bc932c', '公司简介', 'N', 'admin/villa/ifm/listVilla', '2', '2', null, '1', '4', '1');
INSERT INTO `t_menutree` VALUES ('3', '角色管理', 'N', 'role/listRole', '2', '1', null, '1', '2', '1');
INSERT INTO `t_menutree` VALUES ('32399b90711e4cfe9e16618e3ce70d06', '权限详情', 'N', 'rights/listRights', '3', '5', null, '2', '2', '1');
INSERT INTO `t_menutree` VALUES ('369f31bb585f473fa61d8f5e93aab590', '权限类别', 'N', 'rightsType/listRightsType', '3', '5', null, '2', '1', '1');
INSERT INTO `t_menutree` VALUES ('5', '权限管理', 'Y', '', '2', '1', null, '2', '5', '1');
INSERT INTO `t_menutree` VALUES ('529e2795eec5476cb2f3a8d5d8c73b68', '藏经阁', 'N', 'admin/wenku/ifm/listWenKu', '2', '2', null, '1', '3', '1');
INSERT INTO `t_menutree` VALUES ('6', '首页广告', 'N', 'admin/ads/ifm/listAds', '2', '2', null, '1', '1', '1');
INSERT INTO `t_menutree` VALUES ('6a5c7e03db964700b3c862fd5c42b5af', '文章分类', 'N', 'admin/articleType/ifm/listArticleType', '3', 'fa118caea1f940638235444ece23d896', null, '1', '1', '1');
INSERT INTO `t_menutree` VALUES ('8', '菜单管理', 'N', 'treeMenu/listMenu', '2', '1', null, '1', '1', '1');
INSERT INTO `t_menutree` VALUES ('9', '系统信息', 'Y', '', '1', '0', null, '1', '3', '1');
INSERT INTO `t_menutree` VALUES ('95cf86189f644e5382c516993db91434', 'test', 'N', null, '2', '9', null, '1', null, '1');
INSERT INTO `t_menutree` VALUES ('9c58fe80a0564a2aa6777831eb10c57a', '硬件信息', 'N', null, '2', '9', null, '1', '1', '1');
INSERT INTO `t_menutree` VALUES ('a8c97087347a43ed8b1f9b3d6c16e25c', '前台用户', 'N', 'userCon/listUser', '3', 'b61149f26760443f8792dcf02f91bc28', null, '1', '1', '1');
INSERT INTO `t_menutree` VALUES ('b61149f26760443f8792dcf02f91bc28', '用户管理', 'Y', '', '2', '1', null, '1', '4', '1');
INSERT INTO `t_menutree` VALUES ('e8e9c64f20cc4bdeabf82d322acde6b6', '软件信息', 'N', 'soft/listMsg', '2', '9', null, '1', '3', '1');
INSERT INTO `t_menutree` VALUES ('f68339ff7d334f5d988217c32dac9dad', '后台用户', 'N', 'oper/listOper', '3', 'b61149f26760443f8792dcf02f91bc28', null, '1', '2', '1');
INSERT INTO `t_menutree` VALUES ('fa118caea1f940638235444ece23d896', '门户新闻', 'Y', '', '2', '2', null, '1', '2', '1');

-- ----------------------------
-- Table structure for t_oper
-- ----------------------------
DROP TABLE IF EXISTS `t_oper`;
CREATE TABLE `t_oper` (
  `f_id` varchar(32) COLLATE utf8_bin NOT NULL,
  `f_passwd` varchar(50) COLLATE utf8_bin NOT NULL,
  `f_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_des` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `f_status` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `f_create_time` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `f_create_oper` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`,`f_passwd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='操作员表';

-- ----------------------------
-- Records of t_oper
-- ----------------------------
INSERT INTO `t_oper` VALUES ('1', '202CB962AC59075B964B07152D234B70', 'admin', '超级管理员', '1', '2014-07-06 10:33:00', 'super');
INSERT INTO `t_oper` VALUES ('52d264fbcc9645b48677e409dbad1864', '202CB962AC59075B964B07152D234B70', 'fcs', '你笑个屁', '1', '2015-03-16 17:31:28', null);
INSERT INTO `t_oper` VALUES ('9189a9489e604f4e8a483a1f8f36386a', '123', '测试', '好玩的很', '1', '2015-03-16 17:27:26', null);
INSERT INTO `t_oper` VALUES ('a2c55f7c8f764a13b361b2db662e517d', '202CB962AC59075B964B07152D234B70', 'only', '这是一首简单的小情歌', '1', '2015-04-02 08:43:01', null);
INSERT INTO `t_oper` VALUES ('a3a21f0a4cd042a5ac6df9e97aeb9518', '202CB962AC59075B964B07152D234B70', 'lf', '张飒飒', '1', '2015-04-01 22:16:54', null);

-- ----------------------------
-- Table structure for t_res
-- ----------------------------
DROP TABLE IF EXISTS `t_res`;
CREATE TABLE `t_res` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `name` varchar(111) DEFAULT NULL,
  `des` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `iconCls` varchar(255) DEFAULT 'wrench',
  `seq` int(11) DEFAULT '1',
  `type` int(1) DEFAULT '2' COMMENT '1 功能 2 权限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_res
-- ----------------------------
INSERT INTO `t_res` VALUES ('1', null, '系统管理', '系统管理', null, 'plugin', '10', '1');
INSERT INTO `t_res` VALUES ('2', '1', '资源管理', null, '/system/res', 'database_gear', '1', '1');
INSERT INTO `t_res` VALUES ('3', '1', '角色管理', null, '/system/role', 'tux', '10', '1');
INSERT INTO `t_res` VALUES ('4', '1', '用户管理', null, '/system/user', 'status_online', '11', '1');
INSERT INTO `t_res` VALUES ('5', '1', '数据库管理', null, '/druid', 'database', '14', '1');
INSERT INTO `t_res` VALUES ('6', '1', '系统监控', null, '/monitoring', 'database', '15', '1');
INSERT INTO `t_res` VALUES ('7', '1', 'bug管理', null, '/system/bug', 'bug', '12', '1');
INSERT INTO `t_res` VALUES ('8', '4', '用户添加', null, '/system/user/add', 'wrench', '1', '2');
INSERT INTO `t_res` VALUES ('9', '4', '用户删除', null, '/system/user/delete', 'wrench', '1', '2');
INSERT INTO `t_res` VALUES ('10', '4', '用户编辑', null, '/system/user/edit', 'wrench', '1', '2');
INSERT INTO `t_res` VALUES ('12', '4', '搜索用户', null, '/system/user/serach', 'wrench', '1', '2');
INSERT INTO `t_res` VALUES ('13', '4', '批量授权', null, '/system/user/batchGrant', 'wrench', '1', '2');
INSERT INTO `t_res` VALUES ('14', '4', '批量删除', null, '/system/user/batchDelete', 'wrench', '1', '2');
INSERT INTO `t_res` VALUES ('15', '4', '用户授权', null, '/system/user/grant', 'wrench', '1', '2');
INSERT INTO `t_res` VALUES ('16', null, '项目地址', null, 'http://git.oschina.net/jayqqaa12/JFinal_Authority', 'github', '15', '1');
INSERT INTO `t_res` VALUES ('17', '1', '日志管理', null, '/system/log', 'page_edit', '11', '1');
INSERT INTO `t_res` VALUES ('18', '2', '资源删除', null, '/system/res/delete', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('19', '2', '资源添加', null, '/system/res/add', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('20', '2', '资源编辑', null, '/system/res/edit', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('27', '3', '角色添加', null, '/system/role/add', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('28', '3', '角色删除', null, '/system/role/delete', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('29', '3', '角色编辑', null, '/system/role/edit', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('30', '3', '权限管理', null, '/system/role/grant', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('31', '7', 'bug添加', null, '/system/bug/add', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('32', '17', '日志删除', null, '/system/log/delete', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('33', '17', '查看统计图', null, '/system/log/chart', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('34', '7', 'bug删除', null, '/system/bug/delete', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('35', '7', 'bug编辑', null, '/system/bug/edit', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('36', '1', '文件上传', null, '/common/file/upload', 'wrench', '20', '2');
INSERT INTO `t_res` VALUES ('39', '7', 'bug查看', null, '/system/bug/view', 'wrench', '13', '2');
INSERT INTO `t_res` VALUES ('40', '17', '导出Excel', null, '/system/log/excel', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('47', '1', '动态图表', null, '/system/chart', 'server_chart', '21', '1');
INSERT INTO `t_res` VALUES ('63', '4', '冻结用户', null, '/system/user/freeze', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('64', '4', '修改密码', null, '/system/user/pwd', 'wrench', '11', '2');
INSERT INTO `t_res` VALUES ('65', '7', '修改状态', null, '/system/bug/status', 'wrench', '11', '2');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `f_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `f_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_des` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `f_create_time` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `f_status` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', '超级管理员', '拥有所有权限', '2015-03-31 18:07:00', '1');
INSERT INTO `t_role` VALUES ('2', '操作员', '管理权限', '2014-07-15 18:07:00', '1');
INSERT INTO `t_role` VALUES ('3', '山庄领导', '查看权限', '2014-07-14 18:07:00', '1');
INSERT INTO `t_role` VALUES ('a4e901302cda41bfbd4e8d34150059d1', 'test', '测试', '2015-03-31 11:17:391', '1');

-- ----------------------------
-- Table structure for t_role_res
-- ----------------------------
DROP TABLE IF EXISTS `t_role_res`;
CREATE TABLE `t_role_res` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(255) DEFAULT NULL,
  `res_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_res
-- ----------------------------
INSERT INTO `t_role_res` VALUES ('1', '1', '047b1ab137304af78b07120fd4086501');
INSERT INTO `t_role_res` VALUES ('2', '1', '1');
INSERT INTO `t_role_res` VALUES ('3', '1', '117e716619b64b2896945ad395aacc95');
INSERT INTO `t_role_res` VALUES ('4', '1', '2');
INSERT INTO `t_role_res` VALUES ('5', '1', '2b3b38859d03428c897e2a00b0bc932c');
INSERT INTO `t_role_res` VALUES ('6', '1', '3');
INSERT INTO `t_role_res` VALUES ('7', '1', '32399b90711e4cfe9e16618e3ce70d06');
INSERT INTO `t_role_res` VALUES ('8', '1', '369f31bb585f473fa61d8f5e93aab590');
INSERT INTO `t_role_res` VALUES ('10', '1', '5');
INSERT INTO `t_role_res` VALUES ('11', '1', '529e2795eec5476cb2f3a8d5d8c73b68');
INSERT INTO `t_role_res` VALUES ('12', '1', '6');
INSERT INTO `t_role_res` VALUES ('13', '1', '6a5c7e03db964700b3c862fd5c42b5af');
INSERT INTO `t_role_res` VALUES ('14', '1', '8');
INSERT INTO `t_role_res` VALUES ('15', '1', '9');
INSERT INTO `t_role_res` VALUES ('16', '1', '9c58fe80a0564a2aa6777831eb10c57a');
INSERT INTO `t_role_res` VALUES ('17', '1', 'a8c97087347a43ed8b1f9b3d6c16e25c');
INSERT INTO `t_role_res` VALUES ('18', '1', 'b61149f26760443f8792dcf02f91bc28');
INSERT INTO `t_role_res` VALUES ('19', '1', 'f68339ff7d334f5d988217c32dac9dad');
INSERT INTO `t_role_res` VALUES ('20', '1', 'fa118caea1f940638235444ece23d896');
INSERT INTO `t_role_res` VALUES ('21', '1', '10');
INSERT INTO `t_role_res` VALUES ('22', '1', '11');
INSERT INTO `t_role_res` VALUES ('25', '1', '12');
INSERT INTO `t_role_res` VALUES ('26', '1', '13');
INSERT INTO `t_role_res` VALUES ('27', '1', '14');
INSERT INTO `t_role_res` VALUES ('28', '1', '15');
INSERT INTO `t_role_res` VALUES ('29', '1', '16');
INSERT INTO `t_role_res` VALUES ('30', '1', '17');
INSERT INTO `t_role_res` VALUES ('31', '1', '18');
INSERT INTO `t_role_res` VALUES ('32', '1', '19');
INSERT INTO `t_role_res` VALUES ('33', '1', '20');
INSERT INTO `t_role_res` VALUES ('34', '1', '21');
INSERT INTO `t_role_res` VALUES ('35', '1', '22');
INSERT INTO `t_role_res` VALUES ('36', '1', '23');
INSERT INTO `t_role_res` VALUES ('37', '1', '24');
INSERT INTO `t_role_res` VALUES ('38', '1', '25');
INSERT INTO `t_role_res` VALUES ('39', '1', '26');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `f_id` varchar(32) COLLATE utf8_bin NOT NULL,
  `f_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_des` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `f_img` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `f_email` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `f_qq` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `f_age` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `f_sex` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `f_job` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_addr` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `f_role` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `f_passwd` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `f_create_time` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `f_status` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `f_bbs_score` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_bbs_level` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `f_mobile` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `f_rights` text COLLATE utf8_bin,
  `f_nickName` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('2', 'fcs', '长晟将军', null, null, null, null, null, null, null, 'e21e17128966492b93e95d3d11057382', '202CB962AC59075B964B07152D234B70', '2014-10-24 15:13:11', '2', null, null, null, null, null);
INSERT INTO `t_user` VALUES ('296cf45d5e1c400aa635cf7c528aee25', 'dfaf', null, null, null, null, null, '1', null, null, null, '123', '2015-03-18 10:47:45', '1', null, null, null, null, null);
INSERT INTO `t_user` VALUES ('3', 'LFs', '猴子请来的', null, null, '646653132', null, null, null, null, '2', '202CB962AC59075B964B07152D234B70', '2014-11-25 12:58:11', '2', null, null, null, 0x34363631323663373634363534646162613263396162386465343232386261362C382C, '李飞');
INSERT INTO `t_user` VALUES ('6a74b54705ec4e55b4137b566b075768', 'esteban', '猴子请来的逗比', '6a74b54705ec4e55b4137b566b075768.jpg', null, null, null, '1', null, null, '1', '202CB962AC59075B964B07152D234B70', '2014-01-03 19:22:11', '1', null, null, null, 0x312C332C33333930313965353736383434613437623635303363336433313635393765342C342C34363631323663373634363534646162613263396162386465343232386261362C352C372C382C39653930303532623534643334396133383538323934653138613836666239302C62393562303535356461306434303135623038366662383563623661356261302C66376436663261666238656334653065393366633839663066333034326463382C, '猴子');
INSERT INTO `t_user` VALUES ('c0c573ff2bd24ea4ac229367e4a5a885', 'xx', 'hao', 'fcs.jpg', null, null, null, '1', null, null, null, '123', '2014-03-16 05:43:11', '1', null, null, null, null, 'xxoo');

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `lsh` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lsh`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES ('1', '52d264fbcc9645b48677e409dbad1864', '1');
INSERT INTO `t_user_role` VALUES ('2', 'a3a21f0a4cd042a5ac6df9e97aeb9518', '1');
INSERT INTO `t_user_role` VALUES ('3', 'a2c55f7c8f764a13b361b2db662e517d', '1');
INSERT INTO `t_user_role` VALUES ('4', 'a2c55f7c8f764a13b361b2db662e517d', '2');
