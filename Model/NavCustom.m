//
//  NavCustom.m
//  ELiuYan
//
//  Created by laoniu on 14-4-29.
//  Copyright (c) 2014年 chaoyong.com. All rights reserved.
//

#import "NavCustom.h"
#import "DefineModel.h"


@implementation NavCustom
@synthesize NavDelegate;

-(void)setNav:(NSString *)NavTitile mySelf:(UIViewController *)mySelf
{
    UILabel * lab;
    if(IOS_VERSION <7)
    {
        lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
    }
    else
    {
        lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    }
    
    [lab setFont:[UIFont systemFontOfSize:17.0]];
    lab.textColor = [UIColor whiteColor];
    lab.text = NavTitile;
    lab.backgroundColor = [UIColor clearColor];
    mySelf.navigationItem.titleView = lab;
    
}


-(void)setNavRightBtnTitle:(NSString *)RightBtnTitle mySelf:(UIViewController *)mySelf
{
    //创建右边按钮
    UIButton *rightBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    //判断字体大小
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isBigOrSmall"] isEqualToString:@"font"]) {
        rightBackBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    [rightBackBtn setTitle:RightBtnTitle forState:UIControlStateNormal];
    
    [rightBackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBackBtn addTarget:self action:@selector(NavRightButtononClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加进BARBUTTONITEM
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBackBtn];
    
    //右按钮
    mySelf.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)setNavRightBtnImage:(NSString *)RightBtnImage RightBtnSelectedImage:(NSString *)RightBtnSelectedImage mySelf:(UIViewController *)mySelf
{
    //创建右边按钮
    UIButton *rightBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(-30, 0, 45, 25)];
    
    [rightBackBtn setBackgroundImage:[UIImage imageNamed:RightBtnImage] forState:UIControlStateNormal];
    [rightBackBtn setBackgroundImage:[UIImage imageNamed:RightBtnSelectedImage] forState:UIControlStateHighlighted];
    [rightBackBtn addTarget:self action:@selector(NavRightButtononClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加进BARBUTTONITEM
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBackBtn];
    
    //右按钮
    mySelf.navigationItem.rightBarButtonItem = rightBtn;
    
}

- (void) NavRightButtononClick{
    
    if ([NavDelegate respondsToSelector:@selector(NavRightButtononClick)])
    {//判断方法是否实现
        [NavDelegate NavRightButtononClick];
    }
}




@end
