//
//  DragViewController.m
//  Button
//
//  Created by xiangronghua on 2017/5/26.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "DragViewController.h"
#import "Header.h"
#import "DragDataSource.h"
#import "DragCollectionViewCell.h"
#define kCellSpace 10

@interface DragViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DragCollectionViewCellDelegate> {
    
    NSIndexPath *_currentIndexPath;
    NSIndexPath *_nextIndexPath;
    UIImageView *_currentView;
    DragCollectionViewCell *_currentCell;
}
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UIView *backGroundView;

@end

@implementation DragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
        flowLayOut.minimumLineSpacing = kCellSpace;
        flowLayOut.minimumInteritemSpacing = kCellSpace;
        flowLayOut.itemSize = CGSizeMake(80, 35);
        flowLayOut.headerReferenceSize = CGSizeMake(kScreenW, 44);
        flowLayOut.sectionInset = UIEdgeInsetsMake(kCellSpace, kCellSpace, kCellSpace, kCellSpace);
        flowLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) collectionViewLayout:flowLayOut];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[DragCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DragCollectionViewCell class])];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader1"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader0"];
    }
    return _collectionView;
}

- (UIView *)backGroundView {
    if (!_backGroundView) {
        self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH)];
        _backGroundView.backgroundColor = [UIColor whiteColor];
    }
    NSInteger subCount = _backGroundView.subviews.count;
    NSInteger dataCount = _collectionView.visibleCells.count;//[[LLDragDataSource shareInstancetype].dataSource[0] count];
    if (subCount != dataCount) {
        for (UIView *view in _backGroundView.subviews) {
            [view removeFromSuperview];
        }
        for (NSInteger i = 0; i < dataCount; i++) {
            
        }
    }
    return _backGroundView;
}

- (void)layoutBackGroundViewSubview:(UIView *)backGroundView atIndex:(NSInteger)i {
    UILabel *_titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 0, 75, 30);
    _titleLabel.center = _collectionView.visibleCells[i].center;
    _titleLabel.font  = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = kBlackColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = kGrayColor.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = [UIBezierPath bezierPathWithRoundedRect:_titleLabel.bounds cornerRadius:35 / 2].CGPath;
    layer.lineWidth = 1.0f;
    layer.lineDashPattern = @[@4, @2];
    [_titleLabel.layer addSublayer:layer];
    [backGroundView addSubview:_titleLabel];
}

- (UIImage *)creatViewByLongPressCell:(DragCollectionViewCell *)cell {
    cell.hidden = NO;
    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, cell.opaque, 0);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.hidden = YES;
    return image;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [DragDataSource shareInstancetype].isEditing ? 1 : [DragDataSource shareInstancetype].dataSouerce.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[DragDataSource shareInstancetype].dataSouerce[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DragCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DragCollectionViewCell class]) forIndexPath:indexPath];
    [cell setTitleName:[DragDataSource shareInstancetype].dataSouerce[indexPath.section][indexPath.row]];
    [cell setDelegate:self];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader0" forIndexPath:indexPath];
        if (!view.subviews.count) {
            view.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:241 / 255.0 blue:245 / 255.0 alpha:1.0];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 80, 30)];
            label.text = @"切换栏目";
            label.font = [UIFont systemFontOfSize:14];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"排序删除" forState:UIControlStateNormal];
            [button setTitle:@"完成" forState:UIControlStateNormal];
            [button setSelected:[DragDataSource shareInstancetype].isEditing];
            [button setTitleColor:[UIColor colorWithRed:231 / 255.0 green:111 / 255.0 blue:113 / 255.0 alpha:1.0] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.frame = CGRectMake(kScreenW - 120, 9.5, 70, 20);
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 20 / 2.0f;
            button.layer.borderColor = [UIColor colorWithRed:231 / 255.0 green:111 / 255.0 blue:113 / 255.0 alpha:1.0].CGColor;
            button.layer.borderWidth = 0.75f;
            [button addTarget:self action:@selector(sortTheamAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:label];
            [view addSubview:button];
        } else {
            UIButton *button = view.subviews[view.subviews.count - 1];
            [button setSelected:[DragDataSource shareInstancetype].isEditing];
        }
        return view;
    }else{
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader1" forIndexPath:indexPath];
        if (!view.subviews.count) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 130, 30)];
            view.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:241 / 255.0 blue:245 / 255.0 alpha:1.0];
            label.text = @"点击添加更多栏目";
            label.font = [UIFont systemFontOfSize:14];
            [view addSubview:label];
        }
        return view;
    }
}

-(void)sortTheamAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    [DragDataSource shareInstancetype].isEditing = sender.selected;
    _collectionView.scrollEnabled = !sender.selected;
    
    
    [_collectionView reloadData];
    
}

