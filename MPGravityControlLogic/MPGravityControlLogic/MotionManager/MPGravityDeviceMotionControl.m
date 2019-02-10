//
//  MPGravityDeviceMotionControl.m
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MPGravityDeviceMotionControl.h"

@implementation MPGravityDeviceMotionControl

- (MPGravityControlType)type {
    return MPGravityControlTypeDeviceMotion;
}

- (CMDeviceMotion *)data {
    return  (CMDeviceMotion *)_logItem;
}

- (void)onUpdataData {
    
}
@end
