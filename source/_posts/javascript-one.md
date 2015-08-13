title: "JavaScript学习（一）"
date: 2015-07-21 13:30:42 
tags: javascript
toc: true
---
![js](/img/js.png)

### 关于JavaScript

1. JavaScript是一个和Java没有一分钱关系的语言。
2. ECMAJavaScript才是JavaScript的全球标准。
3. JavaScript诞生只用了10天，膜拜下它的[父亲][1]。

<!--more-->

### 使用JavaScript
使用JavaScript的方法一般有两种：

1. 直接嵌在网页的`任何地方`，但是通常都把它写在`<head>`中：

```html
<html>
<head>
	<script>
	alert('Hello world');
	</script>
</head>
<body>
	...
</body>
</html>
```
2. 把JavaScript放入一个单独的`.js`文件中，然后在HTML中引用：

比如在文件目录`/static/js/`下建立`alert.js`:

```html
<script>
alert('Hello world');
</script>
```
那么就可以在HTML中引用（和CSS类似）：

```html
<html>
<head>
	<script src="/static/js/alert.js></script>
</head>
<body>
	...
</body>
</html>
```

### 基本语法和注释

JavaScript的语法风格与Java一致，语法块由`{...}`组成，语法以`;`结尾。这里要注意的是：虽然在语句后添加`;`不是强制性的写法，但是如果要保证程序的语法一致性，必须保证统一添加`;`。

行注释是`//`，多行注释是`/*...*/`。

以下为几个简单语法实例：

```javascript
\\示例程序
var x = 1;  \\ 赋值x
if (x > 1){
	alert('hello world'); \\ 哟哟哟
	if (x > 10){
		alert('nested bracket I');
		if (x > 100){
			alert('nested bracket II');
			}
		}
	}
```
### 数据类型
JavaScript中有以下几种数据类型：

#### Number

```javascript
1234567; // 整数123456
0.1111; // 浮点数0.1111
1.2345e3; // 科学计数表示1.2344x1000
-100 // 负数
NaN; // NaN为Not a Number，无法计算结果用NaN表示
Infinity; // Infiinty表示数值超过JavaScript的表示范围的Number
```
数值同时也可以用16进制来表示，如`0xffff`, `0x1a`。
数值可以做数学运算：

```javascript
2/0; // Infinity
0/0; // NaN
10%3; // %为求余运算符
```
#### 字符串

JavaScript字符串是以单引号或双引号括起来的任意文本，比如:`'abc'`,`"abc"`。

如果字符串中既含有`'`又包含`"`，可以用转义字符`\`来表示，比如：
> 'I\'m \"OK\"!'

表示的字符串内容是：`I'm "OK"!`

转义字符`\`可以转义很多字符，比如`\n`表示换行，`\t`表示制表符，字符`\`本身也要转义，所以`\\`表示的字符就是`\`。

`\`还可以用来`\u####`表示一个Unicode字符:

