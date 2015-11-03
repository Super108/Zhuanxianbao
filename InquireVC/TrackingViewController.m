//
//  TrackingViewController.m
//  ZhuanXB
//
//  Created by shanchen on 15/6/11.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import "TrackingViewController.h"

#import "InfoTableViewCell.h"
#import "ListDetail.h"

#import "WebViewController.h"

@interface TrackingViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_listTableView ;
}
@end

@implementation TrackingViewController

-(void)viewWillDisappear:(BOOL)animated
{
    //键盘下落
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.title = @"货物跟踪";
//    self.view.backgroundColor = ZhuanXB_color(0xe6ebf0);;
//    
//    _listArr = [[NSMutableArray alloc] initWithCapacity:0];
//    //添加右边的添加按钮
//    UIButton *navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
//    [navRightButton setBackgroundImage:[UIImage imageNamed:@"home640.png"] forState:UIControlStateNormal];
//    [navRightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView: navRightButton];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    if([UIDevice currentDevice].systemVersion.floatValue >= 7.0f){
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                           target:nil action:nil];
//        negativeSpacer.width = -7.5;
//        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
//    }
//    else{
//        self.navigationItem.rightBarButtonItem = rightItem;
//    }
//    
//
//    
//    //头部view
//    headerView = [[UIView alloc] initWithFrame:CGRectMake(6, 6, self.view.frame.size.width-12, 284/2)];
//    headerView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:headerView];
//    
//    //运单号
//   yundanLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, headerView.frame.size.width-20, 54/2)];
//    yundanLabel.text = @"运单号:ajsdfajshjdf";
//    yundanLabel.font = [UIFont systemFontOfSize:16.0];
//    yundanLabel.textColor = ZhuanXB_color(0x646464);
//    [headerView addSubview:yundanLabel];
//    
//    //面单号
//    miandanLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, yundanLabel.frame.origin.y+yundanLabel.frame.size.height-5, headerView.frame.size.width-20, 54/2)];
//    miandanLabel.text = @"运单号:ajsdfajshjdf";
//    miandanLabel.font = [UIFont systemFontOfSize:16.0];
//    miandanLabel.textColor = ZhuanXB_color(0x646464);
//    [headerView addSubview:miandanLabel];
//    
//    //分割线image
//    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, miandanLabel.frame.origin.y+miandanLabel.frame.size.height+5, headerView.frame.size.width, 1)];
//    lineImage.image = [UIImage imageNamed:@"运单详情粗斜线.png"];
//    [headerView addSubview:lineImage];
//    
//    //图片logo
//    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, lineImage.frame.origin.y+1+10, 60, 60)];
//    logoImage.image = [UIImage imageNamed:@"640运单列表无图.png"];
//    [headerView addSubview:logoImage];
//    
//    //图片旁边 上面的label
//    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(logoImage.frame.origin.x+logoImage.frame.size.width+10, logoImage.frame.origin.y+7, 220, 25)];
//    _topLabel.textColor = ZhuanXB_color(0x454545);
//    _topLabel.font = [UIFont systemFontOfSize:29/2.0];
//    [headerView addSubview:_topLabel];
//    
//    //图片旁边 下面的label
//    _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(logoImage.frame.origin.x+logoImage.frame.size.width+10, logoImage.frame.origin.y+_topLabel.frame.size.height, 220, 25)];
//    _bottomLabel.textColor = ZhuanXB_color(0x636363);
//    _bottomLabel.font = [UIFont systemFontOfSize:25/2.0];
//    [headerView addSubview:_bottomLabel];
//    
//    
//    
//    
//    //////////////////////____________//////////////////
//    
//    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(6, headerView.frame.origin.y+headerView.frame.size.height+6, self.view.frame.size.width-12, self.view.frame.size.height-64-headerView.frame.size.height-6-6)];
////    _listTableView.showsVerticalScrollIndicator = NO;
//    _listTableView.tableFooterView = [[UIView alloc] init];
//    _listTableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    _listTableView.delegate = self;
//    _listTableView.dataSource = self;
//    [self.view addSubview:_listTableView];
//    
//    
//    _activity = [[Activity alloc] initWithActivity:self.view];
//    
    
    [self getInfoHttp];
    
    
   
    
}

