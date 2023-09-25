---
title: 进行mybatis实战时遇到的一些错误
date: 2023-09-21 10:07:41
tags:
- 编译器报错
---

## 背景

今天在看mybatis-plus的一些知识，我其实学知识一直很难动手实践，因为配置环境超级麻烦，各种报错，解决起来很烦，尤其是不知道怎么办的时候，但我不能总是不动手去做，不实践我永远不可能知道具体怎么做。在这里记录一下解决配置问题的有效方法。

## Plugin‘org.springframework.boot:spring-boot-maven-plugin:‘ not found的解决方案

解决方法来自https://www.cnblogs.com/Cheney822/p/16487932.html，只是为了记录搬运到本博客

### 方法一：清理IDEA的缓存

> File -> Invalidate Caches

### 方法二：添加版本号

先看自己当前的版本号

- 首先打开`pom.xml`文件进行查看
- Ctrl+F搜索`spring-boot-starter-parent`
- 找到`<artifactId>spring-boot-starter-parent</artifactId>`这一行。
- 下面一行就是版本号。

然后将版本号放到报错一行的下面

# 类文件具有错误的版本 61.0, 应为 52.0 请删除该文件或确保该文件位于正确的类路径子目录中。

原因：boot3.0.0版本要求jdk17以上，自己的版本是1.8

方法：

改Project Structure的JDK版本 

# Mysql 80 解决忘记密码无法跳过错误 mysqld --console --skip-grant-tables --shared-memory 代码无效的问题

参考这个方法解决https://blog.csdn.net/wangzhepaohui/article/details/109685612

# Unsupported class file major version 61

类文件主版本61对应的Java SDK 17

下载的项目中的springboot不支持JAVA SDK17

配置环境经典的错误就是版本不兼容

# Maven项目pom.xml project标签爆红解决方法

> ‘parent.relativePath’ of POM com.hrp:springboot_jpa:1.0-SNAPSHOT (F:\IdeaCode\java-web\springboot_jpa\pom.xml) points at com.hrp:java-web instead of org.springframework.boot:spring-boot-starter-parent, please verify your project structure

这个问题是说在project标签下的parent.relativePath标签指向的路径出现了错误，所以导致报错。

解决方法：在parent标签下，添加**`<relativePath/>`**即可

