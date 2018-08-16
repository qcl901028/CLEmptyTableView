//
//  TestDemo.m
//  study
//
//  Created by 秦传龙 on 2018/8/15.
//  Copyright © 2018年 秦传龙. All rights reserved.
//

#import "TestDemo.h"



@implementation TestDemo

+ (CLEmptyDefaultView *)emptyDefultViewWithDelegate:(id<CLEmptyDefaultViewDelegate>)emptyDelegate {
    CLEmptyDefaultView *defaultView = [CLEmptyDefaultView emptyViewWithDelegate:emptyDelegate];
    defaultView.title = @"无法连接到网络";
    defaultView.image = [UIImage imageNamed:@"notWork"];
    defaultView.subTitle = @"请检查网络设置或稍后重试";
    return defaultView;
}



@end
