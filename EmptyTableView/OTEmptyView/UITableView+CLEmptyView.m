//
//  UITableView+CLEmptyView.m
//  一对多教程
//
//  Created by hezhijingwei on 2017/7/12.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "UITableView+CLEmptyView.h"
#import <objc/message.h>


@interface UITableView ()

@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic) UITableViewCellSeparatorStyle cellSeparatorStyle;

@end


@implementation UITableView (CLEmptyView)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self methodSwizzlingWithOriginalSelector:@selector(reloadData) bySwizzlingedSelector:@selector(new_reloadData)];
        
    });
    
}

- (void)setEmptystyle:(CLEmptyViewStyle)emptystyle {
    
    objc_setAssociatedObject(self, @selector(emptystyle), @(emptystyle), OBJC_ASSOCIATION_ASSIGN);
}

- (CLEmptyViewStyle)emptystyle {
    return [objc_getAssociatedObject(self, @selector(emptystyle)) integerValue];
}

- (void)setCellSeparatorStyle:(UITableViewCellSeparatorStyle)cellSeparatorStyle {
    objc_setAssociatedObject(self, @selector(cellSeparatorStyle), @(cellSeparatorStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (UITableViewCellSeparatorStyle)cellSeparatorStyle {
    return [objc_getAssociatedObject(self, @selector(cellSeparatorStyle)) integerValue];
}

- (void)setEmptyView:(UIView *)emptyView {
    objc_setAssociatedObject(self, @selector(emptyView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)emptyView {
    UIView *view = objc_getAssociatedObject(self, @selector(emptyView));
    return view;
}



- (void)showView {
    self.cellSeparatorStyle = self.separatorStyle;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.emptyView];
}

- (void)hiddenView {
    self.separatorStyle = self.cellSeparatorStyle;
    [self.emptyView removeFromSuperview];
}


- (void)new_reloadData {
    BOOL isEmpty = [self checkIsEmpty];
    if (isEmpty) {
        [self showView];
    } else {
        [self hiddenView];
    }
    [self new_reloadData];
}


- (BOOL)checkIsEmpty {
        
    NSUInteger sections = 1;
    NSUInteger row = 0;
    
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [self.dataSource numberOfSectionsInTableView:self];
    }
    
    for (NSInteger index = 0; index < sections;index ++) {
        
        if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            row = [self.dataSource tableView:self numberOfRowsInSection:index];
        }
        
        // 如果有一个数据说明数据存在   直接返回不是空的 并终止方法
        if (row) {
            return NO;
        }
    }
    return YES;
}


+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzlingedSelector:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod([self class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    
    BOOL didAddMethod = class_addMethod([self class], originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod([self class], swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
