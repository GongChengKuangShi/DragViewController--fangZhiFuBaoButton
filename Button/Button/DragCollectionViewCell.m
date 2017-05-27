//
//  DragCollectionViewCell.m
//  Button
//
//  Created by xiangronghua on 2017/5/26.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "DragCollectionViewCell.h"
#import "DragDeleteButton.h"
#import "Header.h"
#import "DragDataSource.h"

#define kDeleteH 8

@interface DragCollectionViewCell ()<UIGestureRecognizerDelegate>

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)DragDeleteButton *deleteButton;
@property(nonatomic, strong)UIView *backgrondView;

@end

@implementation DragCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAtion:)];
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAtion:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAtion:)];
    [self addGestureRecognizer:tap];
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = kBlackColor;
    _titleLabel.layer.masksToBounds = YES;
    _titleLabel.layer.borderWidth = 0.75f;
    _titleLabel.layer.borderColor = kGrayColor.CGColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    self.deleteButton = [DragDeleteButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.backgroundColor = [UIColor grayColor];
    _deleteButton.frame = CGRectMake(0, 0, kDeleteH, kDeleteH);
    [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteButton];
}

- (void)showDeleteButton {
    _deleteButton.hidden = NO;
}

- (void)setTitleName:(NSString *)titleName {
    _titleName = titleName;
    _titleLabel.text = _titleName;
    _deleteButton.hidden = ![DragDataSource shareInstancetype].isEditing;
    _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _titleLabel.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height * 0.5);
    _titleLabel.layer.cornerRadius = _titleLabel.bounds.size.height / 2.0f;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [[DragDataSource shareInstancetype]isEditing]) {
        return NO;
    }
    return YES;
}

- (void)deleteAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(DragCollectionViewCell:canclefocus:)]) {
        [self.delegate DragCollectionViewCell:self canclefocus:sender];
    }
}

- (void)gestureAtion:(UIGestureRecognizer *)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(DragCollectionViewCell:gestureAction:)]) {
        [self.delegate DragCollectionViewCell:self gestureAction:gesture];
    }
}

@end
