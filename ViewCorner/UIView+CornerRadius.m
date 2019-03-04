#import "UIView+CornerRadius.h"
#import <objc/runtime.h>
@interface UIView(){
    
}
@property (nonatomic,strong)CAShapeLayer* topRightCorner;
@property (nonatomic,strong)CAShapeLayer* topLeftCorner;
@property (nonatomic,strong)CAShapeLayer* bottomRightCorner;
@property (nonatomic,strong)CAShapeLayer* bottomLeftCorner;
@property (nonatomic,strong)CAShapeLayer* borderLayer;
@property (nonatomic,assign)CGFloat cornerRadiu;
@property (nonatomic,assign)CGSize viewSize;
@end
@implementation UIView (CornerRadius)

+(void)load {
    Method leftMethod = class_getInstanceMethod([self class], @selector(layoutSubviews));
    Method rightMethod = class_getInstanceMethod([self class], @selector(cornerLayoutSubviews));
    method_exchangeImplementations(leftMethod, rightMethod);
}
- (void)cornerLayoutSubviews{
    [self cornerLayoutSubviews];
//    NSLog(@"self.frame.size %@",NSStringFromCGRect(self.frame));
    if(self.cornerRadiu == 0){
        return;
    }
    
    
    //view size changed will perform layoutsubview
    if (CGSizeEqualToSize(self.viewSize, self.frame.size) == NO)  {
        self.viewSize = self.frame.size;
        if(self.topLeftCorner != nil){
            self.topLeftCorner.path =  [self topLeftPathWithRadiu:self.cornerRadiu].CGPath;
        }
        if(self.topRightCorner != nil){
            self.topRightCorner.path =  [self topRightPathWithRadiu:self.cornerRadiu].CGPath;
        }
        if(self.bottomLeftCorner != nil){
            self.bottomLeftCorner.path =  [self bottomLeftPathWithRadiu:self.cornerRadiu].CGPath;
        }
        if(self.bottomRightCorner != nil){
            self.bottomRightCorner.path =  [self bottomRightPathWithRadiu:self.cornerRadiu].CGPath;
        }
        if (self.borderLayer != nil) {
            self.borderLayer.path = [self cornerBorderLinePath].CGPath;
        }
    }
    ///view adding subviews that will perform layoutsubview
    if(self.topLeftCorner != nil){
        [self.layer addSublayer: self.topLeftCorner];
    }
    if(self.topRightCorner != nil){
        [self.layer addSublayer: self.topRightCorner];
    }
    if(self.bottomLeftCorner != nil){
        [self.layer addSublayer: self.bottomLeftCorner];
    }
    if(self.bottomRightCorner != nil){
        [self.layer addSublayer: self.bottomRightCorner];
    }
    if (self.borderLayer != nil) {
         [self.layer addSublayer: self.borderLayer];
    }
    
}

- (CGSize)viewSize{
    NSString* sizeStr = objc_getAssociatedObject(self, (__bridge const void*)@"UIViewCornerViewSize");
    return CGSizeFromString(sizeStr);
}

