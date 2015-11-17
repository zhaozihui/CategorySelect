//
//  ProjectTagsController.m
//  HeLiWangYeWuBang
//
//  Created by 赵子辉 on 15/10/19.
//  Copyright © 2015年 ZhongLianHeLi. All rights reserved.
//

#import "ProjectTagsController.h"
#import "TagCell.h"
#import "TagHeaderView.h"
@interface ProjectTagsController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ProjectTagsController
{
    BOOL editModel;
    NSMutableArray *data,*data2;
    long index;
    NSDictionary *category;
    
}
@synthesize tagCollectionView;

- (void)viewDidLoad {
    editModel = NO;
    index = 0;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    category = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSMutableArray *tags = [[NSMutableArray alloc] initWithArray:[category allKeys]];
    
    
    data = [NSMutableArray arrayWithArray:@[@"推荐"]];
    
    data2 = [NSMutableArray arrayWithArray:tags];

    NSArray* newArray=[NSArray arrayWithArray:data2];
    for (int i =0 ; i<[newArray count]; i++)
    {
        id item=[newArray objectAtIndex:i];
        if ([data containsObject:item])
        {
            [data2 removeObject:item];
        }
    }
    tagCollectionView.frame = CGRectMake(0, 0, 320, 640);
    [tagCollectionView registerClass:[TagCell class] forCellWithReuseIdentifier:@"TagCell"];
    tagCollectionView.backgroundColor = [UIColor whiteColor];
    tagCollectionView.delegate = self;
    tagCollectionView.dataSource = self;
    [tagCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TagHeaderView"];
    [tagCollectionView registerNib:[UINib nibWithNibName:@"TagHeaderView" bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"TagHeaderView"];
    
    
    UIPanGestureRecognizer *longPress = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    [tagCollectionView addGestureRecognizer:longPress];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return [data count];
    }
    if (section == 1 && !editModel)  {
        return [data2 count];
    }
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (editModel) {
        return 1;
    } else {
        return 2;
    }
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    return CGSizeMake(75, 40);
}

- (UICollectionReusableView*)collectionView:(UICollectionView*)collectionView viewForSupplementaryElementOfKind:(NSString*)kind atIndexPath:(NSIndexPath*)indexPath
{
    
    UICollectionReusableView* reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader ) {
        
        TagHeaderView* headerView = (TagHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TagHeaderView" forIndexPath:indexPath];
        
        
        [headerView setSectionView:[indexPath section]];
        [headerView.arrowBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [headerView.actionBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        if (editModel) {
            [headerView setEditModel];
        } else {
            [headerView setShowModel];
        }
        reusableview = headerView;
        reusableview.backgroundColor = [indexPath section]==0?[UIColor whiteColor]:[UIColor lightGrayColor];
    }

    return reusableview;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
 //   TagCell *cell = [TagCell initCellWithCollectionView:collectionView indexPath:indexPath];
    static NSString * identifier = @"TagCell";
    TagCell *cell = (TagCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([indexPath section] == 0)
    {
        cell.title.text = [data objectAtIndex:[indexPath row]];
        if ([indexPath row] == 0) {
            // cell.title.text = @"推荐";
             cell.title.textColor = [UIColor greenColor];
        }
        
        if (editModel)
        {
            [cell setEditModel];
        } else
        {
            [cell setShowModel];
        }
    }
    if ([indexPath section] == 1)
    {
        cell.title.text = [data2 objectAtIndex:[indexPath row]];
        [cell setShowModel];

    }
   
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] == 0)
    {
       
        if (editModel) {
            if ([indexPath row] == 0)
            {
                return;
            }
            [data2 addObject:[data objectAtIndex:[indexPath row]]];
            [data removeObjectAtIndex:[ indexPath row]];
            [tagCollectionView reloadData];
        } else {
           
            index = [indexPath row];
            [self backAction];
        }
    } else {
        
        [data addObject:[data2 objectAtIndex:[indexPath row]]];
        [data2 removeObjectAtIndex:[ indexPath row]];
        [tagCollectionView reloadData];
    }
}

- (void)editAction:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"完成"]) {
        editModel = NO;
        NSMutableArray *ids = [[NSMutableArray alloc] init];
        for(NSString *keyStr in category)
        {
            if([data containsObject:keyStr])
            {
                [ids addObject:[category objectForKey:keyStr]];
            }
        }
        [tagCollectionView reloadData];
        

    } else {
        editModel = YES;
        [tagCollectionView reloadData];
    }
    
}
- (void)backAction
{

    _block(index);
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


- (IBAction)panGestureRecognized:(id)sender {
    
    UIPanGestureRecognizer *longPress = (UIPanGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:tagCollectionView];
    NSIndexPath *indexPath = [tagCollectionView indexPathForItemAtPoint:location];
    if ([indexPath section] == 1 || !editModel) {
        return;
    }


    NSLog(@"indexPath section:%d,row:%d",[indexPath section],[indexPath row]);
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            
            if (indexPath) {
                sourceIndexPath = indexPath;
               
                UICollectionViewCell *cell = [tagCollectionView cellForItemAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [tagCollectionView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    center.x = location.x;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    
                    // Fade out.
                    cell.alpha = 0.0;
                } completion:nil];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            center.x = location.x;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath] && [sourceIndexPath row] !=0 &&[indexPath row] !=0) {
                
                // ... update data source.
                [data exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [tagCollectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default: {
            // Clean up.
            UICollectionViewCell *cell = [tagCollectionView cellForItemAtIndexPath:sourceIndexPath];
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                
                // Undo the fade-out effect we did.
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            sourceIndexPath = nil;
            break;
        }
    }
}

#pragma mark - Helper methods

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

@end
