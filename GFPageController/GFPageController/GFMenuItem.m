//
//  GFMenuItem.m
//  GFPageController
//
//  Created by 谭高丰 on 2017/4/13.
//  Copyright © 2017年 谭高丰. All rights reserved.
//

#import "GFMenuItem.h"

@interface GFMenuItem ()
/** 标题label */
@property (weak, nonatomic) UILabel *titleLabel;
/** 副标题label */
@property (weak, nonatomic) UILabel *subTitleLabel;
@end

@implementation GFMenuItem

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureContentView];
    }
    return self;
}

- (void)configureContentView {
    UILabel *titleLabel         = [[UILabel alloc] init];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    _titleLabel                 = titleLabel;
    UILabel *subTitleLabel      = [[UILabel alloc] init];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    _subTitleLabel              = subTitleLabel;
    [self addSubview:_titleLabel];
    [self addSubview:_subTitleLabel];
}

#pragma mark - setter

- (void)setTitleText:(NSString *)titleText {
    _titleText           = [titleText copy];
    self.titleLabel.text = titleText;
}

- (void)setSubTitleText:(NSString *)subTitleText {
    _subTitleText           = [subTitleText copy];
    self.subTitleLabel.text = subTitleText;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor               = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setSubTitleColor:(UIColor *)subTitleColor {
    _subTitleColor               = subTitleColor;
    self.subTitleLabel.textColor = subTitleColor;
}

- (void)setTitleTextFont:(UIFont *)titleTextFont {
    _titleTextFont       = titleTextFont;
    self.titleLabel.font = titleTextFont;
}

- (void)setSubTitleTextFont:(UIFont *)subTitleTextFont {
    _subTitleTextFont       = subTitleTextFont;
    self.subTitleLabel.font = subTitleTextFont;
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds          = self.bounds;
    CGFloat titleLabelW    = bounds.size.width;
    CGFloat titleLabelH    = _titleLabelHeight;
    CGFloat titleLabelY    = bounds.size.height/2 - titleLabelH + 1;
    CGFloat subTitleLabelW = bounds.size.width;
    CGFloat subTitleLabelH = _subTitleLabelHeight;
    CGFloat subTitleLabelY = bounds.size.height/2 + 3;
    _titleLabel.frame      = CGRectMake(0, titleLabelY, titleLabelW, titleLabelH);
    _subTitleLabel.frame   = CGRectMake(0, subTitleLabelY, subTitleLabelW, subTitleLabelH);
}

@end


