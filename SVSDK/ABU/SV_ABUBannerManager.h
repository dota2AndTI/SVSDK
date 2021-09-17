//
//  SV_ABUBannerManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_ABUBannerManager : SV_AdsManager

-(void)sv_requestAdWitSlotID:(NSString *)slotId adFrame:(CGRect)frame interval:(NSInteger)interval currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately;

-(void)sv_showBannerAd;

-(void)sv_closeBannerAd;

-(void)sv_bannerWillAppearAnimated:(BOOL)animated;
-(void)sv_bannerWillDisappearAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
