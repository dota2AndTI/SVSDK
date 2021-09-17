//
//  SV_GADSplashManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_GADSplashManager.h"

@interface SV_GADSplashManager ()<GADFullScreenContentDelegate>

@property(strong, nonatomic) GADAppOpenAd* sv_ad;

@end

@implementation SV_GADSplashManager

-(void)sv_showAdWithUnitID:(NSString *)unitID viewController:(UIViewController *)vc {
    self.currentVC = vc;
    [GADAppOpenAd loadWithAdUnitID:unitID
                           request:[GADRequest request]
                       orientation:UIInterfaceOrientationPortrait
                 completionHandler:^(GADAppOpenAd *_Nullable appOpenAd, NSError *_Nullable error) {
        if (error) {
            NSLog(@"Failed to load app open ad: %@", error);
            if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
                [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeGoogle];
            }
            return;
        }
        self.sv_ad = appOpenAd;
        self.sv_ad.fullScreenContentDelegate = self;
        [self ads_showAds];
        if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
            [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeGoogle];
        }
    }];
}

-(void)ads_showAds {
    if (self.sv_ad) {
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
