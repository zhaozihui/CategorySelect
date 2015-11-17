//
//  TagCell.h
//  HeLiWangYeWuBang
//
//  Created by 赵子辉 on 15/10/19.
//  Copyright © 2015年 ZhongLianHeLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagCell : UICollectionViewCell
- (void)setEditModel;
- (void)setShowModel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *delMark;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@end
