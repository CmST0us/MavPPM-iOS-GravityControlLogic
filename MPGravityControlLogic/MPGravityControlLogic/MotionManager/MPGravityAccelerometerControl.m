//
//  MPGravityAccelerometerControl.m
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MPGravityAccelerometerControl.h"

@implementation MPGravityAccelerometerControl
- (MPGravityControlType)type {
    return MPGravityControlTypeAccelerometer;
}

- (CMAccelerometerData *)data {
    return (CMAccelerometerData *)_logItem;
}

- (void)onUpdataData {
    
}
@end
