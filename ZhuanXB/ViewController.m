//
//  ViewController.m
//  ZhuanXB
//
//  Created by shanchen on 15/6/10.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import "ViewController.h"
#import "PriceViewController.h"
#import "WebsiteViewController.h"
#import "SendProductVC.h"
#import "InquireViewController.h"

#import "FMDatabase.h"
#import "FMDBTools.h"

#import "LoginViewController.h"
#import "SendProductVC.h"
#import "ZSAppServer.h"
#import "PersonalCenterVC.h"
#import "ValuationToolsVC.h"

#import "BannerVC.h"
@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = ZhuanXB_color(0xe6ebf0);
    
    //导航栏中间图片
    UIImageView *topImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 233/2, 55/2)];
    topImgeView.contentMode = UIViewContentModeScaleAspectFit;//设置内容样式,通过保持长宽比缩放内容适应视图的大小,任何剩余的区域的视图的界限是透明的。
    topImgeView.image = [UIImage imageNamed:@"专线宝.png"];
    self.navigationItem.titleView =topImgeView;
    
    //    //广告位
    //    _Topic = [[JCTopic alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 144)];
    //    _Topic.JCdelegate = self;
    //
    //    [self.view addSubview:_Topic];
    //
    //    //pagecontrol 的初始化
    //
    //    _myPageControl= [[UIPageControl alloc] initWithFrame:CGRectMake(0,_Topic.frame.size.height-20, 320, 20)];
    //    _myPageControl.currentPage=0;
    //    [self.view addSubview:_myPageControl];
    //公告
//    UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 288/2)];
//    adImageView.image = [UIImage imageNamed:@"banner.png"];
//    [self.view addSubview:adImageView];
    _bannerScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 288/2)];
    _bannerScrollView.pagingEnabled = YES;
    _bannerScrollView.delegate = self;
    _bannerScrollView.showsHorizontalScrollIndicator = NO;
    _bannerScrollView.showsVerticalScrollIndicator = NO;
    _bannerScrollView.contentSize=CGSizeMake(_bannerScrollView.bounds.size.width, _bannerScrollView.bounds.size.height);
    [self.view addSubview:_bannerScrollView];
    
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 288/2-30-5, self.view.bounds.size.width, 30)];  //创建UIPageControl，位置在屏幕最下方。
//    _pageCtrl.numberOfPages = 6;//总的图片页数
    _pageCtrl.currentPage = 0; //当前页
    [self.view addSubview:_pageCtrl];
    //菊花
    _activity = [[Activity alloc] initWithActivity:self.view];
    
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(11, _bannerScrollView.frame.size.height+11, self.view.frame.size.width-22, self.view.frame.size.height-_bannerScrollView.frame.size.height+1)];
    [scrollView setShowsVerticalScrollIndicator:YES];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width-22, 568-_bannerScrollView.frame.size.height);
    [self.view addSubview:scrollView];
    if (iPhone5||iPhone6||iPhone6Plus) {
        scrollView.scrollEnabled = NO;
    }else{
        scrollView.scrollEnabled = YES;
    }
    UIImageView *btnView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-22, 680/2)];
    btnView.image = [UIImage imageNamed:@"首页按钮iosNew.png"];
    btnView.userInteractionEnabled = YES;
    [scrollView addSubview:btnView];
    //线路运价
    UIButton *topBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn1.backgroundColor =[UIColor clearColor];
    topBtn1.tag = 111;
    topBtn1.frame = CGRectMake(0, 0, 298/2-2, 80+1);
    [topBtn1 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:topBtn1];
    // 运单查询
    UIButton *topBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn2.backgroundColor =[UIColor clearColor];
    topBtn2.tag = 222;
    topBtn2.frame = CGRectMake(topBtn1.frame.size.width+10/2, 0, 296/2-2, 80+1);
    [topBtn2 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:topBtn2];
    //专线宝网点
    UIButton *topBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn3.backgroundColor =[UIColor clearColor];
    topBtn3.tag = 333;
    topBtn3.frame = CGRectMake(topBtn2.frame.origin.x, topBtn2.frame.size.height+13/2, topBtn1.frame.size.width, 81);
    [topBtn3 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:topBtn3];
    //        我要发货
    UIButton *sendProductBut = [UIButton buttonWithType:UIButtonTypeCustom];
    sendProductBut.backgroundColor =[UIColor clearColor];
    sendProductBut.tag = 555;
    sendProductBut.frame = CGRectMake(topBtn1.frame.origin.x, topBtn1.frame.size.height+13/2, topBtn1.frame.size.width, 150+15+2);
    [sendProductBut addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:sendProductBut];
    
    //客服
    UIButton *topBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn4.backgroundColor =[UIColor clearColor];
    topBtn4.tag = 444;
    topBtn4.frame = CGRectMake(sendProductBut.frame.origin.x,sendProductBut.frame.origin.y + sendProductBut.frame.size.height + 5, topBtn1.frame.size.width, 81);
    [topBtn4 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:topBtn4];
    
    //个人中心
    UIButton *topBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn5.backgroundColor =[UIColor clearColor];
    topBtn5.tag = 666;
    topBtn5.frame = CGRectMake(topBtn3.frame.origin.x, topBtn3.frame.origin.y + topBtn3.frame.size.height + 5, topBtn2.frame.size.width, 81);
    [topBtn5 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:topBtn5];
    
    //估价工具
    UIButton *topBtn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn6.backgroundColor =[UIColor clearColor];
    topBtn6.tag = 777;
    topBtn6.frame = CGRectMake(topBtn3.frame.origin.x, topBtn5.frame.origin.y + topBtn5.frame.size.height + 5, topBtn2.frame.size.width, 81);
    [topBtn6 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:topBtn6];
    
    //banner请求
    [self bannerHttp];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageCtrl.currentPage = scrollView.contentOffset.x / self.view.frame.size.width;
}

