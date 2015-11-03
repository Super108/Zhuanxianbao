//
//  WebsiteViewController.m
//  ZhuanXB
//
//  Created by 康冬 on 15/6/10.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import "WebsiteViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "webDetail.h"

#import "WebViewController.h"

@interface WebsiteViewController ()
<BMKMapViewDelegate>
{
    BMKMapView* _mapView;
    BMKLocationService* _locService;
    UISlider *_faderSlider;
    int value;
    UIButton *plusBtn;
    UIButton *minusBtn;
    webDetail *_web;
}
@end

@implementation WebsiteViewController

//- (void) viewDidAppear:(BOOL)animated {
//    
//    _activity  = [[Activity alloc] initWithActivity:self.view];
//    
//    [self getInfoHttp];
//    
//    if (_allArry.count==0) {
//        
//        [self createNoView];
//        
//    }else
//    {
//        [_noInfoView removeFromSuperview];
//        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height)];
//        self.view = _mapView;
//        _mapView.delegate = self;
//        //设置地图缩放级别
//        [_mapView setZoomLevel:10];
//        [_locService startUserLocationService];
//        _mapView.showsUserLocation = NO;//先关闭显示的定位图层
//        _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
//        _mapView.showsUserLocation = YES;//显示定位图层
//
//        
//        for (int i=0; i<_allArry.count; i++) {
//            
//            webDetail *web  = [_allArry objectAtIndex:i];
//    
//            //如果经纬度为空 什么都不做
//            if ([web.longitude isKindOfClass:[NSNull class]]||[web.dimensions isKindOfClass:[NSNull class]]) {
//                
//            }else
//            {
//                // 添加一个PointAnnotation
//                BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//                CLLocationCoordinate2D coor;
////                        NSLog(@"%f",[web.dimensions floatValue]);
////                        NSLog(@"%f",[web.longitude floatValue]);
//                
//                coor.latitude = [web.longitude floatValue];
//                coor.longitude = [web.dimensions floatValue];
//                annotation.title = web.name;
////                annotation.subtitle = web.memo;
//                [_mapView setCenterCoordinate:coor animated:NO];
//                
//                annotation.coordinate = coor;
//                
//                [_mapView addAnnotation:annotation];
//                [_mapView selectAnnotation:annotation animated:YES];
//            }
//            
//        }
//
//    }
//    
//    
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"专线宝网点";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //添加右边的添加按钮
    UIButton *navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
    [navRightButton setBackgroundImage:[UIImage imageNamed:@"home640.png"] forState:UIControlStateNormal];
    [navRightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView: navRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    if([UIDevice currentDevice].systemVersion.floatValue >= 7.0f){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -7.5;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    }
    else{
        self.navigationItem.rightBarButtonItem = rightItem;
    }

    
    _allArry = [[NSMutableArray alloc] initWithCapacity:0];
    
    _activity = [[Activity alloc] initWithActivity:self.view];

    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    NSLog(@"%@",timeString);
    
    //请求接口
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:appID, @"appId",timeString, @"time",nil];
    NSLog(@"%@",dic);
    NSString * allStr= @"";
    
    //排序key
    NSArray* keyArr = [dic allKeys];
    keyArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    //    NSLog(@"%@",keyArr);
    
    for (int i=0; i<=1; i++)
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
    
    
    NSString *param=[NSString stringWithFormat:@"appId=%@&time=%@&sign=%@",appID,timeString,sign];
    NSURL *URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@/shipper/branch/allbranch?%@",ZhuanXB_address,param]];//不需要传递参数
    
    NSLog(@"%@",URL);
    
    //直接用网页打开就行了
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    webView.delegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:URL];
    [self.view addSubview: webView];
    [webView loadRequest:request];
   
    
    
    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    
//    _faderSlider = [[UISlider alloc] initWithFrame:CGRectMake(220, self.view.frame.size.height-120, 150, 10)];
//    _faderSlider.minimumValue  = 6;
//    _faderSlider.maximumValue = 19;
//    _faderSlider.backgroundColor = [UIColor blackColor];
//    [window addSubview:_faderSlider];
//    
//    
//    [self faderSliderInit];
    
