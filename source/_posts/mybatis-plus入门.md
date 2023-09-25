---
title: mybatis-plus入门
date: 2023-09-20 14:34:35
tags:
- mybatis-plus
---

## 开篇

这篇文章是基于mybatis-plus官方文档写的，项目中要用到mybatis-plus，故写下这篇文章。

## MyBatis-Plus是什么

MyBatis-Plus是MyBatis的增强工具，简化开发，提高效率。

特性：

- **无侵入**：只做增强不做改变，引入它不会对现有工程产生影响，如丝般顺滑
- **损耗小**：启动即会自动注入基本 CURD，性能基本无损耗，直接面向对象操作
- **强大的 CRUD 操作**：内置通用 Mapper、通用 Service，仅仅通过少量配置即可实现单表大部分 CRUD 操作，更有强大的条件构造器，满足各类使用需求
- **支持 Lambda 形式调用**：通过 Lambda 表达式，方便的编写各类查询条件，无需再担心字段写错
- **支持主键自动生成**：支持多达 4 种主键策略（内含分布式唯一 ID 生成器 - Sequence），可自由配置，完美解决主键问题
- **支持 ActiveRecord 模式**：支持 ActiveRecord 形式调用，实体类只需继承 Model 类即可进行强大的 CRUD 操作
- **支持自定义全局通用操作**：支持全局通用方法注入（ Write once, use anywhere ）
- **内置代码生成器**：采用代码或者 Maven 插件可快速生成 Mapper 、 Model 、 Service 、 Controller 层代码，支持模板引擎，更有超多自定义配置等您来使用
- **内置分页插件**：基于 MyBatis 物理分页，开发者无需关心具体操作，配置好插件之后，写分页等同于普通 List 查询
- **分页插件支持多种数据库**：支持 MySQL、MariaDB、Oracle、DB2、H2、HSQL、SQLite、Postgre、SQLServer 等多种数据库
- **内置性能分析插件**：可输出 SQL 语句以及其执行时间，建议开发测试时启用该功能，能快速揪出慢查询
- **内置全局拦截插件**：提供全表 delete 、 update 操作智能分析阻断，也可自定义拦截规则，预防误操作

## 快速开始

添加依赖、在application.yml配置数据库相关内容，在spring boot启动类中添加@MapperScan注解。

编写Mapper包下的接口

```java
public interface UserMapper extends BaseMapper<User> {

}
```

## 注解

### @TableName

表明注解，标识实体类对应的表

```java
@TableName("sys_user")
public class User {
    private Long id;
    private String name;
    private Integer age;
    private String email;
}
```

### @TableId

主键注解

| 属性  | 类型   | 必须指定 | 默认值      | 描述         |
| ----- | ------ | -------- | ----------- | ------------ |
| value | String | 否       |             | 主键字段名   |
| type  | Enum   | 否       | IdType.NONE | 指定主键类型 |

IdType的字段介绍

| 值          | 描述                                                         |
| ----------- | ------------------------------------------------------------ |
| AUTO        | 数据库ID自增                                                 |
| NONE        | 无状态，该类型为未设置主键类型（注解里等于跟随全局，全局里约等于 INPUT） |
| INPUT       | insert 前自行 set 主键值                                     |
| ASSIGN_ID   | 分配 ID(主键类型为 Number(Long 和 Integer)或 String)(since 3.3.0),使用接口`IdentifierGenerator`的方法`nextId`(默认实现类为`DefaultIdentifierGenerator`雪花算法) |
| ASSIGN_UUID | 分配 UUID,主键类型为 String(since 3.3.0),使用接口`IdentifierGenerator`的方法`nextUUID`(默认 default 方法) |

```java
@TableName("sys_user")
public class User {
    @TableId
    private Long id;
    private String name;
    private Integer age;
    private String email;
}
```

### @TableField

非主键字段注解

### @Version

乐观锁注解，标记在字段上

### @EnumValue

普通枚举类注解

## 核心功能

### 代码生成器

快速生成 Entity、Mapper、Mapper XML、Service、Controller 等各个模块的代码

### CRUD接口

##### Mapper CRUD接口

通用 CRUD 封装[BaseMapper (opens new window)](https://gitee.com/baomidou/mybatis-plus/blob/3.0/mybatis-plus-core/src/main/java/com/baomidou/mybatisplus/core/mapper/BaseMapper.java)接口，为 `Mybatis-Plus` 启动时自动解析实体表关系映射转换为 `Mybatis` 内部对象注入容器

## 总结

其实mybatis-plus中涉及到了许多功能，但我看不下去了，我只挑了些许功能写到博客中。在学习mybatis-plus的过程中，Mapper层的CRUD接口让我想到了Spring JPA，也是用来简化单表操作的，但我看了网上相关文章，感觉没有说清楚，挖个坑以后再弄清楚吧。要学的东西还有很多，想象就很疲惫QAQ。
