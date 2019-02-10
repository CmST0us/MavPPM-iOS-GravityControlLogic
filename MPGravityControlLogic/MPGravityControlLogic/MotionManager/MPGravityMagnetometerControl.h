//
//  MPGravityMagnetometerControl.h
//  MPGravityControlLogic
//
//  Created by CmST0us on 2019/2/10.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import "MPGravityControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPGravityMagnetometerControl : MPGravityControl
@property (nonatomic, readonly) CMMagnetometerData *data;
@end

NS_ASSUME_NONNULL_END
