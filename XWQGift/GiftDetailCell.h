//
//  GiftDetailCell.h
//  XWQGift
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftDetailCellFrame.h"
#import "GiftDCModel.h"

@class GiftDetailCell;
@protocol ButtonClickDelegate <NSObject>

- (void)ButtonClick:(GiftDetailCell *)cell button:(UIButton *)button;

@end

@interface GiftDetailCell : UITableViewCell

@property (nonatomic, strong) GiftDetailCellFrame *cellFrame;

@property (nonatomic, strong) GiftDCModel *model;

@property (nonatomic, weak) id<ButtonClickDelegate>delegate;


@end
