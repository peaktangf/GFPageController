//
//  GFMenuView.m
//  GFPageController
//
//  Created by 谭高丰 on 2017/4/13.
//  Copyright © 2017年 谭高丰. All rights reserved.
//

#import "GFMenuView.h"
#import "GFMenuItem.h"
#import "GFMaskView.h"

static NSString *GFMENUITEM_NIBNAME         = @"GFSegmentedItem";
static const NSInteger BOTTOM_COLLECTIONVIEW_TAG = 11;
static const NSInteger TOP_COLLECTIONVIEW_TAG    = 22;

@interface GFMenuView ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** item的高度 */
@property (nonatomic, assign) CGFloat                    itemHeight;
/** collectionView内边距 */
@property (nonatomic, assign) CGFloat                    collectionViewEdge;
/** 遮罩下面的collectionView */
@property (nonatomic, strong) UICollectionView           *collectionViewBottom;
/** 遮罩上面的collectionView */
@property (nonatomic, strong) UICollectionView           *collectionViewTop;
/** collectionView的布局 */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/** 遮罩视图 */
@property (nonatomic, strong) GFMaskView                 *maskView;

@end

@implementation GFMenuView

#pragma mark - public

+ (instancetype)gfMenuViewWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles subTitles:(NSArray<NSString *> *)subTitles {
    GFMenuView *menuView = [[GFMenuView alloc] initWithFrame:frame];
    menuView.titles      = [titles copy];
    menuView.subTitles   = [subTitles copy];
    return menuView;
}

- (void)setMenuContentOffect:(CGPoint)offect {
    [_collectionViewTop setContentOffset:offect];
}

#pragma mark - init

- (void)initialization {
    _itemWidth              = 80;
    _itemHeight             = self.bounds.size.height;
    _menuBackgroundColor    = [UIColor blackColor];
    _maskFillColor          = [UIColor redColor];
    _triangleWidth          = 20;
    _triangleHeight         = 8;
    _normalTitleColor       = [UIColor lightGrayColor];
    _selectedTitleColor     = [UIColor whiteColor];
    _titleTextFont          = [UIFont systemFontOfSize:16];   
    _titleTextHeight        = 16;
    _normalSubTitleColor    = [UIColor lightGrayColor];
    _selectedSubTitleColor  = [UIColor whiteColor];
    _subTitleTextFont       = [UIFont systemFontOfSize:12];
    _subTitleTextHeight     = 12;
    _collectionViewEdge     = self.bounds.size.width/2 - _itemWidth/2;
}

- (void)setupContentView {
    self.backgroundColor = self.menuBackgroundColor;
    [self addSubview:self.collectionViewBottom];
    [self addSubview:self.maskView];
    [self.maskView addSubview:self.collectionViewTop];
}

// 代码初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupContentView];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
        [self setupContentView];
    }
    return self;
}

// xib初始化
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
        [self setupContentView];
    }
    return self;
}

#pragma mark - life circles

- (void)layoutSubviews {
    [super layoutSubviews];
    self.itemHeight                       = self.bounds.size.height;
    self.collectionViewEdge               = self.bounds.size.width/2 - self.itemWidth/2;
    self.flowLayout.itemSize              = CGSizeMake(self.itemWidth, self.itemHeight);
    self.flowLayout.sectionInset          = UIEdgeInsetsMake(0, self.collectionViewEdge, 0, self.collectionViewEdge);
    self.collectionViewBottom.frame       = self.bounds;
    self.maskView.frame                   = CGRectMake(self.collectionViewEdge, 0, self.itemWidth, self.itemHeight + self.triangleHeight);
    self.collectionViewTop.frame          = CGRectMake(-self.collectionViewEdge, 0, self.bounds.size.width, self.itemHeight);
    self.collectionViewTop.contentSize    = CGSizeMake(self.itemWidth * self.titles.count + self.collectionViewEdge * 2, 0);
    self.collectionViewBottom.contentSize = CGSizeMake(self.itemWidth * self.titles.count + self.collectionViewEdge * 2, 0);
    if (self.selectIndex != 0) {
        [self selectItemAtIndex:self.selectIndex];
    }
}

