//  Copyright (c) 2016 Heartland Payment Systems. All rights reserved.
#import <Foundation/Foundation.h>
#import "HpsBinaryDataScanner.h"
#import "HpsTerminalEnums.h"

@interface HpsPaxAmountResponse : NSObject

@property (nonatomic) double approvedAmount;
@property (nonatomic) double amountDue;
@property (nonatomic) double tipAmount;
@property (nonatomic) double cashBackAmount;
@property (nonatomic) double merchantFee;
@property (nonatomic) double taxAmount;
@property (nonatomic) double balance1;
@property (nonatomic) double balance2;

- (id)initWithBinaryReader: (HpsBinaryDataScanner*)br;

@end
