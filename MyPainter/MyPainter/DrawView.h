//
//  DrawView.h
//  MyPainter
//
//  Created by 温国力 on 16/9/21.
//  Copyright © 2016年 wenguoli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView


@property (nonatomic, strong) UIColor *pathColor;
@property (nonatomic, assign) NSInteger lineWidth;


@property (nonatomic, strong) UIImage *image;

// 清屏
- (void)clear;

// 撤销
- (void)undo;

@end
