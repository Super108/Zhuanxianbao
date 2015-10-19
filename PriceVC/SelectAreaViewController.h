//
//  SelectAreaViewController.h
//  ZhuanXB
//
//  Created by 康冬 on 15/6/10.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)(NSString *,NSString*);

@interface SelectAreaViewController : UIViewController

{
    NSInteger _currentCompent;
    NSInteger _currentRow;
    
    NSInteger _currentProvinceNum;
    NSInteger _currentCityNum;
    
}


@property (nonatomic,strong )block backBlock;
-(void)getArea:(void(^)(NSString *,NSString*))myBlock;

@end
