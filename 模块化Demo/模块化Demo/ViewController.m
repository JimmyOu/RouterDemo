//
//  ViewController.m
//  模块化Demo
//
//  Created by JimmyOu on 17/2/23.
//  Copyright © 2017年 JimmyOu. All rights reserved.
//

#import "ViewController.h"
#import "AXDRouterImport.h"
#import <WebKit/WebKit.h>
#import "JSBridge.h"

#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *uiWebView;

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) JSBridge *jsBridge;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*******       1.testRouter      *******/
//    [self routerTest];
    
    /*******       2.UIWebTest       *******/
//    [self UIWebTest];
    
    /*******       3.WKWebTest       *******/
    [self UIWebTest];
}


- (void)routerTest {
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


- (void)UIWebTest {
    
    //1.初始化
    [[AXDRouter sharedInstance] js_install];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    _jsBridge = [JSBridge bridgeWithWKWebViewConfiguration:configuration];
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, screenWidth, (screenHeight- 20) * 0.5) configuration:configuration];
    
   NSString *path = [[NSBundle mainBundle] pathForResource:@"web" ofType:@"html"];
    [_wkWebView loadHTMLString:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] baseURL:nil];
    [self.view addSubview:_wkWebView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_jsBridge insertBridgeScript];
}


@end
