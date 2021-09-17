//
//  SV_GADRewardManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_GADRewardManager : SV_AdsManager

-(void)sv_requestAdWithUnitID:(NSString *)unitID currentVC:(UIViewController *)vc immediatelyShow:(BOOL) isImmediately;

-(void)sv_showAd;

-(BOOL)sv_earnRewardStatus;

@end

NS_ASSUME_NONNULL_END
