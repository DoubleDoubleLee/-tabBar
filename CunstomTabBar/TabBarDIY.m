//
//  TabBarDIY.m
//  CunstomTabBar
//
//  Created by OnePiece on 15/9/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TabBarDIY.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH   [UIScreen mainScreen].bounds.size.width

@interface TabBarDIY ()

@end

@implementation TabBarDIY

- (void)viewDidLoad
{
    [super viewDidLoad];
    //当系统提供的UITabBar（标签栏）的样式不能满足开发的需求时，我们需要隐藏系统的标签栏，自己定制标签栏
    self.tabBar.hidden = YES;
    [self createViewControllers];
    //自己定制标题栏
    [self createCustomTabBar];
}

//UIImageView+UIButton+UILabel(底部紫色的指示条)
- (void)createCustomTabBar{
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,HEIGHT-49,WIDTH,49)];
    bgView.tag = 999;
    bgView.backgroundColor = [UIColor whiteColor];
    //    bgView.image = [UIImage imageNamed:@"tabbg.png"];
    //开启用户交互属性
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];

    //间隔
    CGFloat space = (WIDTH-4*30)/5;
    for (int i = 0; i<4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"tab_%d.png",i];
        NSString *selectImageName =[NSString stringWithFormat:@"tab_c%d.png",i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        //设置btn处于选中状态下的图片
        [btn setBackgroundImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
        //UIControlStateSelected 此状态由UIButton 的selected属性来控制
        btn.tag = i+100;
        if (btn.tag == 100) {
            //selected 属性为YES,button处于选中状态
            btn.selected = YES;
        }
        btn.frame = CGRectMake(space+i*(space +30),(49-30)/2,30,30);
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //将button加到imageView上
        [bgView addSubview:btn];
    }
    
    //用于指示的uilabel
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(space,41,30,2)];
    tipLabel.backgroundColor = [UIColor purpleColor];
    tipLabel.tag = 998;
    [bgView addSubview:tipLabel];
}

- (void)btnClicked:(UIButton *)btn{
    //切换视图控制器
    NSInteger index = btn.tag-100;
    //改变selectedIndex属性，标签栏控制器会自动实现视图控制器view的切换
    self.selectedIndex = index;
    
    UIImageView *bgView = (UIImageView*)[self.view viewWithTag:999];
    //改btn的状态
    //通过imageView的子视图数组拿到btn
    for (UIView *view in bgView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            //拿到btn
            UIButton *currentBtn = (UIButton *)view;
            if (currentBtn.tag == btn.tag) {
                //为选中状态
                currentBtn.selected = YES;
            }else{
                //常态
                currentBtn.selected = NO;
            }
        }
    }
    
    CGFloat space = (WIDTH-4*30)/5;
    //改变tipLabel的横坐标
    UILabel *tipLabel = (UILabel *)[bgView viewWithTag:998];
    
    //给label x坐标的改变过程加一个过渡（缓冲）动画
    //animateWithDuration:后续代码执行时长
    //^{ }是一个不是马上被执行的代码片段:匿名函数（block）
    [UIView animateWithDuration:0.3 animations:^{
        //写在里面的代码会在0.3秒的时间完成
        CGRect frame = tipLabel.frame;
        //改变x
        frame.origin.x =  space + index*(space +30);
        //将更改后的frame重新赋值给label
        tipLabel.frame = frame;
    }];
}

- (void)createViewControllers{
    UIViewController *vc1 = [[FirstViewController alloc] init];
    vc1.title = @"界面1";
    UIViewController *vc2 = [[SecondViewController alloc] init];
    vc2.title = @"界面2";
    UIViewController *vc3 =[[ThirdViewController alloc] init];
    vc3.title = @"界面3";
    UIViewController *vc4 =[[FourthViewController alloc] init];
    vc4.title = @"界面4";
    NSArray *controllers = [NSArray arrayWithObjects:vc1,vc2,vc3,vc4,nil];

    self.viewControllers = controllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
