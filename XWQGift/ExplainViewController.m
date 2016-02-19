//
//  ExplainViewController.m
//  XWQGift
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 谢文清. All rights reserved.
//

#import "ExplainViewController.h"

@interface ExplainViewController ()

@end

@implementation ExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self addImage];

}

- (void)addImage {

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"555.jpg"];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(30, 200, self.view.frame.size.width-60, 300);
    label.text = @"  伊倩小淘,帮你选购好东西,男票女票生日不知道送什么礼物?每次更换护肤品都有选择恐惧症?等人等车很多的碎片时间不知如何打发?来逛伊倩小淘吧,在这里你可以选你喜欢的,这里有你想要的一切好物~,我们的宗旨是:都是小清新,我们的原则是:都是好东西~";
    //label.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:20];
    //label.textAlignment = NSTextAlignmentCenter;
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
    label.attributedText = attributedString;

    UIImageView *smallView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    
    smallView.center = CGPointMake(self.view.frame.size.width/2, 150);
    smallView.image = [UIImage imageNamed:@"553"];
    smallView.layer.cornerRadius = 60;
    smallView.layer.masksToBounds = YES;
    
    [imageView addSubview:smallView];
    [imageView addSubview:label];

    
    [self.view addSubview:imageView];

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
