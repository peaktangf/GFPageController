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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initialization];
    [self setupContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _scrollView.delegate = nil;
    // 移除所有子控制器
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:self];
        [vc removeFromParentViewController];
    }
}

#pragma mark - private

- (void)initialization {
    self.gf_menuHeight  = 50;
    self.gf_menuY       = 0;
}

- (void)setupContentView {
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.gfSegmentedControl];
}

- (void)scrollControllerAtIndex:(int)index {
    CGFloat offsetX = index * GF_SCREEN_WIDTH;
    CGPoint offset = CGPointMake(offsetX, 0);
    if (fabs(self.scrollView.contentOffset.x - offset.x) > GF_SCREEN_WIDTH || self.scrollView.contentOffset.x == offset.x) {
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
    // 回调当前选中的下标
    gfWeakSelf(weakSelf);
    if (weakSelf.gf_curPageIndexBlock) {
        weakSelf.gf_curPageIndexBlock(index);
    }
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
    if (self.gf_controllers) {
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
        CGFloat scrollViewY = _gf_menuHeight + _gf_menuY;
        if (self.navigationController && !self.navigationController.navigationBar.hidden) {
            scrollViewY = _gf_menuHeight + _gf_menuY + 64;
        }
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollViewY, GF_SCREEN_WIDTH, GF_SCREEN_HEIGHT - scrollViewY)];
        _scrollView.contentSize                    = CGSizeMake(_gf_controllers.count * GF_SCREEN_WIDTH, 0);
        _scrollView.pagingEnabled                  = YES;
        _scrollView.bounces                        = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate                       = self;
    }
    return _scrollView;
}

- (GFMenuView *)gfSegmentedControl {
    if (!_menuView) {
        CGFloat segmentedControlY = _gf_menuY;
        if (self.navigationController && !self.navigationController.navigationBar.hidden) {
            segmentedControlY = _gf_menuY + 64;
        }
        _menuView = [GFMenuView gfMenuViewWithFrame:CGRectMake(0, segmentedControlY, GF_SCREEN_WIDTH, _gf_menuHeight) titles:_gf_titles subTitles:_gf_subTitles];
        gfWeakSelf(weakSelf);
        _menuView.clickIndexBlock = ^(int clickIndex) {
            [weakSelf scrollControllerAtIndex:clickIndex];
        };
    }
    return _menuView;
}

#pragma mark - setter

// set dataSource
- (void)setGf_controllers:(NSArray<UIViewController *> *)controllers {
    _gf_controllers            = [controllers copy];
    // 移除所有子控制器
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:self];
        [vc removeFromParentViewController];
    }
    self.scrollView.contentSize = CGSizeMake(_gf_controllers.count * GF_SCREEN_WIDTH, 0);
    // 添加子控制器
    for (UIViewController *vc in controllers) {
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }
    if (self.gf_selectIndex != 0) {
        // 添加指定下标控制器
        [self addChildViewAtIndex:self.gf_selectIndex];
    } else {
        // 默认添加第一个控制器
        [self addChildViewAtIndex:0];
    }
}

- (void)setGf_titles:(NSArray<NSString *> *)titles {
    _gf_titles                     = [titles copy];
    self.gfSegmentedControl.titles = titles;
}

- (void)setGf_subTitles:(NSArray<NSString *> *)subTitles {
    _gf_subTitles                     = [subTitles copy];
    self.gfSegmentedControl.subTitles = subTitles;
}

// set menu
- (void)setGf_menuY:(CGFloat)gf_menuY {
    _gf_menuY = gf_menuY;
    CGFloat viewY = _gf_menuY;
    if (self.navigationController && !self.navigationController.navigationBar.hidden) {
        viewY = _gf_menuY + 64;
    }
    self.gfSegmentedControl.frame = CGRectMake(0, viewY, GF_SCREEN_WIDTH, _gf_menuHeight);
    self.scrollView.frame         = CGRectMake(0, _gf_menuHeight + viewY, GF_SCREEN_WIDTH, GF_SCREEN_HEIGHT -  viewY - _gf_menuHeight);
}