#pragma mark -- DragCollectionViewCellDelegate
- (void)DragCollectionViewCell:(DragCollectionViewCell *)cell canclefocus:(UIButton *)sender {
    NSIndexPath *indexpath = [_collectionView indexPathForCell:cell];
    NSMutableArray *likeData = [DragDataSource shareInstancetype].dataSouerce[0];
    NSMutableArray *recommendData = [DragDataSource shareInstancetype].dataSouerce[1];
    NSString *currentTeam = likeData[indexpath.row];
    [recommendData addObject:currentTeam];
    [likeData removeObjectAtIndex:indexpath.row];
    [_collectionView deleteItemsAtIndexPaths:@[indexpath]];
}

- (void)DragCollectionViewCell:(DragCollectionViewCell *)cell gestureAction:(UIGestureRecognizer *)gesture {
    NSIndexPath *indexpath = [_collectionView indexPathForCell:cell];
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        if (indexpath.section == 1) {
            NSMutableArray *likeData = [DragDataSource shareInstancetype].dataSouerce[0];
            NSMutableArray *recommendData = [DragDataSource shareInstancetype].dataSouerce[1];
            NSString *currentTeam = recommendData[indexpath.row];
            [likeData addObject:currentTeam];
            [recommendData removeObjectAtIndex:indexpath.row];
            [_collectionView moveItemAtIndexPath:indexpath toIndexPath:[NSIndexPath indexPathForRow:likeData.count - 1 inSection:0]];
        }else{
            if ([DragDataSource shareInstancetype].isEditing) {
                return;
            }
            NSLog(@"单击跳转到响应的专题");
        }
        return;
    }
    
    static CGPoint startPoint;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
                [DragDataSource shareInstancetype].isEditing = YES;
                _collectionView.scrollEnabled = NO;
                [_collectionView reloadData];
            }
            
            if (![DragDataSource shareInstancetype].isEditing) {
                return;
            }
            
            for (DragCollectionViewCell *acell in _collectionView.visibleCells) {
                [acell showDeleteButton];
            }
            
            if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
                _currentIndexPath = [_collectionView indexPathForCell:cell];
                //            _currentView = [cell snapshotViewAfterScreenUpdates:YES];
                [self.view  addSubview:self.backGroundView];
                [self.view bringSubviewToFront:_collectionView];
                _currentView = [[UIImageView alloc]init];
                _currentView.backgroundColor = [UIColor whiteColor];
                UIImage *image = [self creatViewByLongPressCell:cell];
                _currentView.image = image;
                CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
                _currentView.frame = frame;
                _currentView.center = cell.center;
                [_collectionView addSubview:_currentView];
                _currentCell = cell;
                startPoint = [gesture locationInView:_collectionView];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            
            if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
                return;
            }
            
            CGFloat tansX = [gesture locationOfTouch:0 inView:_collectionView].x - startPoint.x;
            CGFloat tansY = [gesture locationOfTouch:0 inView:_collectionView].y - startPoint.y;
            
            _currentView.center = CGPointApplyAffineTransform(_currentView.center, CGAffineTransformMakeTranslation(tansX, tansY));
            startPoint = [gesture locationOfTouch:0 inView:_collectionView];
            NSArray *cells = _collectionView.visibleCells;
            for (DragCollectionViewCell *acell in cells) {
                if (_currentIndexPath == [_collectionView indexPathForCell:acell] || [_collectionView indexPathForCell:acell].item == 0) {
                    continue;
                }
                
                CGFloat spaceCVToCell = sqrtf(pow(_currentView.center.x - acell.center.x, 2) + pow(_currentView.center.y - acell.center.y, 2));
                if (spaceCVToCell <= 80 / 2.0 && fabs(_currentView.center.y - acell.center.y) <= 35 * 0.5f) {
                    _nextIndexPath = [_collectionView indexPathForCell:acell];
                    NSMutableArray *likeData = [DragDataSource shareInstancetype].dataSouerce[0];
                    if (_nextIndexPath.item > _currentIndexPath.item) {
                        for (NSUInteger i = _currentIndexPath.item; i < _nextIndexPath.item; i++) {
                            [likeData exchangeObjectAtIndex:i withObjectAtIndex:i+1];
                        }
                    }else{
                        for (NSUInteger i = _currentIndexPath.item; i > _nextIndexPath.item; i--) {
                            [likeData exchangeObjectAtIndex:i withObjectAtIndex:i-1];
                        }
                    }
                    [[DragDataSource shareInstancetype].dataSouerce replaceObjectAtIndex:0 withObject:likeData];
                    [_collectionView moveItemAtIndexPath:_currentIndexPath toIndexPath:_nextIndexPath];
                    _currentIndexPath = _nextIndexPath;
                    break;
                }
            }
            
        }break;
        case UIGestureRecognizerStateEnded :{
            [self.backGroundView removeFromSuperview];
            [_currentView removeFromSuperview];
            _currentCell.hidden = NO;
            
        }break;
        default:
            break;
    }

}
@end
