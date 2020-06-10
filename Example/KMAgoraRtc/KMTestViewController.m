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
@import KMRouter;
@interface KMTestViewController ()//<KMCallingSystemOperationDelegate>

@end

@implementation KMTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    KMFloatViewManager * manager = [KMFloatViewManager sharedInstance];
    self.view.backgroundColor = [UIColor redColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rejectedCalling) name:@"rejectedCallingInKMCallingOperation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(answerCallingIn) name:@"answerCallingInKMCallingOperation" object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)rejectedCalling{
    NSLog(@"挂断");
}
- (void)answerCallingIn{
    NSLog(@"接听");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    KMCallingSystemController * callSystem = [[KMCallingSystemController alloc]init];
//    callSystem.delegate = self;
//    callSystem.callName = @"黄医生";
//    callSystem.callImage = @"https://prstore.kmwlyy.com/images/doctor/unknow.png";
//    callSystem.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:callSystem animated:true completion:nil];
    
//    [KMRouter pathWithUrlStr:@"KMAgoraRtc.KMCallingSystemController?callName=黄医生&callImage=https://prstore.kmwlyy.com/images/doctor/unknow.png"
//                      isPush:false
//                    callback:^(UIViewController * control) {
//        control.modalPresentationStyle = UIModalPresentationFullScreen;
//    }];
    
    [KMRouter persentWithClassName:@"KMAgoraRtc.KMCallingSystemController"
                             param:@{@"callName":@"黄医生",@"callImage":@"https://prstore.kmwlyy.com/images/doctor/unknow.png"}
                          callback:^(UIViewController * control) {
        control.modalPresentationStyle = UIModalPresentationFullScreen;
    }];
}

//-(void)answerCallingInKMCallingOperation {
//    NSLog(@"接听");
//}
//-(void)rejectedCallingInKMCallingOperation {
//    NSLog(@"挂断");
//}
@end
