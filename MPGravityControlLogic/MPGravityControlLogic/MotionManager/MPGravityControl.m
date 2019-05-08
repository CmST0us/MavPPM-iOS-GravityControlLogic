//
//  MPGravityControl.m
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "MPGravityControl.h"

@implementation MPGravityControl

- (instancetype)init {
    self = [super init];
    if (self) {
        _logItem = nil;
    }
    return self;
}

- (void)updateData:(CMLogItem *)logItem {
    _logItem = logItem;
    if ([self respondsToSelector:@selector(onUpdataData)]) {
        [self onUpdataData];
    }
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(gravityControlDidUpdateData:)]) {
        [self.delegate gravityControlDidUpdateData:self];
    }
}

- (MPGravityControlType)type {
    return 0;
}

- (void)onUpdataData {
    
}

@end
