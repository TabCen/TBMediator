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
	// Do any additional setup after loading the view, typically from a nib.
    [self aprint:@"dafd",@12,nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testABtnClicked:(id)sender {
    [TBMediator callViewController:@"TBTestAViewController" params:@{@"paramsA":@"aaaa"} viewController:self callBack:^(NSDictionary *callBackDic) {
        
    }];
}

- (IBAction)test2BtnClicked:(id)sender {
//    [TBMediator performTarget:@"TBTestAViewController" action:@"testFunction" params:nil shouldCacheTarget:NO];
//    [TBMediator performTarget:@"TBTestAViewController" action:@selector(testFunction:) params:nil shouldCacheTarget:NO];
//
//    NSArray *arr = [NSArray arrayWithObjects:@"a",@"b", nil];
    
//    NSArray * a = [TBMediator safePerformAction:@selector(aprint:bbb:ccc:ddd:) target:self params:@"shabi",@"1234567",@32,@(TRUE), nil];
    NSArray *arr = [TBMediator performTargetClassName:@"TBViewController" action:@selector(aprint:bbb:ccc:ddd:) params:@"shabi",@"1234567",@32,@(TRUE), nil];
    
    NSLog(@"%@",arr);
    
}
#define AppLog(format,...)  NSLog((format),##__VA_ARGS__)

-(NSArray *)aprint:(id)a bbb:(id)b ccc:(id)c ddd:(id)d{
//    return [NSString stringWithFormat:@"%@,%@,%@,%@",a,b,c,d];
    return @[a,b,c,d];
}

-(void)aprint:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION{
    NSLog(@"%@",firstObj);
    
    va_list args;
    id arg;
    va_start(args, firstObj);
    while((arg = va_arg(args, id))){
        NSLog(@"%@",arg);
    }
    va_end(args);
}



@end
