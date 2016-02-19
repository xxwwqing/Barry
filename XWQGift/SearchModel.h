//
//  SearchModel.h
//  XWQGift
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 谢文清. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface ProductsModel : JSONModel

@property (nonatomic, copy) NSString *idt;
@property (nonatomic, copy) NSString *name;


@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString<Optional> *price;
@property (nonatomic, copy) NSString<Optional> *pushLink;



@end





@protocol ProductsModel <NSObject>

@end


@interface SearchDataModel : JSONModel

@property (nonatomic, strong) NSMutableArray<ProductsModel> *products;

@end



@interface SearchModel : JSONModel

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString<Optional> *mag;

@property (nonatomic, strong)SearchDataModel *data;


@end
