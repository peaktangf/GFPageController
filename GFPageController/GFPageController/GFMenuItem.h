//
//  GFMenuItem.h
//  GFPageController
//
//  Created by 谭高丰 on 2017/4/13.
//  Copyright © 2017年 谭高丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFMenuItem : UICollectionViewCell

/** 标题内容 */
@property (nonatomic, copy) NSString  *titleText;
/** 标题文字颜色 */
@property (strong, nonatomic) UIColor *titleColor;
/** 标题文字字体 */
@property (strong, nonatomic) UIFont  *titleTextFont;
/** 标题label的高度 */
@property (assign, nonatomic) CGFloat titleLabelHeight;

/** 副标题内容 */
@property (nonatomic, copy) NSString  *subTitleText;
/** 副标题文字颜色 */
@property (strong, nonatomic) UIColor *subTitleColor;
/** 副标题文字字体 */
@property (strong, nonatomic) UIFont  *subTitleTextFont;
/** 副标题label的高度 */
@property (assign, nonatomic) CGFloat subTitleLabelHeight;

@end