#pragma mark - setter && getter

- (void)setMenuBackgroundColor:(UIColor *)menuBackgroundColor {
    _menuBackgroundColor = menuBackgroundColor;
    self.backgroundColor = menuBackgroundColor;
}

- (void)setMaskFillColor:(UIColor *)maskFillColor {
    _maskFillColor          = maskFillColor;
    self.maskView.fillColor = maskFillColor;
}

- (void)setTriangleHeight:(CGFloat)triangleHeight {
    _triangleHeight              = triangleHeight;
    self.maskView.triangleHeight = triangleHeight;
}

- (void)setTriangleWidth:(CGFloat)triangleWidth {
    _triangleWidth              = triangleWidth;
    self.maskView.triangleWidth = triangleWidth;
}

- (void)setSelectIndex:(int)selectIndex {
    _selectIndex = selectIndex;
    [self selectItemAtIndex:selectIndex];
}

- (UICollectionView *)collectionViewTop {
    if (!_collectionViewTop) {
        _collectionViewTop                                = [[UICollectionView alloc] initWithFrame:CGRectMake(-self.collectionViewEdge, 0, self.bounds.size.width, self.itemHeight) collectionViewLayout:self.flowLayout];
        [_collectionViewTop registerClass:[GFMenuItem class] forCellWithReuseIdentifier:GFMENUITEM_NIBNAME];
        _collectionViewTop.tag                            = TOP_COLLECTIONVIEW_TAG;
        _collectionViewTop.backgroundColor                = [UIColor clearColor];
        _collectionViewTop.showsHorizontalScrollIndicator = NO;
        _collectionViewTop.decelerationRate               = 0;//设置手指放开后的减速率(值域 0~1 值越小减速停止的时间越短),默认为1
        _collectionViewTop.delegate                       = self;
        _collectionViewTop.dataSource                     = self;
    }
    return _collectionViewTop;
}

- (UICollectionView *)collectionViewBottom {
    if (!_collectionViewBottom) {
        _collectionViewBottom                                = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        [_collectionViewBottom registerClass:[GFMenuItem class] forCellWithReuseIdentifier:GFMENUITEM_NIBNAME];
        _collectionViewBottom.tag                            = BOTTOM_COLLECTIONVIEW_TAG;
        _collectionViewBottom.backgroundColor                = [UIColor clearColor];
        _collectionViewBottom.showsHorizontalScrollIndicator = NO;
        _collectionViewBottom.decelerationRate               = 0;//设置手指放开后的减速率(值域 0~1 值越小减速停止的时间越短),默认为1
        _collectionViewBottom.delegate                       = self;
        _collectionViewBottom.dataSource                     = self;
    }
    return _collectionViewBottom;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout                    = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize           = CGSizeMake(self.itemWidth, self.itemHeight);
        _flowLayout.sectionInset       = UIEdgeInsetsMake(0, self.collectionViewEdge, 0, self.collectionViewEdge);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.scrollDirection    = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView                 = [[GFMaskView alloc] init];
        _maskView.backgroundColor = [UIColor clearColor];
        _maskView.fillColor       = self.maskFillColor;
        _maskView.triangleHeight  = self.triangleHeight;
        _maskView.triangleWidth   = self.triangleWidth;
        _maskView.clipsToBounds   = YES;
    }
    return _maskView;
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GFMenuItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GFMENUITEM_NIBNAME forIndexPath:indexPath];
    NSString *title    = self.titles[indexPath.row];
    NSString *subTitle = self.subTitles[indexPath.row];
    if (collectionView.tag == BOTTOM_COLLECTIONVIEW_TAG) {
        cell.titleColor    = self.normalTitleColor;
        cell.subTitleColor = self.normalSubTitleColor;
    } else {
        cell.titleColor    = self.selectedTitleColor;
        cell.subTitleColor = self.selectedSubTitleColor;
    }
    cell.titleText           = title;
    cell.subTitleText        = subTitle;
    cell.titleTextFont       = self.titleTextFont;
    cell.subTitleTextFont    = self.subTitleTextFont;
    cell.titleLabelHeight    = self.titleTextHeight;
    cell.subTitleLabelHeight = self.subTitleTextHeight;
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GFMenuItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GFMENUITEM_NIBNAME forIndexPath:indexPath];
    if (collectionView.tag == BOTTOM_COLLECTIONVIEW_TAG && cell) {
        // 禁用手势 (防止连续点击) 
        self.collectionViewBottom.userInteractionEnabled = NO;
        [self refreshContentOffsetItemFrame:cell.frame];
    }
}

