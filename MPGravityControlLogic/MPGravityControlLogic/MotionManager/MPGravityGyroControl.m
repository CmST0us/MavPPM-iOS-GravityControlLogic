//
//  MPGravityGyroControl.m
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MPGravityGyroControl.h"

@implementation MPGravityGyroControl

- (MPGravityControlType)type {
    return MPGravityControlTypeGyro;
}

- (CMGyroData *)data {
    return (CMGyroData *)_logItem;
}

- (void)onUpdataData {
    
}

@end
