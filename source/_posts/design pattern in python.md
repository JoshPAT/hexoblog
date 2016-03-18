title: "Design Pattern in Python"
date: 2016-03-17 01:13:20
toc: ture
tags:
    - Design Pattern
    - Python
---

![pope](/img/design_pattern.jpg)

## 创建型模式

### Simple Factory Pattern

#### 模式动机

考虑一个简单的软件应用场景，一个软件系统可以提供多个外观不同的按钮（如圆形按钮、矩形按钮、菱形按钮等）， 这些按钮都源自同一个基类，不过在继承基类后不同的子类修改了部分属性从而使得它们可以呈现不同的外观，如果我们希望在使用这些按钮时，不需要知道这些具体按钮类的名字，只需要知道表示该按钮类的一个参数，并提供一个调用方便的方法，把该参数传入方法即可返回一个相应的按钮对象，此时，就可以使用简单工厂模式。

#### 模式定义
简单工厂模式(Simple Factory Pattern)：又称为静态工厂方法(Static Factory Method)模式，它属于类创建型模式。在简单工厂模式中，可以根据参数的不同返回不同类的实例。简单工厂模式专门定义一个类来负责创建其他类的实例，被创建的实例通常都具有共同的父类。

#### 模式结构
简单工厂模式包含如下角色：

Factory：工厂角色
工厂角色负责实现创建所有实例的内部逻辑

Product：抽象产品角色
抽象产品角色是所创建的所有对象的父类，负责描述所有实例所共有的公共接口

ConcreteProduct：具体产品角色
具体产品角色是创建目标，所有创建的对象都充当这个角色的某个具体类的实例。

##### 实例

<!--more-->
```
import random

class Product(object):
    types = []

def factory(type):
    
    class ProductA(Product):
        def use(self): print("ProductA being used")
    
    class ProductB(Product):
        def use(self): print("ProductB being used")

    if type == "ProductA": return ProductA()
    if type == "ProductB": return ProductB()
    assert 0, "Bad shape creation: " + type

def productNameGen(n):
    for i in range(n):
        yield factory(random.choice(["ProductA", "ProductB"]))

for prod in productNameGen(7):
    prod.use()

```

### Factory Method Pattern

#### 模式动机

现在对该系统进行修改，不再设计一个按钮工厂类来统一负责所有产品的创建，而是将具体按钮的创建过程交给专门的工厂子类去完成，我们先定义一个抽象的按钮工厂类，再定义具体的工厂类来生成圆形按钮、矩形按钮、菱形按钮等，它们实现在抽象按钮工厂类中定义的方法。这种抽象化的结果使这种结构可以在不修改具体工厂类的情况下引进新的产品，如果出现新的按钮类型，只需要为这种新类型的按钮创建一个具体的工厂类就可以获得该新按钮的实例，这一特点无疑使得工厂方法模式具有超越简单工厂模式的优越性，更加符合“开闭原则”。

#### 模式定义
工厂方法模式(Factory Method Pattern)又称为工厂模式，也叫虚拟构造器(Virtual Constructor)模式或者多态工厂(Polymorphic Factory)模式，它属于类创建型模式。在工厂方法模式中，工厂父类负责定义创建产品对象的公共接口，而工厂子类则负责生成具体的产品对象，这样做的目的是将产品类的实例化操作延迟到工厂子类中完成，即通过工厂子类来确定究竟应该实例化哪一个具体产品类。

#### 模式结构
工厂方法模式包含如下角色：

Product：抽象产品
ConcreteProduct：具体产品
Factory：抽象工厂
ConcreteFactory：具体工厂

