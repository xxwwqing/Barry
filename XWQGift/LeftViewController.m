//
//  LeftViewController.m
//  XWQGift
//
//  Created by qianfeng on 16/1/8.
//  Copyright © 2016年 谢文清. All rights reserved.
//

#import "LeftViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "AppTabBarViewController.h"
#import "AppDelegate.h"
#import <SDImageCache.h>
#import "JWCache.h"

#import "ExplainViewController.h"
#import "CollectionViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    UIImageView *_imageView;
    
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addImage];
    
    [self createTableView];
    
    _dataArray = @[@"   首页",@"   我的收藏",@"   清除缓存",@"   应用简介"];


}

- (void)addImage {
    
    int i = arc4random()%2+1;
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, self.view.frame.size.height/3 + 50)];
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
    
    [self.view addSubview:_imageView];
}

- (void)createTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_imageView.frame), 300, self.view.frame.size.height - CGRectGetHeight(_imageView.frame)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight  = 60;
    
    //_tableView.scrollEnabled = NO;
    
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //隐藏下面的线
    //_tableView.tableFooterView = [UIView new];
    
    // 给tableView设置背景视图
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetHeight(_imageView.frame), self.view.frame.size.width, self.view.frame.size.height - 300)];
    bgImageView.image = [UIImage imageNamed:@"23"];
    _tableView.backgroundView = bgImageView;
    
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *dd = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dd];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
        
        UIView *selectView = [[UIView alloc] init];
        selectView.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = selectView;
    }
    
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    MMDrawerController *mdc = appDelegate.mdc;
    
    UITabBarController *tbc = appDelegate.tbc;

    switch (indexPath.row) {
        case 0:{
            
            mdc.centerViewController = tbc;
            
        }
            break;
        case 1:{
            
            CollectionViewController *clvc = [[CollectionViewController alloc]init];
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:clvc];
            
            mdc.centerViewController = nvc;
            
        }
            break;
        case 2:{
            
            [self cleanCache];
            
            
        }
            
            break;
        case 3:{
        
            ExplainViewController *explainVC = [ExplainViewController new];
            mdc.centerViewController = explainVC;
        
        
        }
            
        default:
            break;
    }
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
    }];
    
    
}

- (void)cleanCache {
    
    
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"确定清除缓存%.2fM", [self getCacheSize]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertController *a2 = [UIAlertController alertControllerWithTitle:@"清理成功" message:@"已经很干净啦" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *aA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [a2 addAction:aA];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"清理" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self removeCacheData];
        [JWCache resetCache];
        
        [self presentViewController:a2 animated:YES completion:nil];

    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:^{
        
            }];

}

- (void)removeCacheData {
    [[SDImageCache sharedImageCache] clearDisk];
}
    
- (double)getCacheSize {
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    NSUInteger fileSize = [imageCache getSize]; // 以字节为单位
    NSString *myCachePath =  [JWCache cacheDirectory];
    //NSLog(@"%@",myCachePath);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fileInfo = [fm attributesOfItemAtPath:myCachePath error:nil];
    fileSize += fileInfo.fileSize;
    return fileSize/1024.0/1024.0;
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
