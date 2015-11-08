//
//  PriceViewController.m
//  ZhuanXB
//
//  Created by 康冬 on 15/6/10.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import "PriceViewController.h"
#import "SelectAreaViewController.h"
#import "BtnTableViewCell.h"
#import "WebViewController.h"

#define kInquireHistoryBackViewMarginLeft   11
#define kInquireHistoryBackViewMarginTop    220
#define kInquireHistoryBackViewWidth        self.view.frame.size.width - 22
#define kInquireHistoryBackViewHeight       133

#define keyInquireHistory  @"keyInquireHistory"
#define keyInquireHistory_Start  @"keyInquireHistory_Start"
#define keyInquireHistory_End  @"keyInquireHistory_End"
@interface PriceViewController ()

{
    BtnTableViewCell *_cell1;
    BtnTableViewCell *_cell2;
}


@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"线路运价";
    self.view.backgroundColor = ZhuanXB_color(0xe6ebf0);
    
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

    
//    [self createSecondView];
    
    //查询前的view
    
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    _firstView.backgroundColor = ZhuanXB_color(0xe6ebf0);
    [self.view addSubview:_firstView];

    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(11, 22, self.view.frame.size.width-22, 88)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    if (IOS_VERSION>=8.0) {
        _myTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_myTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_myTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }

    [_firstView addSubview:_myTableView];
    
    
    
    
    //查询按钮
    UIButton *inquireBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inquireBtn.frame = CGRectMake(11, _myTableView.frame.size.height+_myTableView.frame.origin.y+35, self.view.frame.size.width-22, 82/2);
    [inquireBtn setBackgroundImage:[UIImage imageNamed:@"线路查询按钮.png"] forState:UIControlStateNormal];
    [inquireBtn addTarget:self action:@selector(inquireBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_firstView addSubview:inquireBtn];
    
    
    
    /////////////////////________________/////////////////
    //查询后的view
    
//   查询历史
    [self initInquireHistoryView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self initInquireHistoryView];
}

#pragma mark - InquireHistoryView
- (void)removeHistoryViewSubviews
{
    UIView * HistoryView = [self.view viewWithTag:1];
    for (UIView * subView in HistoryView.subviews) {
        [subView removeFromSuperview];
    }
    [HistoryView removeFromSuperview];
}

-(void)initInquireHistoryView
{
    [self removeHistoryViewSubviews];
    UIView * inquireHistoryBackView = [[UIView alloc]initWithFrame:CGRectMake(kInquireHistoryBackViewMarginLeft, kInquireHistoryBackViewMarginTop, kInquireHistoryBackViewWidth, kInquireHistoryBackViewHeight)];
    inquireHistoryBackView.tag = 1;
    inquireHistoryBackView.backgroundColor = [UIColor clearColor];
    [_firstView addSubview:inquireHistoryBackView];
//    inquireHistoryBackView.layer.borderColor = [MAIN_COLOR_BORDERCOLOR CGColor];
//    inquireHistoryBackView.layer.borderWidth = 1;
    
    UILabel * usedWaysLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kInquireHistoryBackViewWidth, 40)];
    usedWaysLabel.backgroundColor = [UIColor clearColor];
    usedWaysLabel.textAlignment = NSTextAlignmentLeft;
    [inquireHistoryBackView addSubview:usedWaysLabel];
    usedWaysLabel.text = @"  历史记录";
    usedWaysLabel.font = [UIFont systemFontOfSize:18];
    
    CALayer * lineLayer =   [CALayer layer];
    lineLayer.frame = CGRectMake(0, 40, kInquireHistoryBackViewWidth, 1);
    [inquireHistoryBackView.layer addSublayer:lineLayer];
    lineLayer.backgroundColor = [MAIN_COLOR_BORDERCOLOR CGColor];
    
    NSMutableArray * historyArr = [[NSUserDefaults standardUserDefaults] objectForKey:keyInquireHistory];
    for (int i = 0 ; i < historyArr.count; i ++) {
        NSDictionary * historyDic = historyArr[i];
        
        UILabel * usedWaysLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 + 25 * i, kInquireHistoryBackViewWidth, 20)];
        usedWaysLabel.font = [UIFont systemFontOfSize:12];
        usedWaysLabel.backgroundColor = [UIColor clearColor];
        usedWaysLabel.textAlignment = NSTextAlignmentLeft;
        [inquireHistoryBackView addSubview:usedWaysLabel];
        usedWaysLabel.text = [NSString stringWithFormat:@"  %@ - >%@",[historyDic objectForKey:keyInquireHistory_Start],[historyDic objectForKey:keyInquireHistory_End]];
    }
}