-(void)bannerHttp
{
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    NSLog(@"%@",timeString);
    
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:appID, @"appId",timeString, @"time",nil];
    NSLog(@"%@",dic);
    NSString * allStr= @"";
    
    //排序key
    NSArray* keyArr = [dic allKeys];
    keyArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    //            NSLog(@"%@",keyArr);
    
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
    NSURL *URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@/shipper/banner?%@",ZhuanXB_address,param]];//不需要传递参数
    
    NSLog(@"%@",URL);
    
    
    //第二步，创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    request.HTTPMethod=@"POST";//设置请求方法
    
    //第三步，连接服务器
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    NSLog(@"%@",connection);
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (received==nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络断了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        //        [self createNoView];
        [alert show];
    }else
    {
        NSError *error1=nil;
        id result1 =[NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error1];
        NSLog(@"%@",result1);
        if (result1==nil) {
            
            
            return;
        }else
        {
            if ([[result1 objectForKey:@"code"]isEqualToString:@"1"]) {//正确
                
                NSLog(@"%@",result1);
                
                
                [self layoutBannerScrollViewWithData:result1];
                
            }else
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络断了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                
                //        [self createNoView];
                [alert show];
                
                
            }
        }
        
    }
    
}
-(void)layoutBannerScrollViewWithData : (NSDictionary *)result1{
    bannerArray=[NSArray arrayWithArray:[result1 objectForKey:@"value"]];
    _bannerScrollView.contentSize=CGSizeMake(self.view.frame.size.width*bannerArray.count, _bannerScrollView.bounds.size.height);
    _pageCtrl.numberOfPages = bannerArray.count;
    for (int i=0 ; i<bannerArray.count ;i++) {
//        NSString *bannerImgUrl=[NSString stringWithFormat:@"http://122.225.192.50:9100/ZXBMobileEx%@",[bannerArray[i] objectForKey:@"imgUrl"]];
        NSString *bannerImgUrl=[bannerArray[i] objectForKey:@"imgUrl"];
        NSLog(@"%@",bannerImgUrl);
   
        UIImageView *bannerView=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, 288/2)];
