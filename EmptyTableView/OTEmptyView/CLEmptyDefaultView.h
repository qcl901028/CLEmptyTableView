//
//  CLEmptyDefaultView.h
//  study
//
//  Created by 秦传龙 on 2018/8/15.
//  Copyright © 2018年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLEmptyDefaultView;
@protocol CLEmptyDefaultViewDelegate <NSObject>

@optional
- (void)emptyDefaultViewDidClickRefresh:(CLEmptyDefaultView *)emptyView;


@end

@interface CLEmptyDefaultView : UIView


+ (instancetype)emptyViewWithDelegate:(id<CLEmptyDefaultViewDelegate>)emptyDelegate;

@property (nonatomic, weak) id<CLEmptyDefaultViewDelegate> emptyDelegate;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *btnTitle;

@end
