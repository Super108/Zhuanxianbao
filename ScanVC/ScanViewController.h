//
//  ScanViewController.h
//  ZhuanXB
//
//  Created by shanchen on 15/6/11.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
@interface ScanViewController : UIViewController
<AVCaptureMetadataOutputObjectsDelegate>
{
    UIImageView * _imageView;
    UIImageView *_backImageView;
    int num;
    BOOL upOrdown;
    BOOL _hasScan;
    NSTimer * timer;
    UILabel * _labIntroudction;
}

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property(retain,nonatomic)AVCaptureSession *session;
@property(retain,nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property(retain,nonatomic)UIImageView *line;


@end
