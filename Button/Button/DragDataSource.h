//
//  DragDataSource.h
//  Button
//
//  Created by xiangronghua on 2017/5/26.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DragDataSource : NSObject

@property (strong, nonatomic) NSMutableArray *dataSouerce;

@property (strong, nonatomic) NSMutableArray *recommendData;

@property (assign, nonatomic) BOOL isEditing;

+ (instancetype)shareInstancetype;


@end
