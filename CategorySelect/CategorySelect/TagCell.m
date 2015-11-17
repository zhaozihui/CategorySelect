//
//  TagCell.m
//  HeLiWangYeWuBang
//
//  Created by 赵子辉 on 15/10/19.
//  Copyright © 2015年 ZhongLianHeLi. All rights reserved.
//

#import "TagCell.h"

@implementation TagCell
@synthesize delMark,bgImg,title;
- (void)awakeFromNib {

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        // 初始化时加载WLImageViewCell文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"TagCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}
- (void)setEditModel
{
    if(![title.text isEqualToString:@"推荐"])
    {
        delMark.hidden = NO;
        [bgImg setImage:[UIImage imageNamed:@"tag_border_edit"]];
    } else {
        delMark.hidden = YES;
        [bgImg setImage:[UIImage imageNamed:@"tag_border"]];
    }
    //title.textColor = [V getColor:BASE_LIGHT_GRAY];
}
- (void)setShowModel
{
    delMark.hidden = YES;
    [bgImg setImage:[UIImage imageNamed:@"tag_border"]];
    //title.textColor = [V getColor:BASE_COLOR_GREEN];
}
@end
