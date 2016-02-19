//
//  SearchViewController.m
//  XWQGift
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 谢文清. All rights reserved.
//

#import "SearchViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "SearchModel.h"
#import "SearchCell.h"
#import "TaoBaoViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface SearchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;

}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    self.view.backgroundColor = [UIColor redColor];
    
    
    [self createCollectionView];
    
    [self loadDataFromNet];

}

- (void)loadDataFromNet {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //显示 loading 提示框
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *str = [NSString stringWithFormat:SOUSUO,_text];
    
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SearchModel *model = [[SearchModel alloc]initWithData:responseObject error:nil];
        for (SearchDataModel *dataModel in model.data.products) {
            [_dataArray addObject:dataModel];
        }
        
        [_collectionView reloadData];
        
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
}


- (void)createCollectionView {

    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[self createLayout]];
    _collectionView.backgroundColor = [UIColor colorWithRed:242/255.0 green:244/255.0 blue:246/255.0 alpha:1.0];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册cell类型及复用标识
    [_collectionView registerClass:[SearchCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.view addSubview:_collectionView];


}

- (UICollectionViewFlowLayout *)createLayout {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    CGFloat width = self.view.bounds.size.width;
    layout.itemSize = CGSizeMake(width/2 - 15, (width/2) + 50);
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    return layout;
    
}

#pragma mark --- 代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    ProductsModel *dModel = [_dataArray objectAtIndex:indexPath.row];
    cell.productModel = dModel;
    cell.backgroundColor =[UIColor whiteColor];
    cell.layer.cornerRadius = 15;
    
    cell.layer.masksToBounds = YES;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TaoBaoViewController *tbc = [[TaoBaoViewController alloc]init];
    ProductsModel *dModel = [_dataArray objectAtIndex:indexPath.row];
    tbc.url = dModel.pushLink;
    tbc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tbc animated:YES];
    
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
