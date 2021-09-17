//
//  SV_BaseUtil.h
//  AdsDemo
//
//  Created by  on 2021/9/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SV_BaseUtil : NSObject

+(instancetype)sv_shareUtil;

+ (UIViewController*)sv_getCurrentViewController;

+ (BOOL) sv_showLog;


@end

NS_ASSUME_NONNULL_END