//    //添加加号
//    plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    plusBtn.frame = CGRectMake(self.view.frame.size.width-10-40, self.view.frame.size.height-150-40, 40, 40);
//    plusBtn.backgroundColor = [UIColor redColor];
//    [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [window addSubview:plusBtn];
//    
//    //添加减号
//    minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    minusBtn.frame = CGRectMake(plusBtn.frame.origin.x, self.view.frame.size.height-10-40, 40, 40);
//    minusBtn.backgroundColor = [UIColor redColor];
//    [minusBtn addTarget:self action:@selector(minusBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [window addSubview:minusBtn];
//    
//    value = (int)[_faderSlider value];
    
}

- (void )webViewDidStartLoad:(UIWebView  *)webView
{
    
    [_activity start];
    
    
}
- (void )webViewDidFinishLoad:(UIWebView  *)webView
{
    
    [_activity stop];
    
    
}

- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error
{
    
    
    [_activity stop];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
    
}

//-(void)viewWillDisappear:(BOOL)animated
//{
//    [_faderSlider removeFromSuperview];
//    [plusBtn removeFromSuperview];
//    [minusBtn removeFromSuperview];
//}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
    
//    // 生成重用标示identifier
//    NSString *AnnotationViewID = @"xidanMark";
//    
//    // 检查是否有重用的缓存
//    BMKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//    
//    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
//    if (annotationView == nil) {
//        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
//        // 设置重天上掉下的效果(annotation)
//        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
//    }
//    
//    // 设置位置
//    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
//    annotationView.annotation = annotation;
//    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
//    annotationView.canShowCallout = YES;
//    // 设置是否可以拖拽
//    annotationView.draggable = NO;
//    
//     return annotationView;
}

-(void)getInfoHttp
{
    [_activity start];
    
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    NSLog(@"%@",timeString);
    
    //请求接口
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:appID, @"appId",timeString, @"time",nil];
    NSLog(@"%@",dic);
    NSString * allStr= @"";
    
    //排序key
    NSArray* keyArr = [dic allKeys];
    keyArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    //    NSLog(@"%@",keyArr);
    
    for (int i=0; i<=1; i++)
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
    
    
    NSString *param=[NSString stringWithFormat:@"appId=%@&time=%@&sign=%@",appID,timeString,sign];
    NSURL *URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@/shipper/branch/allbranch?%@",ZhuanXB_address,param]];//不需要传递参数
    
    NSLog(@"%@",URL);
    
    //直接用网页打开就行了
    
    
    WebViewController *webView=[[WebViewController alloc] init];
    //        NSLog(@"%@",_htmlArray);
    
    webView.url=[NSString stringWithFormat:@"%@/shipper/waybill/viewroute?%@",ZhuanXB_address,param];
    webView.name = @"线路运价";
    [self.navigationController pushViewController:webView animated:YES];
    
