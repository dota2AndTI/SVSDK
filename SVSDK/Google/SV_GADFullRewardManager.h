//
//  SV_GADFullRewardManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_GADFullRewardManager : SV_AdsManager

-(void)sv_requestAdWithUnitID:(NSString *)unitId currentVC:(UIViewController *)vc immediatelyShow:(BOOL) isImmediately;

-(void)sv_showFullVideoAd;

@end

NS_ASSUME_NONNULL_END