- (void)setGf_itemWidth:(CGFloat)gf_itemWidth {
    _gf_itemWidth                     = gf_itemWidth;
    self.gfSegmentedControl.itemWidth = gf_itemWidth;
}

- (void)setGf_menuHeight:(CGFloat)menuHeight {
    _gf_menuHeight = menuHeight;
    CGFloat viewY  = _gf_menuHeight;
    if (self.navigationController && !self.navigationController.navigationBar.hidden) {
        viewY = _gf_menuHeight + 64;
    }
    self.gfSegmentedControl.frame = CGRectMake(0, viewY, GF_SCREEN_WIDTH, _gf_menuHeight);
    self.scrollView.frame         = CGRectMake(0, _gf_menuHeight + viewY, GF_SCREEN_WIDTH, GF_SCREEN_HEIGHT -  viewY - _gf_menuHeight);
}

- (void)setGf_menuBackgroundColor:(UIColor *)menuBackgroundColor {
    _gf_menuBackgroundColor                     = menuBackgroundColor;
    self.gfSegmentedControl.menuBackgroundColor = menuBackgroundColor;
}

- (void)setGf_maskFillColor:(UIColor *)maskFillColor {
    _gf_maskFillColor                     = maskFillColor;
    self.gfSegmentedControl.maskFillColor = maskFillColor;
}

- (void)setGf_triangleHeight:(CGFloat)triangleHeight {
    _gf_triangleHeight                     = triangleHeight;
    self.gfSegmentedControl.triangleHeight = triangleHeight;
}

- (void)setGf_triangleWidth:(CGFloat)triangleWidth {
    _gf_triangleWidth                     = triangleWidth;
    self.gfSegmentedControl.triangleWidth = triangleWidth;
}

// set title
- (void)setGf_normalTitleColor:(UIColor *)normalTitleColor {
    _gf_normalTitleColor                     = normalTitleColor;
    self.gfSegmentedControl.normalTitleColor = normalTitleColor;
}

- (void)setGf_selectedTitleColor:(UIColor *)selectedTitleColor {
    _gf_selectedTitleColor                     = selectedTitleColor;
    self.gfSegmentedControl.selectedTitleColor = selectedTitleColor;
}

- (void)setGf_titleTextFont:(UIFont *)titleTextFont {
    _gf_titleTextFont                     = titleTextFont;
    self.gfSegmentedControl.titleTextFont = titleTextFont;
}

- (void)setGf_titleTextHeight:(CGFloat)titleTextHeight {
    _gf_titleTextHeight                     = titleTextHeight;
    self.gfSegmentedControl.titleTextHeight = titleTextHeight;
}

// set subTitle
- (void)setGf_normalSubTitleColor:(UIColor *)normalSubTitleColor {
    _gf_normalSubTitleColor                     = normalSubTitleColor;
    self.gfSegmentedControl.normalSubTitleColor = normalSubTitleColor;
}

- (void)setGf_selectedSubTitleColor:(UIColor *)selectedSubTitleColor {
    _gf_selectedSubTitleColor                     = selectedSubTitleColor;
    self.gfSegmentedControl.selectedSubTitleColor = selectedSubTitleColor;
}

- (void)setGf_subTitleTextFont:(UIFont *)subTitleTextFont {
    _gf_subTitleTextFont                     = subTitleTextFont;
    self.gfSegmentedControl.subTitleTextFont = subTitleTextFont;
}

- (void)setGf_subTitleTextHeight:(CGFloat)subTitleTextHeight {
    _gf_subTitleTextHeight                     = subTitleTextHeight;
    self.gfSegmentedControl.subTitleTextHeight = subTitleTextHeight;
}

// set selectIndex
- (void)setGf_selectIndex:(int)selectIndex {
    _gf_selectIndex                     = selectIndex;
    self.gfSegmentedControl.selectIndex = selectIndex;
    [self scrollControllerAtIndex:selectIndex];
}

// set curPageIndexBlock
- (void)setGf_curPageIndexBlock:(void (^)(int))gf_curPageIndexBlock {
    _gf_curPageIndexBlock = [gf_curPageIndexBlock copy];
    if (self.gf_selectIndex == 0) {
        [self scrollControllerAtIndex:0];
    }
}

@end





