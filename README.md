# UIViewCorner
Adding round corners to UIView  and avoiding Off-screen rendering.

UIView 在添加圆角时 如果view 只是有backgroundcolor 设置layer.corner = x;  就可以了。没有离屏渲染
但是如果是UIImageview 或者是UILabel 通常用的方法是加上   layer.clipsToBounds = yes;   这时就会有离屏渲染了。



UIViewCorner 采用的方法是用layer层直接盖住矩形直角的边缘区域，使其达到一种圆角的效果。不用设置layer.clipsToBounds = yes;没有离屏渲染
但是只适用于父视图背景是纯色的。

使用方法如下

     self.view.backgroundColor = [UIColor whiteColor];
     UIView*subA = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
     subA.backgroundColor = [UIColor redColor];
    [self.view addSubview:subA];
    

    [subA setBorderWidth:0.5 withBorderColor:[UIColor colorWithWhite:0 alpha:1]];
    [subA cornerRadiu:5 backGroundColor:[UIColor whiteColor]];// [UIColor whiteColor] == self.view.backgroundColor