//查询后的view
//-(void)createSecondView
//{
//        [_secondView removeFromSuperview];
//        _secondView = [[UIView alloc] initWithFrame:CGRectMake(11, 11, self.view.frame.size.width-22, self.view.frame.size.height-22)];
//        //        if (IOS_VERSION>=8.0) {
//        //            _secondView = [[UIView alloc] initWithFrame:CGRectMake(11, 11, self.view.frame.size.width-22, self.view.frame.size.height-22)];
//        //
//        //        }else
//        //        {
//        //
//        //            _secondView = [[UIView alloc] initWithFrame:CGRectMake(11, 11, self.view.frame.size.width-22, self.view.frame.size.height-22-64)];
//        //        }
//        
//        
//        _secondView.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:_secondView];
//        
////        //地区label
////        UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _secondView.frame.size.width, 25)];
////        areaLabel.textAlignment = NSTextAlignmentCenter;
////        areaLabel.textColor = ZhuanXB_color(0x454545);
////        areaLabel.font = [UIFont systemFontOfSize:16.0];
////        if (self.startAreaNameString ==nil) {
////            self.startAreaNameString = @"浙江省-杭州市-滨江区";
////        }else
////        {
////            
////        }
////        
////        NSArray *array1 = [self.startAreaNameString  componentsSeparatedByString:@"-"];
////        
////        NSArray *array2 = [self.endAreaNameString componentsSeparatedByString:@"-"];
////        NSString *str1 = [array1 objectAtIndex:1];
////        NSString *str2 = [array1 objectAtIndex:2];
////        NSString *allStr1 = [NSString stringWithFormat:@"%@-%@",str1,str2];
////        
////        NSString *str3 = [array2 objectAtIndex:1];
////        NSString *str4 = [array2 objectAtIndex:2];
////        NSString *allStr2 = [NSString stringWithFormat:@"%@-%@",str3,str4];
////        
////        areaLabel.text = [NSString stringWithFormat:@"%@->%@",allStr1,allStr2];
////        [_secondView addSubview:areaLabel];
////        
////        //时效label
////        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, areaLabel.frame.origin.y+areaLabel.frame.size.height-10, _secondView.frame.size.width, 30)];
////        _timeLabel.textAlignment = NSTextAlignmentCenter;
////        _timeLabel.textColor = ZhuanXB_color(0xff5000);
////        _timeLabel.font = [UIFont systemFontOfSize:13.0];
////        [_secondView addSubview:_timeLabel];
////        
////        
////        //上面那块表格
////        UIImageView *topImage = [[UIImageView alloc] initWithFrame:CGRectMake(_secondView.frame.size.width/2-569/4, _timeLabel.frame.origin.y+_timeLabel.frame.size.height-5, 569/2, 406/2)];
////        topImage.image = [UIImage imageNamed:@"线路查询结果.png"];
////        [_secondView addSubview:topImage];
////        
////        //创建八个label
////        for (int i=0; i<=7; i++) {
////            _label = [[UILabel alloc] initWithFrame:CGRectMake(_secondView.frame.size.width-15-120+8, 2+25*i, 60, 25)];
////            _label.backgroundColor= [UIColor clearColor];
////            _label.textAlignment = NSTextAlignmentCenter;
////            _label.font = [UIFont systemFontOfSize:11.0];
////            _label.textColor = ZhuanXB_color(0x454545);
////            _label.tag = i+100;
////            [topImage addSubview:_label];
////            
////        }
////        //创建八个label
////        for (int i=0; i<=7; i++) {
////            _label = [[UILabel alloc] initWithFrame:CGRectMake(_secondView.frame.size.width-15-120+2+60, 2+25*i, 60, 25)];
////            _label.backgroundColor= [UIColor clearColor];
//////                        _label.textAlignment = NSTextAlignmentCenter;
////            _label.textColor = ZhuanXB_color(0x454545);
////            _label.font = [UIFont systemFontOfSize:11.0];
////            _label.tag = i+200;
////            [topImage addSubview:_label];
////        }
////        
////        
////        //下面那块注意
//////        UIImageView *bottomImage = [[UIImageView alloc] initWithFrame:CGRectMake(topImage.frame.origin.x, topImage.frame.origin.y+topImage.frame.size.height+8/2, 569/2, 470/2)];
//////        bottomImage.image = [UIImage imageNamed:@"线路查询结果1.png"];
//////        [_secondView addSubview:bottomImage];
////        
////        UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(topImage.frame.origin.x, topImage.frame.origin.y+topImage.frame.size.height+8/2, 569/2, 20)];
////        aLabel.backgroundColor = [UIColor clearColor];
////        aLabel.text = @"注意：";
////        aLabel.textColor = ZhuanXB_color(0x454545);
////        aLabel.font = [UIFont systemFontOfSize:14.0];
////        [_secondView addSubview:aLabel];
////        
////        
////        vie = [[UITextView alloc] initWithFrame:CGRectMake(topImage.frame.origin.x, aLabel.frame.origin.y+aLabel.frame.size.height, 569/2, 470/2-15)];
////        vie.textColor = ZhuanXB_color(0x454545);
////        vie.backgroundColor = [UIColor clearColor];
////        vie.userInteractionEnabled = NO;
////        [_secondView addSubview:vie];
////        
////        
////        
////        _activity = [[Activity alloc] initWithActivity:_secondView];
////
//    
//       
//    
//}
//

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"deviceCell";
    BtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell=[[BtnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.tag = indexPath.row+123;
    cell.areaLabel.adjustsFontSizeToFitWidth = YES;
    if (indexPath.row==0) {
        cell.contentLabel.text = @"起始地：";
        cell.areaLabel.text = @"浙江省-杭州市-滨江区";
        cell.areaLabel.textColor = ZhuanXB_color(0x454545);
        cell.areaLabel.font = [UIFont systemFontOfSize:15.0];
    }
    if (indexPath.row==1) {
        cell.contentLabel.text = @"目的地：";
        cell.areaLabel.text = @"请选择目的地";
    }
    
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BtnTableViewCell *cell = (BtnTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row==0) {
        SelectAreaViewController *selectVC =[[SelectAreaViewController alloc] init];

        [selectVC getArea:^(NSString *areaCodeString, NSString *areaNameString) {
            if ([areaCodeString isEqualToString:@""]) {
                cell.areaLabel.text = @"浙江省-杭州市-滨江区";
                self.startAreaCodeString = @"330108";
                self.startAreaNameString = @"浙江省-杭州市-滨江区";
                
            }else
            {
                cell.areaLabel.text = areaNameString;
                self.startAreaNameString = areaNameString;
                self.startAreaCodeString = areaCodeString;
            }
            cell.areaLabel.font = [UIFont systemFontOfSize:15.0];
            cell.areaLabel.textColor = ZhuanXB_color(0x454545);
           
        }];
        
        [self.navigationController pushViewController:selectVC animated:YES];
    }
    if (indexPath.row==1) {
        SelectAreaViewController *selectVC =[[SelectAreaViewController alloc] init];
        [selectVC getArea:^(NSString *areaCodeString, NSString *areaNameString) {
            cell.areaLabel.text = areaNameString;
            self.endAreaNameString = areaNameString;
            self.endAreaCodeString = areaCodeString;
            cell.areaLabel.font = [UIFont systemFontOfSize:15.0];
            cell.areaLabel.textColor = ZhuanXB_color(0x454545);
        }];
        [self.navigationController pushViewController:selectVC animated:YES];
    }
}



-(void)rightBtnClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoveToMain" object:nil];
}