-(void)getInfoHttp
{
//    [_activity start];
     [_noInfoView removeFromSuperview];
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    NSLog(@"%@",timeString);
    
    //请求接口
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:appID, @"appId",self.snString, @"sn",timeString, @"time",nil];
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
    
    
    NSString *param=[NSString stringWithFormat:@"appId=%@&sn=%@&time=%@&sign=%@",appID,self.snString,timeString,sign];
    NSURL *URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@/shipper/waybill/viewwaybill?%@",ZhuanXB_address,param]];//不需要传递参数
    
    NSLog(@"%@",URL);
    
    //直接用网页打开就行了
    
    
    WebViewController *webView=[[WebViewController alloc] init];
    //        NSLog(@"%@",_htmlArray);
    
    webView.url=[NSString stringWithFormat:@"%@/shipper/waybill/viewwaybill?%@",ZhuanXB_address,param];
    webView.name = @"货物跟踪";
    [self.navigationController pushViewController:webView animated:YES];

    
//    //第二步，创建请求
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//    request.HTTPMethod=@"GET";//设置请求方法
//    
//    //第三步，连接服务器
//    
//    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//    
//    NSLog(@"%@",connection);
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSLog(@"%@",received);
//    
//    if (received==nil) {
//    [_activity stop];
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络断了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
////        
////        [self createNoView];
////        [alert show];
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
//                
//                if ([[result1 objectForKey:@"value"] isKindOfClass:[NSNull class]]) {
//                    
//                    [headerView removeFromSuperview];
//                    [_listTableView removeFromSuperview];
//                    
//                    [self createNoView];
//                    
//                }else
//                {
//                    //运单号
//                    
//                    if ([[[result1 objectForKey:@"value"]objectForKey:@"sn"] isKindOfClass:[NSNull class]]) {
//                        yundanLabel.text = @"运单号：暂无";
//                    }else
//                    {
//                        yundanLabel.text =[NSString stringWithFormat:@"运单号：%@",[[result1 objectForKey:@"value"]objectForKey:@"sn"]];
//                    }
//                    
//                    //面单号
//                    if ([[[result1 objectForKey:@"value"]objectForKey:@"waybillNo"] isKindOfClass:[NSNull class]]) {
//                        miandanLabel.text = @"面单号：暂无";
//                    }else
//                    {
//                        miandanLabel.text = [NSString stringWithFormat:@"面单号：%@",[[result1 objectForKey:@"value"]objectForKey:@"waybillNo"]];
//                    }
//                    
//                    
//                    _topLabel.text = [NSString stringWithFormat:@"%@，%.2f公斤，%.2f立方",[[result1 objectForKey:@"value"]objectForKey:@"goodName"],[[[result1 objectForKey:@"value"]objectForKey:@"goodWeight"] floatValue],[[[result1 objectForKey:@"value"]objectForKey:@"goodVolume"] floatValue]];
//                    
//                    if ([[[result1 objectForKey:@"value"]objectForKey:@"consigneePhone"] isKindOfClass:[NSNull class]]) {
//                        _bottomLabel.text = [NSString stringWithFormat:@"收货人：%@，暂无",[[result1 objectForKey:@"value"]objectForKey:@"consigneeName"]];
//                        
//                    }else
//                    {
//                        _bottomLabel.text = [NSString stringWithFormat:@"收货人：%@，%@",[[result1 objectForKey:@"value"]objectForKey:@"consigneeName"],[[result1 objectForKey:@"value"]objectForKey:@"consigneePhone"]];
//                    }
//                    
//                    
//                    
//                    NSArray *arr = [[result1 objectForKey:@"value"] objectForKey:@"listTradeTrack"];
//                    //            NSLog(@"arrarrarrararararararar%@",arr);
//                    //判断数组是否存在
//                    if(arr==nil)
//                    {
//                        
//                    }else
//                    {
//                        for (int i =0; i<arr.count;i++) {
//                            NSMutableDictionary *detailDic = [arr objectAtIndex:i];
//                            ListDetail *listDetail = [[ListDetail alloc] init];
//                            //                    listDetail.carNumber = [detailDic  objectForKey:@"carNumber"];
//                            listDetail.status = [detailDic  objectForKey:@"status"];
//                            listDetail.createTime = [detailDic  objectForKey:@"createTime"];
//                            listDetail.statusValue = [NSString stringWithFormat:@"%ld",[[detailDic objectForKey:@"statusValue"] integerValue]];
//                            //                    listDetail.driverName = [detailDic  objectForKey:@"driverName"];
//                            //                    listDetail.driverPhone = [detailDic  objectForKey:@"driverPhone"];
//                            
//                            [_listArr addObject:listDetail];
//                        }
//                        [_listTableView reloadData];
//                    }
//                    
//                    
//                }
//                
//                [_activity stop];
//                
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
//            }
//            
//        }
//
//    }
  
}

