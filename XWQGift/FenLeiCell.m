//
//  FenLeiCell.m
//  XWQGift
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "FenLeiCell.h"
#import <UIImageView+WebCache.h>

@implementation FenLeiCell

{
    UIImageView *_imageView;
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self customViews];
        
    }
    
    return self;
    
}

- (void)customViews {
    
    
    _imageView = [UIImageView new];
    
    [self.contentView addSubview:_imageView];
    
    _label = [UILabel new];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:15];
    //_label.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    
    [self.contentView addSubview:_label];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    _imageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width,self.contentView.frame.size.width);
    
    _label.frame = CGRectMake(0, self.contentView.frame.size.width + 5, self.contentView.frame.size.width, self.contentView.frame.size.height - self.contentView.frame.size.width);
}

- (void)setTopicModel:(FLTopicModel *)topicModel {

    _topicModel = topicModel;
    NSString *str = [NSString stringWithFormat:IMAGE@"%@",topicModel.url];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    _label.text = topicModel.name;



}


@end
