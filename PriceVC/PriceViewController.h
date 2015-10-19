//
//  PriceViewController.h
//  ZhuanXB
//
//  Created by 康冬 on 15/6/10.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_myTableView ;
    //查询前的view
    
    UIView *_firstView;
    //查询后的view
    
    UIView *_secondView;
    //八个label
    UILabel *_label;
    //时效label
    UILabel *_timeLabel;
    UIScrollView *scrollView;
    
    UIView *_noInfoView;
    Activity *_activity;
    
    
    UITextView *vie;
    
}
@property(nonatomic,retain)NSString *startAreaCodeString;
@property(nonatomic,retain)NSString *endAreaCodeString;
@property(nonatomic,retain)NSString *startAreaNameString;
@property(nonatomic,retain)NSString *endAreaNameString;

@end
