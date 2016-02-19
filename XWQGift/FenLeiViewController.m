//
//  FenLeiViewController.m
//  XWQGift
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "FenLeiViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "FenLeiModel.h"
#import "FenLeiCell.h"

#import "FDetailViewController.h"


@interface FenLeiViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
{

    UIScrollView *_scrollView;
    
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
    
    UICollectionView *_collectionView2;
    NSMutableArray *_dataArray2;
    
    UICollectionView *_collectionView3;
    NSMutableArray *_dataArray3;
    
    UIButton *_button;
    UILabel *_lineLabel;
    
}

@end

@implementation FenLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @"分类";
    
    _dataArray = [NSMutableArray new];
    _dataArray2 = [NSMutableArray new];
    _dataArray3 = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createScrollView];
    
    [self createButtons];
    
    [self createCollectionView];
    [self createCollectionView2];
    [self createCollectionView3];
    

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    

    [self loatDataFromNet];
    
}

- (void)addBackButton {

}


- (void) createButtons{
    
    for (int i = 0; i<3; i++) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            _button.frame = CGRectMake(0, 64, self.view.frame.size.width/3, 43);
            [_button setTitle:@"对象" forState:UIControlStateNormal];
        }else if (i == 1) {
            _button.frame = CGRectMake(self.view.frame.size.width/3, 64, self.view.frame.size.width/3, 43);
            [_button setTitle:@"个性" forState:UIControlStateNormal];
        
        }else {
            _button.frame = CGRectMake(self.view.frame.size.width/3 * 2, 64, self.view.frame.size.width/3, 43);
            [_button setTitle:@"场景" forState:UIControlStateNormal];
        }
        
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        
        _button.tag = 100 + i;
        [self.view addSubview:_button];
    }
    UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(0, 109, self.view.frame.size.width, 5)];
    Label.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self.view addSubview:Label];
    
    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 107, self.view.frame.size.width/3 - 40, 2)];
    _lineLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_lineLabel];
}

- (void)buttonClick:(UIButton *)button {
    
    switch (button.tag) {
        case 100:
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
            case 101:
            [_scrollView setContentOffset:CGPointMake(  self.view.frame.size.width, 0) animated:YES];
            
            break;
            case 102:
            
            [_scrollView setContentOffset:CGPointMake(2 *  self.view.frame.size.width, 0) animated:YES];
            
            break;
        default:
            break;
    }

     _lineLabel.frame = CGRectMake( 20 + (_scrollView.contentOffset.x/self.view.frame.size.width) * self.view.frame.size.width/3, 107, self.view.frame.size.width/3 - 40, 2);

}

- (void)createScrollView {

    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 114, self.view.frame.size.width, self.view.frame.size.height - 114 - 44)];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, 0);
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate = self;
    
    //_scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.bounces = NO;
    
    
    [self.view addSubview:_scrollView];
}

- (void)createCollectionView {
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 114 - 44) collectionViewLayout:[self createLayout]];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册cell类型及复用标识
    [_collectionView registerClass:[FenLeiCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [_scrollView addSubview:_collectionView];
    
}

- (void)createCollectionView2 {
    
    _collectionView2 = [[UICollectionView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height - 114 - 44) collectionViewLayout:[self createLayout]];
    _collectionView2.backgroundColor = [UIColor whiteColor];
    
    _collectionView2.delegate = self;
    _collectionView2.dataSource = self;
    
    //注册cell类型及复用标识
    [_collectionView2 registerClass:[FenLeiCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [_scrollView addSubview:_collectionView2];
    
}

- (void)createCollectionView3 {
    
    _collectionView3 = [[UICollectionView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 2, 0, self.view.frame.size.width, self.view.frame.size.height - 114 - 44) collectionViewLayout:[self createLayout]];
    _collectionView3.backgroundColor = [UIColor whiteColor];
    
    _collectionView3.delegate = self;
    _collectionView3.dataSource = self;
    
    //注册cell类型及复用标识
    [_collectionView3 registerClass:[FenLeiCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [_scrollView addSubview:_collectionView3];
    
}

- (UICollectionViewFlowLayout *)createLayout {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    
    CGFloat width = self.view.frame.size.width;
    //CGFloat height = self.view.bounds.size.height;
    layout.itemSize = CGSizeMake(width/5 , width/4 + 5);
    
    layout.sectionInset = UIEdgeInsetsMake(30, 30, 50, 30);
    
    
    return layout;
}


- (void)loatDataFromNet {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:FenLei parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        FenLeiModel *model = [[FenLeiModel alloc]initWithData:responseObject error:nil];
        
        FLDataModel *dataModel = model.data[0];
        [_dataArray addObjectsFromArray:dataModel.topic];
        
        FLDataModel *dataModel2 = model.data[1];
        [_dataArray2 addObjectsFromArray:dataModel2.topic];
        FLDataModel *dataModel3 = model.data[2];
        [_dataArray3 addObjectsFromArray:dataModel3.topic];
        
        [_collectionView reloadData];
        [_collectionView2 reloadData];
        [_collectionView3 reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

#pragma mark --- collection代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == _collectionView) {
        return _dataArray.count;

    }else if (collectionView == _collectionView2){
    
        return _dataArray2.count;
    
    }else {
    
        return _dataArray3.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FenLeiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (collectionView == _collectionView) {
        cell.topicModel = _dataArray[indexPath.row];
    }else if (collectionView == _collectionView2){
        cell.topicModel = _dataArray2[indexPath.row];
    
    }else {
        cell.topicModel = _dataArray3[indexPath.row];
    
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    FDetailViewController *fldv = [[FDetailViewController alloc]init];

    if (collectionView == _collectionView) {
        FLTopicModel *model = _dataArray[indexPath.row];
        fldv.Idt = model.Idt;
    }else if (collectionView == _collectionView2) {
    
        FLTopicModel *model2 = _dataArray2[indexPath.row];
        fldv.Idt = model2.Idt;
    }else {
        FLTopicModel *model3 = _dataArray3[indexPath.row];
        fldv.Idt = model3.Idt;
    }
    
    [self.navigationController pushViewController:fldv animated:YES];
}


#pragma mark -- scrollView代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    
        _lineLabel.frame = CGRectMake( 20 + (_scrollView.contentOffset.x/self.view.frame.size.width) * self.view.frame.size.width/3, 107, self.view.frame.size.width/3 - 40, 2);



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
