//
//  TrackingViewController.h
//  ZhuanXB
//
//  Created by shanchen on 15/6/11.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackingViewController : UIViewController

{
    Activity *_activity;
    
    //运单号
    UILabel *yundanLabel;
    //面单号
    UILabel *miandanLabel;
    
    //图片旁边 上面的label
    UILabel *_topLabel;
    //图片旁边 下面的label
    UILabel *_bottomLabel;
    
    NSMutableArray *_listArr;
    
    //头部view
    UIView *headerView;
    
    UIView *_noInfoView;
}

@property (nonatomic,strong) NSString *snString;


@end
