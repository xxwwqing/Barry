//
//  TopicDetailVController.m
//  XWQGift
//
//  Created by qianfeng on 15/12/28.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "TopicDetailVController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>

@interface TopicDetailVController ()

@end

@implementation TopicDetailVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @"专题详情";
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    barButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = barButton;
    
    

    _tableView.tableFooterView.frame = CGRectZero;
    
    _scrollViewImages = nil;
    _imageViews = nil;

}

- (void)leftAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



- (void)createScrollImage {

}
- (void)createPageControl {

}



- (void)loadDataFormNetWithURL:(NSString *)urlString isMore:(BOOL)isMore{
    
    NSInteger page = 1;
    if (isMore) {
        if (_dataArray.count%8 == 0) {
            page = _dataArray.count/8 + 1;
        }else {
            [_tableView.mj_footer endRefreshing];
            return;
            
        }
    }
   
    NSString *strt = [NSString stringWithFormat:TOPICDETAIL,_jId,page];
 
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   [manager GET:strt parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       if (!isMore) {
           [_dataArray removeAllObjects];
           [_tableView reloadData];
       }
       
 
    GiftModel *giftModel = [[GiftModel alloc]initWithData:responseObject error:nil];
   for (GiftDataModel *dataModel in giftModel.data) {
   [_dataArray addObject:dataModel];
}
 
   [_tableView reloadData];
  isMore ? [_tableView.mj_footer endRefreshing] : [_tableView.mj_header endRefreshing];
       
              
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
        isMore ? [_tableView.mj_footer endRefreshing] : [_tableView.mj_header endRefreshing];
     
 }];
 
 
 
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
