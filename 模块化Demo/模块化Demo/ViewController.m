//
//  ViewController.m
//  模块化Demo
//
//  Created by JimmyOu on 17/2/23.
//  Copyright © 2017年 JimmyOu. All rights reserved.
//

#import "ViewController.h"
#import "AXDRouterImport.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    /**1.app内动态调用**/
    NSLog(@"/**1.app内动态调用**/");
    [[AXDRouter sharedInstance] doLogin:^(NSInteger result) {
        NSLog(@"%d",(int)result);
    }];
    
    [[AXDRouter sharedInstance] doBussiness];
    
    id returnValue = [[AXDRouter sharedInstance] doBussiness:^(NSInteger result) {
        NSLog(@"%d",(int)result);
    }];
    NSLog(@"%@",[returnValue class]);
    
    
    /**2.通过协议调用**/
    NSLog(@"/**2.通过协议调用**/");
    
    [AXDRouter dispatchInvokesWithUrl:@"axd://login/dologin"];
    
    [AXDRouter dispatchInvokesWithUrl:@"axd://login/dologin?pram1=hello"];
    
    id returnValue2 = [AXDRouter dispatchInvokesWithUrl:@"axd://login/dologin_protocol?pram1=hello"];
    NSLog(@"%@",[returnValue2 class]);
}


@end
