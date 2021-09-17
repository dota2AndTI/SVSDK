//
//  SV_BURewardManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_BURewardManager : SV_AdsManager

-(void)sv_buRequestRewardAdWith:(NSString *)idStr userId:(NSString *)userId viewController:(UIViewController *)vc promptlyShow:(BOOL) isImmediately;

-(void)sv_buShowRewardAdWith:(NSString *)adId;

-(BOOL)sv_earnRewardStatus;


@end

NS_ASSUME_NONNULL_END
