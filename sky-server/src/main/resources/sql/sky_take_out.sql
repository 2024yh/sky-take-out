/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50724
Source Host           : localhost:3306
Source Database       : sky_take_out

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2024-04-01 21:40:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `consignee` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '收货人',
  `sex` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认 0 否 1是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='地址簿';

-- ----------------------------
-- Records of address_book
-- ----------------------------
INSERT INTO `address_book` VALUES ('1', '1', '李峰', '0', '13657704353', '11', '北京市', '1101', '市辖区', '110102', '西城区', '江城一路', '2', '1');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int(11) DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '分类名称',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '顺序',
  `status` int(11) DEFAULT NULL COMMENT '分类状态 0:禁用，1:启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='菜品及套餐分类';

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('11', '1', '酒水饮料', '10', '1', '2022-06-09 22:09:18', '2024-02-18 18:42:57', '1', '1');
INSERT INTO `category` VALUES ('12', '1', '传统主食', '9', '1', '2022-06-09 22:09:32', '2022-06-09 22:18:53', '1', '1');
INSERT INTO `category` VALUES ('13', '2', '人气套餐', '12', '1', '2022-06-09 22:11:38', '2024-02-19 14:44:06', '1', '1');
INSERT INTO `category` VALUES ('15', '2', '商务套餐', '13', '1', '2022-06-09 22:14:10', '2022-06-10 11:04:48', '1', '1');
INSERT INTO `category` VALUES ('16', '1', '蜀味烤鱼', '4', '1', '2022-06-09 22:15:37', '2024-02-19 14:45:17', '1', '1');
INSERT INTO `category` VALUES ('17', '1', '蜀味牛蛙', '2', '1', '2022-06-09 22:16:14', '2024-02-18 18:48:23', '1', '1');
INSERT INTO `category` VALUES ('18', '1', '特色蒸菜', '6', '1', '2022-06-09 22:17:42', '2022-06-09 22:17:42', '1', '1');
INSERT INTO `category` VALUES ('19', '1', '新鲜时蔬', '7', '1', '2022-06-09 22:18:12', '2022-06-09 22:18:28', '1', '1');
INSERT INTO `category` VALUES ('20', '1', '水煮鱼', '8', '1', '2022-06-09 22:22:29', '2022-06-09 22:23:45', '1', '1');
INSERT INTO `category` VALUES ('21', '1', '汤类', '11', '1', '2022-06-10 10:51:47', '2022-06-10 10:51:47', '1', '1');

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint(20) NOT NULL COMMENT '菜品分类id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品价格',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图片',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述信息',
  `status` int(11) DEFAULT '1' COMMENT '0 停售 1 起售',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dish_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='菜品';

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES ('46', '王老吉', '11', '6.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/ad4fdd6a-bbe2-4cc0-9db6-74cd46ef720d.png', '', '1', '2022-06-09 22:40:47', '2024-04-01 19:46:13', '1', '1');
INSERT INTO `dish` VALUES ('47', '北冰洋', '11', '4.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/2c896f8a-304e-468a-9413-883e5be66af5.png', '还是小时候的味道', '1', '2022-06-10 09:18:49', '2024-04-01 19:46:35', '1', '1');
INSERT INTO `dish` VALUES ('48', '雪花啤酒', '11', '4.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/ef996e58-50a3-4e60-a160-c8b024c500b5.png', '', '1', '2022-06-10 09:22:54', '2024-04-01 19:46:47', '1', '1');
INSERT INTO `dish` VALUES ('49', '米饭', '12', '2.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/354d4a1d-37c5-46d2-b1f9-ea9ff012a675.png', '精选五常大米', '1', '2022-06-10 09:30:17', '2024-04-01 19:46:58', '1', '1');
INSERT INTO `dish` VALUES ('50', '馒头', '12', '1.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/8a34fb44-5746-493d-b63c-83b63af452f2.png', '优质面粉', '1', '2022-06-10 09:34:28', '2024-04-01 19:47:30', '1', '1');
INSERT INTO `dish` VALUES ('51', '老坛酸菜鱼', '20', '56.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/e61d51d3-c381-4465-af7e-4690d58c083b.png', '原料：汤，草鱼，酸菜', '1', '2022-06-10 09:40:51', '2024-04-01 19:48:29', '1', '1');
INSERT INTO `dish` VALUES ('52', '经典酸菜鮰鱼', '20', '66.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/aa75016b-1edc-42e2-be30-3d93720ee76d.png', '原料：酸菜，江团，鮰鱼', '1', '2022-06-10 09:46:02', '2024-04-01 19:48:48', '1', '1');
INSERT INTO `dish` VALUES ('53', '蜀味水煮草鱼', '20', '38.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/48f1ff19-f35b-4726-a6d3-577897d67bea.png', '原料：草鱼，汤', '1', '2022-06-10 09:48:37', '2024-04-01 19:49:01', '1', '1');
INSERT INTO `dish` VALUES ('54', '清炒小油菜', '19', '18.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/320ddf36-e97b-4a2e-88e1-1ab8b2008916.png', '原料：小油菜', '1', '2022-06-10 09:51:46', '2024-04-01 19:49:14', '1', '1');
INSERT INTO `dish` VALUES ('55', '蒜蓉娃娃菜', '19', '18.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/85c7763d-2305-4e71-9e05-fd15481d8024.png', '原料：蒜，娃娃菜', '1', '2022-06-10 09:53:37', '2024-04-01 19:49:30', '1', '1');
INSERT INTO `dish` VALUES ('56', '清炒西兰花', '19', '18.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/4eea21cd-6118-4845-be60-c250d55810cf.png', '原料：西兰花', '1', '2022-06-10 09:55:44', '2024-04-01 19:49:42', '1', '1');
INSERT INTO `dish` VALUES ('57', '炝炒圆白菜', '19', '18.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/45f081b7-1501-41d3-ae9a-e95fccce5d63.png', '原料：圆白菜', '1', '2022-06-10 09:58:35', '2024-04-01 19:49:53', '1', '1');
INSERT INTO `dish` VALUES ('58', '清蒸鲈鱼', '18', '98.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/d3c32cc0-0f35-4b6d-a579-87783a9ea500.png', '原料：鲈鱼', '1', '2022-06-10 10:12:28', '2024-04-01 19:50:08', '1', '1');
INSERT INTO `dish` VALUES ('59', '东坡肘子', '18', '138.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/7729c847-b296-4040-a74d-feffe9392587.png', '原料：猪肘棒', '1', '2022-06-10 10:24:03', '2024-04-01 19:50:27', '1', '1');
INSERT INTO `dish` VALUES ('60', '梅菜扣肉', '18', '58.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/64db9ada-fc44-4804-9e69-1145696a4880.png', '原料：猪肉，梅菜', '1', '2022-06-10 10:26:03', '2024-04-01 19:50:37', '1', '1');
INSERT INTO `dish` VALUES ('61', '剁椒鱼头', '18', '66.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/99ae88b8-839c-4d3c-b720-30346d140045.png', '原料：鲢鱼，剁椒', '1', '2022-06-10 10:28:54', '2024-04-01 19:50:48', '1', '1');
INSERT INTO `dish` VALUES ('62', '金汤酸菜牛蛙', '17', '88.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/763716c5-58de-4708-8493-e9e98261a41b.png', '原料：鲜活牛蛙，酸菜', '1', '2022-06-10 10:33:05', '2024-04-01 19:51:01', '1', '1');
INSERT INTO `dish` VALUES ('63', '香锅牛蛙', '17', '88.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/f0801ede-d6d1-4ddf-af9a-6365c3babbf1.png', '配料：鲜活牛蛙，莲藕，青笋', '1', '2022-06-10 10:35:40', '2024-04-01 19:51:11', '1', '1');
INSERT INTO `dish` VALUES ('64', '馋嘴牛蛙', '17', '88.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/4c57d658-8aed-4b5a-8eeb-575c1dbf1717.png', '配料：鲜活牛蛙，丝瓜，黄豆芽', '1', '2022-06-10 10:37:52', '2024-04-01 19:51:22', '1', '1');
INSERT INTO `dish` VALUES ('65', '草鱼2斤', '16', '68.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/2df2095c-d7d1-49b8-80ee-b68c1162a1db.png', '原料：草鱼，黄豆芽，莲藕', '1', '2022-06-10 10:41:08', '2024-04-01 19:51:32', '1', '1');
INSERT INTO `dish` VALUES ('66', '江团鱼2斤', '16', '119.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/6a1cb458-2ee5-4e14-bfb5-442fd7b967f9.png', '配料：江团鱼，黄豆芽，莲藕', '1', '2022-06-10 10:42:42', '2024-04-01 19:51:41', '1', '1');
INSERT INTO `dish` VALUES ('67', '鮰鱼2斤', '16', '72.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/81d1c321-8b20-4256-bb94-0683d72d4644.png', '原料：鮰鱼，黄豆芽，莲藕', '1', '2022-06-10 10:43:56', '2024-04-01 19:51:53', '1', '1');
INSERT INTO `dish` VALUES ('68', '鸡蛋汤', '21', '5.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/0a711efc-2dd4-40ed-a1ea-dc9178de90ed.png', '配料：鸡蛋，紫菜', '1', '2022-06-10 10:54:25', '2024-04-01 19:47:55', '1', '1');
INSERT INTO `dish` VALUES ('69', '平菇豆腐汤', '21', '6.00', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/248e6305-bc44-4d4c-8dd4-0fa03548ddef.png', '配料：豆腐，平菇', '1', '2022-06-10 10:55:02', '2024-04-01 19:47:46', '1', '1');

-- ----------------------------
-- Table structure for dish_flavor
-- ----------------------------
DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dish_id` bigint(20) NOT NULL COMMENT '菜品',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '口味名称',
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '口味数据list',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='菜品口味关系表';

-- ----------------------------
-- Records of dish_flavor
-- ----------------------------
INSERT INTO `dish_flavor` VALUES ('40', '10', '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES ('41', '7', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES ('42', '7', '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]');
INSERT INTO `dish_flavor` VALUES ('45', '6', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES ('46', '6', '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES ('47', '5', '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES ('48', '5', '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES ('49', '2', '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES ('50', '4', '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES ('51', '3', '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES ('52', '3', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES ('104', '70', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES ('105', '72', '辣度', '[\"中辣\"]');
INSERT INTO `dish_flavor` VALUES ('106', '72', '忌口', '[\"不要葱\"]');
INSERT INTO `dish_flavor` VALUES ('107', '75', '温度', '[\"热饮\"]');
INSERT INTO `dish_flavor` VALUES ('108', '75', '甜味', '[\"全糖\"]');
INSERT INTO `dish_flavor` VALUES ('114', '51', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES ('115', '51', '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES ('116', '52', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES ('117', '52', '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES ('118', '53', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES ('119', '53', '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES ('120', '54', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\"]');
INSERT INTO `dish_flavor` VALUES ('121', '56', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES ('122', '57', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES ('123', '60', '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES ('124', '65', '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES ('125', '66', '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES ('126', '67', '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) COLLATE utf8_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) COLLATE utf8_bin NOT NULL COMMENT '身份证号',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态 0:禁用，1:启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='员工信息';

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13812312312', '1', '110101199001010047', '1', '2022-02-15 15:51:20', '2022-02-17 09:16:20', '10', '1');
INSERT INTO `employee` VALUES ('2', '张三', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '13657705433', '1', '450655199612181234', '1', '2024-02-05 16:38:30', '2024-02-27 18:49:55', '10', '1');
INSERT INTO `employee` VALUES ('3', '李四', 'lisi', 'e10adc3949ba59abbe56e057f20f883e', '13657704536', '1', '450654199912141230', '1', '2024-02-05 16:42:26', '2024-02-18 15:17:45', '10', '1');
INSERT INTO `employee` VALUES ('8', '王五', 'wangwu', 'e10adc3949ba59abbe56e057f20f883e', '13657709090', '1', '450545198712101547', '1', '2024-02-05 17:15:23', '2024-02-28 14:38:27', '1', '1');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '订单号',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
  `user_id` bigint(20) NOT NULL COMMENT '下单用户',
  `address_book_id` bigint(20) NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime DEFAULT NULL COMMENT '结账时间',
  `pay_method` int(11) NOT NULL DEFAULT '1' COMMENT '支付方式 1微信,2支付宝',
  `pay_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付状态 0未支付 1已支付 2退款',
  `amount` decimal(10,2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `phone` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '地址',
  `user_name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名称',
  `consignee` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '收货人',
  `cancel_reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '订单取消原因',
  `rejection_reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '订单拒绝原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '订单取消时间',
  `estimated_delivery_time` datetime DEFAULT NULL COMMENT '预计送达时间',
  `delivery_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '配送状态  1立即送出  0选择具体时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '送达时间',
  `pack_amount` int(11) DEFAULT NULL COMMENT '打包费',
  `tableware_number` int(11) DEFAULT NULL COMMENT '餐具数量',
  `tableware_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '餐具数量状态  1按餐量提供  0选择具体数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='订单表';

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('27', '1710424109250', '5', '1', '1', '2024-03-14 21:48:29', '2024-03-14 21:48:31', '1', '1', '226.00', '', '13657704353', '北京市市辖区西城区江城一路', null, '李峰', null, null, null, '2024-03-14 22:48:00', '0', null, '4', '1', '0');
INSERT INTO `orders` VALUES ('28', '1710424119202', '6', '1', '1', '2024-03-14 21:48:39', null, '1', '0', '184.00', '', '13657704353', '北京市市辖区西城区江城一路', null, '李峰', '用户取消', null, '2024-03-14 21:49:43', '2024-03-14 22:48:00', '0', null, '2', '0', '0');
INSERT INTO `orders` VALUES ('29', '1710424196569', '6', '1', '1', '2024-03-14 21:49:57', '2024-03-14 21:49:58', '1', '2', '15.00', '', '13657704353', '北京市市辖区西城区江城一路', null, '李峰', '卖完了，准备打烊', null, '2024-03-14 21:53:03', '2024-03-14 22:49:00', '0', null, '3', '0', '0');
INSERT INTO `orders` VALUES ('30', '1710424711704', '3', '1', '1', '2024-03-14 21:58:32', '2024-03-14 21:58:34', '1', '1', '80.00', '', '13657704353', '北京市市辖区西城区江城一路', null, '李峰', null, null, null, '2024-03-14 22:58:00', '0', null, '5', '1', '0');
INSERT INTO `orders` VALUES ('31', '1711704052645', '3', '1', '1', '2024-03-29 17:20:53', '2024-03-29 17:20:54', '1', '1', '95.00', '', '13657704353', '北京市市辖区西城区江城一路', null, '李峰', null, null, null, '2024-03-29 18:20:00', '0', null, '1', '0', '0');
INSERT INTO `orders` VALUES ('32', '1711704160069', '6', '1', '1', '2024-03-29 17:22:40', '2024-03-29 17:22:41', '1', '2', '63.00', '', '13657704353', '北京市市辖区西城区江城一路', null, '李峰', '菜品已销售完，暂时无法接单', null, '2024-03-29 17:23:58', '2024-03-29 18:22:00', '0', null, '1', '0', '0');
INSERT INTO `orders` VALUES ('33', '1711704213140', '5', '1', '1', '2024-03-29 17:23:33', '2024-03-29 17:23:34', '1', '1', '11.00', '', '13657704353', '北京市市辖区西城区江城一路', null, '李峰', null, null, null, '2024-03-29 18:23:00', '0', null, '1', '0', '0');
INSERT INTO `orders` VALUES ('34', '1711705103403', '5', '1', '1', '2024-03-29 17:38:23', '2024-03-29 17:38:25', '1', '1', '95.00', '', '13657704353', '北京市市辖区西城区江城一路', null, '李峰', null, null, null, '2024-03-29 18:38:00', '0', null, '1', '0', '0');
INSERT INTO `orders` VALUES ('35', '1711705155157', '6', '1', '1', '2024-03-29 17:39:15', '2024-03-29 17:39:16', '1', '2', '95.00', '', '13657704353', '北京市市辖区西城区江城一路', null, '李峰', '菜品已销售完，暂时无法接单', null, '2024-03-29 17:39:40', '2024-03-29 18:39:00', '0', null, '1', '0', '0');
INSERT INTO `orders` VALUES ('36', '1711786554663', '6', '1', '1', '2024-03-30 16:15:55', null, '1', '0', '95.00', '', '13657704353', '北京市市辖区西城区江城一路', null, '李峰', '订单超时，自动取消', null, '2024-03-30 16:31:00', '2024-03-30 17:15:00', '0', null, '1', '0', '0');

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '名字',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图片',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `dish_id` bigint(20) DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint(20) DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '口味',
  `number` int(11) NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='订单明细表';

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('40', '东坡肘子', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/a80a4b8c-c93e-4f43-ac8a-856b0d5cc451.png', '27', '59', null, null, '1', '138.00');
INSERT INTO `order_detail` VALUES ('41', '剁椒鱼头', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/13da832f-ef2c-484d-8370-5934a1045a06.png', '27', '61', null, null, '1', '66.00');
INSERT INTO `order_detail` VALUES ('42', '王老吉', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/41bfcacf-7ad4-4927-8b26-df366553a94c.png', '27', '46', null, null, '2', '6.00');
INSERT INTO `order_detail` VALUES ('43', '金汤酸菜牛蛙', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/7694a5d8-7938-4e9d-8b9e-2075983a2e38.png', '28', '62', null, null, '2', '88.00');
INSERT INTO `order_detail` VALUES ('44', '米饭', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', '29', '49', null, null, '3', '2.00');
INSERT INTO `order_detail` VALUES ('45', '清炒西兰花', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/e9ec4ba4-4b22-4fc8-9be0-4946e6aeb937.png', '30', '56', null, '不要葱', '1', '18.00');
INSERT INTO `order_detail` VALUES ('46', '米饭', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', '30', '49', null, null, '1', '2.00');
INSERT INTO `order_detail` VALUES ('47', '王老吉', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/41bfcacf-7ad4-4927-8b26-df366553a94c.png', '30', '46', null, null, '1', '6.00');
INSERT INTO `order_detail` VALUES ('48', '鸡蛋汤', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/c09a0ee8-9d19-428d-81b9-746221824113.png', '30', '68', null, null, '1', '5.00');
INSERT INTO `order_detail` VALUES ('49', '蜀味水煮草鱼', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/a6953d5a-4c18-4b30-9319-4926ee77261f.png', '30', '53', null, '不要葱,中辣', '1', '38.00');
INSERT INTO `order_detail` VALUES ('50', '金汤酸菜牛蛙', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/7694a5d8-7938-4e9d-8b9e-2075983a2e38.png', '31', '62', null, null, '1', '88.00');
INSERT INTO `order_detail` VALUES ('51', '老坛酸菜鱼', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/4a9cefba-6a74-467e-9fde-6e687ea725d7.png', '32', '51', null, '不要葱,不辣', '1', '56.00');
INSERT INTO `order_detail` VALUES ('52', '北冰洋', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/4451d4be-89a2-4939-9c69-3a87151cb979.png', '33', '47', null, null, '1', '4.00');
INSERT INTO `order_detail` VALUES ('53', '香锅牛蛙', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/f5ac8455-4793-450c-97ba-173795c34626.png', '34', '63', null, null, '1', '88.00');
INSERT INTO `order_detail` VALUES ('54', '香锅牛蛙', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/f5ac8455-4793-450c-97ba-173795c34626.png', '35', '63', null, null, '1', '88.00');
INSERT INTO `order_detail` VALUES ('55', '香锅牛蛙', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/f5ac8455-4793-450c-97ba-173795c34626.png', '36', '63', null, null, '1', '88.00');

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint(20) NOT NULL COMMENT '菜品分类id',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '套餐名称',
  `price` decimal(10,2) NOT NULL COMMENT '套餐价格',
  `status` int(11) DEFAULT '1' COMMENT '售卖状态 0:停售 1:起售',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图片',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_setmeal_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='套餐';

-- ----------------------------
-- Records of setmeal
-- ----------------------------

-- ----------------------------
-- Table structure for setmeal_dish
-- ----------------------------
DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `setmeal_id` bigint(20) DEFAULT NULL COMMENT '套餐id',
  `dish_id` bigint(20) DEFAULT NULL COMMENT '菜品id',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10,2) DEFAULT NULL COMMENT '菜品单价（冗余字段）',
  `copies` int(11) DEFAULT NULL COMMENT '菜品份数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='套餐菜品关系';

-- ----------------------------
-- Records of setmeal_dish
-- ----------------------------

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '商品名称',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图片',
  `user_id` bigint(20) NOT NULL COMMENT '主键',
  `dish_id` bigint(20) DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint(20) DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '口味',
  `number` int(11) NOT NULL DEFAULT '1' COMMENT '数量',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='购物车';

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
INSERT INTO `shopping_cart` VALUES ('5', '香锅牛蛙', 'https://sky-take-outy.oss-cn-beijing.aliyuncs.com/f0801ede-d6d1-4ddf-af9a-6365c3babbf1.png', '1', '63', null, null, '1', '88.00', '2024-04-01 20:19:10');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '微信用户唯一标识',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '手机号',
  `sex` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '头像',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户信息';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'okzWb4ltXgoJFE9LUTha5_JlJPKg', null, null, null, null, null, '2024-03-03 18:10:16');
