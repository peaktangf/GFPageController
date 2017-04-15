//
//  GFPageViewController.m
//  GFSegmentedControl
//
//  Created by 谭高丰 on 2017/4/13.
//  Copyright © 2017年 谭高丰. All rights reserved.
//

#import "GFPageViewController.h"
#import "GFMenuView.h"
#import "GFPageConst.h"

@interface GFPageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) GFMenuView   *menuView;
@property (nonatomic, strong) UIScrollView *scrollView;
/** scrollView是否正在拖拽 */
@property (nonatomic, assign) BOOL         isDrag;
@end

@implementation GFPageViewController

#pragma mark - life cycler

- (void)viewDidLoad {
    [super viewDidLoad];
    // 防止视图控制器在未经允许的情况下调整控件的位置（不设置为NO，GFSegmentedControl 的 collectionview 在有导航栏的情况下会向下偏移64个像素）
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initialization];
    [self setupContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    // 移除所有子控制器
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:self];
        [vc removeFromParentViewController];
    }
}

#pragma mark - private

- (void)initialization {
    _menuHeight  = 50;
    _menuY       = 0;
}

- (void)setupContentView {
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.gfSegmentedControl];
}

- (void)scrollControllerAtIndex:(int)index {
    CGFloat offsetX = index * GF_SCREEN_WIDTH;
    CGPoint offset = CGPointMake(offsetX, 0);
    if (fabs(self.scrollView.contentOffset.x - offset.x) > GF_SCREEN_WIDTH) {
        [self.scrollView setContentOffset:offset animated:NO];
        // 获得索引
        int index = (int)self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
        [self addChildViewAtIndex:index];
    } else {
        [self.scrollView setContentOffset:offset animated:YES];
    }
}

- (void)addChildViewAtIndex:(int)index {
    // 设置选中的下标
    self.menuView.selectIndex = index;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:vc.view];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isDrag) {
        [self.menuView setMenuContentOffect:CGPointMake(scrollView.contentOffset.x * self.menuView.itemWidth / GF_SCREEN_WIDTH, scrollView.contentOffset.y)];
    }
}

// 滚动动画结束后调用（代码导致)
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView {
    self.isDrag = NO;
    // 添加控制器
    if (self.controllers) {
        // 获得索引
        int index = (int)self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
        [self addChildViewAtIndex:index];
    }
}

// 滚动结束（手势导致)
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

// 将要开始拖拽ScrollView时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isDrag = YES;
}

#pragma mark - getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat scrollViewY = _menuHeight + _menuY;
        if (self.navigationController && !self.navigationController.navigationBar.hidden) {
            scrollViewY = _menuHeight + _menuY + 64;
        }
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollViewY, GF_SCREEN_WIDTH, GF_SCREEN_HEIGHT - scrollViewY)];
        _scrollView.contentSize                    = CGSizeMake(_controllers.count * GF_SCREEN_WIDTH, 0);
        _scrollView.pagingEnabled                  = YES;
        _scrollView.bounces                        = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate                       = self;
    }
    return _scrollView;
}

- (GFMenuView *)gfSegmentedControl {
    if (!_menuView) {
        CGFloat segmentedControlY = _menuY;
        if (self.navigationController && !self.navigationController.navigationBar.hidden) {
            segmentedControlY = _menuY + 64;
        }
        _menuView = [GFMenuView gfMenuViewWithFrame:CGRectMake(0, segmentedControlY, GF_SCREEN_WIDTH, _menuHeight) titles:_titles subTitles:_subTitles];
        gfWeakSelf(weakSelf);
        _menuView.clickIndexBlock = ^(int clickIndex) {
            [weakSelf scrollControllerAtIndex:clickIndex];
        };
    }
    return _menuView;
}

#pragma mark - setter

// set dataSource
- (void)setControllers:(NSArray<UIViewController *> *)controllers {
    _controllers            = [controllers copy];
    self.scrollView.contentSize = CGSizeMake(_controllers.count * GF_SCREEN_WIDTH, 0);
    // 添加子控制器
    for (UIViewController *vc in controllers) {
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }
    if (self.selectIndex != 0) {
        // 添加指定下标控制器
        [self addChildViewAtIndex:self.selectIndex];
    } else {
        // 默认添加第一个控制器
        [self addChildViewAtIndex:0];
    }
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles                        = [titles copy];
    self.gfSegmentedControl.titles = titles;
}

