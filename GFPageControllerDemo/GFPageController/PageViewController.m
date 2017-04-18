//
//  PageViewController.m
//  GFPageController
//
//  Created by 谭高丰 on 2017/4/13.
//  Copyright © 2017年 谭高丰. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    [self configureContentView];
}

- (void)refresh {
    NSLog(@"刷新");
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
    self.gf_controllers = controllers;
    // 设置标题数组
    self.gf_titles      = titles;
    // 设置副标题数组
    self.gf_subTitles   = subTitles;
    // 设置当前下标
    self.gf_selectIndex = 2;
    // 滚动结束后返回当前下标
    self.gf_curPageIndexBlock = ^(int curPageIndex) {
        NSLog(@"%d",curPageIndex);
    };
    // 刷新数据
    [self gf_reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
