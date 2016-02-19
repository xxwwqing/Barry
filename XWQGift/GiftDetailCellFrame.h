//
//  GiftDetailCellFrame.h
//  XWQGift
//
//  Created by qianfeng on 15/12/27.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GiftDCModel.h"
#define CONTENTFONT [UIFont systemFontOfSize:16]

@interface GiftDetailCellFrame : NSObject

@property (nonatomic, assign, readonly) CGRect titleFrame;

@property (nonatomic, assign, readonly) CGRect descFrame;
@property (nonatomic, assign, readonly) CGRect imageFrame;
@property (nonatomic, assign, readonly) CGRect priceFrame;
@property (nonatomic, assign, readonly) CGRect buttonFrame;
@property (nonatomic, assign, readonly) CGRect lineFrame;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong)GiftDCModel *DCmodel;

@end
