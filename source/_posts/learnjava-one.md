title: "Java学习笔记(一）"
date: 2015-05-28 23:44:32
tags: [java,python]
---
![learn_java_banner](/img/learn_java.png)
<!--more-->
Java学习第六周部分：

### 6.1 异常处理：异常的抛出与捕获

#### 1.异常的定义

异常（Exception）就是Java中得运行处理机制。
基本写法如下：

```java

try{
		语句组
	}catch(Exception ex){
		异常处理语句；	
	}catch(异常类名 异常形式参数名）{
		异常处理语句；
	}finally{
		异常处理语句；
	}	
```
回顾一下发现与Python的异常处理很像，Python的基本写法如下：

```python
try:
	语句组
except:#General Error catching
	异常处理语句
finally:
	异常处理语句
```
所以说语言很多都是想通的=。=，接下来看一个例子

```java
public static void main(String[] args) {
		try{
			BufferedReader in = new BufferedReader(
				new InputStreamReader(System.in));
			System.out.println("please input a number:");
			String s = in.readLine();
			int n = Integer.parseInt(s);
		}catch(IOException ex){
			ex.printStackTrace();  //"输入输出"可能导致错误
		}catch(NumberFormatException ex){
			ex.printStackTrace();	//"解析"可能导致错误
		}
	}
```

Java异常处理过程：

1. `抛出(throw)`异常：如果出现错误，底层函数抛出异常
2. `运行时系统在调用栈`中查找，从生成异常的方法开始`回溯,直到找到哪里捕获了异常
3. `捕获(catch)`异常

#### 2.异常的分类

Java中的Throwable类下分为两类异常：`Error`类和`Exception`类，在java中前者通常指的是虚拟机的错误，而后者便是一般意义上的异常。

`Exception`类是所有Exception类的父类

构造方法(Constructor)：

>	public Exception();
>	public Exception(String message);//带一个信息
>	Exception(String message, Throwable cause);//带一个信息和一个底层原因

方法(Method)：

>	getMessage() // 带一个信息
>	getCause() //底层原因
>	printStackTrace()//显示调用堆栈的信息


#### 3.多异常的处理

1. 在多异常处理中，子类异常要在父类异常的前面，因为子类异常一般比父类异常更具体。

2. 无论`是否有异常出现`，finally语句中的异常处理语句`必须处理`，不管break、return语句是否在finally之前。这点非常重要，务记！！！

### 6.2 异常处理：受检的异常

Exception异常类又分两种：`运行异常类(RuntimeException)`和`受检的异常类(checked Exception)`。前者和其子类一般可以不做不明确处理，而且在写程序是最好用if语句代替,比如变量格式不对等。但后者`要求明确进行语法处理`，要么在程序内捕获异常，要么要在方法签名后面用`throws xxxx`来声明自身会抛出异常。

这里有两点要注意：1.在子类中，如果要覆盖父类的一个方法,若父类中的方法声明了throws异常,则子类的方法也可以throws异常。2.可以抛出子类异常(更具体的异常),但不能抛出更一般的异常。

此外，java在JDK1.7后多了一个处理机制try...with...resource，try(类型 变量名 = new 变量),省略catch，自动添加了finally{变量.close()}，这种处理机制本质上是`自动对可释放资源的进行释放`，简化了编写方式。
比如：

```java
    public static void main(String ... args)
		throws IOException
	{
		String path = "c:\\aaa.txt";
		System.out.println( ReadOneLine1( path ) );
		System.out.println( ReadOneLine2( path ) );
    }
	static String ReadOneLine1(String path){
		BufferedReader br=null;
        try {
            br=new BufferedReader(new FileReader(path));
            return br.readLine();
        } catch(IOException e) {
            e.printStackTrace();
        } finally {
            if(br!=null){
				try{ 
					br.close();
				}catch(IOException ex){
				}
			}
        }
		return null;
	}
	static String ReadOneLine2(String path)
		throws IOException
	{
		try(BufferedReader br= new BufferedReader(new FileReader(path))){
            return br.readLine();
        }
	}
```
其实python中也有类似自动释放的处理机制：

```python
try:
    with open(filename) as f:
        print f.readlines()
except IOError:
    print 'oops'

```
### 6.3 自定义异常

#### 1.创建用户自定义异常时1. 继承自Exception类或某个子Exception类
2. 定义属性和方法,或重载父类的方法

#### 2.重抛异常及异常链接

对于异常,不仅要进行捕获处理,有时候还需要将此`异常进一步传递给调用者`,以便让调用者也能感受到这种异常。这时可以在catch语句块或finally语句块中采取以下三种处理方式:
1. 将当前捕获的异常再次抛出: throw e;2. 重新生成一个异常,加上一些新的信息并抛出: throw new Exception("some message"); 3. 重新生成并抛出一个新异常,该异常中包含了当前异常的信息，和一个异常的内部原因e: throw new Exception("some message",e)。

****其实内部异常e也是一个可抛出的对象，它也是有底层异常原因的，我们可用e.getCause()来得到内部异常.这样做就可以逐个找出异常的原因，形成了`异常链接(exception chaining)`。

举异常链接的例子：

```java
public class ExceptionCause {
	public static void main(String [] args)	{
		try 
		{
			BankATM.GetBalanceInfo( 12345L);
		}catch(Exception e)	{
			System.out.println("something wrong£º " + e);
			System.out.println("cause£º" + e.getCause());
		}
	}
}

class DataHouse {
	public static void FindData( long ID)
		throws DataHouseException
	{
		if( ID>0 && ID<1000)
			System.out.println( "id: " + ID );
		else
			throw new DataHouseException("cannot find the id");
	}
}
class BankATM{
	public static void GetBalanceInfo( long  ID)
		throws MyAppException
	{
		try 
		{
			DataHouse.FindData(ID);
		}catch (DataHouseException e) {
			throw new MyAppException("invalid id",e);
		}
	}
}
//分别自定义两个异常类
//
class DataHouseException extends Exception {
	public DataHouseException( String message ) {
		super(message);
	}
}
//
class MyAppException extends Exception {
	public MyAppException (String message){ 
		super (message); 
	}
	public MyAppException (String message, Exception cause) {
		super(message,cause);
	}   
}
```
在eclipse中编译，可以观察到异常链接：

	something wrong！MyAppException: invalid id
	cause！DataHouseException: cannot find the id

为了巩固一下python的知识，我尝试了一下在python2.7中编写异常链接：
```python
class MyAppError(Exception):
    def __init__(self, message, cause):
        self.message = message
        self.cause = cause

    def __str__(self):
        return repr(self.message)

class DataHouseError(Exception):
    def __init__(self, message):
        self.message = message

    def __str__(self):
        return repr(self.message)

class BankATM(object):
    def get_bankinfo(self, id):
        try:
            DataHouse().find_id(id)
        except DataHouseError as e:
            raise MyAppError('invaild id', e)

class DataHouse(object):
    def find_id(self, id):
        if 0 < id < 1000:
            print id
        else:
            raise DataHouseError('cannot find id')

if __name__ == '__main__':
    try:
        BankATM().get_bankinfo(1233l)
    except Exception, e:
        print e
        print e.cause
```
编译后可以同样可以观察到异常链接：
	
	'invaild id'
	'cannot find id'

### 6.4 断言及程序测试

### 6.5 程序调试