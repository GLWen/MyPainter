//
//  DrawViewController.h
//  MyPainter
//
//  Created by 温国力 on 16/9/21.
//  Copyright © 2016年 wenguoli. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DrawImageBlock) (UIImage* drawImage);
typedef void (^DrawImageDataStrBlock) (NSString* drawImageDataStr);
typedef void (^DrawImageDataBlock) (NSData* drawImageData);
@interface DrawViewController : UIViewController

/**
 *  将保存图片回传出去
 *
 */
@property(strong,nonatomic) DrawImageBlock drawImageBlock;
/**
 *  将保存图片二进制回传出去
 *
 */
@property(strong,nonatomic) DrawImageDataBlock drawImageDataBlock;
/**
 *  将保存图片二进制再转十六进制再回传出去
 *
 */
@property(strong,nonatomic) DrawImageDataStrBlock drawImageDataStrBlock;


@end
