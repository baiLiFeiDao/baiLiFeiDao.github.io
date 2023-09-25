---
title: 针对fsb的权限过滤文档
date: 2023-09-22 17:01:13
tags:
- 权限过滤
password: 123
---

## 引言

本文主要介绍丰收宝的数据权限的类型、数据权限过滤是如何实现的。

## 数据权限过滤介绍

### 数据权限分配

在系统管理-角色管理-操作-更多-分配权限中可以对已经新增的角色进行数据权限分配。

在新增角色的时候没有分配数据权限的选项，据观察，默认为本部门及以下数据权限（在表sys_role的data_scope字段，默认值是4）

![image-20230925000454246](C:\Users\allinpay\AppData\Roaming\Typora\typora-user-images\image-20230925000454246.png)

![image-20230925101840149](C:\Users\allinpay\AppData\Roaming\Typora\typora-user-images\image-20230925101840149.png)

### 支持的权限类型

| 字段                        | 描述               | 备注                                                         |
| --------------------------- | ------------------ | ------------------------------------------------------------ |
| *DATA_SCOPE_ALL*            | 全部数据权限       | 值：1；不做权限过滤                                          |
| *DATA_SCOPE_CUSTOM*         | 自定数据权限       | 值：2；针对sys_role_dept角色对应的一个或多个部门做数据权限过滤 |
| *DATA_SCOPE_DEPT*           | 部门数据权限       | 值：3                                                        |
| *DATA_SCOPE_DEPT_AND_CHILD* | 部门及以下数据权限 | 值：4                                                        |
| *DATA_SCOPE_SELF*           | 仅本人数据权限     | 值：5                                                        |

### 数据权限过滤的两种类型

| 字段             | 描述                                     | 备注             |
| ---------------- | ---------------------------------------- | ---------------- |
| *DATA_SCOPE*     | 对管理后台的用户进行数据权限过滤的关键字 | 值：dataScope    |
| *CUS_DATA_SCOPE* | 对小程序的用户进行数据权限过滤的关键字   | 值：cusDataScope |

## 数据权限过滤是如何实现的

以客户管理-用户绑定银行信息查询为例，介绍丰收宝是如何进行数据权限过滤的

在service层，通过@DataScope注解指定小程序用户表的别名

```java
    @Override
    @DataScope(deptAlias = "u")
    public List<TblBindCardInf> selectTblBindCardInfList(TblBindCardInf tblBindCardInf)
    {
        return tblBindCardInfMapper.selectTblBindCardInfList(tblBindCardInf);
    }
```

在程序运行到@DataScope(deptAlias = "u")注解时，进入DataScopeAspect，定义执行的代码

```java
    @Before("dataScopePointCut()")
    public void doBefore(JoinPoint point) throws Throwable
    {
        clearDataScope(point);//拼接权限sql前先清空params.dataScope参数防止注入
        handleDataScope(point);//拼接sql
    }
```

 handleDataScope()函数下的dataScopeFilter负责数据范围过滤，通过不同的数据范围拼接不同的sql语句。

```java
    public static void dataScopeFilter(JoinPoint joinPoint, SysUser user, String deptAlias, String userAlias)
    {
        StringBuilder sqlString = new StringBuilder();
        StringBuilder cusSqlString = new StringBuilder();

        boolean flag = true;
        for (SysRole role : user.getRoles())
        {
            String dataScope = role.getDataScope();
            if (DATA_SCOPE_ALL.equals(dataScope))
            {
                sqlString = new StringBuilder();
                break;
            }
            else if (DATA_SCOPE_CUSTOM.equals(dataScope))
            {
                sqlString.append(StringUtils.format(
                        " OR {}.dept_id IN ( SELECT dept_id FROM sys_role_dept WHERE role_id = {} ) ", deptAlias,
                        role.getRoleId()));
            }
            else if (DATA_SCOPE_DEPT.equals(dataScope))
            {
                sqlString.append(StringUtils.format(" OR {}.dept_id = {} ", deptAlias, user.getDeptId()));
            }
            else if (DATA_SCOPE_DEPT_AND_CHILD.equals(dataScope))
            {
                sqlString.append(StringUtils.format(
                        " OR {}.dept_id IN ( SELECT dept_id FROM sys_dept WHERE dept_id = {} or find_in_set( {} , ancestors ) )",
                        deptAlias, user.getDeptId(), user.getDeptId()));
            }
            else if (DATA_SCOPE_SELF.equals(dataScope))
            {
                if (StringUtils.isNotBlank(userAlias))
                {
                    sqlString.append(StringUtils.format(" OR {}.user_id = {} ", userAlias, user.getUserId()));
                }
                else
                {
                    // 数据权限为仅本人且没有userAlias别名不查询任何数据
                    sqlString.append(" OR 1=0 ");
                }
            }

            if ("admin".equals(role.getRoleKey())){
                flag=false;
            }
        }

        if (flag){
//            cusSqlString.append(StringUtils.format(
////                    " OR {}.ind_cd IN ( select ind_cd FROM tbl_agency_inf where dept_id IN ( SELECT dept_id FROM sys_dept WHERE dept_id = {} or find_in_set( {} , ancestors )) ) ",
////                    deptAlias,user.getDeptId(),user.getDeptId()));
                        cusSqlString.append(StringUtils.format(
                    " OR {}.dept_id IN ( SELECT dept_id FROM sys_dept WHERE dept_id = {} or find_in_set( {} , ancestors )) ",
                    deptAlias,user.getDeptId(),user.getDeptId()));
        }

        if (StringUtils.isNotBlank(sqlString.toString()))
        {
            Object params = joinPoint.getArgs()[0];
            if (StringUtils.isNotNull(params) && params instanceof BaseEntity)
            {
                BaseEntity baseEntity = (BaseEntity) params;
                baseEntity.getParams().put(DATA_SCOPE, " AND (" + sqlString.substring(4) + ")");
            }
        }
        if (StringUtils.isNotBlank(cusSqlString.toString()))
        {
            Object params = joinPoint.getArgs()[0];
            if (StringUtils.isNotNull(params) && params instanceof BaseEntity)
            {
                BaseEntity baseEntity = (BaseEntity) params;
                baseEntity.getParams().put(CUS_DATA_SCOPE, " AND (" + cusSqlString.substring(4) + ")");
            }
        }
    }

```

使用非超级管理员的账户登录，在如图所示的第47行打断点，可以看到tblBindCardInf中的params的值被注入了

![image-20230925095759897](C:\Users\allinpay\AppData\Roaming\Typora\typora-user-images\image-20230925095759897.png)

![image-20230925094949946](C:\Users\allinpay\AppData\Roaming\Typora\typora-user-images\image-20230925094949946.png)

params.cusDataScope将拼接在sql语句之后，实现了登录者只能查看该部门下的小程序用户绑定银行卡的信息

![image-20230925095936287](C:\Users\allinpay\AppData\Roaming\Typora\typora-user-images\image-20230925095936287.png)
