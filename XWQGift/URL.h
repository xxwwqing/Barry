//
//  URL.h
//  XWQGift
//
//  Created by qianfeng on 15/12/25.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#ifndef URL_h
#define URL_h

#define SIZE self.view.frame.size

//首页滚动视图
#define SOUSCROLL @"http://117.21.248.20:91/TopicInfo/"


//首页
#define SOU @"http://117.21.248.20:91/StrategyInfo/?pageSize=20&&uid=&&pageIndex=%ld"

//首页详情
#define SOUDETAIL @"http://117.21.248.20:91/StrategyInfo/GetStrategyInfoDetail?id=%@&&dvType=2&&dvid=357139054246579"

//图片
#define  IMAGE @"http://117.21.248.20:91"

//搜索
#define SOUSUO @"http://117.21.248.20:91/StrategyInfo/Search?uid=&&key=%@"

//好物
#define GoodURL @"http://117.21.248.20:91/ProductInfo/GetHotProductInfo?id=&&pageSize=6&&pageIndex=%ld"

//分类
#define FenLei @"http://117.21.248.20:91/TopicCategoryInfo/"

//分类详情
#define FenLeiDetail @"http://117.21.248.20:91/TopicInfo/GetStrategyInfoByTopicId?pageSize=60&&uid=&&id=%@&&pageIndex=1"

//专题
#define TOPIC @"http://117.21.248.20:91/TopicInfo/GetTopicInfo?pageSize=8&&pageIndex=%ld"


//专题详情
#define TOPICDETAIL @"http://117.21.248.20:91/TopicInfo/GetStrategyInfoByTopicId?pageSize=8&&uid=&&id=%@&&pageIndex=%ld"

#endif /* URL_h */
