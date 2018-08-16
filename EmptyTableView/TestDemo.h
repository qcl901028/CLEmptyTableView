//
//  TestDemo.h
//  study
//
//  Created by 秦传龙 on 2018/8/15.
//  Copyright © 2018年 秦传龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CLEmptyView.h"


@interface TestDemo : NSObject

+ (CLEmptyDefaultView *)emptyDefultViewWithDelegate:(id<CLEmptyDefaultViewDelegate>)emptyDelegate;

@end
