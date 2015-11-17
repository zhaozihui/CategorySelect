//
//  TagHeaderView.h
//  HeLiWangYeWuBang
//
//  Created by 赵子辉 on 15/10/19.
//  Copyright © 2015年 ZhongLianHeLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;


- (void) setSectionView:(long)section;
- (void) setEditModel;
- (void) setShowModel;
@end