- (void)setSubTitles:(NSArray<NSString *> *)subTitles {
    _subTitles                        = [subTitles copy];
    self.gfSegmentedControl.subTitles = subTitles;
}

// set menu
- (void)setMenuY:(CGFloat)menuY {
    _menuY = menuY;
    CGFloat viewY = _menuY;
    if (self.navigationController && !self.navigationController.navigationBar.hidden) {
        viewY = _menuY + 64;
    }
    self.gfSegmentedControl.frame = CGRectMake(0, viewY, GF_SCREEN_WIDTH, _menuHeight);
    self.scrollView.frame         = CGRectMake(0, _menuHeight + viewY, GF_SCREEN_WIDTH, GF_SCREEN_HEIGHT -  viewY - _menuHeight);
}

- (void)setItemWidth:(CGFloat)itemWidth {
    _itemWidth                        = itemWidth;
    self.gfSegmentedControl.itemWidth = itemWidth;
}

- (void)setMenuHeight:(CGFloat)menuHeight {
    _menuHeight                   = menuHeight;
    CGFloat viewY = _menuY;
    if (self.navigationController && !self.navigationController.navigationBar.hidden) {
        viewY = _menuY + 64;
    }
    self.gfSegmentedControl.frame = CGRectMake(0, viewY, GF_SCREEN_WIDTH, _menuHeight);
    self.scrollView.frame         = CGRectMake(0, _menuHeight + viewY, GF_SCREEN_WIDTH, GF_SCREEN_HEIGHT -  viewY - _menuHeight);
}

- (void)setMenuBackgroundColor:(UIColor *)menuBackgroundColor {
    _menuBackgroundColor                        = menuBackgroundColor;
    self.gfSegmentedControl.menuBackgroundColor = menuBackgroundColor;
}

- (void)setMaskFillColor:(UIColor *)maskFillColor {
    _maskFillColor                        = maskFillColor;
    self.gfSegmentedControl.maskFillColor = maskFillColor;
}

- (void)setTriangleHeight:(CGFloat)triangleHeight {
    _triangleHeight                        = triangleHeight;
    self.gfSegmentedControl.triangleHeight = triangleHeight;
}

- (void)setTriangleWidth:(CGFloat)triangleWidth {
    _triangleWidth                        = triangleWidth;
    self.gfSegmentedControl.triangleWidth = triangleWidth;
}

// set title
- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
    _normalTitleColor                        = normalTitleColor;
    self.gfSegmentedControl.normalTitleColor = normalTitleColor;
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor                        = selectedTitleColor;
    self.gfSegmentedControl.selectedTitleColor = selectedTitleColor;
}

- (void)setTitleTextFont:(UIFont *)titleTextFont {
    _titleTextFont                        = titleTextFont;
    self.gfSegmentedControl.titleTextFont = titleTextFont;
}

- (void)setTitleTextHeight:(CGFloat)titleTextHeight {
    _titleTextHeight                        = titleTextHeight;
    self.gfSegmentedControl.titleTextHeight = titleTextHeight;
}

// set subTitle
- (void)setNormalSubTitleColor:(UIColor *)normalSubTitleColor {
    _normalSubTitleColor                        = normalSubTitleColor;
    self.gfSegmentedControl.normalSubTitleColor = normalSubTitleColor;
}

- (void)setSelectedSubTitleColor:(UIColor *)selectedSubTitleColor {
    _selectedSubTitleColor                        = selectedSubTitleColor;
    self.gfSegmentedControl.selectedSubTitleColor = selectedSubTitleColor;
}

- (void)setSubTitleTextFont:(UIFont *)subTitleTextFont {
    _subTitleTextFont                        = subTitleTextFont;
    self.gfSegmentedControl.subTitleTextFont = subTitleTextFont;
}

- (void)setSubTitleTextHeight:(CGFloat)subTitleTextHeight {
    _subTitleTextHeight                        = subTitleTextHeight;
    self.gfSegmentedControl.subTitleTextHeight = subTitleTextHeight;
}

// set selectIndex
- (void)setSelectIndex:(int)selectIndex {
    _selectIndex                        = selectIndex;
    self.gfSegmentedControl.selectIndex = selectIndex;
    [self scrollControllerAtIndex:selectIndex];
}

@end





