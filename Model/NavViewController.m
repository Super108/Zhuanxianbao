//
//  NavViewController.m
//  KbWireless
//
//  Created by niufuwei on 14-3-9.
//  Copyright (c) 2014年 niufuwei. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController
#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion doubleValue]


static NSString *no_select_backImageName = @"640返回.png";
static NSString *selected_backImageName = @"640返回.png";



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(id)initWithRootViewController:(UIViewController *)rootViewController{

    if([super initWithRootViewController:rootViewController]){
        
    }
    return self;
}

-(void)popself{

    if([self.viewControllers count]>1){
        [self popViewControllerAnimated:YES];
    }else{
        [self.topViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void) setLeftItem: (UIViewController *)VC{
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 38/2, 36/2);
    [backButton setBackgroundImage: [UIImage imageNamed:selected_backImageName] forState:UIControlStateHighlighted];
    [backButton setBackgroundImage: [UIImage imageNamed:selected_backImageName] forState:UIControlStateNormal];
    
    backButton.backgroundColor=[UIColor clearColor];

    
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    if([UIDevice currentDevice].systemVersion.floatValue >= 7.0f){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -7.5;
        VC.navigationItem.leftBarButtonItems = @[negativeSpacer, leftButtonItem];
    }
    else{
        VC.navigationItem.leftBarButtonItem = leftButtonItem;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.interactivePopGestureRecognizer.enabled=YES;
    
    if(SYSTEM_VERSION <7.0)
    {
        
        self.navigationBar.tintColor = ZhuanXB_color(0xe52e2e);
    }
    else
    {
        self.navigationBar.barTintColor = ZhuanXB_color(0xe52e2e);;
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    }
    
    
    self.navigationBar.translucent = NO;
    
    if(self.topViewController != nil && self.topViewController.navigationItem.backBarButtonItem == nil && self.topViewController.navigationItem.leftBarButtonItem == nil
       )
    {
        [self setLeftItem:self.topViewController];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if(self.navigationBarHidden)
    {
        [self setNavigationBarHidden:NO animated:YES];
    }
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count > 1)
    {
        [self setLeftItem:viewController];
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.interactivePopGestureRecognizer.delegate = self;
        }
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    if (self.viewControllers.count == 1) {
        return NO;
    }else{
    
        return YES;
    }
    return nil;
    

}
@end
