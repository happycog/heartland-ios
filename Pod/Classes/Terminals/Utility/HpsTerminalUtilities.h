//  Copyright (c) 2016 Heartland Payment Systems. All rights reserved.

#import <Foundation/Foundation.h>
#import "HpsDeviceProtocols.h"
#import "HpsDeviceMessage.h"
#import "HpsTerminalEnums.h"

@interface HpsTerminalUtilities : NSObject
{
     NSString *_version;
}
+ (HpsDeviceMessage*) buildRequest: (NSString*) messageId;
+ (HpsDeviceMessage*) buildRequest: (NSString*) messageId withElements:(NSArray*)elements;
+ (NSData *)trimHpsResponseData:(NSData *)data;
@end
