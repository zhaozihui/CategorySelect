//
//  ViewController.m
//  CategorySelect
//
//  Created by 赵子辉 on 15/11/17.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "ViewController.h"
#import "ProjectTagsController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMe:(id)sender {
    ProjectTagsController *tagsC = [[ProjectTagsController alloc] init];
    tagsC.view.frame = CGRectMake(0, 20, 320, 640);
    tagsC.block = ^(long index)
    {
        NSLog(@"indexTT:%ld",index);

    };
    [self.view addSubview:tagsC.view];
    [self addChildViewController:tagsC];


}

@end
