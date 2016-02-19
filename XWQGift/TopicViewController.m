//
//  TopicViewController.m
//  XWQGift
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "TopicViewController.h"
#import <AFNetworking/AFNetworking.h>

#import "AppModel.h"
#import "TopicCell.h"
#import "TopicDetailVController.h"
#import <MJRefresh/MJRefresh.h>

@interface TopicViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableView;
    NSMutableArray *_dataArray;
    AFHTTPRequestOperationManager *_manager;

}

@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.titles = @"专题";

    _dataArray = [NSMutableArray new];
    
    [self createTableView];
    
    
}

- (void)addBackButton {

}

- (void)createTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFormNetWithURL:TOPIC isMore:NO];
    }];
    _tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer  =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataFormNetWithURL:TOPIC isMore:YES];
        
    }];
    _tableView.mj_footer = footer;
    
    [_tableView.mj_header beginRefreshing];
    
}

#pragma mark --- 网络请求数据

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

    NSString *tt = [NSString stringWithFormat:urlString,page];
    
    
    
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    
    [_manager GET:tt parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (!isMore) {
            [_dataArray removeAllObjects];
            [_tableView reloadData];
        }
        
        AppModel *giftModel = [[AppModel alloc]initWithData:responseObject error:nil];
        for (AppDataModel *dataModel in giftModel.data) {
            [_dataArray addObject:dataModel];
        }
        
        [_tableView reloadData];
         isMore ? [_tableView.mj_footer endRefreshing] : [_tableView.mj_header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
         isMore ? [_tableView.mj_footer endRefreshing] : [_tableView.mj_header endRefreshing];
    }];
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *dd = @"cellId";
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:dd];
    if (cell == nil) {
        cell = [[TopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        
    }
    cell.appModel = _dataArray[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height/3 - 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    TopicDetailVController *tvc = [[TopicDetailVController alloc]init];
    AppDataModel *model = _dataArray[indexPath.row];
    
    tvc.jId = model.topicInfoID;
    
    
    tvc.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:tvc animated:YES];
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
