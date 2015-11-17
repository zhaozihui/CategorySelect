//
//  TagHeaderView.m
//  HeLiWangYeWuBang
//
//  Created by 赵子辉 on 15/10/19.
//  Copyright © 2015年 ZhongLianHeLi. All rights reserved.
//

#import "TagHeaderView.h"

@implementation TagHeaderView
@synthesize title,actionBtn,arrowBtn,bottomLine;
- (void)awakeFromNib {
    // Initialization code
    actionBtn.layer.borderWidth = 1;
    actionBtn.layer.borderColor = [UIColor greenColor].CGColor;
    actionBtn.layer.masksToBounds = YES;
    actionBtn.layer.cornerRadius =  actionBtn.frame.size.height/2;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        // 初始化时加载WLImageViewCell文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"TagHeaderView" owner:self options:nil];
        
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
- (void) setSectionView:(long)section
{
    if (section == 0) {
        self.backgroundColor = [UIColor whiteColor];
        title.text = @"切换工程类别";
        actionBtn.hidden = NO;
        arrowBtn.hidden = NO;
    } else {
        self.backgroundColor = [UIColor whiteColor];
        title.text = @"点击添加更多类别";
        actionBtn.hidden = YES;
        arrowBtn.hidden = YES;
    }
}

- (void) setEditModel
{
    [actionBtn setTitle:@"完成" forState:UIControlStateNormal];
}
- (void) setShowModel
{
    [actionBtn setTitle:@"排序/删除" forState:UIControlStateNormal];
}
@end
