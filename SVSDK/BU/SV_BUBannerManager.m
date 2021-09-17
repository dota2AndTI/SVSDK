//
//  SV_BUBannerManager.m
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_BUBannerManager.h"

@interface SV_BUBannerManager ()<BUNativeExpressBannerViewDelegate>

@property (nonatomic,strong)BUNativeExpressBannerView *sv_adView;
@property (nonatomic,assign)BOOL isShowed;
@property (nonatomic,assign)BOOL isAddedView;//广告已被加入视图

@end

@implementation SV_BUBannerManager

-(void)sv_requestAdWitSlotID:(NSString *)slotID adFrame:(CGRect)frame interval:(NSInteger)interval currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately {
    self.currentVC = vc;
    self.isPromptly = isImmediately;
    self.sv_adView = [[BUNativeExpressBannerView alloc] initWithSlotID:slotID rootViewController:vc adSize:frame.size interval:interval];
    self.sv_adView.frame = frame;
    self.sv_adView.delegate = self;
    [self.sv_adView loadAdData];
}

-(void)sv_showBannerAd {
    if (self.sv_adsLoaded) {
        self.isShowed = YES;
        self.isAddedView = YES;
        [self.currentVC.view addSubview:self.sv_adView];
    }
}

-(void)sv_closeBannerAd {
    [self.sv_adView removeFromSuperview];
    self.sv_adView = nil;
}

-(void)sv_bannerWillAppearAnimated:(BOOL)animated {
    if (!self.isShowed && self.isAddedView) {
        [self.currentVC.view addSubview:self.sv_adView];
    }
}

-(void)sv_bannerWillDisappearAnimated:(BOOL)animated {
    if (self.isShowed) {
        self.isShowed = NO;
        [self.sv_adView removeFromSuperview];
    }
}


#pragma mark - BUNativeExpressBannerViewDelegate
// 加载成功
-(void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    if ([bannerAdView isEqual:self.sv_adView]) {
        if (self.isPromptly ) {
            self.isAddedView = YES;
            [self.currentVC.view addSubview:bannerAdView];
        }else{
            self.sv_adsLoaded = YES;
        }
    }
}
// 返回的错误码(error)表示广告加载失败的原因
-(void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    
}
// dislike回调方法，需要在此回调方法中进行广告的移除操作，并将广告对象置为nil，如若不实现此回调方法，关闭按钮将不会生效
-(void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [bannerAdView removeFromSuperview];
    self.sv_adView = nil;
}



@end
