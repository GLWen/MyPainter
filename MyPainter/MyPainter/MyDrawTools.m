//
//  MyDrawTools.m
//  MyPainter
//
//  Created by 温国力 on 16/9/21.
//  Copyright © 2016年 wenguoli. All rights reserved.
//

#import "MyDrawTools.h"

@implementation MyDrawTools

#pragma mark - 屏幕适配
+ (float)smartScale:(float)width
{
    // 以iphone6s的屏幕宽度作为标准进行适配
    float iphone6sWidth = 375;
    // 缩放比例
    float scale = [UIScreen mainScreen].bounds.size.width / iphone6sWidth;
    
    return scale * width;
}

#pragma mark - 绘制椭圆按钮
+ (void)drawEllipseButton:(UIButton *)button
{
    button.layer.cornerRadius =button.frame.size.height * 0.5;
    button.layer.masksToBounds = YES;
}
#pragma mark - 将二进制数据转换成十六进制字符串(方法1)
+ (NSString *)data2Hex:(NSData *)data {
    if (!data) {
        return nil;
    }
    Byte *bytes = (Byte *)[data bytes];
    NSMutableString *str = [NSMutableString stringWithCapacity:data.length * 2];
    for (int i=0; i < data.length; i++){
        [str appendFormat:@"%0x", bytes[i]];
    }
    return str;
}
#pragma mark - 将二进制数据转换成十六进制字符串（方法2）
+ (NSString *)hexStringFromString:(NSData *)data{
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

@end
