//
//  BtnTableViewCell.m
//  ZhuanXB
//
//  Created by shanchen on 15/6/12.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import "BtnTableViewCell.h"

@implementation BtnTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        self.backgroundColor = [UIColor clearColor];
       //起始地label
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 7, 80, 30)];
        _contentLabel.textColor = ZhuanXB_color(0x454545);
        [self addSubview:_contentLabel];
        //地区label
        _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-60-175, 7, 180, 30)];
        _areaLabel.textColor = ZhuanXB_color(0x9f9f9f);
//        _areaLabel.backgroundColor = [UIColor redColor];
        _areaLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_areaLabel];
        
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
