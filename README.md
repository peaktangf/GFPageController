# GFPageController [（组件详解）](http://www.jianshu.com/p/6f10ae622d44)

## 效果
![](https://github.com/gaofengtan/GFPageController/blob/master/%E6%BC%94%E7%A4%BA.gif)

## 介绍
- 实现了菜单切换的视觉差，效果棒棒哒；
- 使用简单，创建一个控制器直接继承GFPageViewController，设置需要添加的子控制器、标题、副标题就搞定；
- 菜单大部分的样式都可进行自定义；
- 菜单遮罩的颜色、大小和箭头的大小也可以设置参数来控制；
- 菜单实现了防止用户连续点击功能；
- 可以设置滚动完成之后的回调;
- 增加reload方法来刷新菜单数据;
- 支持pod导入

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
创建一个控制器继承自```GFPageViewController```，创建完之后给控制器设置需要添加的子控制器（```Array```）、标题（```Array```）、副标题（```Array```）：
```
#import <UIKit/UIKit.h>
#import "GFPageViewController.h"
@interface PageViewController : GFPageViewController
@end
```
```
@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureContentView];
}

- (void)configureContentView {
    NSArray *titles             = @[@"8:00",@"10:00",@"12:00",@"14:00",@"16:00",@"18:00",@"20:00"];
    NSArray *subTitles          = @[@"已结束",@"已结束",@"已结束",@"疯抢中",@"即将开始",@"即将开始",@"即将开始"];
    NSMutableArray *controllers = [NSMutableArray new];
    for (int i = 0; i < 7; i ++) {
        UIViewController *vc    = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f];
        [controllers addObject:vc];
    }
    // 设置控制器数组
    self.controllers = controllers;
    // 设置标题数组
    self.titles      = titles;
    // 设置副标题数组
    self.subTitles   = subTitles;
    // 设置初始下标
    self.selectIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
```
OK，搞定，运行就可以看到效果，是不是很简单。

### 自定义菜单样式
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
大家可以自行尝试！

## 许可
该项目使用 MIT 许可证，详情见 LICENSE 文件。








