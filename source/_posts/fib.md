title: "在Python中解决Fib问题的多种方法"
date: 2015-10-25 01:13:20
tags:
    - performance
    - python
    - algorithm
toc: true
---

![pope](/img/fib.jpg)

### 问题由来

传说在十字军东征的某一天晚上，罗马的大主教在做了一个梦， 梦中天使加里列和他说：`找到所有会数学的文化人，特别是那个叫Fibonacci。你们必须算出第一百万个Fibonacci数是什么，不然的话十字军在中东就会被穆斯林哥哥团灭。这是上帝大人的意思。`说完，大天使消失，教皇也醒了。教皇心想：喔哦，天降大任于斯人也，必将苦其心志...（我瞎说的）。教皇心想：一百万是多少？

<!--more-->

要知道，那时候欧洲还采用罗马数字，而罗马数字是没有加减运算的。为什么呢，因为罗马数字里面是没有`零`的，没有了零，大家怎么做加减呢，没错就是幼儿园的用的手指头计数。而且，有个大学士在罗马数字中开发了`零`后还写了一堆论文来论证用`零`来简易计数的方法。喔哦，然并卵，罗马教会看到后说，罗马数字是完美神圣的，不可加入这个邪恶的`零`，于是`零`和这个人就直接被简单粗暴的烧烧烧烧死了。

教皇冷静了一下，恩，心想到：上帝怎么会这样考验我（一个数学不好的人），这一定是恶魔👿。睡觉先。

恩，接下来，上帝不开心了。请转播萨拉丁大帝如何大破圣十字军。

### 解决方法

ok。今天，我准备讲下用python来解这道题的基本思路。

首先，最基本的递归算法，这应该是所有初学算法里面最常见的一种。


#### 原始递归

```python
def fib(n):
    return n if n in [0, 1] else fib(n-2) + fib(n-1)
```

这种算法非常低效，因为每次都有算一遍前fib(n)的值。

#### 原始递推

那么于是有了基于它的优化算法：用`递推`来代替`递归`。

```python
def fib_1(n):
    a, b = 0, 1
    for i in xrange(n):
        a, b = b, a + b
    return a
```

这是一般是最优化的fib算法了，包括python自己的文档Modules里面也是这个思路。

#### 装饰器递推

但是不得不提一下网上利用python自身语言特性，用装饰器来优化之前的`递归`算法的。[参看][1]

[1]:http://ujihisa.blogspot.fr/2010/11/memoized-recursive-fibonacci-in-python.html

```python
def memorize(fn):
    stored_results = {}
    def memoized(*args):
        try:
            # try to get the cached result
            return stored_results[args]
        except KeyError:
            # nothing was cached for those args. let's fix that.
            result = stored_results[args] = fn(*args)
            return result
    return memorized
```

```python
@memorize
def fib(n):
    return n if n in [0, 1] else fib(n-2) + fib(n-1)
```

这样的做的话，在做递归的时候，会先看一下装饰器中有没有储存相应的fib值，如果没有，则把计算结果储存在装饰器里。
这样做递归就不需要再去重新计算n之前的值了，其实也就是`递推`思路。

#### 简单粗暴的公式法

当然，也可以用[数学公式][2]解决。

[2]:https://zh.wikipedia.org/wiki/斐波那契数列

```python
import math
def fib_2(n):
    '''formula for Fibonacci'''
    sr5 = math.sqrt(5)
    y = (((1 + sr5) / 2) ** n - ((1 - sr5) / 2) ** n)/ sr5
    return y
```

#### 线性代数

然而其实最高效和快速的是用[线性代数][3]来解决.

[3]:https://zh.wikipedia.org/wiki/斐波那契数列

它的推演过程就是：

1. f(2) = f(1)+f(0) 
2. f(3) = f(2)+f(1)=2*f(1) + f(0)
3. f(4) = f(3) + f(2) = 3\*f(1) + 2\*f(0)

......

n+1. f(n) = f(n-1) + f(n-2) = A\*f(1) + B\*f(0)


如果以矩阵行列式的方式来表示这种推演就是如下注释中的公式

```bash
    线性代数解法
    | Fn    |   | 1   1 |            |  1 |
    |       | = |       | ** (n-1) x |    |
    | Fn-1  |   | 1   0 |            |  0 |   

```
我在网上找到了一段代码实现代码，这个实现方法写出来非常不pythonic，可读性也很差。

```python
def fib_3(n):
    if n <= 0:
        return 0
    i = n - 1
    a,b = 1,0
    c,d = 0,1
    while i > 0:
        if i % 2 == 1: # 这也是一个优化，将 a\*\*4 的问题优化成 a\*\*2 * a**2
            a,b = d\*b + c\*a, d\*(b + a) + c\*b
        c,d = c\*\*2 + d\*\*2, d\*(2\*c + d)
        i = i / 2
    return a + b
```

那么在python中我们可以使用numpy的库，这个库是专门用于实现集合矩阵的计算。使用这个库，我们能非常方便的实现矩阵的n-1次方。
而且使用这种方法执行非常之快

```python
import numpy as np
def fib_4(n):    
    m = np.matrix([[1,1], [1, 0]], object) # 注意这里的类型是object，其他类型会溢出
    result = (m **(n-1)) * [[1], [0]] 
    return result[0,0]
```

### 测试

那么接下来来帮罗马教主计算一下第一百万个Fibonacci数，
同时测试一下各算法的优劣。

```python
python -m timeit 'import fib\_test' 'fib_test.fib(1000000)'
RuntimeError: maximum recursion depth exceeded
```

使用`原始递归加装饰器`的方式直接超出python的可递归范围。

```python
python -m timeit 'import fib\_test' 'fib_test.fib\_2(1000000)'
OverflowError: (34, 'Result too large')
```

使用`数学公式`的方式直接溢出。

```python
python -m timeit 'import fib\_test' 'fib_test.fib\_2(1000000)'
  File "./fib\_test.py", line 31, in fib_1
    a, b = b, a + b
KeyboardInterrupt
```

程序进入循环，性能很慢，被我直接中断。


```python
python -m timeit -s 'import fib\_test' 'fib\_test.fib_3(1000000)'
10 loops, best of 3: 262 msec per loop
```

用`线性代数`实现的方式耗时*262ms*。

```python
python -m timeit -s 'import fib\_test' 'fib\_test.fib_4(1000000)'
10 loops, best of 3: 403 msec per loop
```
使用`numpy库线性代数`的方式耗时*403ms*。

这是因为在`线性代数`存在一个优化就是：将 a\*\*4 的问题优化成 a\*\*2 * a**2，把计算量2n次方简化到n次方。


### 后记

这是最近研究numpy和算法后的一点点小的心得体会，已作记录。


---




