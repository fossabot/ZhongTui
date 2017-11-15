//
//  UIView+YYViewFrame.m
//  壹元服务
//
//  Created by VINCENT on 2017/3/22.
//  Copyright © 2017年 北京京壹元资讯信息服务有限公司. All rights reserved.
//

#import "UIView+YYViewFrame.h"

@implementation UIView (YYViewFrame)


/**
 加载xib返回，对象

 @return 返回View
 */
+ (instancetype)viewFromXib {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}


- (void)setX:(CGFloat)x

{
    
    CGRect frame = self.frame;
    
    frame.origin.x = x;
    
    self.frame = frame;
    
}

- (CGFloat)x

{
    
    return self.frame.origin.x;
    
}

- (void)setY:(CGFloat)y
{
    
    CGRect frame = self.frame;
    
    frame.origin.y = y;
    
    self.frame = frame;
    
}

- (CGFloat)y

{
    
    return self.frame.origin.y;
    
}

- (void)setOrigin:(CGPoint)origin

{
    
    CGRect frame = self.frame;
    
    frame.origin = origin;
    
    self.frame = frame;
    
}

- (CGPoint)origin

{
    
    return self.frame.origin;
    
}

- (void)setWidth:(CGFloat)width

{
    
    CGRect frame = self.frame;
    
    frame.size.width = width;
    
    self.frame = frame;
    
}

- (CGFloat)width

{
    
    return self.frame.size.width;
    
}

- (void)setHeight:(CGFloat)height

{
    
    CGRect frame = self.frame;
    
    frame.size.height = height;
    
    self.frame = frame;
    
}

- (CGFloat)height

{
    
    return self.frame.size.height;
    
}

- (void)setSize:(CGSize)size

{
    
    CGRect frame = self.frame;
    
    frame.size = size;
    
    self.frame = frame;
    
}

- (CGSize)size

{
    
    return self.frame.size;
    
}

- (void)setCenterX:(CGFloat)centerX

{
    
    CGPoint center = self.center;
    
    center.x = centerX;
    
    self.center = center;
    
}

- (CGFloat)centerX

{
    
    return self.center.x;
    
}

- (void)setCenterY:(CGFloat)centerY

{
    
    CGPoint center = self.center;
    
    center.y = centerY;
    
    self.center = center;
    
}

- (CGFloat)centerY

{
    
    return self.center.y;
    
}


/** yy_系列 避免与masonry冲突*/

- (void)setYy_x:(CGFloat)yy_x

{

    CGRect frame = self.frame;

    frame.origin.x = yy_x;

    self.frame = frame;

}

- (CGFloat)yy_x

{

    return self.frame.origin.x;

}

- (void)setYy_y:(CGFloat)yy_y
{

    CGRect frame = self.frame;

    frame.origin.y = yy_y;

    self.frame = frame;

}

- (CGFloat)yy_y

{

    return self.frame.origin.y;

}

- (void)setYy_origin:(CGPoint)yy_origin

{

    CGRect frame = self.frame;

    frame.origin = yy_origin;

    self.frame = frame;

}

- (CGPoint)yy_origin

{

    return self.frame.origin;

}

- (void)setYy_width:(CGFloat)yy_width

{

    CGRect frame = self.frame;

    frame.size.width = yy_width;

    self.frame = frame;

}

- (CGFloat)yy_width

{

    return self.frame.size.width;

}

- (void)setYy_height:(CGFloat)yy_height

{

    CGRect frame = self.frame;

    frame.size.height = yy_height;

    self.frame = frame;

}

- (CGFloat)yy_height

{

    return self.frame.size.height;

}

- (void)setYy_size:(CGSize)yy_size

{

    CGRect frame = self.frame;

    frame.size = yy_size;

    self.frame = frame;

}
 
- (CGSize)yy_size

{

    return self.frame.size;
 
}

- (void)setYy_center:(CGPoint)yy_center

{
    self.center = yy_center;
}

- (CGPoint)yy_center

{
    return self.center;
}

- (void)setYy_centerX:(CGFloat)yy_centerX

{

    CGPoint center = self.center;

    center.x = yy_centerX;

    self.center = center;

}

- (CGFloat)yy_centerX

{

    return self.center.x;

}

- (void)setYy_centerY:(CGFloat)yy_centerY

{

    CGPoint center = self.center;

    center.y = yy_centerY;

    self.center = center;

}

- (CGFloat)yy_centerY

{

    return self.center.y;

}
 

@end