-(void)inquireBtnClick
{
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    _cell1 =(BtnTableViewCell *) [_myTableView cellForRowAtIndexPath:indexPath1];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:1 inSection:0];
    _cell2 =(BtnTableViewCell *) [_myTableView cellForRowAtIndexPath:indexPath2];
    
    NSLog(@" 》》》》》》》》 %@",_cell1.areaLabel.text);
    NSLog(@" 》》》》》》》》 %@",_cell2.areaLabel.text);
    
    //判断地点是否为空
    if ([_cell1.areaLabel.text isEqualToString:@"请选择起始地"]||[_cell2.areaLabel.text isEqualToString:@"请选择目的地"]) {
        [self setHub:@"请您先选择地区"];
    }else
    {
        //请求接口
        NSMutableArray * inquireHistoryArr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:keyInquireHistory]];
        BOOL hasTheSameHistory = NO;
        for (NSDictionary * dic in inquireHistoryArr) {
            NSString * historyStr = [NSString stringWithFormat:@"%@→%@",[dic objectForKey:keyInquireHistory_Start],[dic objectForKey:keyInquireHistory_End]];
            if ([historyStr isEqualToString:[NSString stringWithFormat:@"%@→%@",_cell1.areaLabel.text,_cell2.areaLabel.text]]) {
                hasTheSameHistory = YES;
                break;
            }
        }
        
        if (hasTheSameHistory == NO) {
            NSDictionary * dic = @{keyInquireHistory_Start:_cell1.areaLabel.text,
                                   keyInquireHistory_End:_cell2.areaLabel.text};
            [inquireHistoryArr insertObject:dic atIndex:0];
//            查询历史超过四个 删除最后一个 保持只有三个最近历史记录
            if (inquireHistoryArr.count == 4) {
                [inquireHistoryArr removeLastObject];
            }
            [[NSUserDefaults standardUserDefaults] setObject:inquireHistoryArr forKey:keyInquireHistory];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        
//        [self createSecondView];
        
//        [_activity start];
        
        
     
        [_noInfoView removeFromSuperview];
        
        //获取系统当前的时间戳
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970]*1000;
        NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
        NSLog(@"%@",timeString);
        
        //请求接口
        if (self.startAreaCodeString ==nil) {
            
            self.startAreaCodeString = @"330108";
            
        }else
        {
            
        }
