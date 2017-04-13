//
//  GFMenuView.h
//  GFPageController
//
//  Created by 谭高丰 on 2017/4/13.
//  Copyright © 2017年 谭高丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFMenuView : UIView

/** item的宽度 */
@property (nonatomic, assign) CGFloat itemWidth;
/** 背景颜色 */
@property (nonatomic, strong) UIColor *menuBackgroundColor;
/** mask的填充颜色 */
@property (nonatomic, strong) UIColor *maskFillColor;
/** mask三角形的宽度 */
@property (nonatomic, assign) CGFloat triangleWidth;
/** mask三角形的高度 */
@property (nonatomic, assign) CGFloat triangleHeight;

/** 标题数组 */
@property (nonatomic, copy)   NSArray<NSString *> *titles;
/** 标题未选中时的颜色 */
@property (nonatomic, strong) UIColor *normalTitleColor;
/** 标题选中时的颜色 */
@property (nonatomic, strong) UIColor *selectedTitleColor;
/** 标题文字字体 */
@property (nonatomic, strong) UIFont  *titleTextFont;
/** 标题文字高度 */
@property (nonatomic, assign) CGFloat titleTextHeight;

/** 副标题数组 */
@property (nonatomic, copy)   NSArray<NSString *> *subTitles;
/** 副标题未选中时的颜色 */
@property (nonatomic, strong) UIColor *normalSubTitleColor;
/** 副标题选中时的颜色 */
@property (nonatomic, strong) UIColor *selectedSubTitleColor;
/** 副标题文字字体 */
@property (nonatomic, strong) UIFont  *subTitleTextFont;
/** 副标题文字高度 */
@property (nonatomic, assign) CGFloat subTitleTextHeight;

/** 设置选中的下标 */
@property (nonatomic, assign) int selectIndex;

/** block方式监听点击 */
@property (nonatomic, copy) void (^clickIndexBlock)(int clickIndex);


/**
 初始分段选择控件
 
 @param frame frame
 @param titles 标题数组
 @param subTitles 副标题数组
 @return 结果
 */
+ (instancetype)gfMenuViewWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles subTitles:(NSArray<NSString *> *)subTitles; 

@end