-(void)rightBtnClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoveToMain" object:nil];
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

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _listArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 163/2;
}



//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 150)];
//    headerView.backgroundColor = [UIColor redColor];
//    return headerView;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 150;
//}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"deviceCell";
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell=[[InfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    ListDetail *listDetail = [_listArr objectAtIndex:indexPath.row];
    cell.detailLabel.text = listDetail.status;
    cell.timeLabel.text = listDetail.createTime;
    
//    if (indexPath.row==0) {
//        cell.grayImage.frame = CGRectMake(20+60/2-10/2, 50, 10, 50);
//    }
    
    
    switch ([listDetail.statusValue integerValue]) {
        case -5:
            
            if (indexPath.row==0) {
                cell.logoImage.image = [UIImage imageNamed:@"-5.png"];
            }else
            {
                cell.logoImage.image = [UIImage imageNamed:@"-5.png"];
            }
            
            break;
        case 0:
            if (indexPath.row==0) {
                cell.logoImage.image = [UIImage imageNamed:@"0绿.png"];
            }else
            {
                cell.logoImage.image = [UIImage imageNamed:@"0灰.png"];
            }

            break;
        case 5:
            if (indexPath.row==0) {
                cell.logoImage.image = [UIImage imageNamed:@"5绿.png"];
            }else
            {
                cell.logoImage.image = [UIImage imageNamed:@"5灰.png"];
            }
            break;
        case 10:
            if (indexPath.row==0) {
                cell.logoImage.image = [UIImage imageNamed:@"5绿.png"];
            }else
            {
                cell.logoImage.image = [UIImage imageNamed:@"5灰.png"];
            }

            break;
        case 15:
            if (indexPath.row==0) {
                cell.logoImage.image = [UIImage imageNamed:@"15绿.png"];
            }else
            {
                cell.logoImage.image = [UIImage imageNamed:@"15灰色.png"];
            }
            
            break;
        case 25:
            if (indexPath.row==0) {
                cell.logoImage.image = [UIImage imageNamed:@"15绿.png"];
            }else
            {
                cell.logoImage.image = [UIImage imageNamed:@"15灰色.png"];
            }
            
            break;
        case 30:
            if (indexPath.row==0) {
                cell.logoImage.image = [UIImage imageNamed:@"30.png"];
            }else
            {
                cell.logoImage.image = [UIImage imageNamed:@"30.png"];
            }
            break;
            
        default:
            break;
    }
    
    
//    //判断图标
//    if (indexPath.row==0&&!([listDetail.statusValue isEqualToString:@"-5"]||[listDetail.statusValue isEqualToString:@"0"])) {
////                        cell.logoImage.image = [UIImage imageNamed:@"货物跟踪车.png"];
//        
//        cell.logoImage.image = [UIImage imageNamed:@"货物跟踪车.png"];
//        }
////    else if (indexPath.row==0&&([listDetail.statusValue isEqualToString:@"-5"]||[listDetail.statusValue isEqualToString:@"0"]))
////                  {
////                      cell.grayImage.frame = CGRectMake(20+60/2-10/2, 0, 10, 50);
////                      cell.logoImage.image = [UIImage imageNamed:@"货物跟踪包裹.png"];
////                  }
//    
//        else
//        {
//                        if ([listDetail.statusValue isEqualToString:@"-5"]||[listDetail.statusValue isEqualToString:@"0"]) {
//                            
//                            cell.logoImage.image = [UIImage imageNamed:@"货物跟踪包裹1.png"];
//                            
//                            
//                        }else
//                        {
//                            cell.logoImage.image = [UIImage imageNamed:@"货物跟踪车1.png"];
//                            
//                            
//                        }
//
//                    }
//    
    
    
    
    
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
