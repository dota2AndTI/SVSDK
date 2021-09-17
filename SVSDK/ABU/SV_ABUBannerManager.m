//
//  SV_ABUBannerManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_ABUBannerManager.h"

@interface SV_ABUBannerManager ()<ABUBannerAdDelegate>

@property (nonatomic,strong)ABUBannerAd *sv_ad;
@property (nonatomic,strong)UIView *bannerAdView;

@property (nonatomic,assign)CGRect bannerFrame;
@property (nonatomic,assign)BOOL isShowed;

@end

@implementation SV_ABUBannerManager

-(void)sv_requestAdWitSlotID:(NSString *)slotId adFrame:(CGRect)frame interval:(NSInteger)interval currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = isImmediately;
    self.bannerFrame = frame;
    
    self.sv_ad = [[ABUBannerAd alloc] initWithAdUnitID:slotId rootViewController:vc adSize:frame.size autoRefreshTime:interval];
    self.sv_ad.delegate = self;
    [self.sv_ad loadAdData];
}

-(void)sv_showBannerAd {
    if (self.bannerAdView && self.sv_adsLoaded && !self.isPromptly && !self.isShowed) {
        self.isShowed = YES;
        [self.currentVC.view addSubview:self.bannerAdView];
    }
}

-(void)sv_closeBannerAd {
    if (self.bannerAdView) {
        [self.bannerAdView removeFromSuperview];
        self.sv_ad = nil;
    }
}

-(void)sv_bannerWillAppearAnimated:(BOOL)animated {
    if (!self.isShowed && self.bannerAdView) {
        [self.currentVC.view addSubview:self.bannerAdView];
    }
}

-(void)sv_bannerWillDisappearAnimated:(BOOL)animated {
    if (self.isShowed && self.bannerAdView) {
        self.isShowed = NO;
        [self.bannerAdView removeFromSuperview];
    }
}

#pragma mark - ABUBannerAdDelegate
-(void)bannerAdDidLoad:(ABUBannerAd *)bannerAd bannerView:(UIView *)bannerView {
    NSLog(@"%s",__func__);
    bannerView.frame = self.bannerFrame;
    self.bannerAdView = bannerView;
    self.sv_adsLoaded = YES;
    if (self.isPromptly) {
        self.isShowed = YES;
        [self.currentVC.view addSubview:bannerView];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeABU];
    }
}

-(void)bannerAd:(ABUBannerAd *)bannerAd didLoadFailWithError:(NSError *)error {
    NSLog(@"%s",__func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeABU];
    }
}

-(void)bannerAdDidClick:(ABUBannerAd *)ABUBannerAd bannerView:(UIView *)bannerView {
    NSLog(@"%s",__func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsDidClick:adsType:)]) {
        [self.delegate sv_adsDidClick:self adsType:SVAdsTypeABU];
    }
}

- (void)bannerAdWillDismissFullScreenModal:(ABUBannerAd *_Nonnull)ABUBannerAd bannerView:(UIView *)bannerView {
    
}

-(void)bannerAdDidClosed:(ABUBannerAd *)ABUBannerAd bannerView:(UIView *)bannerView dislikeWithReason:(NSArray<ABUDislikeWords *> *)filterwords {
    NSLog(@"%s",__func__);
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsClosedWithManager:adsType:)]) {
        [self.delegate sv_adsClosedWithManager:self adsType:SVAdsTypeABU];
    }
}

- (void)bannerAdDidBecomVisible:(ABUBannerAd * _Nonnull)ABUBannerAd bannerView:(nonnull UIView *)bannerView {
    
}

- (void)bannerAdWillPresentFullScreenModal:(ABUBannerAd * _Nonnull)ABUBannerAd bannerView:(nonnull UIView *)bannerView {
    
}

@end
