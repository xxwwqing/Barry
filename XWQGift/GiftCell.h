//
//  GiftCell.h
//  XWQGift
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftModel.h"

@class GiftCell;
@protocol HeartButtonDelegate <NSObject>

- (void)HeartButtonClick:(GiftCell *)cell button:(UIButton *)button;

@end


@interface GiftCell : UITableViewCell

@property (nonatomic, strong) GiftDataModel *model;

@property (nonatomic, weak)id<HeartButtonDelegate>delegate;

@end
