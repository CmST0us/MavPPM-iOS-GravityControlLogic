//
//  MPGravityDeviceMotionControl.h
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPGravityControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPGravityDeviceMotionControl : MPGravityControl
@property (nonatomic, readonly) CMDeviceMotion *data;
@end

NS_ASSUME_NONNULL_END
