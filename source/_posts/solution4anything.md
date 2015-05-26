title: "Solution for Anything"
date: 2015-05-26 13:30:42
tags: python 
---
![the ultimate answer](/img/answer_42.png)

今天在网上看到一道十分有趣的题目，叫做`Solution for anything`。这道题需要通过Python编写仅调用一个变量的函数或者类，它输出的结果与其他数据类型比较的结果为`True`。


比如:
>输入：任意数据。参照以下输入数据。
>
>输出：未知数据。(Something As a something else.)

<!-- more -->

举几个简单的例子：

```python
checkio({}) != [] # True
checkio('Hello') < 'World' # True
checkio(80) > 81 # True
checkio(re) >= re # True
checkio(re) <= math # True
checkio(5) == ord # True
```
### 魔术方法

事实上解这道题的思路就是掌握并使用Python`Class(类)`的`Magic Method(魔法方法)`。那什么是魔法方法呢？它们就存在于面向对象Python，我们可以添加`它们`来自定义`类`。

在这道题里，我们只要在我们的类里**自定义**我们自己类中得**运算符**，重载Python内类默认的运算符方法，从而达到我们所需要的结果。这样做的好处是：避免丑陋的、非标准化的基本操作方法。

那怎么在类中使用魔法方法呢？下面列出了一部分Python中类里面可以使用的魔术方法：
>二进制运算符

|**运算符**|**方法**
|:---	|:------
|`+`	|`object.__add__(self, other)`
|`-`	|`object.__sub__(self, other)`
|`*	`	|`object.__mul__(self, other)`
|`//`	|`object.__floordiv__(self, other)`
|`/`	|`object.__div__(self, other)`
|`%`	|`object.__mod__(self, other)`
|`**`	|`object.__pow__(self, other[, modulo])`
|`<<`	|`object.__lshift__(self, other)`
|`>>`	|`object.__rshift__(self, other)`
|`&`	|`object.__and__(self, other)`
|`^`	|`object.__xor__(self, other)`
|`or`[^1]	|`object.__or__(self, other)`


>扩展赋值运算符

|**运算符**|**方法**
|:---	|:------
|`+=`	|`object.__iadd__(self, other)`
|`-=`	|`object.__isub__(self, other)`
|`*=`	|`object.__imul__(self, other)`
|`/=`	|`object.__idiv__(self, other)`
|`//=`	|`object.__ifloordiv__(self, other)`
|`%=`	|`object.__imod__(self, other)`
|`**=`	|`object.__ipow__(self, other[, modulo])`
|`<<=`	|`object.__ilshift__(self, other)`
|`>>=`	|`object.__irshift__(self, other)`
|`&=`	|`object.__iand__(self, other)`
|`^=`	|`object.__ixor__(self, other)`
|`or=`[^2]	|`object.__ior__(self, other)`

>位元运算符

|**运算符**|**方法**
|:---	|:------
|`-`	|`object.__neg__(self)`
|`+`	|`object.__pos__(self)`
|`abs()`	|`object.__abs__(self)`
|`~`	|`object.__invert__(self)`
|`complex()`	|`object.__complex__(self)`
|`int()`	|`object.__int__(self)`
|`long()`	|`object.__long__(self)`
|`float()`	|`object.__float__(self)`
|`oct()`	|`object.__oct__(self)`
|`hex()`	|`object.__hex__(self)`

>比较运算符

|**运算符**|**方法**
|:---	|:------
|`<`	|`object.__lt__(self, other)`
|`<=`	|`object.__le__(self, other)`
|`==`	|`object.__eq__(self, other)`
|`!=`	|`object.__ne__(self, other)`
|`>=`	|`object.__ge__(self, other)`
|`>`	|`object.__gt__(self, other)`

从上面我们可以看到，我们只要自定义类内的**比较运算符**，便可以使与其他数据类型比较的结果都为`True`。于是我们在Python中编写一个类，让它与其他数据类型运算后，返回值都为`True`。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

class checkio(object):
    '''
    A class object which is the anwser to anything.
    '''
    def __init__(self, anything = None):
        self.anything = anything

    def __ne__(self, other):
        return True

    def __cmp__(self, other):
        return True

    def __eq__(self, other):
        return True

    def __le__(self, other):
        return True

    def __lt__(self, other):
        return True

    def __ge__(self, other):
        return True

    def __gt__(self, other):
        return True

    def __str__(self, question = None):
        return '42'

if __name__ == '__main__':
    import re
    import math
    assert checkio({}) != [],          'You'
    assert checkio('Hello') < 'World', 'will'
    assert checkio(80) > 81,           'never'
    assert checkio(re) >= re,          'make'
    assert checkio(re) <= math,        'this'
    assert checkio(5) == ord,          ':)'
    print checkio("What's the anwser to life and the universe?")
    print('NO WAY!!! :(')
    
```
编译程序，无编译错误，执行正确。

```
42
NO WAY!!! :(
[Finished in 0.2s]
```

### 小结

使用魔术方法，我们能定义自己类中的操作，从而使得我们自己的方法就像类中自带的`built-in`方法。当然，魔法方法不仅仅局限于`自定义类中的运算符`，它还可以用于`描述类`、`属性访问控制`、`定义可调用对象`等等。

[^1]:	这里`or`代表`或运算符 |`,因为markdown没有`|`的转义符，而markdown的table语法，`|`的功能是构建新的表格边框。
[^2]: 同上。

更多可以戳：

[A Guide to Python's Magic Methods][1]

[Python 的 Magic Methods 指南][2]

[1]:http://www.rafekettler.com/magicmethods.html#comparisons
[2]:http://www.oschina.net/translate/python-magicmethods


