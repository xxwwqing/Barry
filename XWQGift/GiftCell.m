//
//  GiftCell.m
//  XWQGift
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "GiftCell.h"
#import <UIImageView+WebCache.h>
#import "DBManager.h"
#import "TScaleButton.h"

@implementation GiftCell
{

    UILabel *_titleLabel;
    UIImageView *_photoImageView;
    UIButton *_heartButton;
    
     BOOL _isFavourite;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self customViews];
    }
    
    return self;
}

- (void)customViews {

    _photoImageView = [UIImageView new];
    
    _photoImageView.layer.cornerRadius = 15;
    _photoImageView.layer.masksToBounds = YES;
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_titleLabel sizeToFit];
     _titleLabel.adjustsFontSizeToFitWidth = YES;
    
    _heartButton = [[TScaleButton alloc]init];
    
    [_heartButton setBackgroundImage:[UIImage imageNamed:@"002_2"] forState:UIControlStateNormal];
    [_heartButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //_titleLabel.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    
    [self.contentView addSubview:_photoImageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_heartButton];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGFloat leftPadding = 8;
    CGFloat topPadding = 2;
    CGFloat padding = 5;
    CGSize size = self.contentView.frame.size;
    _photoImageView.frame = CGRectMake(leftPadding , topPadding, size.width - 2*leftPadding , size.height - 2*topPadding);
    _titleLabel.frame = CGRectMake(CGRectGetMinX(_photoImageView.frame) + padding, CGRectGetMaxY(_photoImageView.frame) - size.height/5, CGRectGetWidth(_photoImageView.frame), size.height/5);
    
    _heartButton.frame = CGRectMake(size.width - 45, 20, 25, 25);
   
}

- (void)setModel:(GiftDataModel *)model {
    _model = model;
    
    NSString *str = [NSString stringWithFormat:IMAGE@"%@",model.photo];
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"556"]];
    _titleLabel.text = model.name;
    
    
    _isFavourite = [[DBManager sharedManager]isExistAppForAppId:model.idt recordType:@"uuxxw"];
    
    if (_isFavourite) {
        
        [_heartButton setImage:[UIImage imageNamed:@"002_2_x"] forState:UIControlStateNormal];
        
    }else{
        
        [_heartButton setImage:[UIImage imageNamed:@"002_2"] forState:UIControlStateNormal];
        
    }


    
}


- (void)buttonClick:(UIButton *)button {

    _isFavourite = [[DBManager sharedManager]isExistAppForAppId:_model.idt recordType:@"uuxxw"];
    
    if (_isFavourite) {
        [[DBManager sharedManager]deleteModelForAppId:_model.idt recordType:@"uuxxw"];
        [_heartButton setImage:[UIImage imageNamed:@"002_2"] forState:UIControlStateNormal];
    }else {
    
        [[DBManager sharedManager]insertModel:_model recordType:@"uuxxw"];
        [_heartButton setImage:[UIImage imageNamed:@"002_2_x"] forState:UIControlStateNormal];
    
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(HeartButtonClick:button:)]) {
        [_delegate HeartButtonClick:self button:button];
    }
    

}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
