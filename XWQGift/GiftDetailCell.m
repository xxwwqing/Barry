//
//  GiftDetailCell.m
//  XWQGift
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "GiftDetailCell.h"
#import <UIImageView+WebCache.h>


//#define CONTENTFONT [UIFont systemFontOfSize:15]

@implementation GiftDetailCell
{
    UILabel *_titleLabel;
    UILabel *_descLabel;
    UIImageView *_imageView;
    UILabel *_priceLabel;
    UIButton *_button;
    
    UILabel *_lineLabel;
    
   
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customViews];
    }
    return self;
}

- (void)customViews {

    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    
    _descLabel = [UILabel new];
    _descLabel.numberOfLines = 0;
    _descLabel.font = [UIFont systemFontOfSize:16];
    _descLabel.textColor = [UIColor colorWithRed:117/255.0 green:118/255.0 blue:119/255.0 alpha:1.0];
    _descLabel.adjustsFontSizeToFitWidth = YES;
    
    _imageView = [UIImageView new];
    _imageView.layer.cornerRadius = 15;
    _imageView.layer.masksToBounds = YES;
    
    _priceLabel = [UILabel new];
    _priceLabel.textColor = [UIColor colorWithRed:238/255.0 green:101/255.0 blue:102/255.0 alpha:1.0];
    _priceLabel.font = [UIFont boldSystemFontOfSize:20];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = [UIColor colorWithRed:250/255.0 green:72/255.0 blue:92/255.0 alpha:1.0];
    [_button setTitle:@"详情" forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:20];
    _button.layer.cornerRadius = 20;
    _button.layer.masksToBounds = YES;
    [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _lineLabel = [UILabel new];
    _lineLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    

    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_descLabel];
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_button];
    [self.contentView addSubview:_lineLabel];

}

- (void)buttonClick:(UIButton *)button {

    if (_delegate && [_delegate respondsToSelector:@selector(ButtonClick:button:)]) {
        [_delegate ButtonClick:self button:button];
    }

}

- (void)setCellFrame:(GiftDetailCellFrame *)cellFrame {

    _titleLabel.text = cellFrame.DCmodel.title;
    _titleLabel.frame = cellFrame.titleFrame;
    
    _descLabel.text = [NSString stringWithFormat:@"  %@",cellFrame.DCmodel.desc];
    
        _descLabel.frame = cellFrame.descFrame;
    
    NSString *textStr = [NSString stringWithFormat:@"%@",_descLabel.text];
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, textStr.length)];
    [attributedString addAttribute:NSFontAttributeName value:CONTENTFONT range:NSMakeRange(0, attributedString.length)];
       
    _descLabel.attributedText = attributedString;
    
    //[_descLabel sizeToFit];

    
    
     NSString *str = [NSString stringWithFormat:IMAGE@"%@",cellFrame.DCmodel.image];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"557"]];
    _imageView.frame = cellFrame.imageFrame;
    
    _priceLabel.text = [NSString stringWithFormat:@"价格:%@",cellFrame.DCmodel.price];
    _priceLabel.frame = cellFrame.priceFrame;
    

    _button.frame = cellFrame.buttonFrame;
    
    _lineLabel.frame = cellFrame.lineFrame;

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
