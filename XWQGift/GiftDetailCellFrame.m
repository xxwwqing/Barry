//
//  GiftDetailCellFrame.m
//  XWQGift
//
//  Created by qianfeng on 15/12/27.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "GiftDetailCellFrame.h"
#import <UIKit/UIKit.h>


@implementation GiftDetailCellFrame

- (void)setDCmodel:(GiftDCModel *)DCmodel {

    _DCmodel = DCmodel;
    
    
    CGFloat leftPadding = 10;
    CGFloat rightPadding = 10;
    CGFloat topPadding = 10;
    CGFloat padding = 8;
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen]bounds]);
    CGFloat height = CGRectGetHeight([[UIScreen mainScreen]bounds]);
    
    
    
    _titleFrame = CGRectMake(leftPadding, topPadding,width, 25);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:DCmodel.desc];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, DCmodel.desc.length)];
    [attributedString addAttribute:NSFontAttributeName value:CONTENTFONT range:NSMakeRange(0, DCmodel.desc.length)];
    
    
    CGFloat descHeight = [self sizeWithText:attributedString maxSize:CGSizeMake(width - leftPadding - rightPadding, height) font:CONTENTFONT].height;

    
    _descFrame = CGRectMake(leftPadding, CGRectGetMaxY(_titleFrame) + padding, width - leftPadding - rightPadding, descHeight);
    _imageFrame = CGRectMake(leftPadding, CGRectGetMaxY(_descFrame) + padding, width-leftPadding-rightPadding,height/2 - 10);
    
    _priceFrame = CGRectMake(leftPadding * 2, CGRectGetMaxY(_imageFrame) + padding + 3, 150, 40);
   _buttonFrame = CGRectMake(width - 120, CGRectGetMaxY(_imageFrame) + padding, 100, 40);
    
    _lineFrame = CGRectMake(0, CGRectGetMaxY(_priceFrame)+2*padding - 8, width, 6);
    
    _cellHeight = CGRectGetMaxY(_priceFrame) + 2*padding;


}


//计算文字的高度
- (CGSize)sizeWithText:(NSMutableAttributedString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [text boundingRectWithSize:maxSize
                                     options:options
                                     context:nil];
    return rect.size;
}


@end