#### 实例1
```
from __future__ import generators
import random

class ShapeFactory:
    factories = {}
    
    @staticmethod
    def addFactory(id, shapeFactory):
        ShapeFactory.factories.put[id] = shapeFactory

    @staticmethod
    def createShape(id):
        if not ShapeFactory.factories.has_key(id):
            factoryname = id + 'Factory'
            # make a class instance
            ShapeFactory.factories[factoryname] = globals()[factoryname]()
        return ShapeFactory.factories[factoryname].create()

    # Below: Original Code from Python 3 Patterns
    # I don't like it.
    # @staticmethod
    # def createShape(id):
    #     if not ShapeFactory.factories.has_key(id):
    #         ShapeFactory.factories[id] = eval(id + '.Factory()')
    #     return ShapeFactory.factories[id].create()

class CircleFactory:
    def create(self):
        return Circle()

class SquareFactory:
    def create(self):
        return Square()

class Shape(object):
    pass

class Circle(Shape):
    def draw(self): print("Circle.draw")
    def erase(self): print("Circle.erase")
    # class Factory:
    #     def create(self):
    #         return Circle()

class Square(Shape):
    def draw(self): print("Square.draw")
    def erase(self): print("Square.erase")
    # class Factory:
    #     def create(self):
    #         return Square()

def shapeNameGen(n):
    # children of Shape class
    types = Shape.__subclasses__()
    # children's name
    for i in range(n):
        yield random.choice(types).__name__

shapes = [ ShapeFactory.createShape(i) for i in shapeNameGen(7)]

for shape in shapes:
    shape.draw()
    shape.erase()
```

#### 实例2

该实例来自于Book: [Learning Python Design Patterns][5]的个人改编版, 但是个人觉得创建逻辑依旧是静态.

```
import abc

class Factory(object):
    __metaclass__ = abc.ABCMeta

    def __init__(self):
        self.creation = self.create()
        self.consumption = self.consume()

    @abc.abstractmethod
    def create(self):
        pass
    @abc.abstractmethod
    def consume(self):
        pass

class CarFactory(Factory):
    def create(self):
        print('creating a car')
        return Car()
    def consume(self):
        print('consuming car parts')

class MotorcycleFactory(Factory):
    def create(self):
        print('creating a Motorcycle')
        return Motorcycle()
    def consume(self):
        print('consuming Motorcycle parts')

class Vichel(object):
    __metaclass__ = abc.ABCMeta
    
    @abc.abstractmethod
    def __str__(self):
        pass

class Car(Vichel):
    def __str__(self):
        return 'a fancy Car'

class Motorcycle(Vichel):
    def __str__(self):
        return 'a fancy Motorcycle'

if __name__ == '__main__':
    # this abc stuff is same as Interface in Java
    # I think it is still a simple factory pattern
    # Still Static, I don't like it
    CarFactory.create()
```

## Abstract Factory Pattern

###  模式动机

在工厂方法模式中具体工厂负责生产具体的产品，每一个具体工厂对应一种具体产品，工厂方法也具有唯一性，一般情况下，一个具体工厂中只有一个工厂方法或者一组重载的工厂方法。但是有时候我们需要一个工厂可以提供多个产品对象，而不是单一的产品对象。

为了更清晰地理解工厂方法模式，需要先引入两个概念：

- 产品等级结构 ：产品等级结构即产品的继承结构，如一个抽象类是电视机，其子类有海尔电视机、海信电视机、TCL电视机，则抽象电视机与具体品牌的电视机之间构成了一个产品等级结构，抽象电视机是父类，而具体品牌的电视机是其子类。
- 产品族 ：在抽象工厂模式中，产品族是指由同一个工厂生产的，位于不同产品等级结构中的一组产品，如海尔电器工厂生产的海尔电视机、海尔电冰箱，海尔电视机位于电视机产品等级结构中，海尔电冰箱位于电冰箱产品等级结构中。

当系统所提供的工厂所需生产的具体产品并不是一个简单的对象，而是多个位于不同产品等级结构中属于不同类型的具体产品时需要使用抽象工厂模式。

抽象工厂模式是所有形式的工厂模式中最为抽象和最具一般性的一种形态。

抽象工厂模式与工厂方法模式最大的区别在于，工厂方法模式针对的是一个产品等级结构，而抽象工厂模式则需要面对多个产品等级结构，一个工厂等级结构可以负责多个不同产品等级结构中的产品对象的创建 。当一个工厂等级结构可以创建出分属于不同产品等级结构的一个产品族中的所有对象时，抽象工厂模式比工厂方法模式更为简单、有效率。

### 模式定义
抽象工厂模式(Abstract Factory Pattern)：提供一个创建一系列相关或相互依赖对象的接口，而无须指定它们具体的类。抽象工厂模式又称为Kit模式，属于对象创建型模式。

### 模式结构
抽象工厂模式包含如下角色：

