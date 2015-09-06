//
//  ViewController.m
//  HYGRUnlocked
//
//  Created by heyang on 15/9/6.
//  Copyright (c) 2015年 com.scxingdun. All rights reserved.
//
#import "HYLockView.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     *    < 一句话添加手势解锁 >
     *
     *    InView: 添加到那个视图上
     *    Target: 代理人
     */
    
    [HYLockView showInView:self.view andTarget:self];
}
//代理方法

- (void)HYLockView:(HYLockView *)lockView didSelectedPassword:(NSString *)password{
    
    NSLog(@"password = %@", password);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
