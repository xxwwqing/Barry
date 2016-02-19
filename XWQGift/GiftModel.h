//
//  GiftModel.h
//  XWQGift
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GiftDataModel : JSONModel

@property (nonatomic, copy) NSString *idt;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString<Optional> *desc;
@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString<Optional> *price;
@property (nonatomic, copy) NSString<Optional> *pushLink;


@end



@protocol GiftDataModel <NSObject>

@end

@interface GiftModel : JSONModel

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString<Optional> *mag;

@property (nonatomic, strong)NSMutableArray<GiftDataModel> *data;


@end
