//
//  TopicCell.m
//  XWQGift
//
//  Created by qianfeng on 15/12/28.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "TopicCell.h"
#import <UIImageView+WebCache.h>

@implementation TopicCell
{

    UIImageView *_imageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageView = [UIImageView new];
        _imageView.layer.cornerRadius = 15;
        _imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_imageView];
    }
    return self;

}

- (void)layoutSubviews {

    [super layoutSubviews];
    CGFloat leftPadding = 8;
    CGFloat topPadding = 2;
    
    CGSize size = self.contentView.frame.size;
    _imageView.frame = CGRectMake(leftPadding , topPadding, size.width - 2*leftPadding , size.height - 2*topPadding);


}

- (void)setAppModel:(AppDataModel *)appModel {

    NSString *Str = [NSString stringWithFormat:IMAGE@"%@",appModel.topicPhoto];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:Str] placeholderImage:[UIImage imageNamed:@"556"]];


}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
