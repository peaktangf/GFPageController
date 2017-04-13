//
//  GFMaskView.h
//  GFSegmentedControl
//
//  Created by 谭高丰 on 2017/4/12.
//  Copyright © 2017年 谭高丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFMaskView : UIView

/** 填充颜色 */
@property (nonatomic, strong) UIColor *fillColor;
/** 三角形的宽度 */
@property (nonatomic, assign) CGFloat triangleWidth;
/** 三角形的高度 */
@property (nonatomic, assign) CGFloat triangleHeight;

@end
