//
//  UIView+CornerRadius.h
//  ViewCorner
//
//  Created by hailong9 on 2018/4/16.
//  Copyright © 2018年 Weibo. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,UIViewCornerPosition){
    TopLeftPosition,
    TopRigthPosition,
    BottomLeftPosition,
    BottomRightPosition,
};
@interface UIView (CornerRadius)
- (void)cornerRadiu:(CGFloat)radiu poistion:(UIViewCornerPosition) position backGroundColor:(UIColor*)background;
- (void)cornerRadiu:(CGFloat)radiu  backGroundColor:(UIColor *)background;
- (void)setBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color;
@end
