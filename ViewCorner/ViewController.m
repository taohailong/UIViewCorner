//
//  ViewController.m
//  ViewCorner
//
//  Created by hailong9 on 2018/4/16.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CornerRadius.h"

@interface ViewController ()
{
    UIView * subA ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    subA = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    subA.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:subA];
    

    [subA setBorderWidth:0.5 withBorderColor:[UIColor colorWithWhite:0 alpha:1]];
    [subA cornerRadiu:5 backGroundColor:[UIColor whiteColor]];
    
//    [subA cornerRadiu:25 poistion:BottomLeftPosition backGroundColor:[UIColor whiteColor]];
//    [subA cornerRadiu:25 poistion:TopLeftPosition backGroundColor:[UIColor whiteColor]];
//     [subA cornerRadiu:25 poistion:TopRigthPosition backGroundColor:[UIColor whiteColor]];
//     [subA cornerRadiu:25 poistion:BottomRightPosition backGroundColor:[UIColor whiteColor]];
    
    
//
//    UIView* subC = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
//    subC.backgroundColor = [UIColor redColor];
//    [subA addSubview:subC];
//
//    UIView* subD = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
//    subD.backgroundColor = [UIColor greenColor];
//    [subA addSubview:subD];
    
    
   
//    UIImageView * subB =  [[UIImageView alloc]initWithFrame:CGRectMake(120, 50, 50, 70)];
////    subB.backgroundColor = [UIColor blackColor];
//    subB.image = [UIImage imageNamed:@"user"];
//    [self.view addSubview:subB];
//    [subB cornerRadiu:25 backGroundColor:[UIColor redColor]];
    
  
//    [subA cornerRadiu:0 poistion:BottomLeftPosition backGroundColor:[UIColor whiteColor]];
    
    
//    [self.view.layer addSublayer:shape];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)changsize:(id)sender{
    subA.frame = CGRectMake(100, 200, CGRectGetWidth(subA.frame), CGRectGetHeight(subA.frame)+1);
    [subA addSubview:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