//        NSLog(@"%@",self.startAreaCodeString);
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:appID, @"appId",@"101", @"ver",self.startAreaCodeString, @"startCountyCode",self.endAreaCodeString, @"endCountyCode",timeString, @"time",nil];
        NSLog(@"%@",dic);
        NSString * allStr= @"";
        
        //排序key
        NSArray* keyArr = [dic allKeys];
        keyArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            NSComparisonResult result = [obj1 compare:obj2];
            return result==NSOrderedDescending;
        }];
        
//            NSLog(@"%@",keyArr);
        
        for (int i=0; i<=4; i++)
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

        
        
        
        NSString *param=[NSString stringWithFormat:@"appId=%@&ver=%@&startCountyCode=%@&endCountyCode=%@&time=%@&sign=%@",appID,@"101",self.startAreaCodeString,self.endAreaCodeString,timeString,sign];
        NSURL *URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@/shipper/waybill/viewroute?%@",ZhuanXB_address,param]];//不需要传递参数
        
            NSLog(@"%@",URL);
        
        //直接用网页打开就行了
        
        
        WebViewController *webView=[[WebViewController alloc] init];
        //        NSLog(@"%@",_htmlArray);
        
        webView.url=[NSString stringWithFormat:@"%@/shipper/waybill/viewroute?%@",ZhuanXB_address,param];
        webView.name = @"线路运价";
        [self.navigationController pushViewController:webView animated:YES];
        