//        if (i==0) {
//            bannerView.backgroundColor=[UIColor redColor];
//        }
        bannerView.userInteractionEnabled=YES;
        bannerView.tag=101+i;
        [bannerView setImageFromURL:[NSURL URLWithString:bannerImgUrl] placeHolderImage:[UIImage imageNamed:@""]];
        UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerURLGo:)];
        [bannerView addGestureRecognizer:tapGR];
        [_bannerScrollView addSubview:bannerView];
    }
}
-(void)bannerURLGo : (UITapGestureRecognizer *)sender{
    
    //    UIImageView *vi=(UIImageView *)sender.view;
    
    NSString *bannerGoUrl=[bannerArray[sender.view.tag-101] objectForKey:@"url"];
    
    BannerVC *bannerV=[[BannerVC alloc] init];
    bannerV.bannerUrl=bannerGoUrl;
    [self.navigationController pushViewController:bannerV animated:YES];
}
-(BOOL)judgeTimeIsTimeOut
{
    //    当前时间和服务器返回时间比较 如果 当前时间比较大 则正常  否则 进入登录界面
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddhhmmss"];
    NSString * str = [formatter stringFromDate:[NSDate date]];
    
    NSString * serverTime = [DPUtil getExpireTime];
    NSString * serverTimeLongValue = [[[serverTime stringByReplacingOccurrencesOfString:@"-" withString:@" "] stringByReplacingOccurrencesOfString:@":" withString:@" "] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"%@ >>>>   %lld",str,[str longLongValue]);
    NSLog(@"%@ >>>>   %lld",serverTime,[serverTimeLongValue longLongValue]);
    
    if ([str longLongValue] < [serverTimeLongValue longLongValue]) {
        return YES;
    }
    return NO;
}

