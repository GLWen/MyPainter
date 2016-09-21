//
//  UIImage+MyPainterExtension.h
//  MyPainter
//
//  Created by 温国力 on 16/9/21.
//  Copyright © 2016年 wenguoli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyPainterExtension)



/**
 *  改变图像的尺寸，方便上传服务器
 *
 *  @param image 图片传入
 *
 *  @param size 传入尺寸
 *
 *  @return 返回新图片
 */
+ (UIImage *)scaleFromImage: (UIImage *)image toSize: (CGSize)size;

/**
 *  保持原来的长宽比，生成一个缩略图
 *
 *  @param image 图片传入
 *
 *  @param asize 传入尺寸
 *
 *  @return 返回新图片
 */
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

@end
