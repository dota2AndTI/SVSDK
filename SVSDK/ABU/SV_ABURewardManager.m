//
//  SV_ABURewardManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_ABURewardManager.h"

@interface SV_ABURewardManager ()<ABURewardedVideoAdDelegate>

@property (nonatomic,strong)ABURewardedVideoAd *sv_ad;

@property (nonatomic,assign)BOOL isGetReward;

@end

@implementation SV_ABURewardManager

-(void)sv_requestRewardAdWith:(NSString *)adId viewController:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = isImmediately;
    
    ABURewardedVideoModel *model = [[ABURewardedVideoModel alloc]init];
    model.userId = @"123";
    model.rewardAmount = 50;
    model.extra = @"khalsihucisacsa";
    
    self.sv_ad = [[ABURewardedVideoAd alloc]initWithAdUnitID:adId rewardedVideoModel:model];
    self.sv_ad.delegate = self;
    self.sv_ad.mutedIfCan = YES;// NO-静音，YES-有声音
    
    // TODO: 已经获得奖励 === NO
    self.isGetReward = NO;
    // 当前配置拉取成功
    if (self.sv_ad.hasAdConfig) {
        [self.sv_ad loadAdData]; // 加载广告
    }else{
        __weak typeof(self) weakSelf = self;
        // 当前配置未拉取成功,在成功之后会调用该callback
        [self.sv_ad setConfigSuccessCallback:^{
            [weakSelf.sv_ad loadAdData];
        }];
    }
}

-(void)sv_showRewardAdWith:(NSString *)adId {
    if (self.sv_adsLoaded && !self.isPromptly) {
        [self.sv_ad showAdFromRootViewController:self.currentVC];
    }
}

-(BOOL)sv_getRewardStatus {
    return self.isGetReward;
}

#pragma mark - ABURewardedVideoAdDelegate

- (void)rewardedVideoAdDidLoad:(ABURewardedVideoAd *_Nonnull)rewardedVideoAd {
    NSLog(@"log-%s",__func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeABU];
    }
}

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)rewardedVideoAd:(ABURewardedVideoAd *_Nonnull)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"log-%s-error:%@s",__func__,error.description);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeABU];
    }
}

/**
 This method is called when a ABURewardedVideoAd failed to render.
 @param error : the reason of error
 Only for expressAd,hasExpressAdGot = yes
 */
- (void)rewardedVideoAdViewRenderFail:(ABURewardedVideoAd *_Nonnull)rewardedVideoAd error:(NSError *_Nullable)error {
    NSLog(@"log-%s-error:%@",__func__,error.description);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsRenderFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsRenderFailedWithManager:self error:error adsType:SVAdsTypeABU];
    }
}

/**
 This method is called when cached successfully.
 */
- (void)rewardedVideoAdDidDownLoadVideo:(ABURewardedVideoAd *_Nonnull)rewardedVideoAd {
    //self.selectedView.showInvalid = YES;
    //self.selectedView.promptStatus = ABUDPromptStatusAdVideoLoadedSuccess;
    NSLog(@"log-%s",__func__);
    if (rewardedVideoAd) {
        if (self.isPromptly) {
            BOOL isSuccessShow = [self.sv_ad showAdFromRootViewController:self.currentVC];
            if (isSuccessShow == NO) {
                // delegate
                if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
                    [self.delegate sv_adsShowFailedWithManager:self error:nil adsType:SVAdsTypeABU];
                }
            }
        }
        self.sv_adsLoaded = YES;
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
            [self.delegate sv_adsShowFailedWithManager:self error:nil adsType:SVAdsTypeABU];
        }
    }
}

/**
 This method is called when video ad slot has been shown.
 */
- (void)rewardedVideoAdDidVisible:(ABURewardedVideoAd *_Nonnull)rewardedVideoAd {
    NSLog(@"%s", __func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsShowSuccessWithManager:self adsType:SVAdsTypeABU];
    }
}

/**
 This method is called when video ad is closed.
 */
- (void)rewardedVideoAdDidClose:(ABURewardedVideoAd *_Nonnull)rewardedVideoAd {
    NSLog(@"%s", __func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeABU];
    }
}

/**
 This method is called when video ad is clicked.
 */
- (void)rewardedVideoAdDidClick:(ABURewardedVideoAd *_Nonnull)rewardedVideoAd {
    NSLog(@"%s", __func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsDidClick:adsType:)]) {
        [self.delegate sv_adsDidClick:self adsType:SVAdsTypeABU];
    }
}

- (void)rewardedVideoAdDidSkip:(ABURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"log-%s", __func__);
    // 因为激励视频时间过长，所以点击跳过也可以算
    self.isGetReward = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoSkipWithType:)]) {
        [self.delegate sv_adsManager:self videoSkipWithType:SVAdsTypeABU];
    }
}


/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)rewardedVideoAdDidPlayFinish:(ABURewardedVideoAd * _Nonnull)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"log-%s error:%@", __func__, error);
    if (!error) {
        self.isGetReward = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoPlayFinishWithType:)]) {
            [self.delegate sv_adsManager:self videoPlayFinishWithType:SVAdsTypeABU];
        }
    }
}

- (void)rewardedVideoAdServerRewardDidSucceed:(ABURewardedVideoAd *)rewardedVideoAd rewardInfo:(ABUAdapterRewardAdInfo *)rewardInfo verify:(BOOL)verify {
    NSLog(@"log-");
}

@end
