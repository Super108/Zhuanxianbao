//
//  WebViewController.h
//  ELiuYan
//
//  Created by eliuyan_mac on 14-5-2.
//  Copyright (c) 2014年 chaoyong.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"


@interface WebViewController : UIViewController <UIWebViewDelegate,UIAlertViewDelegate>
{

    Activity *_activity;
    
}

@property (nonatomic,strong) NSString * url;
@property(nonatomic,strong)NSString *name;
@end
