//
//  AppDelegate.h
//  ZhuanXB
//
//  Created by shanchen on 15/6/10.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

{
    CLLocationManager *_locationManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

