//
//  MPGravityMagnetometerControl.m
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MPGravityMagnetometerControl.h"

@implementation MPGravityMagnetometerControl

- (MPGravityControlType)type {
    return MPGravityControlTypeMagnetometer;
}

- (CMMagnetometerData *)data {
    return (CMMagnetometerData *)_logItem;
}

- (void)onUpdataData {
    
}

@end
