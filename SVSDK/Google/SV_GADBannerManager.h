//
//  SV_GADBannerManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_GADBannerManager : SV_AdsManager

-(void)sv_requestAdWithUnitID:(NSString *)unitId bannerOriginal:(CGPoint)point bannerSize:(GADAdSize)size currentVC:(UIViewController *)vc immediatelyShow:(BOOL) isImmediately;

-(void)sv_requestBannerAdWithUnitID:(NSString *)unitID bannerFrame:(CGRect)frame currentVC:(UIViewController *)vc immediatelyShow:(BOOL) isImmediately;

-(void)sv_showBannerAd;

-(void)sv_closeBannerAd;

-(void)sv_bannerWillAppearAnimated:(BOOL)animated;
-(void)sv_bannerWillDisappearAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
