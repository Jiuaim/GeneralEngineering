//
//  SZMeViewController.m
//  General
//
//  Created by llbt on 16/8/30.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "SZMeViewController.h"
#import <LFLiveKit.h>

@interface SZMeViewController () <LFLiveSessionDelegate>
@property (nonatomic, strong) UIButton *liveButton;

@property (nonatomic, strong) LFLiveSession *session;
@property (nonatomic, weak) UIView *livingPreView;
@end

@implementation SZMeViewController

- (void)hsz_viewController {
    NSLog(@"confuse test");
}

+ (void)hsz_confuseTest {
    NSLog(@"confuse test");
}

- (UIView *)livingPreView {
    if (!_livingPreView) {
        UIView *livingPreView = [[UIView alloc] initWithFrame:self.view.bounds];
        livingPreView.backgroundColor = [UIColor clearColor];
        livingPreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:livingPreView atIndex:0];
        _livingPreView = livingPreView;
    }
    return _livingPreView;
}

- (LFLiveSession *)session {
    if (!_session) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2] captureType:LFLiveCaptureMaskAll];
        _session.delegate = self;
        _session.running = YES;
        _session.preView = self.livingPreView;
        _session.beautyFace = YES;
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setupSubViews];
    self.session.captureDevicePosition = AVCaptureDevicePositionBack;

}

- (void)setupSubViews {
    self.liveButton = [[UIButton alloc] init];
    self.liveButton.backgroundColor = [UIColor whiteColor];
    self.liveButton.layer.cornerRadius = 5;
    self.liveButton.layer.masksToBounds = YES;
    [self.liveButton setTitle:@"直播" forState:UIControlStateNormal];
    [self.liveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.liveButton bk_addEventHandler:^(UIButton *sender) {
        LFLiveStreamInfo *info = [LFLiveStreamInfo new];
        info.url = @"rtmp://192.168.0.110:1935/rtmplive/room";
        [self.session startLive:info];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.liveButton];
    
    [self.liveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
    }];
}

#pragma mark -- delegate
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
}
@end
