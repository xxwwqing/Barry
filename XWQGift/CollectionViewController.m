//
//  CollectionViewController.m
//  XWQGift
//
//  Created by qianfeng on 16/1/10.
//  Copyright © 2016年 谢文清. All rights reserved.
//

#import "CollectionViewController.h"
#import "DBManager.h"
#import "GiftCell.h"
#import "HeadDetailViewController.h"
#import "GiftModel.h"

@interface CollectionViewController ()<UITableViewDataSource, UITableViewDelegate,HeartButtonDelegate>
{

    UITableView *_tableView;
    NSMutableArray *_dataArray;
    UILabel *_titleLabel;
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addImage];
    _dataArray = [[NSMutableArray alloc]initWithArray:[[DBManager sharedManager]readModelsWithRecordType:@"uuxxw"]];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    [self addNavgationTitle];
    
    [self addData];
}

- (void)addNavgationTitle {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    _titleLabel.text = @"我的收藏";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:22];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _titleLabel;
}


- (void)addImage {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    imageView.image = [UIImage imageNamed:@"554"];
    imageView.userInteractionEnabled = YES;
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(80, 150, self.view.frame.size.width-160, 100);
    label.text = @"你还没有收藏的商品哦~快去收藏自己喜欢的东西吧！";
    label.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    
    [imageView addSubview:label];
    [self.view addSubview:imageView];
    
}

- (void)addData {
    
    if (_dataArray.count > 0) {
        [self createTableView];
    }
    
    
}

- (void)createTableView{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];


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
    
    cell.delegate = self;
    
    cell.model = _dataArray[indexPath.row];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height/3 - 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    HeadDetailViewController *hdvc = [HeadDetailViewController new];

    hdvc.model = _dataArray[indexPath.row];

   [self.navigationController pushViewController:hdvc animated:YES];
    
}


- (void)HeartButtonClick:(GiftCell *)cell button:(UIButton *)button {
    _dataArray = [[NSMutableArray alloc]initWithArray:[[DBManager sharedManager]readModelsWithRecordType:@"uuxxw"]];
    [_tableView reloadData];
    
    if (_dataArray.count == 0) {
        [_tableView removeFromSuperview];
    }

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
