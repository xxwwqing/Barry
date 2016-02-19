//
//  BaseViewController.m
//  XWQGift
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController (){

    UILabel *_titleLabel;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    [self addNavgationTitle];
    
    [self addBackButton];
}



- (void)addNavgationTitle {
   _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    _titleLabel.text = @"伊倩";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:22];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _titleLabel;
}

- (void)setTitles:(NSString *)titles {
    _titles = titles;
    _titleLabel.text = titles;
}

- (void)addBackButton {

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    barButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = barButton;

}

- (void)leftAction {

    [self.navigationController popViewControllerAnimated:YES];


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
