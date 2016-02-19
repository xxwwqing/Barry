//
//  GoodCell.m
//  XWQGift
//
//  Created by qianfeng on 15/12/27.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "GoodCell.h"
#import <UIImageView+WebCache.h>

@implementation GoodCell

{

    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_priceLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self customViews];
    }
    return self;
}

- (void)customViews {

    _imageView = [UIImageView new];
    _imageView.layer.cornerRadius = 15;
    _imageView.layer.masksToBounds = YES;

    
    _titleLabel = [UILabel new];
    //_titleLabel.backgroundColor = [UIColor greenColor];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
    //[_titleLabel sizeToFit];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    
    
    _priceLabel = [UILabel new];
    _priceLabel.textColor = [UIColor colorWithRed:238/255.0 green:101/255.0 blue:102/255.0 alpha:1.0];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    //_priceLabel.backgroundColor = [UIColor redColor];


    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_priceLabel];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGSize size = self.contentView.frame.size;
    
    _imageView.frame = CGRectMake(0, 0, size.width, size.height - size.height/4);
    _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame), size.width, size.height/4 - 20);
    _priceLabel.frame = CGRectMake(20, CGRectGetMaxY(_titleLabel.frame), size.width, 20);

}

- (void)setDataModel:(GiftDataModel *)dataModel {

    _dataModel = dataModel;
    
    NSString *str = [NSString stringWithFormat:IMAGE@"%@",dataModel.photo];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"557"]];
    _titleLabel.text = dataModel.name;
    
    _priceLabel.text = [NSString stringWithFormat:@"价格:%@",dataModel.price];


}


@end