#pragma makr - UIScrollViewDelegate

// 当有滚动的时候就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    //同步两个collectionView的滚动
    if (collectionView.tag == BOTTOM_COLLECTIONVIEW_TAG) {
        [_collectionViewTop setContentOffset:collectionView.contentOffset];
    } else {
        [_collectionViewBottom setContentOffset:collectionView.contentOffset];
    }
}

// 当手动拖拽结束后调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // decelerate 为 YES，还会调用下面的一个方法，为 NO 就会不调用下面的方法
    if (decelerate == NO) {
        GFMenuItem *cell = [self getItemWithLocation:_collectionViewBottom.center];
        if (cell) {
            [self refreshContentOffsetItemFrame:cell.frame];
        }
    }
}

// 当手动拖动结束且减速后调用（如果拖动后就停止了，就不会调用该方法）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    GFMenuItem *cell = [self getItemWithLocation:_collectionViewBottom.center];
    if (cell) {
        [self refreshContentOffsetItemFrame:cell.frame];
    }
}

// setContentOffset改变 且 滚动动画结束后会 调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 滚动动画结束后启用手势 (防止连续点击)
    self.collectionViewBottom.userInteractionEnabled = YES;
}

#pragma mark - parvite

// 设置选中指定下标的item
- (void)selectItemAtIndex:(int)selectIndex {
    CGRect curItemFrame = CGRectMake(selectIndex * self.itemWidth + self.collectionViewEdge, 0, self.itemWidth, self.itemHeight);
    [self refreshContentOffsetItemFrame:curItemFrame];
}

// 获取屏幕中指定点所在的cell
- (GFMenuItem *)getItemWithLocation:(CGPoint)location {
    //坐标点的转换(将当前点击的位置坐标从self上转换到collectionView上)
    CGPoint tableLocation     = [self convertPoint:location toView:_collectionViewBottom];
    //获取到当前所点击的下标
    NSIndexPath *selectedPath = [_collectionViewBottom indexPathForItemAtPoint:tableLocation];
    GFMenuItem *cell          = [_collectionViewBottom dequeueReusableCellWithReuseIdentifier:GFMENUITEM_NIBNAME forIndexPath:selectedPath];
    return cell;
}

// 让选中的item位于中间
- (void)refreshContentOffsetItemFrame:(CGRect)frame {
    CGFloat itemX      = frame.origin.x;
    CGFloat width      = _collectionViewBottom.bounds.size.width;
    CGSize contentSize = _collectionViewBottom.contentSize;
    
    CGFloat targetX;
    if ((contentSize.width-itemX) <= width/2) {
        targetX = contentSize.width - width;
    } else {
        targetX = frame.origin.x - width/2 + frame.size.width/2;
    }
    if (targetX + width > contentSize.width) {
        targetX = contentSize.width - width;
    }
    [_collectionViewBottom setContentOffset:CGPointMake(targetX, 0) animated:YES];
    if (_clickIndexBlock) {
        _clickIndexBlock((itemX-self.collectionViewEdge)/self.itemWidth);
    }
}

@end
