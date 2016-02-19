//
//  FenLeiModel.h
//  XWQGift
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface FLTopicModel : JSONModel

@property (nonatomic, copy) NSString *Idt;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;


@end


@protocol FLTopicModel <NSObject>

@end

@interface FLDataModel : JSONModel

@property (nonatomic, copy) NSString *idt;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong)NSMutableArray<FLTopicModel> *topic;


@end


@protocol FLDataModel <NSObject>
@end

@interface FenLeiModel : JSONModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString<Optional> *msg;
@property (nonatomic, strong) NSMutableArray<FLDataModel> *data;

@end