- (void)setViewSize:(CGSize)viewSize{
    NSString* sizeStr = NSStringFromCGSize(viewSize);
    objc_setAssociatedObject(self, (__bridge const void *)@"UIViewCornerViewSize", sizeStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cornerRadiu{
    NSNumber* radiu = objc_getAssociatedObject(self, (__bridge const void*)@"UIViewCornerCornerRadiu");
    return [radiu floatValue];
}

- (void)setCornerRadiu:(CGFloat)cornerRadiu{
    NSNumber* radiu =  [NSNumber numberWithFloat:cornerRadiu];
    objc_setAssociatedObject(self, (__bridge const void *)@"UIViewCornerCornerRadiu", radiu, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CAShapeLayer*)topRightCorner{
    return (CAShapeLayer *)objc_getAssociatedObject(self, (__bridge const void*)@"UIViewToRightCornerLayer");
}

- (void)setTopRightCorner:(CAShapeLayer *)topRightCorner{
    objc_setAssociatedObject(self, (__bridge const void *)@"UIViewToRightCornerLayer", topRightCorner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CAShapeLayer*)topLeftCorner{
    return (CAShapeLayer *)objc_getAssociatedObject(self, (__bridge const void*)@"UIViewToLeftCornerLayer");
}

- (void)setTopLeftCorner:(CAShapeLayer *)topLeftCorner{
    objc_setAssociatedObject(self, (__bridge const void *)@"UIViewToLeftCornerLayer", topLeftCorner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CAShapeLayer*)bottomRightCorner{
    return (CAShapeLayer *)objc_getAssociatedObject(self, (__bridge const void*)@"UIViewToBottomRightCornerLayer");
}

- (void)setBottomRightCorner:(CAShapeLayer *)bottomRightCorner{
    objc_setAssociatedObject(self, (__bridge const void *)@"UIViewToBottomRightCornerLayer", bottomRightCorner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CAShapeLayer*)bottomLeftCorner{
    return (CAShapeLayer *)objc_getAssociatedObject(self, (__bridge const void*)@"UIViewToBottomLeftCornerLayer");
}

- (void)setBottomLeftCorner:(CAShapeLayer *)bottomLeftCorner{
    objc_setAssociatedObject(self, (__bridge const void *)@"UIViewToBottomLeftCornerLayer", bottomLeftCorner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CAShapeLayer*)borderLayer{
    return (CAShapeLayer *)objc_getAssociatedObject(self, (__bridge const void*)@"UIViewBorderLayer");
}

- (void)setBorderLayer:(CAShapeLayer *)borderLayer{
    objc_setAssociatedObject(self, (__bridge const void *)@"UIViewBorderLayer", borderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)setBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color{
    if (self.borderLayer == nil) {
        CAShapeLayer* border = [[CAShapeLayer alloc]init];
        self.borderLayer = border;
        [self.layer addSublayer:border];
    }
    CAShapeLayer* border =  self.borderLayer;
     border.strokeColor = color.CGColor;
     border.lineWidth = width;
    border.fillColor = [UIColor clearColor].CGColor;
    if (self.frame.size.height != 0 && self.frame.size.width != 0 ) {
        border.path = [self cornerBorderLinePath].CGPath;
    }
}

- (UIBezierPath*)cornerBorderLinePath{
    UIBezierPath*path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadiu];
    return path;
}



- (void)cornerRadiu:(CGFloat)radiu  backGroundColor:(UIColor *)background{
    [self cornerRadiu:radiu poistion:BottomRightPosition backGroundColor:background];
    [self cornerRadiu:radiu poistion:BottomLeftPosition backGroundColor:background];
    [self cornerRadiu:radiu poistion:TopRigthPosition backGroundColor:background];
    [self cornerRadiu:radiu poistion:TopLeftPosition backGroundColor:background];
}

- (void)cornerRadiu:(CGFloat)radiu poistion:(UIViewCornerPosition) position backGroundColor:(UIColor*)background {
    self.cornerRadiu = radiu;
    self.viewSize = self.frame.size;

    if(radiu == 0){
        if(position == BottomLeftPosition){
            [self.bottomLeftCorner removeFromSuperlayer];
            self.bottomLeftCorner = nil;
        }else if (position == TopLeftPosition){
            [self.topLeftCorner removeFromSuperlayer];
            self.topLeftCorner = nil;
        }else if (position == TopRigthPosition){
            [self.topRightCorner removeFromSuperlayer];
            self.topRightCorner = nil;
        }else if (position == BottomRightPosition){
            [self.bottomRightCorner removeFromSuperlayer];
            self.bottomRightCorner = nil;
        }
        [self.borderLayer removeFromSuperlayer];
        self.borderLayer = nil;
        return;
    }
    
    if (self.borderLayer) {
        self.borderLayer.path = [self cornerBorderLinePath].CGPath;
    }
    
    UIBezierPath*path = nil;
    CAShapeLayer* shape = [[CAShapeLayer alloc]init];
    if(position == BottomLeftPosition){
        path =  [self bottomLeftPathWithRadiu:radiu];
        if(self.bottomLeftCorner) [self.bottomLeftCorner removeFromSuperlayer];
        self.bottomLeftCorner = shape;
    }else if (position == TopLeftPosition){
        path = [self topLeftPathWithRadiu:radiu];
        if(self.topLeftCorner) [self.topLeftCorner removeFromSuperlayer];
        self.topLeftCorner = shape;
    }else if (position == TopRigthPosition){
        path = [self topRightPathWithRadiu:radiu];
        if(self.topRightCorner) [self.topRightCorner removeFromSuperlayer];
        self.topRightCorner = shape;
    }else if (position == BottomRightPosition){
        path = [self bottomRightPathWithRadiu:radiu];
        if(self.bottomRightCorner) [self.bottomRightCorner removeFromSuperlayer];
        self.bottomRightCorner = shape;
    }
    shape.path = path.CGPath;
    shape.fillColor = background.CGColor;
    shape.strokeColor = background.CGColor;
}

- (UIBezierPath*)bottomLeftPathWithRadiu:(CGFloat)radiu{
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radiu,self.frame.size.height - radiu) radius:radiu startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(0,self.frame.size.height)];
    [path addLineToPoint:CGPointMake(radiu, self.frame.size.height)];
    return path;
}

- (UIBezierPath*)topLeftPathWithRadiu:(CGFloat)radiu{
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radiu,radiu) radius:radiu startAngle:M_PI endAngle:M_PI+M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(0,0)];
    [path addLineToPoint:CGPointMake(0,radiu)];
    return path;
}

- (UIBezierPath*)topRightPathWithRadiu:(CGFloat)radiu{
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width-radiu,radiu) radius:radiu startAngle:M_PI+M_PI_2 endAngle:0 clockwise:YES];
    [path addLineToPoint:CGPointMake(self.frame.size.width,0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width-radiu,0)];
    return path;
}

- (UIBezierPath*)bottomRightPathWithRadiu:(CGFloat)radiu{
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width-radiu,self.frame.size.height-radiu) radius:radiu startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(self.frame.size.width,self.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.frame.size.width,self.frame.size.height-radiu)];
    return path;
}
@end

