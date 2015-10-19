//
//  InfoTableViewCell.m
//  ZhuanXB
//
//  Created by shanchen on 15/6/11.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, 320-12, 163/2);
        
        //分割段
        _lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        _lineImage.image = [UIImage imageNamed:@"运单详情粗斜线.png"];
        [self addSubview:_lineImage];
//        NSLog(@"%f",self.frame.size.height);
        
//        _grayImage = [[UIImageView alloc] initWithFrame:CGRectMake(20+60/2-10/2, 0, 10, 100)];
//        _grayImage.image = [UIImage imageNamed:@"运单详情长条.png"];
//        [self addSubview:_grayImage];
        //        NSLog(@"%f",self.frame.size.height);

        
        //logo
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 113/2, 163/2)];
//        _logoImage.image = [UIImage imageNamed:@"logo"];
        _logoImage.layer.cornerRadius = _logoImage.frame.size.width/2;
        [self addSubview:_logoImage];
        
        //详情
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(_logoImage.frame.origin.y+_logoImage.frame.size.width+35/2+20, 12, 220, 30)];
//        _detailLabel.text = @"就阿克苏的叫法开始的";
        _detailLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_detailLabel];
        //时间
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_detailLabel.frame.origin.x, _detailLabel.frame.origin.y+_detailLabel.frame.size.height, 220, 25)];
//        _timeLabel.text = @"就阿克苏的叫法开始的";
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_timeLabel];
        
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
