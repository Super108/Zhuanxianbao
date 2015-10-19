//
//  NavCustom.h
//  ELiuYan
//
//  Created by laoniu on 14-4-29.
//  Copyright (c) 2014年 chaoyong.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NavCustomDelegate <NSObject>
@optional

-(void)NavRightButtononClick;


@end
@interface NavCustom : NSObject
{
    id<NavCustomDelegate>NavDelegate;
}

-(void)setNav:(NSString *)NavTitile mySelf:(UIViewController *)mySelf;

-(void)setNavRightBtnTitle:(NSString *)RightBtnTitle mySelf:(UIViewController *)mySelf;

-(void)setNavRightBtnImage:(NSString *)RightBtnImage RightBtnSelectedImage:(NSString *)RightBtnSelectedImage mySelf:(UIViewController *)mySelf;



@property (nonatomic,strong) id<NavCustomDelegate>NavDelegate;

@end
