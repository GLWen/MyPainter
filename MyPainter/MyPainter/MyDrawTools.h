//
//  MyDrawTools.h
//  MyPainter
//
//  Created by 温国力 on 16/9/21.
//  Copyright © 2016年 wenguoli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyDrawTools : NSObject
/**
 *  屏幕适配
 *
 *  @param width 屏幕宽度
 *
 *  @return 返回比例宽度
 */
+ (float)smartScale:(float)width;
/**
 *  绘制椭圆按钮
 *
 *  @param button 传入按钮
 */
+ (void)drawEllipseButton:(UIButton*)button;
/**
 *  将二进制数据转换成十六进制字符串
 *
 *  @param data 二进制数据
 *
 *  @return 十六进制字符串
 */
+ (NSString *)data2Hex:(NSData *)data;
/**
 *  将二进制数据转换成十六进制字符串
 *
 *  @param data 二进制数据
 *
 *  @return 十六进制字符串
 */
+ (NSString *)hexStringFromString:(NSData *)data;

@end
