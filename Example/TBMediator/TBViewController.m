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

@end
