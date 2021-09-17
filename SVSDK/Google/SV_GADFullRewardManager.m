//
//  SV_GADFullRewardManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_GADFullRewardManager.h"

@interface SV_GADFullRewardManager ()<GADFullScreenContentDelegate>

@property(nonatomic, strong) GADRewardedInterstitialAd* sv_ad;
@property (nonatomic,assign)BOOL isGetReward;

@end

@implementation SV_GADFullRewardManager

-(void)sv_requestAdWithUnitID:(NSString *)unitId currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = isImmediately;
    [GADRewardedInterstitialAd loadWithAdUnitID:unitId request:[GADRequest request] completionHandler:^(
                                                                                                        GADRewardedInterstitialAd* _Nullable rewardedInterstitialAd,
                                                                                                        NSError* _Nullable error) {
        if (!error) {
            self.sv_ad = rewardedInterstitialAd;
            self.sv_adsLoaded = YES;
            rewardedInterstitialAd.fullScreenContentDelegate = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isImmediately) {
                    [rewardedInterstitialAd presentFromRootViewController:vc userDidEarnRewardHandler:^{
                        // 奖励内容
                        NSLog(@"激励插屏 获取奖励");
                        self.isGetReward = YES;
                        if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoPlayFinishWithType:)]) {
                            [self.delegate sv_adsManager:self videoPlayFinishWithType:SVAdsTypeGoogle];
                        }
                    }];
                }
            });
        }else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
                [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeGoogle];
            }
        }
    }];
}

-(void)sv_showFullVideoAd {
    [self.sv_ad presentFromRootViewController:self.currentVC userDidEarnRewardHandler:^{
        // 奖励内容
        NSLog(@"激励插屏 获取奖励");
        self.isGetReward = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsManager:videoPlayFinishWithType:)]) {
            [self.delegate sv_adsManager:self videoPlayFinishWithType:SVAdsTypeGoogle];
        }
    }];
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
