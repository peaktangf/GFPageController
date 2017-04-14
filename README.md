# GFPageController

## 效果
![](https://github.com/gaofengtan/GFPageController/blob/master/%E6%BC%94%E7%A4%BA.gif)

## 介绍
* 实现类似淘宝淘抢购等电商类App的分页控件的封装；
* 实现了视觉差，效果棒棒哒；
* 使用简单，直接继承```GFPageController```控制器，设置几个参数就搞定；
* 滚动菜单可完全自定义；
* 遮罩的颜色和箭头的大小也可以设置参数来控制；
* 支持pod导入.

## 导入组件
支持直接拖入和Pod管理两种方式导入库文件。

### 1、直接拖入组件相关的文件夹
把GFPageControler文件夹拖到工程中，选择copy<br>
![](https://github.com/gaofengtan/GFPageController/blob/master/%E6%96%87%E4%BB%B6.png)

### 2、Pod导入
```
pod 'GFPageController'
```

## 使用

### 基本使用
创建一个控制器继承自GFPageViewController，创建完之后如下给控制器设置参数：
```
// 设置控制器数组
self.controllers = controllers;
// 设置标题数组
self.titles      = titles;
// 设置副标题数组
self.subTitles   = subTitles;
// 设置初始下标
self.selectIndex = 1;
```
OK，搞定，运行就可以看到效果，是不是很简单。

### 其他功能
可以看到上面没有一行设置菜单样式的代码，那是因为不设置菜单使用的是默认的样式，除此之外，菜单的样式还是可以自定义的，
GFPageController为大家提供了下面14个参数来控制菜单的样式显示：
```
/** MenuItem 的宽度 */
@property (nonatomic, assign) CGFloat itemWidth;
/** Menu 的高度 */
@property (nonatomic, assign) CGFloat menuHeight;
/** Menu 背景颜色 */
@property (nonatomic, strong) UIColor *menuBackgroundColor;
/** Menu mask的填充颜色 */
@property (nonatomic, strong) UIColor *maskFillColor;
/** Menu mask三角形的宽度 */
@property (nonatomic, assign) CGFloat triangleWidth;
/** Menu mask三角形的高度 */
@property (nonatomic, assign) CGFloat triangleHeight;

/** 标题未选中时的颜色 */
@property (nonatomic, strong) UIColor *normalTitleColor;
/** 标题选中时的颜色 */
@property (nonatomic, strong) UIColor *selectedTitleColor;
/** 标题文字字体 */
@property (nonatomic, strong) UIFont  *titleTextFont;
/** 标题文字高度 */
@property (nonatomic, assign) CGFloat titleTextHeight;

/** 副标题未选中时的颜色 */
@property (nonatomic, strong) UIColor *normalSubTitleColor;
/** 副标题选中时的颜色 */
@property (nonatomic, strong) UIColor *selectedSubTitleColor;
/** 副标题文字字体 */
@property (nonatomic, strong) UIFont  *subTitleTextFont;
/** 副标题文字高度 */
@property (nonatomic, assign) CGFloat subTitleTextHeight;
```

## 许可
该项目使用 MIT 许可证，详情见 LICENSE 文件。








