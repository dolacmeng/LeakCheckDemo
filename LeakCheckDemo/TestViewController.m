
//
//  TestViewController.m
//  LeakCheckDemo
//
//  Created by 许伟杰 on 2018/6/26.
//  Copyright © 2018年 JackXu. All rights reserved.
//

#import "TestViewController.h"

typedef void (^Block)(void);

@interface TestViewController ()

@property(nonatomic,copy) Block block;
@property(nonatomic,strong) NSString *name;

@end

@implementation TestViewController

//测试代码
- (void)viewDidLoad {
    [super viewDidLoad];
    self.block = ^{
        self.name = @"Jack";
    };
}

- (void)dealloc{
    NSLog(@"dealloc");
}


@end
