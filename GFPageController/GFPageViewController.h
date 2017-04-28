//
//  GFPageViewController.h
//  GFSegmentedControl
//
//  Created by 谭高丰 on 2017/4/13.
//  Copyright © 2017年 谭高丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFPageViewController : UIViewController

/** 控制器数组 */
@property (nonatomic, strong) NSArray<UIViewController *> *gf_controllers;
/** 标题数组 */
@property (nonatomic, copy)   NSArray<NSString *> *gf_titles;
/** 副标题数组 */
@property (nonatomic, copy)   NSArray<NSString *> *gf_subTitles;
/** 设置选中的下标 */
@property (nonatomic, assign) int gf_selectIndex;

/** Menu的 纵坐标，不设置默认按照紧贴屏幕上方，如果有导航栏且未隐藏就为64 */
@property (nonatomic, assign) CGFloat gf_menuY;
/** MenuItem 的宽度 */
@property (nonatomic, assign) CGFloat gf_itemWidth;
/** Menu 的高度 */
@property (nonatomic, assign) CGFloat gf_menuHeight;
/** Menu 背景颜色 */
@property (nonatomic, strong) UIColor *gf_menuBackgroundColor;
/** Menu mask的填充颜色 */
@property (nonatomic, strong) UIColor *gf_maskFillColor;
/** Menu mask三角形的宽度 */
@property (nonatomic, assign) CGFloat gf_triangleWidth;
/** Menu mask三角形的高度 */
@property (nonatomic, assign) CGFloat gf_triangleHeight;

/** 标题未选中时的颜色 */
@property (nonatomic, strong) UIColor *gf_normalTitleColor;
/** 标题选中时的颜色 */
@property (nonatomic, strong) UIColor *gf_selectedTitleColor;
/** 标题文字字体 */
@property (nonatomic, strong) UIFont  *gf_titleTextFont;
/** 标题文字高度 */
@property (nonatomic, assign) CGFloat gf_titleTextHeight;

/** 副标题未选中时的颜色 */
@property (nonatomic, strong) UIColor *gf_normalSubTitleColor;
/** 副标题选中时的颜色 */
@property (nonatomic, strong) UIColor *gf_selectedSubTitleColor;
/** 副标题文字字体 */
@property (nonatomic, strong) UIFont  *gf_subTitleTextFont;
/** 副标题文字高度 */
@property (nonatomic, assign) CGFloat gf_subTitleTextHeight;


/**
 滚动结束后返回当前下标
 */
@property (nonatomic, copy) void(^gf_curPageIndexBlock)(int curPageIndex);


/**
 配置完视图之后一定要调用该方法
 */
- (void)reloadView;

@end




