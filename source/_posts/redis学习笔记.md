---
title: redis入门
date: 2023-09-14 
tags:
- redis
---

## Redis数据类型

| 类型   | 存                                         | 取                          | 补充                                                         |
| ------ | ------------------------------------------ | --------------------------- | ------------------------------------------------------------ |
| String | set runoob "菜鸟教程"                      | get runoob                  | 二进制安全，可以包含任何数据。最大能存储512MB                |
| Hash   | HMSET runoob field1 "Hello" field2 "World" | HGET runoob field1          | 键值对集合，是一个string类型的field和value的映射表。每个hash可以存储2**31-1个键值对 |
| List   | lpush runoob redis                         | lrange runoob 0 10          | 按照插入顺序排序，添加一个元素到列表的头部或者尾部           |
| Set    | sadd key member                            | smembers runoob             | 集合中的成员数为2**32-1                                      |
| zset   | zadd key score member                      | zrangebyscore runoob 0 1000 | 有序集合：数据插入集合时，已经天然排序                       |

## Redis命令

用于在redis服务上执行操作。要在redis服务上执行命令需要一个redis客户端。

启动redis客户端

```shell
$redis -cli
-----PING用于检测redis服务是否启动
PING
```

在远程服务上执行命令

```shell
$redis-cli -h 127.0.0.1 -p 6379 -a "123456"
```

Redis键命令：用于管理redis的键