-(void)topBtnClick:(id)sender
{
    [self judgeTimeIsTimeOut];
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 111://线路运价
        {
            PriceViewController *priceVC = [[PriceViewController alloc] init];
            [self.navigationController pushViewController:priceVC animated:YES];
        }
            
            break;
        case 222://运单查询
        {
            InquireViewController *inquireVC = [[InquireViewController alloc] init];
            [self.navigationController pushViewController:inquireVC animated:YES];
        }
            
            break;
        case 333://专线宝网点
        {
            WebsiteViewController *websiteVC = [[WebsiteViewController alloc] init];
            [self.navigationController pushViewController:websiteVC animated:YES];
            break;
        }       case 444://联系我们
        {
            UIWebView*callWebview =[[UIWebView alloc] init];
            NSURL *phoneURL = [NSURL URLWithString:@"tel:400-711-0056"];
            if (!callWebview ) {
                callWebview = [[UIWebView alloc] initWithFrame:CGRectZero];
            }
            [callWebview loadRequest:[NSURLRequest requestWithURL:phoneURL]];
            [self.view addSubview:callWebview];
        }
            break;
        case 555://我要发货
        {
            if([self judgeTimeIsTimeOut]&&[DPUtil isNotNull:[DPUtil getLoginToken]]){
                SendProductVC * sendProVC = [[SendProductVC alloc] init];
                [self.navigationController pushViewController:sendProVC animated:YES];
            }else{
                LoginViewController * loginVC = [[LoginViewController alloc]init];
                loginVC.loginType=LoginTypeSendProductVC;
                [self.navigationController pushViewController:loginVC animated:YES];
            }
        }
            break;
        case 666://个人中心
        {
            if([self judgeTimeIsTimeOut]&&[DPUtil isNotNull:[DPUtil getLoginToken]]){
                NSLog(@"登录成功  进入个人中心");
                PersonalCenterVC *personVC=[[PersonalCenterVC alloc] init];
                [self.navigationController pushViewController:personVC animated:YES];
                //                LoginViewController * loginVC = [[LoginViewController alloc]init];
                //                [self.navigationController pushViewController:loginVC animated:YES];
            }else{
                LoginViewController * loginVC = [[LoginViewController alloc]init];
                loginVC.loginType=LoginTypePersonalCenterVC;
                [self.navigationController pushViewController:loginVC animated:YES];
            }
        }
            
            break;
        case 777://个人中心
        {
            NSLog(@"估价工具");
            ValuationToolsVC * valuationVC=[[ValuationToolsVC alloc] init];
            [self.navigationController pushViewController:valuationVC animated:YES];
            //                LoginViewController * loginVC = [[LoginViewController alloc]init];
            //                [self.navigationController pushViewController:loginVC animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}

-(void)createADview
{
    
    //    ////请求接口  遍历防区
    //    //第一步，创建URL
    //
    NSURL *aUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/user/activityList",ZhuanXB_address]];
    //
    //    //第二步，创建请求
    //
    //    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:aUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //
    //    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    //
    //
    //    NSDictionary *outData = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"token",nil];
    //    NSError *error =nil;
    //
    //    id result = [NSJSONSerialization dataWithJSONObject:outData options:kNilOptions error:&error];
    //
    //    [request setHTTPBody:result];
    //
    //    //第三步，连接服务器
    //
    //    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //
    //    if (received==nil) {
    //        [_activity stop];
    //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"服务器连接出错" message:@"请确认您的网络是否正常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //        [alert show];
    //
    //    }
    //    else
    //    {
    //        NSError *error1=nil;
    //        id result1 =[NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error1];
    //        //解析数据
    //        NSMutableDictionary *allDic=(NSMutableDictionary *)result1;
    //                NSLog(@"....%@",allDic);
    //
    //        //判断数组是否为空
    //        if(allDic!=nil)
    //        {
    //            NSArray *array=[allDic objectForKey:@"list"];
    //            //            NSLog(@"lll=%@",array);
    //            if([array count]!=0)
    //            {
    //                [_headerImage removeFromSuperview];
    //
    //                _urlArray = [[NSMutableArray alloc] init];
    //                _activityIdArray = [[NSMutableArray alloc] init];
    //                _titleArray = [[NSMutableArray alloc] init];
    //                for (int i= 0 ; i<array.count; i++) {
    //                    NSMutableDictionary *detailDict=[array objectAtIndex:i];
    //                    //公告网址
    //                    NSString *htmlPath=[detailDict objectForKey:@"htmlPath"];
    //
    //                    //图片地址
    //                    NSString *activityUrl=[detailDict objectForKey:@"activityUrl"];
    //                    //图片名称
    //                    NSString *title=[detailDict objectForKey:@"title"];
    //                    [_titleArray addObject:title];
    //
    //                    [_activityIdArray addObject:htmlPath];
    //                    [_urlArray addObject:activityUrl];
    //
    //                }
    //
    //                //                NSLog(@"%@...%@>>>%@",_titleArray,_activityIdArray,_urlArray);
    //
    //                NSMutableArray * tempArray = [[NSMutableArray alloc] init];
    //                for(int i =0;i<_urlArray.count;i++)
    //                {
    //                    [tempArray addObject:[NSDictionary dictionaryWithObjects:@[[_urlArray objectAtIndex:i],[_activityIdArray objectAtIndex:i],[_titleArray objectAtIndex:i],@NO,[UIImage imageNamed:@"底色.png"]] forKeys:@[@"pic",@"html",@"title",@"isLoc",@"placeholderImage"]]];
    //                }
    //                NSLog(@"%@",tempArray);
    //
    //                _Topic.pics = tempArray;
    //                [_Topic upDate];
    //                _myPageControl.numberOfPages = [_urlArray count];
    //                if(_myPageControl.numberOfPages == 1)
    //                {
    //                    [_myPageControl setHidden:YES];
    //                }
    //                else
    //                {
    //                    [_myPageControl setHidden:NO];
    //                }
    //
    //            }
    //            else
    //            {
    //
    //                //没有公告的话添加个图片放上去
    //                _headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,_Topic.frame.size.width ,_Topic.frame.size.height)];
    //                _headerImage.image = [UIImage imageNamed:@"暂无公告.png"];
    //                [self.view addSubview:_headerImage];
    //            }
    //            
    //        }
    //        
    //    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
