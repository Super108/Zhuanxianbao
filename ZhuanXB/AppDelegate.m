//
//  AppDelegate.m
//  ZhuanXB
//
//  Created by shanchen on 15/6/10.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NavViewController.h"


//#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
//
//#import <BaiduMapAPI/BMKMapView.h>//只引入所需的单个头文件


@interface AppDelegate ()

//{
//    BMKMapManager* _mapManager;
//}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//
//    // 要使用百度地图，请先启动BaiduMapManager
//    _mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定 generalDelegate参数
//    BOOL ret = [_mapManager start:@"WLGGa8eQwOo6aGFGlZdgQd82"  generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    
   
    
    
    ViewController *mainVC=[[ViewController alloc] init];
    NavViewController *nav=[[NavViewController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = nav;

    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(MoveToMain)
                                                 name: @"MoveToMain"
                                               object: nil];
    
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        //定位初始化
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        [_locationManager startUpdatingLocation];//开启定位
    }else {
        //提示用户无法进行定位操作
        
    }

    
    return YES;
}
-(void)MoveToMain{
    
    ViewController *mainVC=[[ViewController alloc] init];
    NavViewController *nav=[[NavViewController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = nav;
}

//获得位置信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currLocation = [locations lastObject];
    NSLog(@"纬度=%f，经度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude);
    //    NSLog(@"%f",_latitude);
    NSString *latitude = [NSString stringWithFormat:@"%f",currLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",currLocation.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"longitude"];
    
    [manager stopUpdatingLocation];
    
    CLLocation *c = [[CLLocation alloc] initWithLatitude:currLocation.coordinate.latitude longitude:currLocation.coordinate.longitude];
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:c
     //反向地理编码
     
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     if (!error && [placemarks count] > 0)
                     {
                         NSDictionary *dict =
                         [[placemarks objectAtIndex:0] addressDictionary];
                         
                         
                         NSLog(@":::%@",dict);
                         
                         
                         if (![dict objectForKey:@"City"]) {
                             //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                            
                         }
                         
                         NSLog(@"street address: %@", [dict objectForKey:@"Street"]);
                         [_locationManager stopUpdatingLocation];
                     }
                     else
                     {
                         NSLog(@"ERROR: %@", error);
                     }
                 }];

    
}
//获取经纬度失败时候调用的代理方法
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"error = %@",error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
