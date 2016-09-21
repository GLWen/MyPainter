//
//  DrawViewController.m
//  MyPainter
//
//  Created by 温国力 on 16/9/21.
//  Copyright © 2016年 wenguoli. All rights reserved.
//
//调试、发布
#ifdef DEBUG
#define GlLog(...) NSLog(__VA_ARGS__)
#else
#define GlLog(...)
#endif
#define GlLogFunc GlLog(@"%s", __func__);


#import "DrawViewController.h"
#import "MyDrawTools.h"
#import "ImageHandleView.h"
#import "DrawView.h"
#import "UIImage+MyPainterExtension.h"

#define smt(width) ([MyDrawTools smartScale:width])//屏幕适配
#define GlFont(x) [UIFont systemFontOfSize:smt(x)]//字体适配



@interface DrawViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) DrawView *drawView;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    
    
}
#pragma amrk - 设置界面
- (void)setupUI
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"个性签名";
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.backgroundColor = [UIColor redColor];
    [clearBtn setTitle:@"清屏" forState:UIControlStateNormal];
    clearBtn.titleLabel.font = GlFont(18);
    [self.view addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(clickClearBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *undoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    undoBtn.backgroundColor = [UIColor orangeColor];
    [undoBtn setTitle:@"撤回" forState:UIControlStateNormal];
    undoBtn.titleLabel.font = GlFont(18);
    [self.view addSubview:undoBtn];
    [undoBtn addTarget:self action:@selector(clickUndoBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *eraserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eraserBtn.backgroundColor = [UIColor redColor];
    [eraserBtn setTitle:@"橡皮擦" forState:UIControlStateNormal];
    eraserBtn.titleLabel.font = GlFont(18);
    [self.view addSubview:eraserBtn];
    [eraserBtn addTarget:self action:@selector(clickEraserBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = [UIColor orangeColor];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = GlFont(18);
    [self.view addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(clickSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UISlider *slider = [[UISlider alloc] init];
    slider.backgroundColor = [UIColor lightGrayColor];
    slider.value = 1;
    slider.minimumValue = 1;
    slider.maximumValue = 15;
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *pencilBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pencilBtn.backgroundColor = [UIColor blackColor];
    [pencilBtn setTitle:@"画笔" forState:UIControlStateNormal];
    [pencilBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pencilBtn.titleLabel.font = GlFont(12);
    pencilBtn.frame = CGRectMake(0, 0, smt(30), smt(30));
    [MyDrawTools drawEllipseButton:pencilBtn];
    [self.view addSubview:pencilBtn];
    [pencilBtn addTarget:self action:@selector(clickPencilBtn) forControlEvents:UIControlEventTouchUpInside];
    
    DrawView *drawView = [[DrawView alloc]init];
    drawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drawView];
    self.drawView = drawView;
    
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width/4;
    
    clearBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *clearBtnH = [NSLayoutConstraint constraintWithItem:clearBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:44];
    [clearBtn addConstraint:clearBtnH];
    NSLayoutConstraint *clearBtnW = [NSLayoutConstraint constraintWithItem:clearBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:screenW];
    [clearBtn addConstraint:clearBtnW];
    NSLayoutConstraint *clearBtnL = [NSLayoutConstraint constraintWithItem:clearBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.view addConstraint:clearBtnL];
    NSLayoutConstraint *clearBtnB = [NSLayoutConstraint constraintWithItem:clearBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.view addConstraint:clearBtnB];
    
    
    undoBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *undoBtnH = [NSLayoutConstraint constraintWithItem:undoBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:44];
    [undoBtn addConstraint:undoBtnH];
    NSLayoutConstraint *undoBtnW = [NSLayoutConstraint constraintWithItem:undoBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:screenW];
    [undoBtn addConstraint:undoBtnW];
    NSLayoutConstraint *undoBtnL = [NSLayoutConstraint constraintWithItem:undoBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:clearBtn attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:undoBtnL];
    NSLayoutConstraint *undoBtnY = [NSLayoutConstraint constraintWithItem:undoBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:clearBtn attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:undoBtnY];
    
    eraserBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *eraserBtnH = [NSLayoutConstraint constraintWithItem:eraserBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:44];
    [eraserBtn addConstraint:eraserBtnH];
    NSLayoutConstraint *eraserBtnW = [NSLayoutConstraint constraintWithItem:eraserBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:screenW];
    [eraserBtn addConstraint:eraserBtnW];
    NSLayoutConstraint *eraserBtnL = [NSLayoutConstraint constraintWithItem:eraserBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:undoBtn attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:eraserBtnL];
    NSLayoutConstraint *eraserBtnY = [NSLayoutConstraint constraintWithItem:eraserBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:undoBtn attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:eraserBtnY];
    
    saveBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *saveBtnH = [NSLayoutConstraint constraintWithItem:saveBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:44];
    [saveBtn addConstraint:saveBtnH];
    NSLayoutConstraint *saveBtnW = [NSLayoutConstraint constraintWithItem:saveBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:screenW];
    [saveBtn addConstraint:saveBtnW];
    NSLayoutConstraint *saveBtnL = [NSLayoutConstraint constraintWithItem:saveBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:eraserBtn attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:saveBtnL];
    NSLayoutConstraint *saveBtnY = [NSLayoutConstraint constraintWithItem:saveBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:eraserBtn attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:saveBtnY];
    
    
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *sliderH = [NSLayoutConstraint constraintWithItem:slider attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:30];
    [slider addConstraint:sliderH];
    NSLayoutConstraint *sliderR = [NSLayoutConstraint constraintWithItem:slider attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20];
    [self.view addConstraint:sliderR];
    NSLayoutConstraint *sliderL = [NSLayoutConstraint constraintWithItem:slider attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    [self.view addConstraint:sliderL];
    NSLayoutConstraint *sliderB = [NSLayoutConstraint constraintWithItem:slider attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:clearBtn attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10];
    [self.view addConstraint:sliderB];
    
    pencilBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *pencilBtnH = [NSLayoutConstraint constraintWithItem:pencilBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:smt(30)];
    [pencilBtn addConstraint:pencilBtnH];
    NSLayoutConstraint *pencilBtnW = [NSLayoutConstraint constraintWithItem:pencilBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:smt(30)];
    [pencilBtn addConstraint:pencilBtnW];
    NSLayoutConstraint *pencilBtnL = [NSLayoutConstraint constraintWithItem:pencilBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    [self.view addConstraint:pencilBtnL];
    NSLayoutConstraint *pencilBtnT = [NSLayoutConstraint constraintWithItem:pencilBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:84];
    [self.view addConstraint:pencilBtnT];
    
    drawView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *drawViewH = [NSLayoutConstraint constraintWithItem:drawView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:self.view.bounds.size.height*0.4];
    [drawView addConstraint:drawViewH];
    NSLayoutConstraint *drawViewW = [NSLayoutConstraint constraintWithItem:drawView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:self.view.bounds.size.width];
    [drawView addConstraint:drawViewW];
    NSLayoutConstraint *drawViewX = [NSLayoutConstraint constraintWithItem:drawView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:drawViewX];
    NSLayoutConstraint *drawViewY = [NSLayoutConstraint constraintWithItem:drawView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:drawViewY];
    
    
}

#pragma mark - valueChange
- (void)sliderValueChange:(UISlider *)sender {
    // 给画板传递线宽
    _drawView.lineWidth = sender.value;
    
}
#pragma mark - clickPencilBtn
- (void)clickPencilBtn
{
    _drawView.pathColor = [UIColor blackColor];
}
#pragma mark - clickClearBtn
- (void)clickClearBtn
{
    [_drawView clear];
}
#pragma mark - clickUndoBtn
- (void)clickUndoBtn
{
    [_drawView undo];
}
#pragma mark - clickEraserBtn
- (void)clickEraserBtn
{
    _drawView.pathColor = [UIColor whiteColor];
}
#pragma mark - clickSaveBtn
- (void)clickSaveBtn
{
    // 截屏
    UIGraphicsBeginImageContextWithOptions(_drawView.bounds.size, NO, 0);// 开启上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();// 获取上下文
    [_drawView.layer renderInContext:ctx];// 渲染图层
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//获取上下文中的图片
    UIGraphicsEndImageContext();// 关闭上下文
    
    //方案一：保存画板的内容放入相册
    // 注意：以后写入相册方法中，想要监听图片有没有保存完成，保存完成的方法不能随意乱写
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
    //方案二：存入沙盒
    //0.记录传入文件的是否存在
    BOOL success;
    NSError *error;
    //1.创建文件路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [cachesDirectory stringByAppendingPathComponent:@"drawImage.png"];
    GlLog(@"imageFile->>%@",imageFilePath);
    //2.如果存在就移除，重新添加
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //3.对图片进行压缩为500*500
    UIImage *smallImage = [UIImage thumbnailWithImageWithoutScale:image size:CGSizeMake(500, 500)];
    //UIImagePNGRepresentation 存储PNG的图片
    //UIImageJPEGRepresentation 存储JEPG的图片，可设置图片质量
    [UIImagePNGRepresentation(smallImage) writeToFile:imageFilePath atomically:YES];
    //4.写入文件
    UIImage *drawImage = [UIImage imageWithContentsOfFile:imageFilePath];
    //5.回调出去
    if (_drawImageBlock != nil) {
        _drawImageBlock(drawImage);
    }
    //方案三： 将保存图片二进制回传出去
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    if (_drawImageDataBlock != nil) {
        _drawImageDataBlock(data);
    }
    
    
    //方案四：将图片压缩成二进制再转十六进制字符串
    NSString *dataStr = [MyDrawTools data2Hex:data];
    if (_drawImageDataStrBlock != nil) {
        _drawImageDataStrBlock(dataStr);
    }
    
    //保存完成回上个界面
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 保存到相册, 监听保存完成，必须实现这个方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    GlLog(@"保存图片成功");
    
    
}


@end
