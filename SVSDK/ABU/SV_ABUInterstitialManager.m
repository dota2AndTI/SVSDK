//
//  SV_ABUInterstitialManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_ABUInterstitialManager.h"

@interface SV_ABUInterstitialManager ()<ABUInterstitialAdDelegate>

@property (nonatomic,strong)ABUInterstitialAd *sv_ad;

@end

@implementation SV_ABUInterstitialManager

-(void)sv_requestInterstitialAdWith:(NSString *)adId expectSize:(CGSize)size viewController:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = isImmediately;
    
    self.sv_ad = [[ABUInterstitialAd alloc] initWithAdUnitID:adId size:size];
    self.sv_ad.delegate = self;
    [self.sv_ad loadAdData];
}

-(void)sv_showInterstitialAd {
    if (!self.isPromptly && self.sv_adsLoaded) {
        [self.sv_ad showAdFromRootViewController:self.currentVC];
    }
}

#pragma mark - ABUInterstitialAdDelegate
- (void)interstitialAdDidLoad:(ABUInterstitialAd *)interstitialAd {
    NSLog(@"%s",__func__);
    if (interstitialAd && self.isPromptly) {
        [interstitialAd showAdFromRootViewController:self.currentVC];
    }
    self.sv_adsLoaded = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeABU];
    }
}

-(void)interstitialAd:(ABUInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"%s",__func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeABU];
    }
}

-(void)interstitialAdDidClick:(ABUInterstitialAd *)interstitialAd {
    NSLog(@"%s",__func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsDidClick:adsType:)]) {
        [self.delegate sv_adsDidClick:self adsType:SVAdsTypeABU];
    }
}

-(void)interstitialAdDidClose:(ABUInterstitialAd *)interstitialAd {
    NSLog(@"%s",__func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeABU];
    }
}

-(void)interstitialAdDidShowFailed:(ABUInterstitialAd *)interstitialAd error:(NSError *)error {
    NSLog(@"%s",__func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsShowFailedWithManager:self error:error adsType:SVAdsTypeABU];
    }
}

-(void)interstitialAdDidVisible:(ABUInterstitialAd *)interstitialAd {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsShowSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsShowSuccessWithManager:self adsType:SVAdsTypeABU];
    }
}

-(void)interstitialAdViewRenderFail:(ABUInterstitialAd *)interstitialAd error:(NSError *)error {
    NSLog(@"%s",__func__);
    if (!error) {
        self.sv_adsLoaded = YES;
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsRenderFailedWithManager:error:adsType:)]) {
            [self.delegate sv_adsRenderFailedWithManager:self error:error adsType:SVAdsTypeABU];
        }
    }
}

@end
