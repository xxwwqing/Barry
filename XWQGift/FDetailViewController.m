//
//  FDetailViewController.m
//  XWQGift
//
//  Created by qianfeng on 16/1/6.
//  Copyright © 2016年 谢文清. All rights reserved.
//

#import "FDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "GiftModel.h"
#import "GiftCell.h"
#import "HeadDetailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface FDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation FDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titles = @"分类详情";
    
    _dataArray = [NSMutableArray new];

    [self createTableView];
    
    [self loadDataFormNet];

}

- (void)createTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
}

- (void)loadDataFormNet {

    NSString *strt = [NSString stringWithFormat:FenLeiDetail,_Idt];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //显示 loading 提示框
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager GET:strt parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        GiftModel *giftModel = [[GiftModel alloc]initWithData:responseObject error:nil];
        for (GiftDataModel *dataModel in giftModel.data) {
            [_dataArray addObject:dataModel];
        }
        
        [_tableView reloadData];
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *dd = @"cellId";
    GiftCell *cell = [tableView dequeueReusableCellWithIdentifier:dd];
    if (cell == nil) {
        cell = [[GiftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height/3 - 65;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HeadDetailViewController *hdv = [[HeadDetailViewController alloc]init];
    
    GiftDataModel *dataModel = _dataArray[indexPath.row];
    hdv.model = dataModel;
    hdv.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:hdv animated:YES];
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
