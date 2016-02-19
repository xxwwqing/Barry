//
//  GoodViewController.m
//  XWQGift
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "GoodViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "GiftModel.h"

#import "GoodCell.h"

#import <MJRefresh/MJRefresh.h>
#import "TaoBaoViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "NSString+Common.h"
#import "JWCache.h"

#import "SearchViewController.h"
#import "NSString+Common.h"

@interface GoodViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
    
    UISearchBar *_searchBar;

    UIButton *_rightButton;
    UIButton *_souButton;
    
    UIBarButtonItem *_rightBarButton;
}

@end

@implementation GoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.titles = @"好物";
    _dataArray = [NSMutableArray new];

    [self addRightButton];
    
    [self createCollectionView];
    
    

}

- (void)addBackButton {

}


- (void)addRightButton {
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _rightButton.frame = CGRectMake(0, 0, 30, 30);
    
    [_rightButton setImage:[UIImage imageNamed:@"abc_ic_search"] forState:UIControlStateNormal];

    _rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    

    self.navigationItem.rightBarButtonItem = _rightBarButton;
    
    [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightButtonClick:(UIButton *)rightButton {

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(25, 0, self.view.frame.size.width-50, 30)];
    [_searchBar setSearchBarStyle:UISearchBarStyleDefault];
    [_searchBar setPlaceholder:@"更多好物快来搜索"];
    
    _searchBar.delegate = self;
    
    self.navigationItem.titleView = _searchBar;

    

}

#pragma mark searchBar代理

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    _souButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _souButton.frame = CGRectMake(0, 0, 50, 50);
    [_souButton setTitle:@"取消" forState:UIControlStateNormal];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_souButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [_souButton addTarget:self action:@selector(souButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if (searchBar.text.length > 0) {
        SearchViewController *sv = [[SearchViewController alloc]init];
        
        sv.text = URLEncodedString(_searchBar.text);
        
        [self.navigationController pushViewController:sv animated:YES];
    }
    
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    
}


- (void)souButtonClick:(UIButton *)button {

    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    self.navigationItem.rightBarButtonItem = _rightBarButton;

}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:YES];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"好物";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:22];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    self.navigationItem.rightBarButtonItem = _rightBarButton;

}
/*

- (void)addNavgationTitle {
   UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = @"伊倩";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:22];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}
*/

- (void)createCollectionView {

    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[self createLayout]];
     _collectionView.backgroundColor = [UIColor colorWithRed:242/255.0 green:244/255.0 blue:246/255.0 alpha:1.0];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    
    
    //注册cell类型及复用标识
    [_collectionView registerClass:[GoodCell class] forCellWithReuseIdentifier:@"cellId"];

    [self.view addSubview:_collectionView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNetisMore:NO];
    }];
    _collectionView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer  =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataFromNetisMore:YES];
        
    }];
    _collectionView.mj_footer = footer;
    
    [_collectionView.mj_header beginRefreshing];

}

- (UICollectionViewFlowLayout *)createLayout {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    CGFloat width = self.view.bounds.size.width;
    layout.itemSize = CGSizeMake(width/2 - 15, (width/2) + 50);
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    return layout;

}

- (void)loadDataFromNetisMore:(BOOL)isMore {
    
    NSInteger page = 1;
    if (isMore) {
        if (_dataArray.count%6 == 0) {
            page = _dataArray.count/6 + 1;
        }else {
            [_collectionView.mj_footer endRefreshing];
            return;
            
        }
    }

    NSString *tt = [NSString stringWithFormat:GoodURL,page];
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    //显示 loading 提示框
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSData *cacheData = [JWCache objectForKey:MD5Hash(tt)];
    if (cacheData) {
        if (!isMore) {
            [_dataArray removeAllObjects];
            [_collectionView reloadData];
        }
        
        GiftModel *model = [[GiftModel alloc]initWithData:cacheData error:nil];
        for (GiftDataModel *dModel in model.data) {
            [_dataArray addObject:dModel];
        }
        
        [_collectionView reloadData];
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        isMore ? [_collectionView.mj_footer endRefreshing] : [_collectionView.mj_header endRefreshing];
        return;
    }

    
    
    
    [manager GET:tt parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        if (!isMore) {
            [_dataArray removeAllObjects];
            [_collectionView reloadData];
        }
        
        GiftModel *model = [[GiftModel alloc]initWithData:responseObject error:nil];
        for (GiftDataModel *dModel in model.data) {
            [_dataArray addObject:dModel];
        }
        
        [_collectionView reloadData];
        
        isMore ? [_collectionView.mj_footer endRefreshing] : [_collectionView.mj_header endRefreshing];
        
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        // 把数据进行缓存
        [JWCache setObject:responseObject forKey:MD5Hash(tt)];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        isMore ? [_collectionView.mj_footer endRefreshing] : [_collectionView.mj_header endRefreshing];
    }];


}





#pragma mark --- 代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _dataArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    GoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];

    GiftDataModel *dModel = [_dataArray objectAtIndex:indexPath.row];
    cell.dataModel = dModel;
    cell.backgroundColor =[UIColor whiteColor];
    cell.layer.cornerRadius = 15;
    
    cell.layer.masksToBounds = YES;
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    TaoBaoViewController *tbc = [[TaoBaoViewController alloc]init];
    GiftDataModel *dModel = [_dataArray objectAtIndex:indexPath.row];
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
