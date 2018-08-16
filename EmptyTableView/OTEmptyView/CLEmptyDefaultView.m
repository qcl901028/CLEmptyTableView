//
//  CLEmptyDefaultView.m
//  study
//
//  Created by 秦传龙 on 2018/8/15.
//  Copyright © 2018年 秦传龙. All rights reserved.
//

#import "CLEmptyDefaultView.h"

@interface CLEmptyDefaultView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *subLabel;
@property (nonatomic, strong) UIButton *button;

@end

@implementation CLEmptyDefaultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+ (instancetype)emptyViewWithDelegate:(id<CLEmptyDefaultViewDelegate>)emptyDelegate{
    CLEmptyDefaultView *defaultView = [[CLEmptyDefaultView alloc] initWithFrame:CGRectZero];
    defaultView.emptyDelegate = emptyDelegate;
    return defaultView;
}


- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.font = [UIFont systemFontOfSize:16];
        _label.text = @"我是空页面";
        _label.textAlignment = NSTextAlignmentCenter;
         [self addSubview:_label];
    }
    return _label;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subLabel.font = [UIFont systemFontOfSize:14];
        _subLabel.text = @"我是子标题我是子标题";
        _subLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1];
        _subLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_subLabel];
    }
    return _subLabel;
}

//84, 190,179
- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.layer.borderColor = [UIColor colorWithRed:84/255.0 green:190/255.0 blue:179/255.0 alpha:1].CGColor;
        _button.layer.borderWidth = 1;
        [_button setTitle:@"重试" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorWithRed:84/255.0 green:190/255.0 blue:179/255.0 alpha:1] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        _button.layer.cornerRadius = 3;
        _button.layer.masksToBounds = YES;
        [_button addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return _button;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"notWork"];
        [self addSubview:_imageView];
    }
    return _imageView;
}




- (void)didMoveToSuperview {
    
    self.frame = self.superview.bounds;
    UIImage *img = self.imageView.image;
    CGFloat width = img.size.width;
    CGFloat height = img.size.height;
    if (width > 128) {
        height = 128/width * height;
        width = 128;
    }
    
    CGFloat totalHeight = 105 + height;
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    CGFloat startX = (selfHeight - totalHeight)*0.6;
    
    self.imageView.frame = CGRectMake((CGRectGetWidth(self.frame)-width)/2, startX, width, height);
    self.label.frame = CGRectMake(50, CGRectGetMaxY(self.imageView.frame) + 20, self.frame.size.width-100, 20);
    self.subLabel.frame = CGRectMake(50, CGRectGetMaxY(self.label.frame), self.frame.size.width-100, 20);
    self.button.frame = CGRectMake((CGRectGetWidth(self.frame)-60)/2, CGRectGetMaxY(self.subLabel.frame)+15, 60, 30);
    
}

- (void) refresh {
    if (_emptyDelegate && [_emptyDelegate respondsToSelector:@selector(emptyDefaultViewDidClickRefresh:)]) {
        [_emptyDelegate emptyDefaultViewDidClickRefresh:self];
    }
}


- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        self.label.text = title;
    }
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        self.imageView.image = image;
    }
}

- (void)setSubTitle:(NSString *)subTitle {
    if (_subTitle != subTitle) {
        _subTitle = subTitle;
        self.subLabel.text = subTitle;
    }
}

- (void)setBtnTitle:(NSString *)btnTitle {
    if (_btnTitle != btnTitle) {
        _btnTitle = btnTitle;
        [self.button setTitle:btnTitle forState:UIControlStateNormal];
    }
}


@end