```
'\u4e2d\u6587'; // 表示'中文'
```
多行字符串之间如果需要`\n`，可以用\`...\`代替。

```javascript
alert(`多行
字符串
例子`);
```

#### 布尔值
布尔值和布尔代数表达完全一致，只有`true`和`false`。
`&&`是与运算符,`||`是或运算符, `!`是非运算符。

```javascript
true; // true
(3<=1) && false; // true
true || false; // false
!false; // true
```
#### null和undined

`null`表示一个空的值，它和`0`以及空字符串`''`不同。
`null`之于JavaScript，`None`之于Python，`nil`之于Lua。
`undefined`表示一个值未定义，一般没有什么用处。仅在判断函数参数是否传递的情况下有用。

#### 数组

JavaScript的数组可以包括任何数据类型,而且可以通过索引来访问每个元素。

```javascript	
[1, 3, null, false];
```

虽然创建数组可以通过`Array()`函数实现，但一般建议直接使用`[]`创建数组。

```javascript
var arr = [1, 3, null, false];
arr[0] === 1; // true
arr[3] === false; // true
arr.length; // 4
```
要注意的两点：
1.给`Array`的`length`赋一个新的值会导致`Array`大小的变化：

```javascript
var arr = [1, 2, 3];
arr.length; // 3
arr.length = 6;
arr; // arr变为[1, 2, 3, undefined, undefined, undefined]
arr.length = 2;
arr; // arr变为[1, 2]
```
2. 如果通过索引赋值时，索引超过了范围，同样会引起Array大小的变化：

```javascript
var arr = [1, 2, 3];
arr[5] = 'x';
arr; // arr变为[1, 2, 3, undefined, undefined, 'x']
```

在其他编程语言中，比如python中越界索引是会报错的。虽然JavaScript不会报错，但是最好避免这种情况。

##### indexof
类似python的index,来查找一个指定元素的索引位置：

```javascript
var arr = [1, 2, 3];
arr.indexof(1); // 索引为0
```

```python
list = [1, 2, 3]
list.index(1) # 索引为0
```
##### slice
类似python的`[]`，截取`Array`的部分元素，然后返回一个新的`Array`

```javascript
var arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
arr.slice(0, 3); // 从索引0开始，到索引3结束，但不包括索引3: ['A', 'B', 'C']
arr.slice(3); // 从索引3开始到结束: ['D', 'E', 'F', 'G']
var arrCopy = arr.slice(); //复制一个相同的数组
```

```python
list = ['A', 'B', 'C', 'D', 'E', 'F', 'G']
list[0:3]
list[3:]
```
##### push和pop
`push()`向`Array`的末尾添加若干元素，`pop()`则把`Array`的最后一个元素删除掉。
`push()`和python中`List`的`append()`类似，`pop()`和python中`List`的`pop()`类似，

##### unshift和shift
如果要往`Array`的头部添加若干元素，使用`unshift()`方法，`shift()`方法则把Array的第一个元素删掉：

```javascript
var arr = [1, 2, 3];
arr.unshift('A', 'B');
arr; // ['A', 'B', 1, 2, 3]
arr.shift(); 
arr; // ['B', 1, 2, 3]
```

##### sort和reverse
`sort()`可以对当前Array进行排序，它会直接修改当前`Array`的元素位置，直接调用时，按照默认顺序排序。

`reverse()`把整个Array的元素给掉个个，也就是反转。

##### concat

`concat()`方法把当前的`Array`和另一个`Array`连接起来，并返回一个新的`Array`。

##### join
`join()`可以把当前Array的每个元素都用指定的字符串连接起来，然后返回连接后的字符串：

```javascript
var arr = ["A", "B", "C", 1, 2, 3];
arr.join('-'); //如果Array的元素不是字符串，将自动转换为字符串后再连接。
```
对比一下Python中的join():

```python
list = ["a", "b" ,"c"]
"-".join(list)
```
注意：python中join方法是属于字符串的方法，所以事实上是字符串的连接，list中元素必须为字符串。

### 比较运算符

基本的Number比较可以略过。

注意一下JavaScript中对任意数据类型的比较：

```javascript
false == 0; // true
false === 0; // false
```
JavaScript设计了两种比较运算符:

第一种是`==`比较，它会自动转换数据类型在比较，很容易发生错误，应该避免使用这一种比较。

第二种是`===`比较，它不会自动转换数据类型，如果数据类型不一致，返回`false`,如果一致则在进行比较。

此外，`NaN`是一个比较特殊的Number，它与其他值都不相等，甚至不等于它自身，只能用`isNaN()`函数判断：

```javascript
NaN === NaN; // false
isNaN(NaN); // true
```
浮点数的相等比较要用浮点数它们之差的绝对值，看是否小于某个阈值。这是因为在运算过程中会产生误差，计算机无法精确表示无限循环小数。

```javascript
1 / 3 === (1 - 2 / 3); // false
Math.abs(1 / 3 -(1 - 2 / 3)) < 0.0000001; //true
```
### 对象
和Java类似, JavaScript的对象是一组由键-值组成的无序集合，例如：

```javascript
var dog = {
	name: 'Zipper',
	age: '5',
	height: '50cm',
	tags: ['happy', 'lazy'],
	city: 'Berlin',
	zipcode: 'null',
	'prop' : 'invalid'
};
```
要获取一个对象的属性，可以使用`对象变量.属性名`的方式：

```javascript
dog.age; // 5
dog.zipcode; // null
```
如果对象的属性名不是`一个有效的变量`，就需要用''括起来。访问这个属性也无法使用.操作符，必须用['xxx']来访问。

```javascript
dog['prop']; // 'invalid'
```
> 实际上JavaScript对象的所有属性都是字符串，不过属性对应的值可以是任意数据类型。这里javascript的对象和java，python中的对象不同，对象中是没有变量(Variables)和方法(Method)的！只有属性！只有属性！只有属性！

检测一个对象是否有一属性的方法可以使用`in`；

检测一个对象是否自身有一属性(非继承)用`.hasOwnProperty('xxx')`；

因为javascript的对象是动态类型，访问一个不存在的属性不会报错，而且对象的属性可以删除。

### 变量
变量的使用与动态语言Python一样，变量的数据类型在赋值中改变。
此外，注意使用`var`来进行变量申明。(不然要使用`'use strict';`来强制执行)

```javascript
var a = 1; 
a = 'one';
```
~~Mistaken text.~~

| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

| Left-Aligned  | Center Aligned  | Right Aligned |
| :------------ |:---------------:| -----:|
| col 3 is      | some wordy text | $1600 |
| col 2 is      | centered        |   $12 |
| zebra stripes | are neat        |    $1 |

[1]: https://zh.wikipedia.org/wiki/布蘭登·艾克

