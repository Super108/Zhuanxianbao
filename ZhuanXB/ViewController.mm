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
#import "ScanViewController.h"
#import "InquireViewController.h"

#import "FMDatabase.h"
#import "FMDBTools.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = ZhuanXB_color(0xe6ebf0);
    
    //导航栏中间图片
    UIImageView *topImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 233/2, 55/2)];
    topImgeView.contentMode = UIViewContentModeScaleAspectFit;//设置内容样式,通过保持长宽比缩放内容适应视图的大小,任何剩余的区域的视图的界限是透明的。
    topImgeView.image = [UIImage imageNamed:@"专线宝.png"];
    self.navigationItem.titleView =topImgeView;
    NSLog(@">>>   %@",[NSString stringWithFormat:@"%@/user/activityList",ZhuanXB_address]);
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
    UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 288/2)];
    adImageView.image = [UIImage imageNamed:@"banner.png"];
    [self.view addSubview:adImageView];

    //菊花
    _activity = [[Activity alloc] initWithActivity:self.view];
    
    
    
    /////////////////////////_________________////////////////////////
    
    if (iPhone5||iPhone6||iPhone6Plus) {
        //下面几个btn 的view
        
        UIImageView *btnView = [[UIImageView alloc] initWithFrame:CGRectMake(11, adImageView.frame.size.height+11, self.view.frame.size.width-22, 680/2)];
        btnView.image = [UIImage imageNamed:@"首页按钮.png"];
        btnView.userInteractionEnabled = YES;
        [self.view addSubview:btnView];
        //线路运价
        UIButton *topBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn1.backgroundColor =[UIColor redColor];
        topBtn1.tag = 111;
        topBtn1.frame = CGRectMake(0, 0, 298/2, 177/2+20);
        [topBtn1 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:topBtn1];
        // 运单查询
        UIButton *topBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn2.backgroundColor =[UIColor cyanColor];
        topBtn2.tag = 222;
        topBtn2.frame = CGRectMake(topBtn1.frame.size.width+10/2-2, 0, 296/2, 293/2+20);
        [topBtn2 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:topBtn2];
        //专线宝网点
        UIButton *topBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn3.backgroundColor =[UIColor greenColor];
        topBtn3.tag = 333;
        topBtn3.frame = CGRectMake(topBtn1.frame.origin.x, topBtn1.frame.size.height+13/2, topBtn1.frame.size.width, 177/2+22);
        [topBtn3 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:topBtn3];
        //客服
        UIButton *topBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn4.backgroundColor =[UIColor redColor];
        topBtn4.tag = 444;
        topBtn4.frame = CGRectMake(topBtn1.frame.origin.x, topBtn1.frame.size.height+13/2+topBtn3.frame.size.height+13/2, topBtn1.frame.size.width, 177/2+22);
        [topBtn4 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:topBtn4];
        //扫描查单
        UIButton *topBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn5.backgroundColor =[UIColor redColor];
        topBtn5.tag = 555;
        topBtn5.frame = CGRectMake(topBtn2.frame.origin.x-2, topBtn2.frame.size.height+13/2, topBtn2.frame.size.width, 197/2+70);
        [topBtn5 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:topBtn5];

        
        
        
    }else
    {
        
        
        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(11, adImageView.frame.size.height+11, self.view.frame.size.width-22, self.view.frame.size.height-adImageView.frame.size.height+1)];
        [scrollView setShowsVerticalScrollIndicator:YES];
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width-22, 568-adImageView.frame.size.height);
        [self.view addSubview:scrollView];
        
        
        //下面几个btn 的view
        
        UIImageView *btnView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        btnView.image = [UIImage imageNamed:@"首页按钮.png"];
        btnView.userInteractionEnabled = YES;
        [scrollView addSubview:btnView];
        //线路运价
        UIButton *topBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn1.backgroundColor =[UIColor clearColor];
        topBtn1.tag = 111;
        topBtn1.frame = CGRectMake(0, 0, 298/2, 177/2+20);
        [topBtn1 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:topBtn1];
        // 运单查询
        UIButton *topBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn2.backgroundColor =[UIColor clearColor];
        topBtn2.tag = 222;
        topBtn2.frame = CGRectMake(topBtn1.frame.size.width+10/2-2, 0, 296/2, 293/2+20);
        [topBtn2 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:topBtn2];
        //专线宝网点
        UIButton *topBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn3.backgroundColor =[UIColor clearColor];
        topBtn3.tag = 333;
        topBtn3.frame = CGRectMake(topBtn1.frame.origin.x, topBtn1.frame.size.height+13/2, topBtn1.frame.size.width, 177/2+22);
        [topBtn3 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:topBtn3];
        //客服
        UIButton *topBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn4.backgroundColor =[UIColor clearColor];
        topBtn4.tag = 444;
        topBtn4.frame = CGRectMake(topBtn1.frame.origin.x, topBtn1.frame.size.height+13/2+topBtn3.frame.size.height+13/2, topBtn1.frame.size.width, 177/2+22);
        [topBtn4 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:topBtn4];
        //扫描查单
        UIButton *topBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn5.backgroundColor =[UIColor clearColor];
        topBtn5.tag = 555;
        topBtn5.frame = CGRectMake(topBtn2.frame.origin.x-2, topBtn2.frame.size.height+13/2, topBtn2.frame.size.width, 197/2+70);
        [topBtn5 addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:topBtn5];
        

        
       
    }
    


}
-(void)topBtnClick:(id)sender
{
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
        case 555://扫描查单
        {
            ScanViewController *scanVC = [[ScanViewController alloc] init];
            [self.navigationController pushViewController:scanVC animated:YES];
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
//    NSURL *aUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/user/activityList",ZhuanXB_address]];
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
