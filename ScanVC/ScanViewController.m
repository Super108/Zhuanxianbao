//
//  ScanViewController.m
//  ZhuanXB
//
//  Created by shanchen on 15/6/11.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import "ScanViewController.h"
#import "TrackingViewController.h"
#import "WebViewController.h"

@interface ScanViewController ()

@end

static NSString *backImageName = @"返回.png";
static NSString *passImageName = @"返回.png";

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"扫一扫"];
    self.view.backgroundColor = [UIColor whiteColor];
    
  
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self ShowZBarView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.previewLayer removeFromSuperlayer];
    [self performSelector:@selector(setObjectNil) withObject:nil afterDelay:0.3 ];
   
        [super viewWillDisappear:YES];
        [self.previewLayer removeFromSuperlayer];
        self.previewLayer = nil;
        self.session = nil;
        self.input = nil;
        self.output = nil;
        self.device = nil;
    
}
-(void)setObjectNil
{
    self.previewLayer = nil;
    self.session = nil;
}
-(void)ShowZBarView{
    
    //使用系统自带的二维码扫描
    [self readQRcode];
    
    
}
-(void)readQRcode
{
    
    //    NSLog(@"imageview frame original y is %f",_imageView.frame.origin.y);
    
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2 , (self.view.frame.size.height-64)/2-100 , 200, 200)];
    
    _imageView.image = [UIImage imageNamed:@"二维码框.png"];
    [self.view addSubview:_imageView];
    
    if (iPhone4)
    {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -108, self.view.frame.size.width, 568)];
        _backImageView.image = [UIImage imageNamed:@"二维码黑色背景"];
        [self.view addSubview:_backImageView];
        
    }
    else if(iPhone5)
    {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, 568)];
        _backImageView.image = [UIImage imageNamed:@"二维码黑色背景"];
        [self.view addSubview:_backImageView];
        
    }else if (iPhone6)
    {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, 667)];
        _backImageView.image = [UIImage imageNamed:@"二维码黑色背景-6"];
        [self.view addSubview:_backImageView];
    }
    else if(iPhone6Plus)
    {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, 736)];
        _backImageView.image = [UIImage imageNamed:@"二维码黑色背景"];
        [self.view addSubview:_backImageView];
    }else
    {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _imageView.frame.origin.y + 100 - 568/2, self.view.frame.size.width, 568)];
        _backImageView.image = [UIImage imageNamed:@"二维码黑色背景"];
        [self.view addSubview:_backImageView];
        
    }
    
    
    
    _labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake((_backImageView.frame.size.width-260)/2, _imageView.frame.origin.y + 205 + 10-20, 260, 50)];
    _labIntroudction.backgroundColor = [UIColor clearColor];
    _labIntroudction.textAlignment=YES;
    _labIntroudction.numberOfLines=1;
    _labIntroudction.textColor= ZhuanXB_color(0xffffff);
    _labIntroudction.text=@"专线宝运单条形码";
    _labIntroudction.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:_labIntroudction];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, _imageView.frame.origin.y+30, 200, 2)];
    _line.image = [UIImage imageNamed:@"光线.png"];
    [self.view addSubview:_line];
    
    
    
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if (error)
    {
        UIAlertView *cameraInvaliableAlert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"相机功能不可用，请选择 设置>隐私>相机>爱家保 开启设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        cameraInvaliableAlert.tag = 4321;
        [cameraInvaliableAlert show];
        return;
    }
    self.output = [[AVCaptureMetadataOutput alloc] init];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc] init];
    
    [self.session addInput:self.input];
    
    [self.session addOutput:self.output];
    
    
