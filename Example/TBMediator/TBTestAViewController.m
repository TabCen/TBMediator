//
//  TBTestAViewController.m
//  TBMediator_Example
//
//  Created by David on 2018/9/26.
//  Copyright © 2018 chenfeigogo@gmail.com. All rights reserved.
//

#import "TBTestAViewController.h"

#import <TBMediator/TBMediator.h>

@interface TBTestAViewController ()<TBMediator>

@end

@implementation TBTestAViewController

+(void)mediatorLoad:(UIViewController *)fromVC params:(NSDictionary *)params handler:(MediatorBlock)block{
    TBTestAViewController *testAVC = [TBTestAViewController new];
    [fromVC presentViewController:testAVC animated:YES completion:^{
        
    }];
}

-(void)testFunction:(id)sender{
    NSLog(@"打印TBTestAViewController");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
