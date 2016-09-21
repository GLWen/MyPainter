//
//  ImageHandleView.h
//  MyPainter
//
//  Created by 温国力 on 16/9/21.
//  Copyright © 2016年 wenguoli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageHandleView : UIView

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) void(^handleCompletionBlock)(UIImage *image);

@property (nonatomic, strong) void(^handleBeginBlock)();

@end
