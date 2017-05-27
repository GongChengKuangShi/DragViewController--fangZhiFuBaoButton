//
//  DragCollectionViewCell.h
//  Button
//
//  Created by xiangronghua on 2017/5/26.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  DragCollectionViewCell;
@protocol DragCollectionViewCellDelegate <NSObject>
@optional
- (void)DragCollectionViewCell:(DragCollectionViewCell *)cell canclefocus:(UIButton *)sender;
- (void)DragCollectionViewCell:(DragCollectionViewCell *)cell gestureAction:(UIGestureRecognizer *)gesture;

@end

@interface DragCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) id<DragCollectionViewCellDelegate> delegate;
@property (strong, nonatomic) NSString *titleName;
- (void)showDeleteButton;
@end
