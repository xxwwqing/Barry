//
//  AppDelegate.h
//  XWQGift
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppTabBarViewController.h"
#import <MMDrawerController/MMDrawerController.h>
#import "LeftViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UITabBarController *tbc;

@property (nonatomic, strong) MMDrawerController *mdc;

@end