//        //第二步，创建请求
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//        request.HTTPMethod=@"GET";//设置请求方法
//        
//        //第三步，连接服务器
//        
//        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//        
//        NSLog(@"%@",connection);
//        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//        
//        if (received==nil) {
//            [_activity stop];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络断了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            
//            [self createNoView];
//            [alert show];
//        }else
//        {
//            NSError *error1=nil;
//            id result1 =[NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error1];
//            NSLog(@"%@",result1);
//            if (result1==nil) {
//                [_activity stop];
//                
//                return;
//            }else
//            {
//                if ([[result1 objectForKey:@"code"]isEqualToString:@"1"]) {//正确
//                    
//                    if ([[result1 objectForKey:@"value"] isKindOfClass:[NSNull class]]) {
//                        
//                        if (iPhone4) {
//                            [scrollView removeFromSuperview];
//                        }else
//                        {
//                            [_secondView removeFromSuperview];
//                        }
//                        
//                        [self createNoView];
//                        
//                    }else
//                    {
//                        
//                        //时效
//                        _timeLabel.text =[NSString stringWithFormat:@"时效：%@天",[[result1 objectForKey:@"value"] objectForKey:@"aging"]];
//                        NSLog(@"%@",_timeLabel.text);
//                        UILabel *label;
//                        UILabel *label1;
//
//                        
//                        vie.text = [[result1 objectForKey:@"value"] objectForKey:@"carefulNote"];
//
////                        NSLog(@"%@",[[result1 objectForKey:@"value"] objectForKey:@"carefulNote"]);
//                        
//                        for (int i=0; i<=7; i++) {
//                            label = (UILabel *)[_secondView viewWithTag:i+100];
//                            
//                            switch (label.tag) {
//                                case 100://重货1吨以下
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice1"] isKindOfClass:[NSNull class]]) {
//                                        label.text = [NSString stringWithFormat:@"%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrice1"] floatValue]];
//                                        
//                                    }else
//                                    {
//                                        label.text = [NSString stringWithFormat:@"原：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrice1"] floatValue]];
//                                        label.textColor = [UIColor grayColor];
//                                        
//                                        NSUInteger length = [label.text length];
//                                        
//                                        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:label.text];
//                                        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//                                        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
//                                        [label setAttributedText:attri];
//
//                                    }
//                                    
//                                    
//                                    break;
//                                case 101://重货(1-3)吨
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice2"] isKindOfClass:[NSNull class]]) {
//                                        label.text = [NSString stringWithFormat:@"%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrice2"] floatValue]];
//                                        
//                                    }else
//                                    {
//                                        label.text = [NSString stringWithFormat:@"原：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrice2"] floatValue]];
//                                        label.textColor = [UIColor grayColor];
//                                        NSUInteger length = [label.text length];
//                                        
//                                        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:label.text];
//                                        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//                                        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
//                                        [label setAttributedText:attri];
//                                    }
//                                    break;
//                                case 102://重货(3-5)吨
//                                    
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice3"] isKindOfClass:[NSNull class]]) {
//                                        label.text = [NSString stringWithFormat:@"%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrice3"] floatValue]];
//                                        
//                                    }else
//                                    {
//                                        label.text = [NSString stringWithFormat:@"原：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrice3"] floatValue]];
//                                        label.textColor = [UIColor grayColor];
//                                        NSUInteger length = [label.text length];
//                                        
//                                        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:label.text];
//                                        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//                                        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
//                                        [label setAttributedText:attri];
//                                    }
//
//                                    break;
//                                
//
//                                case 103://重货5吨以上
//                                    
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice4"] isKindOfClass:[NSNull class]]) {
//                                        label.text = [NSString stringWithFormat:@"%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrice4"] floatValue]];
//                                        
//                                    }else
//                                    {
//                                        label.text = [NSString stringWithFormat:@"原：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrice4"] floatValue]];
//                                        label.textColor = [UIColor grayColor];
//                                        NSUInteger length = [label.text length];
//                                        
//                                        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:label.text];
//                                        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//                                        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
//                                        [label setAttributedText:attri];
//                                    }
//                                    break;
//                                
//
//                                case 104://抛货2方以下
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice1"] isKindOfClass:[NSNull class]]) {
//                                        label.text = [NSString stringWithFormat:@"%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrice1"] floatValue]];
//                                        
//                                    }else
//                                    {
//                                        label.text = [NSString stringWithFormat:@"原：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrice1"] floatValue]];
//                                        label.textColor = [UIColor grayColor];
//                                        NSUInteger length = [label.text length];
//                                        
//                                        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:label.text];
//                                        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//                                        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
//                                        [label setAttributedText:attri];
//                                    }
//
//                                    
//                                    break;
//                                case 105://抛货2-6方
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice2"] isKindOfClass:[NSNull class]]) {
//                                        label.text = [NSString stringWithFormat:@"%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrice2"] floatValue]];
//                                        
//                                    }else
//                                    {
//                                        label.text = [NSString stringWithFormat:@"原：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrice2"] floatValue]];
//                                        label.textColor = [UIColor grayColor];
//                                        NSUInteger length = [label.text length];
//                                        
//                                        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:label.text];
//                                        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//                                        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
//                                        [label setAttributedText:attri];
//                                    }
//
//                                    break;
//                                
//
//                                case 106://抛货6-15方
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice3"] isKindOfClass:[NSNull class]]) {
//                                        label.text = [NSString stringWithFormat:@"%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrice3"] floatValue]];
//                                        
//                                    }else
//                                    {
//                                        label.text = [NSString stringWithFormat:@"原：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrice3"] floatValue]];
//                                        label.textColor = [UIColor grayColor];
//                                        NSUInteger length = [label.text length];
//                                        
//                                        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:label.text];
//                                        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//                                        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
//                                        [label setAttributedText:attri];
//                                    }
//
//                                    break;
//                                
//                                case 107://抛货15方以上
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice4"] isKindOfClass:[NSNull class]]) {
//                                        label.text = [NSString stringWithFormat:@"%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrice4"] floatValue]];
//                                        
//                                    }else
//                                    {
//                                        label.text = [NSString stringWithFormat:@"原：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrice4"] floatValue]];
//                                        label.textColor = [UIColor grayColor];
//                                        NSUInteger length = [label.text length];
//                                        
//                                        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:label.text];
//                                        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
//                                        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
//                                        [label setAttributedText:attri];
//                                    }
//
//                                    
//                                    break;
//                                    
//                                default:
//                                    break;
//                            }
//                            
//                        }
//                        
//                        for (int i=0; i<=7; i++) {
//                            label1 = (UILabel *)[_secondView viewWithTag:i+200];
//                            switch (label1.tag) {
//                                case 200://重货1吨以下
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice1"] isKindOfClass:[NSNull class]])
//                                    {
//                                        label1.text = @"";
//                                        
//                                    }else
//                                    {
//                                        label1.text = [NSString stringWithFormat:@"现：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice1"] floatValue]];
//                                    }
//                                    
//                                    break;
//                                case 201:
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice2"] isKindOfClass:[NSNull class]])
//                                    {
//                                        label1.text = @"";
//                                        
//                                    }else
//                                    {
//                                        label1.text = [NSString stringWithFormat:@"现：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice2"] floatValue]];
//                                    }
//                                    
//                                    break;
//                                case 202:
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice3"] isKindOfClass:[NSNull class]])
//                                    {
//                                        label1.text = @"";
//                                        
//                                    }else
//                                    {
//                                        label1.text = [NSString stringWithFormat:@"现：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice3"] floatValue]];
//                                    }
//                                    break;
//                                case 203:
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice4"] isKindOfClass:[NSNull class]])
//                                    {
//                                        label1.text = @"";
//                                        
//                                    }else
//                                    {
//                                        label1.text = [NSString stringWithFormat:@"现：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"heavyPrePrice4"] floatValue]];
//                                    }
//                                    break;
//                                case 204:
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice1"] isKindOfClass:[NSNull class]])
//                                    {
//                                        label1.text = @"";
//                                        
//                                    }else
//                                    {
//                                        label1.text = [NSString stringWithFormat:@"现：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice1"] floatValue]];
//                                    }
//                                    break;
//                                case 205:
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice2"] isKindOfClass:[NSNull class]])
//                                    {
//                                        label1.text = @"";
//                                        
//                                    }else
//                                    {
//                                        label1.text = [NSString stringWithFormat:@"现：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice2"] floatValue]];
//                                    }
//                                    break;
//                                case 206:
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice3"] isKindOfClass:[NSNull class]])
//                                    {
//                                        label1.text = @"";
//                                        
//                                    }else
//                                    {
//                                        label1.text = [NSString stringWithFormat:@"现：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice3"] floatValue]];
//                                    }
//                                    break;
//                                case 207:
//                                    if ([[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice4"] isKindOfClass:[NSNull class]])
//                                    {
//                                        label1.text = @"";
//                                        
//                                    }else
//                                    {
//                                        label1.text = [NSString stringWithFormat:@"现：%.2f",[[[result1 objectForKey:@"value"] objectForKey:@"lightPrePrice4"] floatValue]];
//                                    }
//                                    break;
//                                    
//                                default:
//                                    break;
//                            }
//                            
//                        }
//                        
//                        
//                        
//                    }
//                    
//                    [_activity stop];
//                    
//                }else if ([[result1 objectForKey:@"code"]isEqualToString:@"0"])
//                {
//                    [_activity stop];
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"服务端异常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [alert show];
//                    
//                }else if ([[result1 objectForKey:@"code"]isEqualToString:@"100"])
//                {
//                    [_activity stop];
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"非法请求" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [alert show];
//                    
//                    
//                }else if ([[result1 objectForKey:@"code"]isEqualToString:@"101"])
//                {
//                    [_activity stop];
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"非法请求" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [alert show];
//                    
//                }else if ([[result1 objectForKey:@"code"]isEqualToString:@"102"])
//                {
//                    [_activity stop];
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [alert show];
//                }else if ([[result1 objectForKey:@"code"]isEqualToString:@"103"])//记录不存在
//                {
//                    [_activity stop];
//                    [self createNoView];
//                }
//                
//            }
//            
//            
//        }
//

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

-(void)setHub:(NSString *)string
{
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:[[UIApplication sharedApplication].windows count]-1];
    MBProgressHUD *indicator = [[MBProgressHUD alloc] initWithWindow:window];
    indicator.labelText = string;
    indicator.mode = MBProgressHUDModeText;
    [window addSubview:indicator];
    [indicator showAnimated:YES whileExecutingBlock:^{
        sleep(1.2);
    } completionBlock:^{
        [indicator removeFromSuperview];
    }];
    
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
