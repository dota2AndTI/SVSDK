//
//  SV_GADBannerManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_GADBannerManager.h"

@interface SV_GADBannerManager ()<GADBannerViewDelegate>

@property(nonatomic, strong) GADBannerView *sv_adView;
@property (nonatomic,assign) CGPoint point;

@property (nonatomic,assign)NSInteger methods;
@property (nonatomic,assign)BOOL isShowed;

@end

@implementation SV_GADBannerManager

-(void)sv_requestBannerAdWithUnitID:(NSString *)unitID bannerFrame:(CGRect)frame currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = isImmediately;
    
    self.sv_adView = [[GADBannerView alloc] initWithFrame:frame];
    self.sv_adView.adUnitID = unitID;
    if (isImmediately) {
        self.sv_adView.rootViewController = vc;
        [vc.view addSubview:self.sv_adView];
    }
    
    if (@available(iOS 11.0, *)) {
        frame = UIEdgeInsetsInsetRect(vc.view.frame, vc.view.safeAreaInsets);
    }
    CGFloat viewWidth = frame.size.width;
    self.sv_adView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth);
    GADRequest *request = [GADRequest request];
    [self.sv_adView loadRequest:request];
    self.methods = 2;
}

-(void)sv_requestAdWithUnitID:(NSString *)unitId bannerOriginal:(CGPoint)point bannerSize:(GADAdSize)size currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.point = point;
    self.isPromptly = isImmediately;
    self.sv_adView = [[GADBannerView alloc] initWithAdSize:size];
    self.sv_adView.adUnitID = unitId;
    [self.sv_adView loadRequest:[GADRequest request]];
    self.sv_adView.delegate = self;
    self.methods = 1;
    if (isImmediately) {
        [vc.view addSubview:self.sv_adView];
    }
}

-(void)sv_showBannerAd {
    if (!self.isPromptly) {
        self.isShowed = YES;
        [self.currentVC.view addSubview:self.sv_adView];
    }
}

-(void)sv_closeBannerAd {
    [self.sv_adView removeFromSuperview];
    self.sv_adView = nil;
}

-(void)sv_bannerWillAppearAnimated:(BOOL)animated {
    if (!self.isShowed) {
        [self.currentVC.view addSubview:self.sv_adView];
    }
}

-(void)sv_bannerWillDisappearAnimated:(BOOL)animated {
    if (self.isShowed) {
        self.isShowed = NO;
        [self.sv_adView removeFromSuperview];
    }
}


#pragma mark - GADBannerViewDelegate

- (void)bannerViewDidReceiveAd:(nonnull GADBannerView *)bannerView {
    NSLog(@"google banner did receive");
    if (self.methods == 1) {
        CGRect frame = bannerView.frame;
        frame.origin = self.point;
        bannerView.frame = frame;
    }
    self.isShowed = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadSuccessWithManager:adsType:)]) {
        [self.delegate sv_adsLoadSuccessWithManager:self adsType:SVAdsTypeGoogle];
    }
}

- (void)bannerView:(nonnull GADBannerView *)bannerView
didFailToReceiveAdWithError:(nonnull NSError *)error {
    NSLog(@"google banner fail receive");
    if (self.delegate && [self.delegate respondsToSelector:@selector(sv_adsLoadFailedWithManager:error:adsType:)]) {
        [self.delegate sv_adsLoadFailedWithManager:self error:error adsType:SVAdsTypeGoogle];
    }
}

@end
