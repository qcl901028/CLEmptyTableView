//
//  UITableView+CLEmptyView.h
//  一对多教程
//
//  Created by hezhijingwei on 2017/7/12.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, CLEmptyViewStyle) {
    CLEmptyViewStyleDefault,  // 默认视图
    CLEmptySaleViewCustom   // 自定义视图
};


// 使用这个类的时候 一定要至少调用一次reloadData方法  否则第一次是空数据无法显示
@interface UITableView (CLEmptyView)

// 视图显示样式 默认是 CLEmptyViewStyleDefault  要设置emptyImage 和 emptyTitle ;
@property (nonatomic, assign) CLEmptyViewStyle emptystyle;



// 自定义视图
@property (nonatomic, strong) UIView *emptyView;



@end
