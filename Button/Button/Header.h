//
//  Header.h
//  Button
//
//  Created by xiangronghua on 2017/5/26.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define UICOLORRGB(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0]
#define kRedColor UICOLORRGB(223, 63, 66)
#define kBlackColor UICOLORRGB(91, 91, 91)
#define kGrayColor UICOLORRGB(229, 229, 229)
#define kSGrayColor UICOLORRGB(242, 179, 106)

#define kBtnW 120
#define kBtnH 50
#define kBtnMarginX 20
#define kBtnMarginY 30

#define kScreenW [[UIScreen mainScreen]bounds].size.width
#define kScreenH [[UIScreen mainScreen]bounds].size.height

#endif /* Header_h */
