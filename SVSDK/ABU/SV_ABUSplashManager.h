//
//  SV_ABUSplashManager.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import "SV_AdsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SV_ABUSplashManager : SV_AdsManager

-(void)sv_requestAdWithAppId:(NSString *)appId splashId:(NSString *)splashId viewController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
