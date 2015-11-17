//
//  ProjectTagsController.h
//  HeLiWangYeWuBang
//
//  Created by 赵子辉 on 15/10/19.
//  Copyright © 2015年 ZhongLianHeLi. All rights reserved.
//
#import <UIKit/UIKit.h>
@class ProjectTagsController;
typedef void (^TagClick)(long);

@interface ProjectTagsController:UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *tagCollectionView;
@property(nonatomic,copy)TagClick block;
@end
