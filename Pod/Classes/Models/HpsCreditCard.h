//  Copyright (c) 2016 Heartland Payment Systems. All rights reserved.

#import <Foundation/Foundation.h>

@interface HpsCreditCard : NSObject
@property (nonatomic) int expMonth;
@property (nonatomic) int expYear;
@property (nonatomic, strong) NSString *cardNumber;
@property (nonatomic, strong) NSString* cvv;

@end