//    
//    //第二步，创建请求
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    request.HTTPMethod=@"POST";//设置请求方法
//    
//    //第三步，连接服务器
//    
//    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//    
////    NSLog(@"%@",connection);
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSLog(@"%@",received);
//    if (received==nil) {
//        [_activity stop];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络断了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        
//        [self createNoView];
//        [alert show];
//    }else
//    {
//        NSError *error1=nil;
//        id result1 =[NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error1];
//        NSLog(@"%@",result1);
//        if (result1==nil) {
//            [_activity stop];
//            return;
//        }else
//        {
//            if ([[result1 objectForKey:@"code"]isEqualToString:@"1"]) {//正确
//                NSArray *arr = [result1 objectForKey:@"value"];
//                //            NSLog(@"arrarrarrararararararar%@",arr);
//                //判断数组是否存在
//                if([[result1 objectForKey:@"value"] isKindOfClass:[NSNull class]])
//                {
//                    [self createNoView];
//                    
//                }else
//                {
//                    for (int i =0; i<arr.count;i++) {
//                        NSMutableDictionary *detailDic = [arr objectAtIndex:i];
//                        _web = [[webDetail alloc] init];
//                        _web.name = [detailDic objectForKey:@"name"];
//                        //                    _web.memo = [detailDic objectForKey:@"memo"];
//                        _web.longitude = [detailDic objectForKey:@"longitude"];
//                        _web.dimensions = [detailDic objectForKey:@"dimensions"];
//                        
//                        [_allArry addObject:_web];
//                    }
//                    
//                }
//                //            [_activity stop];
//            }
//            
//            else if ([[result1 objectForKey:@"code"]isEqualToString:@"0"])
//            {
//                [_activity stop];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务端异常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [alert show];
//                
//            }else if ([[result1 objectForKey:@"code"]isEqualToString:@"100"])
//            {
//                [_activity stop];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"非法请求" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [alert show];
//                
//                
//            }else if ([[result1 objectForKey:@"code"]isEqualToString:@"101"])
//            {
//                [_activity stop];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"非法请求" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [alert show];
//                
//            }else if ([[result1 objectForKey:@"code"]isEqualToString:@"102"])
//            {
//                [_activity stop];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [alert show];
//            }else if ([[result1 objectForKey:@"code"]isEqualToString:@"103"])//记录不存在
//            {
//                [_activity stop];
//                [self createNoView];
//                
//            }
//            
//        }
// 
//    }
//    
//    
    
}



-(void)rightBtnClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoveToMain" object:nil];
}

-(void)plusBtnClick
{
   
    if (value==19) {
        //设置地图缩放级别
        [_mapView setZoomLevel:19];
    }else
    {
        value++;
        NSLog(@"<><><><><><>%d",value);
        _faderSlider.value = value;
        
        //设置地图缩放级别
        [_mapView setZoomLevel:value];
    }
   
    
}
-(void)minusBtnClick
{
   
    if (value==3) {
        //设置地图缩放级别
        [_mapView setZoomLevel:3];
    }else
    {
        value--;
        _faderSlider.value = value;
        NSLog(@"<><><><><><>%d",value);
        //设置地图缩放级别
        [_mapView setZoomLevel:value];
       
    }
}

-(void)createNoView
{
    _noInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _noInfoView.backgroundColor = ZhuanXB_color(0xe3e6ea);
    [self.view addSubview:_noInfoView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_noInfoView.frame.size.width/2-236/4, 60, 236/2, 220/2)];
    imageView.image = [UIImage imageNamed:@"运单列表_无数据.png"];
    [_noInfoView addSubview:imageView];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height+imageView.frame.origin.y+10, 320, 30)];
    aLabel.text = @"暂时没有找到相关数据";
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.font = [UIFont systemFontOfSize:18.0];
    aLabel.textColor = ZhuanXB_color(0x78848d);
    [_noInfoView addSubview:aLabel];

}

#pragma mark -
#pragma mark FaderSlider init and action listner

- (void)faderSliderInit {
    
    //Init Fader slider UI, set listener method and Transform it to vertical
    [_faderSlider addTarget:self action:@selector(faderSliderAction:) forControlEvents:UIControlEventValueChanged];
    _faderSlider.backgroundColor = [UIColor clearColor];
    UIImage *stetchTrack = [[UIImage imageNamed:@"faderTrack.png"]
                            stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    [_faderSlider setThumbImage: [UIImage imageNamed:@"faderKey.png"] forState:UIControlStateNormal];
    [_faderSlider setMinimumTrackImage:stetchTrack forState:UIControlStateNormal];
    [_faderSlider setMaximumTrackImage:stetchTrack forState:UIControlStateNormal];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * -0.5);
    _faderSlider.transform = trans;
    
}

- (void)faderSliderAction:(id)sender
{
    // UISlider *slider = (UISlider *)sender;
    
    NSLog(@">>>>>%d",(int)[_faderSlider value]);
    //设置地图缩放级别
    [_mapView setZoomLevel:(int)[_faderSlider value]];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
