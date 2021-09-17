//
//  SV_GADInterstitialManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_GADInterstitialManager.h"

@interface SV_GADInterstitialManager ()<GADFullScreenContentDelegate>

@property(nonatomic, strong) GADInterstitialAd *sv_ad;

@end

@implementation SV_GADInterstitialManager

-(void)sv_requestAdWithUnitID:(NSString *)unitID currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = isImmediately;
    GADRequest *request = [GADRequest request];
    [GADInterstitialAd loadWithAdUnitID:unitID
                                request:request
                      completionHandler:^(GADInterstitialAd *ad, NSError *error) {
        if (error) {
            NSLog(@"Failed to load interstitial ad with error: %@", [error localizedDescription]);
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
                [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeGoogle];
            }
            return;
        }
        self.sv_ad = ad;
        ad.fullScreenContentDelegate = self;
        if (isImmediately) {
            [ad presentFromRootViewController:vc];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
            [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeGoogle];
        }
    }];
}

-(void)sv_showInterstitialAd {
    if (!self.isPromptly && self.sv_adsLoaded) {
        [self.sv_ad presentFromRootViewController:self.currentVC];
    }
}

#pragma mark - GADFullScreenContentDelegate
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
    didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
  NSLog(@"didFailToPresentFullScreenContentWithError");
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsShowFailedWithManager:self error:error adsType:SVAdsTypeGoogle];
    }
}

- (void)adDidPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    NSLog(@"adDidPresentFullScreenContent");
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsShowSuccessWithManager:self adsType:SVAdsTypeGoogle];
    }
}

- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
  NSLog(@"adDidDismissFullScreenContent");
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeGoogle];
    }
}

- (void)adDidRecordClick:(nonnull id<GADFullScreenPresentingAd>)ad {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsDidClick:adsType:)]) {
        [self.delegate sv_adsDidClick:self adsType:SVAdsTypeGoogle];
    }
}

@end
