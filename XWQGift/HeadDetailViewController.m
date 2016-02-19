//
//  HeadDetailViewController.m
//  XWQGift
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "HeadDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "GiftDetailCell.h"
#import <UIImageView+WebCache.h>

#import "GiftDetailCellFrame.h"
#import "GiftDCModel.h"
#import "TaoBaoViewController.h"

@interface HeadDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ButtonClickDelegate,UIScrollViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    AFHTTPRequestOperationManager *_manager;
    
    UIView *_headView;
    UIImageView *_imageView;
    UILabel *_nameLabel;
    UILabel *_descLabel;
    UILabel *_lineLabel;
    GiftDataModel *_dataModel;

}

@end

@implementation HeadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @"介绍";
    
    [self createHeadView];

    _dataArray = [NSMutableArray new];

    [self createTableView];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableHeaderView = _headView;
    
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    
    NSString *url = [NSString stringWithFormat:SOUDETAIL,_model.idt];
    
    [self loadDataFormNetWithURL:url];
}





- (void)createHeadView {
    
    CGFloat leftPadding = 10;
    CGFloat rightPadding = 10;
   // CGFloat topPadding = 10;
    CGFloat padding = 8;
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen]bounds]);
   // CGFloat height = CGRectGetHeight([[UIScreen mainScreen]bounds]);

    _headView = [UIView new];
    //_headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);

    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3)];
    
    //_imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMAGE@"%@",_model.photo]] placeholderImage:nil];
    [_headView addSubview:_imageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftPadding, CGRectGetMaxY(_imageView.frame) - 30, CGRectGetWidth(_imageView.frame), 20)];
    _nameLabel.text = _model.name;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont boldSystemFontOfSize:20];
    [_imageView addSubview:_nameLabel];
    
    CGFloat contentHeight = [self sizeWithText:_model.desc maxSize:CGSizeMake(self.view.frame.size.width, MAXFLOAT) font:[UIFont systemFontOfSize:18]].height;
    
    _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftPadding + 5, CGRectGetMaxY(_imageView.frame) + padding, width - leftPadding - rightPadding, contentHeight)];
    _descLabel.text = [NSString stringWithFormat:@"  %@",_model.desc];
    _descLabel.numberOfLines = 0;
 
    _descLabel.textColor = [UIColor colorWithRed:111/255.0 green:112/255.0 blue:133/255.0 alpha:1.0];
    
    
    NSString *textStr = [NSString stringWithFormat:@"%@",_descLabel.text];
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, textStr.length)];
    _descLabel.attributedText = attributedString;
    
    [_descLabel sizeToFit];
    
    _lineLabel = [UILabel new];
    _lineLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    
    [_headView addSubview:_lineLabel];

    [_headView addSubview:_descLabel];
    
    _headView.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(_imageView.frame) + contentHeight + 4*padding + 10);
    _lineLabel.frame = CGRectMake(0, CGRectGetMaxY(_headView.frame)- 6, width, 6);
}

//计算文字的高度
- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

#pragma mark --- 网络请求数据

- (void)loadDataFormNetWithURL:(NSString *)urlString {
    
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    [_manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        GiftModel *giftModel = [[GiftModel alloc]initWithData:responseObject error:nil];
        
        for (_dataModel in giftModel.data) {
            
            GiftDCModel *dcModel = [GiftDCModel new];
            dcModel.title = _dataModel.name;
            dcModel.image = _dataModel.photo;
            dcModel.price = _dataModel.price;
            dcModel.desc = _dataModel.desc;
            dcModel.url = _dataModel.pushLink;
            
            GiftDetailCellFrame *cellFrame = [GiftDetailCellFrame new];
            cellFrame.DCmodel = dcModel;
            [_dataArray addObject:cellFrame];
            
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GiftDetailCellFrame *cellFrame = _dataArray[indexPath.row];
    return cellFrame.cellHeight;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *dd = @"cellId";
    GiftDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:dd];
    if (cell == nil) {
        cell = [[GiftDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        
    }
    cell.cellFrame = _dataArray[indexPath.row];
    cell.delegate = self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        
    return cell;
    
}


- (void)ButtonClick:(GiftDetailCell *)cell button:(UIButton *)button {
    
    NSIndexPath *index = [_tableView indexPathForCell:cell];
    //GiftDataModel *ggModel = _dataArray[index.row];
     GiftDetailCellFrame *cellFrame = _dataArray[index.row];
    
    TaoBaoViewController *tbc = [[TaoBaoViewController alloc]init];
    tbc.url = cellFrame.DCmodel.url;
    tbc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tbc animated:YES];
    
}
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat setY = scrollView.contentOffset.y;
    if (scrollView == _tableView) {
        if (setY > 0) {
            _imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3);
            
        }
        if (setY <0) {
            CGRect rect = _imageView.frame;
            rect.origin.y = setY;
            _imageView.frame = CGRectMake(0, setY, self.view.frame.size.width, self.view.frame.size.height/3 - setY);
            
        }
    }


}


*/


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
