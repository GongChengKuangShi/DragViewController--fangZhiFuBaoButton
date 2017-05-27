//
//  DragDataSource.m
//  Button
//
//  Created by xiangronghua on 2017/5/26.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "DragDataSource.h"

@implementation DragDataSource

static DragDataSource *tool = nil;

+ (instancetype)shareInstancetype {
    @synchronized (self) {
        if (!tool) {
            tool = [[DragDataSource alloc] init];
        }
    }
    return tool;
}

- (NSMutableArray *)dataSouerce {
    if (!_dataSouerce) {
        NSMutableArray *recommendData = [NSMutableArray arrayWithObjects:@"NBA", @"社会", @"影视歌", @"彩票", @"中国足球", @"国际足球", @"CBA", @"跑步", @"冰雪运动", @"手机", @"数码", @"智能", @"云课堂", @"旅游", @"读书", @"酒香", @"态度公开课", @"暴雪游戏", nil];
        NSMutableArray *likeData = [NSMutableArray arrayWithObjects:@"娱乐", @"体育", @"网易好", @"周口", @"视频", @"财经", @"科技", @"时尚", @"图片", @"直播", @"热点", @"汽车", @"跟帖", @"房产", @"股票", @"轻松一刻", @"段子", @"航空", @"军事", @"历史", @"家居", @"独家", @"游戏", @"健康", @"政务", @"要闻", @"漫画", @"彩票", @"美女", @"萌宠", @"直播", @"阳光法院", @"态度营销", nil];
        self.dataSouerce = [NSMutableArray arrayWithObjects:likeData,recommendData, nil];
    }
    return _dataSouerce;
}

@end
