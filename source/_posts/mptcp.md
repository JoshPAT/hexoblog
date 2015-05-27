title: "到底有多难？论设计并实现一种可部署的多路径TCP<译>"
date: 2015-05-27 01:19:28
tags: 
	- Multipath TCP
toc: true
---

##摘要
##引言
##目标
##设计
###建立连接
###加入子网络流(Subflow)
###可靠多路径传输
小彼此
####流量控制
####确认
####编码
####数据序列的映射
####发送缓存管理
####内容修改的中间盒(Middleboxes)
###结束连接和子网络流
##实现问题
###支持中间盒
###减少内存使用
####进一步评估
###解决重序
##MPTCP的效能
###基于Wifi和3G的多路径TCP
###建立连接的延迟
###HTTP的效能
##相关著作(略)

##经验教训

##结论

作者: [`@Costin Raiciu`, `@Christoph Paasch`, `@Sebastien Barre`, `@Alan Ford`, `@Michio Honda`, `@Fabien Duchene`, `@Olivier Bonaventure`, `@Mark Handley`][1]

---

[1]:https://www.cs.princeton.edu/courses/archive/fall14/cos561/papers/MPTCP12.pdf
