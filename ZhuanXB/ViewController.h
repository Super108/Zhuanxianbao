//
//  ViewController.h
//  ZhuanXB
//
//  Created by shanchen on 15/6/10.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JCTopic.h"
#import "Activity.h"
#import "httpRequest.h"
@interface ViewController : UIViewController
<httpRequestDelegate>

{
     Activity *_activity;
    
    UIPageControl* _myPageControl;
    UIImageView *_headerImage;
    NSMutableArray *_urlArray;
    NSMutableArray *_activityIdArray;
    NSMutableArray *_titleArray;
    NSString *_titleName;

}

//@property (nonatomic,strong) JCTopic * Topic;
@end

