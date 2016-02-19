//
//  AppModel.h
//  XWQGift
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AppDataModel : JSONModel

@property (nonatomic, copy)NSString *topicInfoID;
@property (nonatomic, copy)NSString *topicName;
@property (nonatomic, copy)NSString *topicPhoto;
@property (nonatomic, copy)NSString *createtime;

@end



@protocol AppDataModel <NSObject>

@end



@interface AppModel : JSONModel

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString<Optional> *mag;

@property (nonatomic, strong)NSMutableArray<AppDataModel> *data;

@end