//    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code]];
    // 条码类型 AVMetadataObjectTypeQRCode
    if ([self.output.availableMetadataObjectTypes containsObject:
         AVMetadataObjectTypeQRCode]||
        [self.output.availableMetadataObjectTypes containsObject:
         AVMetadataObjectTypeCode128Code]) {
            self.output.metadataObjectTypes =[NSArray arrayWithObjects:
                                              AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, nil];
        }
    
    NSLog(@"%@",self.output.metadataObjectTypes);
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    NSLog(@"self.view height and width are %f,%f",self.view.frame.size.width,self.view.frame.size.height);
    
    
    
    
    self.previewLayer.frame =CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    
    [self.view.layer insertSublayer:self.previewLayer atIndex:1];
    
    
    [self.session startRunning];
    
    
    
    
    
    
}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    
    [self.session stopRunning];
    [self.previewLayer removeFromSuperlayer];
    [_imageView removeFromSuperview];
    [_labIntroudction removeFromSuperview];
    [_line removeFromSuperview];
    [_backImageView removeFromSuperview];
    [timer invalidate];
    self.previewLayer = nil;
    self.session = nil;
    self.input = nil;
    self.output = nil;
    self.device = nil;
    
    
    if (metadataObjects.count > 0)
    {
        _hasScan = YES;
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        [self ShowNextSetting:obj.stringValue];
        
    }
    
}
-(void)ShowNextSetting:(NSString *)deviceID{
    
    if ([deviceID isEqualToString:@""]) {
        UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:[[UIApplication sharedApplication].windows count]-1];
        MBProgressHUD *indicator = [[MBProgressHUD alloc] initWithWindow:window];
        indicator.labelText = @"扫码失败";
        indicator.mode = MBProgressHUDModeText;
        [window addSubview:indicator];
        [indicator showAnimated:YES whileExecutingBlock:^{
            sleep(1.2);
        } completionBlock:^{
            [indicator removeFromSuperview];
        }];

    }else
    {
//        TrackingViewController *trackVC = [[TrackingViewController alloc] init];
//        
//        trackVC.snString = deviceID;
//        
//        [self.navigationController pushViewController:trackVC animated:NO];
        //获取系统当前的时间戳
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970]*1000;
        NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
        NSLog(@"%@",timeString);
        
        //请求接口
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:appID, @"appId",deviceID, @"sn",timeString, @"time",nil];
        NSLog(@"%@",dic);
        NSString * allStr= @"";
        
        //排序key
        NSArray* keyArr = [dic allKeys];
        keyArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            NSComparisonResult result = [obj1 compare:obj2];
            return result==NSOrderedDescending;
        }];
        
        //    NSLog(@"%@",keyArr);
        
        for (int i=0; i<=2; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%@",[keyArr objectAtIndex:i]];
            NSLog(@"%@",str);
            allStr = [NSString stringWithFormat:@"%@%@=%@",allStr,[keyArr objectAtIndex:i],[dic objectForKey:[keyArr objectAtIndex:i]]];
        }
        NSLog(@"%@",allStr);
        NSString *resultStr = [NSString stringWithFormat:@"%@%@",allStr,secretKey];
        NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                        NULL,
                                                                                                        (CFStringRef)resultStr,
                                                                                                        NULL,
                                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                        kCFStringEncodingUTF8 ));
        
        NSLog(@"%@",encodedString);
        NSString *sign = [encodedString MD5];
        
        
        NSString *param=[NSString stringWithFormat:@"appId=%@&sn=%@&time=%@&sign=%@",appID,deviceID,timeString,sign];
        NSURL *URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@/shipper/waybill/viewwaybill?%@",ZhuanXB_address,param]];//不需要传递参数
        
        NSLog(@"%@",URL);
        
        //直接用网页打开就行了
        
        
        WebViewController *webView=[[WebViewController alloc] init];
        //        NSLog(@"%@",_htmlArray);
        
        webView.url=[NSString stringWithFormat:@"%@/shipper/waybill/viewwaybill?%@",ZhuanXB_address,param];
        webView.name = @"货物跟踪";
        [self.navigationController pushViewController:webView animated:YES];

        
    }
    
   
    
    
}
- (void)animation:(UIImageView *)view
{   //扫描框内动画
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        view.frame = CGRectMake(60, CGRectGetMidY(view.superview.frame)-126+200-10, 200, 10) ;
    } completion:^(BOOL finished) {
        
    }];
}
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}

-(void)animation1
{
    if (upOrdown == NO)
    {
        num ++;
        _line.frame = CGRectMake((self.view.frame.size.width-200)/2, _imageView.frame.origin.y + 2*num, 200, 2);
        if (2*num == 200)
        {
            upOrdown = YES;
        }
    }
    else
    {
        num --;
        _line.frame = CGRectMake((self.view.frame.size.width-200)/2,  _imageView.frame.origin.y + 2*num, 200, 2);
        if (num == 0)
        {
            upOrdown = NO;
        }
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
