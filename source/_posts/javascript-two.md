title: "JavaScript学习（二）"
date: 2015-08-14 17:34:49
tags: javascript
toc: true
---
![js](/img/js2.png)

### 函数定义

#### 函数声明

javascript中由`function`来定义一个函数，其中包括：

* 函数名称。
* 圆括号`()`内列出的函数参数，多个参数以`,`分隔。
* 花括号`{ ... }`之间的代码是函数体，可以包含若干语句，甚至可以没有任何语句。

如果输入的参数是一个对象，那函数只能改变该对象的属性。如果尝试改变函数的值，在函数外改变是没有效果的。

<!--more-->

#### 匿名函数

函数还可以用匿名函数表示，它没有函数名。比如：

```javacript
var square = fuction(number){ return number * number};
var x = sqaure(4);
```
### 调用函数

调用函数时，按顺序传入参数即可。

由于JavaScript允许传入任意个参数而不影响调用，因此传入的参数比定义的参数多也没有问题，虽然函数内部并不需要这些参数。

	abs(-9, 'haha', 'hehe', null); // 返回9

传入的参数比定义的少也没有问题。

	abs(); // 返回NaN


函数内可以调用自身。

要避免收到undefined，可以对参数进行检查：
 
```
function abs(x) {
    if (typeof x !== 'number') {
        throw 'Not a number';
    }
    if (x >= 0) {
        return x;  
    } else {
        return -x;
    }
}
```

#### arguments
JavaScript还有一个免费赠送的关键字arguments，它只在函数内部起作用，并且永远指向当前函数的调用者传入的所有参数。

```javascript
// foo(a[,b],c)
function foo(a, b ,c){
    if (arguments.length === 0){
        return 0;
    }
    else if (arguments.length === 2){
        c = b;
        b = null;
    }
    return (a * b - c);
}
```
#### rest参数
由于JavaScript函数允许接收任意个参数，于是我们就不得不用arguments来获取所有参数：

### 函数作用域 

#### 递归

