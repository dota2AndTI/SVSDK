//
//  SV_GADRewardManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_GADRewardManager.h"

@interface SV_GADRewardManager ()<GADFullScreenContentDelegate>

@property(nonatomic, strong) GADRewardedAd *sv_ad;
@property (nonatomic,assign)BOOL isGetReward;

@end

@implementation SV_GADRewardManager

-(void)sv_requestAdWithUnitID:(NSString *)unitID currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.isPromptly = isImmediately;
    self.currentVC = vc;
    GADRequest *request = [GADRequest request];
    [GADRewardedAd loadWithAdUnitID:unitID request:request completionHandler:^(GADRewardedAd *ad, NSError *error) {
        if (error) {
            NSLog(@"Rewarded ad failed to load with error: %@", [error localizedDescription]);
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
                [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeGoogle];
            }
            return;
        }
        self.sv_ad = ad;
        self.sv_ad.fullScreenContentDelegate = self;
        
        if (isImmediately) {
            [ad presentFromRootViewController:vc userDidEarnRewardHandler:^{
                NSLog(@"激励视频 获取奖励");
                self.isGetReward = YES;
                if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoPlayFinishWithType:)]) {
                    [self.delegate sv_adsManager:self videoPlayFinishWithType:SVAdsTypeGoogle];
                }
            }];
        }
        self.sv_adsLoaded = YES;
        NSLog(@"Rewarded ad loaded.");
    }];
}

-(void)sv_showAd {
    if (!self.isPromptly && self.sv_adsLoaded) {
        [self.sv_ad presentFromRootViewController:self.currentVC userDidEarnRewardHandler:^{
            NSLog(@"激励视频 获取奖励");
            self.isGetReward = YES;
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoPlayFinishWithType:)]) {
                [self.delegate sv_adsManager:self videoPlayFinishWithType:SVAdsTypeGoogle];
            }
        }];
    }
}

-(BOOL)sv_earnRewardStatus {
    return self.isGetReward;
}

#pragma mark - GADFullScreenContentDelegate
// 广告无法呈现全屏内容。
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsShowFailedWithManager:self error:error adsType:SVAdsTypeGoogle];
    }
}

// 广告呈现全屏内容。
- (void)adDidPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsShowSuccessWithManager:self adsType:SVAdsTypeGoogle];
    }
}

- (void)adDidRecordClick:(nonnull id<GADFullScreenPresentingAd>)ad {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsDidClick:adsType:)]) {
        [self.delegate sv_adsDidClick:self adsType:SVAdsTypeGoogle];
    }
}

// 广告取消了全屏内容。
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad; {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeGoogle];
    }
}

@end
