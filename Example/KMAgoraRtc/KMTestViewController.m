//
//  KMTestViewController.m
//  KMAgoraRtc_Example
//
//  Created by Ed on 2020/3/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#import "KMTestViewController.h"
#import "KMAgoraRtc_Example-Swift.h"
@import KMAgoraRtc;
@interface KMTestViewController ()

@end

@implementation KMTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    KMFloatViewManager * manager = [KMFloatViewManager sharedInstance];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
