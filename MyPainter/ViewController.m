//
//  ViewController.m
//  MyPainter
//
//  Created by 温国力 on 16/9/21.
//  Copyright © 2016年 wenguoli. All rights reserved.
//

#import "ViewController.h"
#import "DrawViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@property (nonatomic, strong) UIImage *receiveImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _showImage.image = self.receiveImage;
    
    
}
- (IBAction)clickBtn {
    
    DrawViewController *drawVC = [[DrawViewController alloc]init];
    drawVC.drawImageBlock = ^(UIImage *image){
        
        self.receiveImage = image;
    };
    drawVC.drawImageDataBlock = ^(NSData *data){
        NSLog(@"获取到图片二进制：%@",data);
    };
    drawVC.drawImageDataStrBlock = ^(NSString *dataStr){
        
        NSLog(@"获取到图片十六进制字符串：%@",dataStr);
        
    };
    [self.navigationController pushViewController:drawVC animated:YES];
    
    
}



@end
