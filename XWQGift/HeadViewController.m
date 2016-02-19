//
//  HeadViewController.m
//  XWQGift
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "HeadViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "GiftModel.h"
#import "GiftCell.h"

#import "HeadDetailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "JWCache.h"
#import "NSString+Common.h"

#import "AppModel.h"
#import <UIImageView+WebCache.h>

#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "TopicDetailVController.h"

@interface HeadViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    
    //NSMutableArray *_scrollViewImages;
    //NSMutableArray *_imageViews;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    
}

@end

@implementation HeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @"首页";
    _dataArray = [NSMutableArray new];
    _scrollViewImages = [NSMutableArray new];
    _imageViews = [NSMutableArray new];
    
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tab_list"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    barButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = barButton;
    
    
    [self loadDataFormNet];
    
     //[self createScrollView];

    
     [self createTableView];
}

- (void)leftAction {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}



- (void)loadDataFormNet {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:SOUSCROLL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        AppModel *appModel = [[AppModel alloc]initWithData:responseObject error:nil];
    
        [_scrollViewImages addObjectsFromArray:appModel.data];
        
        [self createScrollView];

        [self createPageControl];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    


}



- (void)createScrollView {

    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height/4 + 30)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(3 * self.view.frame.size.width, self.view.frame.size.height/4 + 30);
     _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    
    _scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    //隐藏滚动指示条
    _scrollView.showsHorizontalScrollIndicator = NO;
    //_scrollView.showsVerticalScrollIndicator = NO;
    
    
    
    [self createScrollImage];

}

- (void)createPageControl {
    
    CGSize size = _scrollView.frame.size;
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.frame = CGRectMake(0, size.height - 20, size.width, 20);
    _pageControl.numberOfPages = _scrollViewImages.count;
    
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [_tableView addSubview:_pageControl];
}


- (void)createScrollImage {

    for (int i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height/4 + 30)];
        imageView.backgroundColor = [UIColor redColor];
        imageView.tag = (i-1+_scrollViewImages.count)%_scrollViewImages.count;
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
        
        [self setImageToView:imageView];
        
        [_imageViews addObject:imageView];
        
    }
    
    _tableView.tableHeaderView = _scrollView;
    
}

- (void)setImageToView:(UIImageView *)view {

    AppDataModel *adModel = _scrollViewImages[view.tag];
    [view sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMAGE@"%@",adModel.topicPhoto]] placeholderImage:[UIImage imageNamed:@"556"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle:)];
    [view addGestureRecognizer:tap];
}

- (void)tapHandle:(UITapGestureRecognizer *)tap {

    TopicDetailVController *tvc = [[TopicDetailVController alloc]init];
    AppDataModel *model = _scrollViewImages[tap.view.tag];
    
    tvc.jId = model.topicInfoID;
    tvc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tvc animated:YES];

}

- (void)cycleReuse {

    int flag = 0;
    CGSize size = _scrollView.frame.size;
    CGFloat offsetX = _scrollView.contentOffset.x;
    
    if (offsetX == 2*size.width) {
        flag = 1;
    }else if (offsetX == 0){

        flag = -1;
    }else {
    
        return;
    }
    
    for (UIImageView *view in _imageViews) {
        view.tag = (view.tag + flag + _scrollViewImages.count)%_scrollViewImages.count;
        [self setImageToView:view];
    }
    
    _scrollView.contentOffset = CGPointMake(size.width, 0);
    
    _pageControl.currentPage = [_imageViews[1] tag];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self cycleReuse];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self cycleReuse];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeContentSize:) userInfo:nil repeats:YES];

    [_timer setFireDate:[NSDate distantPast]];

    [_tableView reloadData];
}

- (void)changeContentSize:(NSTimer *)timer {

    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*2, 0) animated:YES];

}


- (void)createTableView{

    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    
    //_tableView.tableHeaderView = _scrollView;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFormNetWithURL:SOU isMore:NO];
    }];
    _tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer  =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataFormNetWithURL:SOU isMore:YES];
        
    }];
    _tableView.mj_footer = footer;
    
    [_tableView.mj_header beginRefreshing];
}

#pragma mark --- 网络请求数据

- (void)loadDataFormNetWithURL:(NSString *)urlString isMore:(BOOL)isMore {
    
     NSInteger page = 1;
    if (isMore) {
        if (_dataArray.count%20 == 0) {
            page = _dataArray.count/20 + 1;
        }else {
            [_tableView.mj_footer endRefreshing];
            return;
            
        }
    }

    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    //显示 loading 提示框
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *stt = [NSString stringWithFormat:urlString,page];
    
    NSData *cacheData = [JWCache objectForKey:MD5Hash(stt)];
    
    if (cacheData) {
        if (!isMore) {
            [_dataArray removeAllObjects];
            [_tableView reloadData];
        }
        GiftModel *giftModel = [[GiftModel alloc]initWithData:cacheData error:nil];
        for (GiftDataModel *dataModel in giftModel.data) {
            [_dataArray addObject:dataModel];
        }
        
        [_tableView reloadData];
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        isMore ? [_tableView.mj_footer endRefreshing] : [_tableView.mj_header endRefreshing];
        return;
    }

    [_manager GET:stt parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        // 把数据进行缓存
        [JWCache setObject:responseObject forKey:MD5Hash(stt)];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        isMore ? [_tableView.mj_footer endRefreshing] : [_tableView.mj_header endRefreshing];
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