AbstractFactory：抽象工厂
ConcreteFactory：具体工厂
AbstractProduct：抽象产品
Product：具体产品

### 实例

```
import abc
import random

class Phone(object):
    def touch(self, button): pass

class SamsungEdge(Phone):
    def touch(self, button):
        print('{} is activated by Edge'.format(button))

class SmartisanNut(Phone):
    def touch(self, button):
        print('{} is activated by Nut'.format(button))

class VR(object):
    def wear(self): pass
    def wearable(self): return True

class GearVR(VR):
    def wear(self):
        print('GearVR is Sooooooo AweSome')

class HammerVR(VR):
    def wear(self):
        print('HammerVR is waiting for SickleVR') 

# Abstract Factory
class Factory(object):
    __metaclass__ = abc.ABCMeta

    @abc.abstractmethod
    def makePhones(self): pass 

    @abc.abstractmethod
    def makeVRGears(self): pass

# Concrete factories:
class SmartisanFactory(Factory):
    def makePhones(self): return SmartisanNut()
    def makeVRGears(self): return HammerVR()

class SamsungFactory(Factory):
    def makePhones(self): return SamsungEdge()
    def makeVRGears(self): return GearVR()


class Client:
    def __init__(self, factory):
        self.factory = factory
        self.phone = factory.makePhones()
        self.vr = factory.makeVRGears()

    def play(self):
        self.phone.touch('home button')
        self.vr.wear()
        print(self.vr.wearable())
if __name__ == '__main__':
    for _ in range(4):
        c = Client(random.choice(Factory.__subclasses__())())
        c.play()
```

### Builder

#### 模式动机

无论是在现实世界中还是在软件系统中，都存在一些复杂的对象，它们拥有多个组成部分，如汽车，它包括车轮、方向盘、发送机等各种部件。而对于大多数用户而言，无须知道这些部件的装配细节，也几乎不会使用单独某个部件，而是使用一辆完整的汽车，可以通过建造者模式对其进行设计与描述，建造者模式可以将部件和其组装过程分开，一步一步创建一个复杂的对象。用户只需要指定复杂对象的类型就可以得到该对象，而无须知道其内部的具体构造细节。

在软件开发中，也存在大量类似汽车一样的复杂对象，它们拥有一系列成员属性，这些成员属性中有些是引用类型的成员对象。而且在这些复杂对象中，还可能存在一些限制条件，如某些属性没有赋值则复杂对象不能作为一个完整的产品使用；有些属性的赋值必须按照某个顺序，一个属性没有赋值之前，另一个属性可能无法赋值等。

复杂对象相当于一辆有待建造的汽车，而对象的属性相当于汽车的部件，建造产品的过程就相当于组合部件的过程。由于组合部件的过程很复杂，因此，这些部件的组合过程往往被“外部化”到一个称作建造者的对象里，建造者返还给客户端的是一个已经建造完毕的完整产品对象，而用户无须关心该对象所包含的属性以及它们的组装方式，这就是建造者模式的模式动机。

#### 模式定义
造者模式(Builder Pattern)：将一个复杂对象的构建与它的表示分离，使得同样的构建过程可以创建不同的表示。

建造者模式是一步一步创建一个复杂的对象，它允许用户只通过指定复杂对象的类型和内容就可以构建它们，用户不需要知道内部的具体构建细节。建造者模式属于对象创建型模式。根据中文翻译的不同，建造者模式又可以称为生成器模式。

#### 模式结构
建造者模式包含如下角色：

Builder：抽象建造者
ConcreteBuilder：具体建造者
Director：指挥者
Product：产品角色



TO Be Continued...

参考资料:

[图说设计模式][1]
[Learning Python Design Patterns][2]
[Python 3 Patterns, Recipes and Idioms][3]
[Github Python Patterns][4]


[1]:http://design-patterns.readthedocs.org/zh_CN/latest/creational_patterns/creational.html
[2]:https://www.packtpub.com/application-development/learning-python-design-patterns
[3]:http://python-3-patterns-idioms-test.readthedocs.org/en/latest/index.html
[4]:https://github.com/faif/python-patterns
[5]:http://ebook-dl.com/item/learning-python-design-patterns-2013-gennadiy-zlobin/




