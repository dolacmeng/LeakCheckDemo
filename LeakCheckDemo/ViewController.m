//
//  ViewController.m
//  LeakCheckDemo
//
//  Created by 许伟杰 on 2018/6/26.
//  Copyright © 2018年 JackXu. All rights reserved.
//

/*
 目标：检测视图控制器是否内存泄漏
 *  思路：在视图控制器弹出栈 && 视图完全消失时，监听对象是已经被销毁
*/

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
