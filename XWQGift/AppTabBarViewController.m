//
//  AppTabBarViewController.m
//  XWQGift
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "AppTabBarViewController.h"
#import "HeadViewController.h"
#import "GoodViewController.h"
#import "FenLeiViewController.h"
#import "TopicViewController.h"

@interface AppTabBarViewController ()

@end

@implementation AppTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addAnimation];
    
    [self createViewControllerForTabBar];

    

}

- (void)addAnimation {
    
    
    
}

- (void)createViewControllerForTabBar {
    
    NSMutableArray *controllers = [NSMutableArray new];
    
    NSArray *array = @[[HeadViewController class],[GoodViewController class],[FenLeiViewController class],[TopicViewController class]];
    NSArray *imageName = @[@"001_1",@"002_2",@"003_3",@"004_4"];
    NSArray *titles = @[@"首页",@"好物",@"分类",@"专题"];
    NSArray *selectName = @[@"001_1_x",@"002_2_x",@"003_3_x",@"004_4_x"];
    for (NSInteger i = 0; i<array.count; i++) {
        Class cls = array[i];
        UIViewController *controller = [[cls alloc]init];
        UINavigationController *nc =[[UINavigationController alloc]initWithRootViewController:controller];
        
        UIImage *normalImage = [UIImage imageNamed:imageName[i]];
        
        UIImage *selectImage = [[UIImage imageNamed:selectName[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:titles[i] image:normalImage selectedImage:selectImage];
        
        UIColor *color = [UIColor colorWithRed:247/255.0 green:78/255.0 blue:129/255.0 alpha:1.0];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
        
        nc.tabBarItem = item;
        [controllers addObject:nc];
    }
    self.viewControllers = controllers;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
