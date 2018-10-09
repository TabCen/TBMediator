//
//  TBViewController.m
//  TBMediator
//
//  Created by chenfeigogo@gmail.com on 09/26/2018.
//  Copyright (c) 2018 chenfeigogo@gmail.com. All rights reserved.
//

#import "TBViewController.h"
#import <TBMediator/TBMediator.h>

@interface TBViewController ()

@end

@implementation TBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testABtnClicked:(id)sender {
    [TBMediator callViewController:@"TBTestAViewController"
                            params:@{@"paramsA":@"aaaa"}
                    viewController:self
                          callBack:^(NSDictionary *callBackDic) {
                          }];
}

- (IBAction)test2BtnClicked:(id)sender {
    ///调用TBTestAViewController的方法testBFunction
    [TBMediator performTargetClassName:@"TBTestAViewController" action:@selector(testBFunction) params:nil, nil];
    
    ///调用方法
    [TBMediator performTarget:self action:@selector(aprint:) params:@"我是一个参数", nil];
    
    ///调用带返回
    NSArray *arr = [TBMediator performTargetClassName:@"TBViewController" action:@selector(aprint:bbb:ccc:ddd:) params:@"你",@"最",@6,@"B", nil];
    NSLog(@"%@",arr);

    ///测试URL调用方法
    [TBMediator performActionWithUrl:[NSURL URLWithString:@"tb://TBViewController/testForUrl:?a=12&b=44"] completion:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
    }];
}

-(NSArray *)aprint:(id)a bbb:(id)b ccc:(id)c ddd:(id)d{
    return @[a,b,c,d];
}

-(void)aprint:(id)firstObj{
    NSLog(@"%@",firstObj);
}

-(NSString *)testForUrl:(id)sender{
    NSLog(@"%@",sender);
    return @"12345678";
}


@end
