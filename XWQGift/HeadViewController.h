//
//  HeadViewController.h
//  XWQGift
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "AppViewController.h"

@class AFHTTPRequestOperationManager;
@interface HeadViewController : AppViewController
{

    UITableView *_tableView;
    NSMutableArray *_dataArray;
    AFHTTPRequestOperationManager *_manager;
    UIScrollView *_scrollView;
    NSMutableArray *_scrollViewImages;
    NSMutableArray *_imageViews;

}



- (void)loadDataFormNetWithURL:(NSString *)urlString isMore:(BOOL)isMore;



@end
