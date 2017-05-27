//
//  ViewController.m
//  Button
//
//  Created by xiangronghua on 2017/5/26.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "ViewController.h"
#import "DragViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)touchButtonEvent {
    DragViewController *controller = [[DragViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
