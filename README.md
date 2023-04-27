# TongCarPool

## 项目介绍

项目总共有26个文件，分为欢迎、注册登录、新建修改个人信息、修改密码、所有行程、我发布的、我申请的、个人信息、行程详情、新建修改行程、查看用户申请列表等界面。

界面主体部分使用了SwiftUI库进行绘制，使用了NavigationView、NavigationLink、List、三种Stack、Button、alert、sheet、Image、Divider、Spacer、Text、Form、TextField、SecureField等函数或组件。同时使用了SlideOverCard开源库增加了半屏sheet的功能。

查看地图详情界面使用了Mapkit库，主要是使用Map将选择的经纬度以地图的形式呈现。同时使用了第三方开源库MapItemPicker增加了搜索地址选择地点的功能。

网络部分使用了SwiftUI自带的网络库URLSession构造request与后端进行通信，使用了JSONEncoder、JSONDecoder等解码、编码器进行对象和JSON的互相转化，由于传输了时间信息，使用了DateFormatter、ISO8601DateFormatter等编码器对时间进行格式化。

生成测试数据时使用了开源库LoremSwiftum辅助生成测试数据。

## 遇到的问题及解决方案

在查看地图详情时，需要对地图进行初始化，但不能直接通过赋值的形式进行初始化，使用了State传入initialValue的方式进行初始化，改变了地图显示的位置。

使用ISO8601DateFormatter时，由于不支持ISO8601DateFormatter到DateFormatter的转换，所以使用了.custom属性进行格式化转换。

网络部分，由于需要先加载完网络得到信息再加载界面，所以使用async-await组合将网络申请变为同步阻塞，在Buttton等组件中使用Task调用，同时加入@MainActor修饰器，保证该函数只通过主进程队列调用。

## 使用的开源库

[joogps/SlideOverCard: A SwiftUI card view, made great for setup interactions. (github.com)](https://github.com/joogps/SlideOverCard)

[lorenzofiamingo/swiftui-map-item-picker (github.com)](https://github.com/lorenzofiamingo/swiftui-map-item-picker)

[lukaskubanek/LoremSwiftum: A lightweight lorem ipsum generator for Swift (github.com)](https://github.com/lukaskubanek/LoremSwiftum)
