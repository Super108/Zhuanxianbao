//
//  JCTopic.m
//  PSCollectionViewDemo
//
//  Created by jc on 14-1-7.
//
//

#import "JCTopic.h"
@implementation JCTopic
@synthesize JCdelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setSelf];
    }
    return self;
}
-(void)setSelf{
    self.pagingEnabled = YES;
    self.scrollEnabled = YES;
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self setSelf];
    
    // Drawing code
}
-(void)upDate{
    NSMutableArray * tempImageArray = [[NSMutableArray alloc]init];
    
    
    [tempImageArray addObject:[self.pics lastObject]];
    
//    NSLog(@"%@",tempImageArray);
    
    for (id obj in self.pics) {
        [tempImageArray addObject:obj];
    }
    [tempImageArray addObject:[self.pics objectAtIndex:0]];
    if(self.pics.count ==1)
    {
        self.scrollEnabled = NO;
    }
    self.pics = Nil;
    self.pics = tempImageArray;
   
    int i = 0;
    for (id obj in self.pics) {
        pic= Nil;
        
        
//         UIImage * newimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[obj objectForKey:@"pic"]]]];
       
        
        
        pic = [UIButton buttonWithType:UIButtonTypeCustom];
        pic.imageView.contentMode = UIViewContentModeTop;
        [pic setFrame:CGRectMake(i*self.frame.size.width,0, self.frame.size.width, self.frame.size.height)];
        UIImageView * tempImage = [[UIImageView alloc] init];
        
//        NSLog(@"%f,%f",tempImage.frame.size.width,tempImage.frame.size.height);
//        tempImage.contentMode = UIViewContentModeScaleToFill;
//        [tempImage setClipsToBounds:YES];
        
        if ([[obj objectForKey:@"isLoc"]boolValue]) {
            [tempImage setImage:[obj objectForKey:@"pic"]];
        }else{
            if ([obj objectForKey:@"placeholderImage"]) {
                UIImage *aImage =[obj objectForKey:@"placeholderImage"];
                
                float aspect = aImage.size.height / aImage.size.width;//图片的宽高比例
                NSLog(@"%f",aspect);
                
                
                
                tempImage.frame=CGRectMake(0, 0, pic.frame.size.width, pic.frame.size.width*aspect);
                
                
                [tempImage setImage:aImage];

            }
            [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[obj objectForKey:@"pic"]]]
                                               queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                                   if (!error && responseCode == 200) {
                                                       tempImage.image = Nil;
                                                       UIImage *_img = [[UIImage alloc] initWithData:data];
                                                        float aspect = _img.size.height / _img.size.width;//图片的宽高比例
                                                       tempImage.frame=CGRectMake(0, 0, pic.frame.size.width, pic.frame.size.width*aspect);
                                                       
                                                        [tempImage setImage:_img];
                                                   }else{
                                                       if ([obj objectForKey:@"placeholderImage"]) {
                                                           
                                                           UIImage *aImage =[obj objectForKey:@"placeholderImage"];
                                                           
                                                           float aspect = aImage.size.height / aImage.size.width;//图片的宽高比例
                                                           NSLog(@"%f",aspect);
                                                           
                                                           
                                                           
                                                           tempImage.frame=CGRectMake(0, 0, pic.frame.size.width, pic.frame.size.width*aspect);
                                                           
                                                           
                                                           [tempImage setImage:aImage];
                                                       }
                                                   }
                                               }];
        }
//        [tempImage setClipsToBounds:YES];
//        tempImage.contentMode = UIViewContentModeScaleAspectFit;
//        if([[obj objectForKey:@"enable"] boolValue])
//        {
//            pic.enabled = YES;
//        }
//        else
//        {
//            pic.enabled = NO;
//        }

        
        [pic addSubview:tempImage];
        [pic setBackgroundColor:ZhuanXB_color(0xf0f0f0)];
        pic.tag = i;
        [pic addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pic];

        i ++;
    }
    [self setContentSize:CGSizeMake(self.frame.size.width*[self.pics count], self.frame.size.height)];
//    NSLog(@"%f",self.frame.size.width*[self.pics count]);
    
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    

    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
        
    }
    if ([self.pics count]>3) {
        scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollTopic) userInfo:nil repeats:YES];
    }
    else
    {
        [self setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    }

}
-(void)click:(id)sender{
   
//    NSLog(@"%@,"[self.pics objectAtIndex:[sender tag]]);
    
    [JCdelegate didClick:[self.pics objectAtIndex:[sender tag]]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat Width=self.frame.size.width;
    if (scrollView.contentOffset.x == self.frame.size.width) {
        flag = YES;
    }
    if (flag) {
        if (scrollView.contentOffset.x <= 0) {
            [self setContentOffset:CGPointMake(Width*([self.pics count]-2), 0) animated:NO];
        }else if (scrollView.contentOffset.x >= Width*([self.pics count]-1)) {
            [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        }
    }
    currentPage = scrollView.contentOffset.x/self.frame.size.width-1;
    [JCdelegate currentPage:currentPage total:[self.pics count]-2];
    scrollTopicFlag = currentPage+2==2?2:currentPage+2;
}
-(void)scrollTopic{
    [self setContentOffset:CGPointMake(self.frame.size.width*scrollTopicFlag, 0) animated:YES];
    
    if (scrollTopicFlag > [self.pics count]) {
        scrollTopicFlag = 1;
    }else {
        scrollTopicFlag++;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollTopic) userInfo:nil repeats:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
    }
    
}
-(void)releaseTimer{
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
        
    }
}



@end
