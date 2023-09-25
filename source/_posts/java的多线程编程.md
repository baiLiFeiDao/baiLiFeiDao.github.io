---
title: java的多线程编程
subtitle: 摘自菜鸟教程
date: 2023-09-12 13:37:44
tags:
- JAVA
- 多线程
---

## 线程的定义

一个进程包括操作系统分配的内存空间，包含一个或多个线程。线程不能独立存在，必须是进程的一部分。多线程编程可以让程序员充分利用CPU

## 一个线程的生命周期

## ![img](https://www.runoob.com/wp-content/uploads/2014/01/java-thread.jpg)线程的优先级

每个JAVA线程都有一个优先级，有助于操作系统确定线程的调度顺序。

Java 线程的优先级是一个整数，其取值范围是 1 （Thread.MIN_PRIORITY ） - 10 （Thread.MAX_PRIORITY ）。

默认情况下，每一个线程都会分配一个优先级 NORM_PRIORITY（5）。

具有较高优先级的线程对程序更重要，并且应该在低优先级的线程之前分配处理器资源。但是，线程优先级不能保证线程执行的顺序，而且非常依赖于平台。

## 创建线程的三种方法

### 继承Thread类创建线程类

- 定义Thread类的子类，重写该类的run方法，run方法的方法体代表了线程要完成的任务，因此把run方法称为执行体

- 创建Thread子类的实例，即创建了线程对象

- 调用线程对象的star方法来启动该线程

  ```java
  class ThreadDemo extends Thread {
     private Thread t;
     private String threadName;
     
     ThreadDemo( String name) {
        threadName = name;
        System.out.println("Creating " +  threadName );
     }
     
     public void run() {
        System.out.println("Running " +  threadName );
        try {
           for(int i = 4; i > 0; i--) {
              System.out.println("Thread: " + threadName + ", " + i);
              // 让线程睡眠一会
              Thread.sleep(50);
           }
        }catch (InterruptedException e) {
           System.out.println("Thread " +  threadName + " interrupted.");
        }
        System.out.println("Thread " +  threadName + " exiting.");
     }
     
     public void start () {
        System.out.println("Starting " +  threadName );
        if (t == null) {
           t = new Thread (this, threadName);
           t.start ();
        }
     }
  }
   
  public class TestThread {
   
     public static void main(String args[]) {
        ThreadDemo T1 = new ThreadDemo( "Thread-1");
        T1.start();
        
        ThreadDemo T2 = new ThreadDemo( "Thread-2");
        T2.start();
     }   
  }
  ```

  ### 通过Runnable接口创建线程类

- 定义Runnable接口的实现类，重写该接口的run方法
- 创建Runnable实现类的实例，并以此实例作为Thread的target来创建Thread对象，该Thread对象才是真正的线程对象。
- 调用线程对象的start()方法来启动该线程。

```
package com.thread;

public class RunnableThreadTest implements Runnable {
    private int i;

    public void run() {
        for (i = 0; i < 100; i++) {
            System.out.println(Thread.currentThread().getName() + " " + i);
        }
    }

    public static void main(String[] args) {
        for (int i = 0; i < 100; i++) {
            System.out.println(Thread.currentThread().getName() + " " + i);
            if (i == 20) {
                RunnableThreadTest rtt = new RunnableThreadTest();
                new Thread(rtt, "新线程1").start();
                new Thread(rtt, "新线程2").start();
            }
        }
    }
}
```



### 通过Callable和Future创建线程

 (1)创建Callable接口的实现类，并实现call()方法，该call()方法将作为线程执行体，并且有返回值。

```java
public interface Callable {
    V call() throws Exception;
}
```

（2）创建Callable实现类的实例，使用FutureTask类来包装Callable对象，该FutureTask对象封装了该Callable对象的call()方法的返回值。（FutureTask是一个包装器，它通过接受Callable来创建，它同时实现了Future和Runnable接口。）

（3）使用FutureTask对象作为Thread对象的target创建并启动新线程。

（4）调用FutureTask对象的get()方法来获得子线程执行结束后的返回值。

```java
package com.thread;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

public class CallableThreadTest implements Callable<Integer> {
    public static void main(String[] args) {
        CallableThreadTest ctt = new CallableThreadTest();
        FutureTask<Integer> ft = new FutureTask<>(ctt);
        for (int i = 0; i < 100; i++) {
            System.out.println(Thread.currentThread().getName() + " 的循环变量i的值" + i);
            if (i == 20) {
                new Thread(ft, "有返回值的线程").start();
            }
        }
        try {
            System.out.println("子线程的返回值：" + ft.get());
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Integer call() throws Exception {
        int i = 0;
        for (; i < 100; i++) {
            System.out.println(Thread.currentThread().getName() + " " + i);
        }
        return i;
    }
}
```

