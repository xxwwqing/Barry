//
//  SearchCell.m
//  XWQGift
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 谢文清. All rights reserved.
//

#import "SearchCell.h"
#import <UIImageView+WebCache.h>

@implementation SearchCell

{
    
    UIImageView *_imageView;
    UILabel *_titleLabel;
    
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
    
    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGSize size = self.contentView.frame.size;
    
    _imageView.frame = CGRectMake(0, 0, size.width, size.height - size.height/6);
    _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame), size.width, size.height/6);
    
    
}

- (void)setProductModel:(ProductsModel *)productModel {
    
    _productModel = productModel;
    
    NSString *str = [NSString stringWithFormat:IMAGE@"%@",productModel.photo];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"557"]];
    _titleLabel.text = productModel.name;
    
    
}




@end
