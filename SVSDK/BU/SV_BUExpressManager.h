//
//  SV_BUExpressManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_BUExpressManager : SV_AdsManager

-(void)sv_requesAdWithSlotID:(NSString *)idStr adSize:(CGSize)size count:(NSInteger)count currentVC:(UIViewController *)vc immediatelyShow:(BOOL)isImmediately;

-(void)sv_showExpressAd;

-(NSMutableArray *)sv_getExpressAdWithSlotID:(NSString *)slotID;

@end

NS_ASSUME_NONNULL_END
