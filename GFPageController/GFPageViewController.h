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
@property (nonatomic, strong) NSArray<UIViewController *> *controllers;
/** 标题数组 */
@property (nonatomic, copy)   NSArray<NSString *> *titles;
/** 副标题数组 */
@property (nonatomic, copy)   NSArray<NSString *> *subTitles;
/** 设置选中的下标 */
@property (nonatomic, assign) int selectIndex;


/** Menu的 纵坐标，不设置默认按照紧贴屏幕上方，如果有导航栏且未隐藏就为64 */
@property (nonatomic, assign) CGFloat menuY;
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

@end




